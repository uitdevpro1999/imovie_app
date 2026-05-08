import 'dart:async';

import 'package:image_picker/image_picker.dart';
import 'package:imovie_app/core/bloc/base_cubit.dart';
import 'package:imovie_app/core/error/app_failure.dart';
import 'package:imovie_app/core/events/app_community_event.dart';
import 'package:imovie_app/core/events/app_event_bus.dart';
import 'package:imovie_app/core/services/location_service.dart';
import 'package:imovie_app/domain/entities/community/community_post.dart';
import 'package:imovie_app/domain/entities/home/home_movie.dart';
import 'package:imovie_app/domain/repositories/community_repository.dart';
import 'package:imovie_app/domain/usecases/home/search_movies_use_case.dart';
import 'package:imovie_app/domain/usecases/community/create_community_post_use_case.dart';
import 'package:imovie_app/domain/usecases/community/update_community_post_use_case.dart';
import 'package:imovie_app/presentation/ui/community/compose/community_compose_state.dart';

class CommunityComposeCubit extends BaseCubit<CommunityComposeState> {
  CommunityComposeCubit({
    required CommunityPost? initialPost,
    required CreateCommunityPostUseCase createCommunityPostUseCase,
    required UpdateCommunityPostUseCase updateCommunityPostUseCase,
    required SearchMoviesUseCase searchMoviesUseCase,
    required LocationService locationService,
  }) : _createCommunityPostUseCase = createCommunityPostUseCase,
       _updateCommunityPostUseCase = updateCommunityPostUseCase,
       _searchMoviesUseCase = searchMoviesUseCase,
       _locationService = locationService,
       super(
         CommunityComposeState(
           initialPost: initialPost,
           locationName: LocationAddress.shortestLabel(
             initialPost?.locationName ?? '',
           ),
           locationFullName: initialPost?.locationName ?? '',
           selectedMovieTitle: initialPost?.movieTitle ?? '',
           selectedMovieSlug: initialPost?.movieSlug ?? '',
           selectedMoviePosterUrl: initialPost?.moviePosterUrl ?? '',
           existingImageUrls: initialPost?.imageUrls ?? const <String>[],
         ),
       );

  final CreateCommunityPostUseCase _createCommunityPostUseCase;
  final UpdateCommunityPostUseCase _updateCommunityPostUseCase;
  final SearchMoviesUseCase _searchMoviesUseCase;
  final LocationService _locationService;
  final ImagePicker _imagePicker = ImagePicker();
  Timer? _movieSearchDebounce;
  int _movieSearchRequestId = 0;

  static const maxPostImages = 5;
  static const _movieSearchDebounceDuration = Duration(milliseconds: 500);

  @override
  Future<void> close() {
    _movieSearchDebounce?.cancel();
    return super.close();
  }

  Future<void> pickImage() async {
    await pickImages();
  }

  Future<void> pickImages() async {
    final remainingSlots =
        maxPostImages -
        state.existingImageUrls.length -
        state.selectedImages.length;
    if (remainingSlots <= 0) {
      return;
    }

    final images = await _imagePicker.pickMultiImage(
      imageQuality: 82,
      limit: remainingSlots,
    );
    if (images.isNotEmpty) {
      emit(
        state.copyWith(
          selectedImages: [
            ...state.selectedImages,
            ...images.take(remainingSlots),
          ],
        ),
      );
    }
  }

  void removeImage() {
    emit(state.copyWith(selectedImages: const []));
  }

  void removeSelectedImage(XFile image) {
    emit(
      state.copyWith(
        selectedImages: state.selectedImages
            .where((item) => item.path != image.path)
            .toList(growable: false),
      ),
    );
  }

  void removeExistingImageUrl(String imageUrl) {
    final normalizedImageUrl = imageUrl.trim();
    emit(
      state.copyWith(
        existingImageUrls: state.existingImageUrls
            .where((item) => item.trim() != normalizedImageUrl)
            .toList(growable: false),
      ),
    );
  }

  Future<void> searchMovies(String keyword) async {
    final normalizedKeyword = keyword.trim();
    _movieSearchDebounce?.cancel();
    final requestId = ++_movieSearchRequestId;

    if (normalizedKeyword.length < 2) {
      emit(
        state.copyWith(movieSearchResults: const [], searchingMovies: false),
      );
      return;
    }

    emit(state.copyWith(failure: null));
    _movieSearchDebounce = Timer(_movieSearchDebounceDuration, () {
      unawaited(_runMovieSearch(normalizedKeyword, requestId));
    });
  }

