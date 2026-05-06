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
           locationName: initialPost?.locationName ?? '',
           selectedMovieTitle: initialPost?.movieTitle ?? '',
           selectedMovieSlug: initialPost?.movieSlug ?? '',
           selectedMoviePosterUrl: initialPost?.moviePosterUrl ?? '',
         ),
       );

  final CreateCommunityPostUseCase _createCommunityPostUseCase;
  final UpdateCommunityPostUseCase _updateCommunityPostUseCase;
  final SearchMoviesUseCase _searchMoviesUseCase;
  final LocationService _locationService;
  final ImagePicker _imagePicker = ImagePicker();

  Future<void> pickImage() async {
    final image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 82,
    );
    if (image != null) {
      emit(state.copyWith(selectedImage: image));
    }
  }

  void removeImage() {
    emit(state.copyWith(selectedImage: null));
  }

  Future<void> searchMovies(String keyword) async {
    final normalizedKeyword = keyword.trim();
    if (normalizedKeyword.length < 2) {
      emit(
        state.copyWith(movieSearchResults: const [], searchingMovies: false),
      );
      return;
    }

    emit(state.copyWith(searchingMovies: true, failure: null));
    final result = await _searchMoviesUseCase(
      SearchMoviesParams(keyword: normalizedKeyword),
    );
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

  Future<void> resolveCurrentLocation({required String failureMessage}) async {
    emit(state.copyWith(resolvingLocation: true, failure: null));
    try {
      final address = await _locationService.getCurrentAddress();
      emit(state.copyWith(resolvingLocation: false, locationName: address));
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
    if (normalizedContent.isEmpty && state.selectedImage == null) {
      final failure = AppFailure.unknown(messages.emptyContent);
      emit(state.copyWith(failure: failure));
      showFailureToast(failure);
      return false;
    }

    emit(state.copyWith(processing: true, failure: null));
    final image = await _imagePayload();
    final result = state.initialPost == null
        ? await _createCommunityPostUseCase(
            CreateCommunityPostParams(
              content: normalizedContent,
              movieTitle: state.selectedMovieTitle,
              movieSlug: state.selectedMovieSlug,
              moviePosterUrl: state.selectedMoviePosterUrl,
              locationName: locationName.trim(),
              image: image,
            ),
          )
        : await _updateCommunityPostUseCase(
            UpdateCommunityPostParams(
              id: state.initialPost!.id,
              content: normalizedContent,
              movieTitle: state.selectedMovieTitle,
              movieSlug: state.selectedMovieSlug,
              moviePosterUrl: state.selectedMoviePosterUrl,
              locationName: locationName.trim(),
              image: image,
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

  Future<CommunityImagePayload?> _imagePayload() async {
    final image = state.selectedImage;
    if (image == null) {
      return null;
    }

    final bytes = await image.readAsBytes();
    if (bytes.isEmpty) {
      return null;
    }

    return CommunityImagePayload(
      bytes: bytes,
      fileName: image.name,
      contentType: image.mimeType ?? _contentTypeFor(image.name),
    );
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
