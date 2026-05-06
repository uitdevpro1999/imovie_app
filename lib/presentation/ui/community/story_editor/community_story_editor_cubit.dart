import 'package:image_picker/image_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:imovie_app/core/bloc/base_cubit.dart';
import 'package:imovie_app/core/error/app_failure.dart';
import 'package:imovie_app/core/events/app_community_event.dart';
import 'package:imovie_app/core/events/app_event_bus.dart';
import 'package:imovie_app/core/services/location_service.dart';
import 'package:imovie_app/domain/entities/home/home_movie.dart';
import 'package:imovie_app/domain/repositories/community_repository.dart';
import 'package:imovie_app/domain/usecases/community/create_community_story_use_case.dart';
import 'package:imovie_app/domain/usecases/home/search_movies_use_case.dart';
import 'package:imovie_app/presentation/ui/community/story_editor/community_story_editor_state.dart';

class CommunityStoryEditorCubit extends BaseCubit<CommunityStoryEditorState> {
  CommunityStoryEditorCubit({
    required CreateCommunityStoryUseCase createCommunityStoryUseCase,
    required SearchMoviesUseCase searchMoviesUseCase,
    required LocationService locationService,
  }) : _createCommunityStoryUseCase = createCommunityStoryUseCase,
       _searchMoviesUseCase = searchMoviesUseCase,
       _locationService = locationService,
       super(const CommunityStoryEditorState());

  final CreateCommunityStoryUseCase _createCommunityStoryUseCase;
  final SearchMoviesUseCase _searchMoviesUseCase;
  final LocationService _locationService;
  final ImagePicker _imagePicker = ImagePicker();

  Future<void> pickImage() async {
    final image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 86,
    );
    if (image != null) {
      emit(state.copyWith(selectedImage: image));
    }
  }

  void removeImage() {
    emit(state.copyWith(selectedImage: null));
  }

  void updateStoryText(String value) {
    emit(state.copyWith(storyText: value));
  }

  void updateLocationName(String value) {
    emit(state.copyWith(locationName: value));
  }

  void updateTextPosition(Offset position) {
    emit(
      state.copyWith(
        textPositionX: _normalizedPosition(position.dx),
        textPositionY: _normalizedPosition(position.dy),
      ),
    );
  }

  void updateMoviePosition(Offset position) {
    emit(
      state.copyWith(
        moviePositionX: _normalizedPosition(position.dx),
        moviePositionY: _normalizedPosition(position.dy),
      ),
    );
  }

  void updateLocationPosition(Offset position) {
    emit(
      state.copyWith(
        locationPositionX: _normalizedPosition(position.dx),
        locationPositionY: _normalizedPosition(position.dy),
      ),
    );
  }

  Future<void> resolveCurrentLocation({required String failureMessage}) async {
    emit(state.copyWith(resolvingLocation: true, failure: null));
    try {
      final address = await _locationService.getCurrentAddress();
      emit(state.copyWith(resolvingLocation: false, locationName: address));
    } catch (_) {
      emit(state.copyWith(resolvingLocation: false));
      showErrorToast(failureMessage);
    }
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

  Future<bool> submit({required CommunityStoryEditorMessages messages}) async {
    final image = state.selectedImage;
    if (image == null) {
      final failure = AppFailure.unknown(messages.emptyImage);
      emit(state.copyWith(failure: failure));
      showFailureToast(failure);
      return false;
    }

    emit(state.copyWith(processing: true, failure: null));
    final imagePayload = await _imagePayload(image);
    if (imagePayload == null) {
      final failure = AppFailure.unknown(messages.emptyImage);
      emit(state.copyWith(processing: false, failure: failure));
      showFailureToast(failure);
      return false;
    }

    final result = await _createCommunityStoryUseCase(
      CreateCommunityStoryParams(
        image: imagePayload,
        caption: state.storyText.trim(),
        movieTitle: state.selectedMovieTitle,
        movieSlug: state.selectedMovieSlug,
        moviePosterUrl: state.selectedMoviePosterUrl,
        locationName: state.locationName,
        textPositionX: state.textPositionX,
        textPositionY: state.textPositionY,
        moviePositionX: state.moviePositionX,
        moviePositionY: state.moviePositionY,
        locationPositionX: state.locationPositionX,
        locationPositionY: state.locationPositionY,
      ),
    );

    return result.map(
      success: (_) {
        emit(state.copyWith(processing: false, failure: null));
        appEventBus.emitCommunity(AppCommunityEvent.changed());
        showSuccessToast(messages.createSuccess);
        return true;
      },
      failure: (failure) {
        emit(state.copyWith(processing: false, failure: failure));
        showFailureToast(failure);
        return false;
      },
    );
  }

  Future<CommunityImagePayload?> _imagePayload(XFile image) async {
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

  double _normalizedPosition(double value) {
    return value.clamp(0.0, 1.0);
  }
}

class CommunityStoryEditorMessages {
  const CommunityStoryEditorMessages({
    required this.emptyImage,
    required this.createSuccess,
  });

  final String emptyImage;
  final String createSuccess;
}