  Future<void> _runMovieSearch(String keyword, int requestId) async {
    if (isClosed || requestId != _movieSearchRequestId) {
      return;
    }

    emit(state.copyWith(searchingMovies: true, failure: null));
    final result = await _searchMoviesUseCase(
      SearchMoviesParams(keyword: keyword),
    );
    if (isClosed || requestId != _movieSearchRequestId) {
      return;
    }

    result.map(
      success: (feed) {
        emit(
          state.copyWith(
            searchingMovies: false,
            movieSearchResults: feed.movies,
          ),
        );
      },
      failure: (failure) {
        emit(state.copyWith(searchingMovies: false, failure: failure));
        showFailureToast(failure);
      },
    );
  }

  void selectMovie(HomeMovie movie) {
    emit(
      state.copyWith(
        selectedMovieTitle: movie.title,
        selectedMovieSlug: movie.slug,
        selectedMoviePosterUrl: movie.posterUrl,
      ),
    );
  }

  void clearSelectedMovie() {
    emit(
      state.copyWith(
        selectedMovieTitle: '',
        selectedMovieSlug: '',
        selectedMoviePosterUrl: '',
      ),
    );
  }

  void updateLocationName(String value) {
    emit(state.copyWith(locationName: value, locationFullName: value));
  }

  Future<void> resolveCurrentLocation({required String failureMessage}) async {
    emit(state.copyWith(resolvingLocation: true, failure: null));
    try {
      final address = await _locationService.getCurrentLocationAddress();
      emit(
        state.copyWith(
          resolvingLocation: false,
          locationName: address.shortLabel,
          locationFullName: address.fullLabel,
        ),
      );
    } catch (error) {
      emit(state.copyWith(resolvingLocation: false));
      showErrorToast(failureMessage);
    }
  }

  Future<bool> submit({
    required String content,
    required String locationName,
    required CommunityComposeMessages messages,
  }) async {
    final normalizedContent = content.trim();
    if (normalizedContent.isEmpty &&
        state.selectedImages.isEmpty &&
        state.existingImageUrls.isEmpty) {
      final failure = AppFailure.unknown(messages.emptyContent);
      emit(state.copyWith(failure: failure));
      showFailureToast(failure);
      return false;
    }

    emit(state.copyWith(processing: true, failure: null));
    final images = await _imagePayloads();
    final result = state.initialPost == null
        ? await _createCommunityPostUseCase(
            CreateCommunityPostParams(
              content: normalizedContent,
              movieTitle: state.selectedMovieTitle,
              movieSlug: state.selectedMovieSlug,
              moviePosterUrl: state.selectedMoviePosterUrl,
              locationName: _submitLocationName(locationName),
              images: images,
            ),
          )
        : await _updateCommunityPostUseCase(
            UpdateCommunityPostParams(
              id: state.initialPost!.id,
              content: normalizedContent,
              movieTitle: state.selectedMovieTitle,
              movieSlug: state.selectedMovieSlug,
              moviePosterUrl: state.selectedMoviePosterUrl,
              locationName: _submitLocationName(locationName),
              keptImageUrls: state.existingImageUrls,
              images: images,
            ),
          );

    return result.map(
      success: (_) {
        emit(state.copyWith(processing: false, failure: null));
        appEventBus.emitCommunity(AppCommunityEvent.changed());
        showSuccessToast(
          state.isEditing ? messages.updateSuccess : messages.createSuccess,
        );
        return true;
      },
      failure: (failure) {
        emit(state.copyWith(processing: false, failure: failure));
        showFailureToast(failure);
        return false;
      },
    );
  }

  Future<List<CommunityImagePayload>> _imagePayloads() async {
    final payloads = <CommunityImagePayload>[];
    for (final image in state.selectedImages.take(maxPostImages)) {
      final bytes = await image.readAsBytes();
      if (bytes.isEmpty) {
        continue;
      }

      payloads.add(
        CommunityImagePayload(
          bytes: bytes,
          fileName: image.name,
          contentType: image.mimeType ?? _contentTypeFor(image.name),
        ),
      );
    }

    return payloads;
  }

  String _contentTypeFor(String fileName) {
    final lowerName = fileName.toLowerCase();
    if (lowerName.endsWith('.png')) {
      return 'image/png';
    }
    if (lowerName.endsWith('.gif')) {
      return 'image/gif';
    }
    if (lowerName.endsWith('.webp')) {
      return 'image/webp';
    }

    return 'image/jpeg';
  }

  String _submitLocationName(String inputLocationName) {
    final normalizedInput = inputLocationName.trim();
    if (normalizedInput.isEmpty) {
      return '';
    }

    final fullLocation = state.locationFullName.trim();
    return fullLocation.isEmpty ? normalizedInput : fullLocation;
  }
}

class CommunityComposeMessages {
  const CommunityComposeMessages({
    required this.emptyContent,
    required this.createSuccess,
    required this.updateSuccess,
  });

  final String emptyContent;
  final String createSuccess;
  final String updateSuccess;
}
