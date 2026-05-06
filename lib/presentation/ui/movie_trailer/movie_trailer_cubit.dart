import 'package:imovie_app/core/bloc/base_cubit.dart';
import 'package:imovie_app/core/bloc/base_state.dart';
import 'package:imovie_app/core/error/app_failure.dart';
import 'package:imovie_app/presentation/ui/movie_trailer/movie_trailer_state.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieTrailerCubit extends BaseCubit<MovieTrailerState> {
  MovieTrailerCubit({required String title, required String trailerUrl})
    : super(MovieTrailerState(title: title, trailerUrl: trailerUrl));

  @override
  Future<void> initData() async {
    final videoId = YoutubePlayer.convertUrlToId(state.trailerUrl);
    if (videoId == null || videoId.trim().isEmpty) {
      emit(
        state.copyWith(
          pageStatus: PageStatus.error,
          failure: AppFailure.unknown('Trailer unavailable.'),
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        pageStatus: PageStatus.loaded,
        videoId: videoId,
        failure: null,
      ),
    );
  }
}
