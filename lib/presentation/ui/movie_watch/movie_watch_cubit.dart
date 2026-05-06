import 'package:imovie_app/core/bloc/base_cubit.dart';
import 'package:imovie_app/core/bloc/base_state.dart';
import 'package:imovie_app/domain/entities/movie_detail/movie_detail.dart';
import 'package:imovie_app/domain/entities/movie_detail/movie_stream_server.dart';
import 'package:imovie_app/domain/usecases/movie_detail/get_movie_detail_use_case.dart';
import 'package:imovie_app/presentation/ui/movie_watch/movie_watch_state.dart';

class MovieWatchCubit extends BaseCubit<MovieWatchState> {
  MovieWatchCubit({
    required GetMovieDetailUseCase getMovieDetailUseCase,
    required String slug,
    MovieDetail? initialDetail,
  }) : _getMovieDetailUseCase = getMovieDetailUseCase,
       _initialDetail = initialDetail,
       super(MovieWatchState(slug: slug));

  final GetMovieDetailUseCase _getMovieDetailUseCase;
  final MovieDetail? _initialDetail;

  @override
  Future<void> initData() => load();

  Future<void> load() async {
    emit(
      state.copyWithBase(pageStatus: PageStatus.loading, clearFailure: true),
    );

    if (_initialDetail != null) {
      _emitSuccess(_initialDetail);
      return;
    }

    final result = await _getMovieDetailUseCase(
      GetMovieDetailParams(slug: state.slug),
    );

    result.map(
      success: _emitSuccess,
      failure: (failure) =>
          emit(state.copyWith(pageStatus: PageStatus.error, failure: failure)),
    );
  }

  void selectServer(int index) {
    final detail = state.detail;
    if (detail == null || index < 0 || index >= detail.servers.length) {
      return;
    }

    emit(
      state.copyWith(
        selectedServerIndex: index,
        selectedEpisodeIndex: _firstPlayableEpisodeIndex(detail.servers[index]),
      ),
    );
  }

  void selectEpisode(int index) {
    final server = state.selectedServer;
    if (server == null || index < 0 || index >= server.episodes.length) {
      return;
    }

    emit(state.copyWith(selectedEpisodeIndex: index));
  }

  void _emitSuccess(MovieDetail detail) {
    final selection = _defaultSelection(detail);
    emit(
      state.copyWith(
        pageStatus: PageStatus.loaded,
        detail: detail,
        selectedServerIndex: selection.serverIndex,
        selectedEpisodeIndex: selection.episodeIndex,
        failure: null,
      ),
    );
  }

  _Selection _defaultSelection(MovieDetail detail) {
    if (detail.servers.isEmpty) {
      return const _Selection(serverIndex: 0, episodeIndex: 0);
    }

    for (
      var serverIndex = 0;
      serverIndex < detail.servers.length;
      serverIndex++
    ) {
      final episodeIndex = _firstPlayableEpisodeIndex(
        detail.servers[serverIndex],
      );
      if (episodeIndex >= 0) {
        return _Selection(serverIndex: serverIndex, episodeIndex: episodeIndex);
      }
    }

    return const _Selection(serverIndex: 0, episodeIndex: 0);
  }

  int _firstPlayableEpisodeIndex(MovieStreamServer server) {
    final index = server.episodes.indexWhere(
      (episode) => episode.hasPlayableStream,
    );
    return index >= 0 ? index : 0;
  }
}

class _Selection {
  const _Selection({required this.serverIndex, required this.episodeIndex});

  final int serverIndex;
  final int episodeIndex;
}
