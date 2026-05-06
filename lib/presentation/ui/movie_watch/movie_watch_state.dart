import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:imovie_app/core/bloc/base_state.dart';
import 'package:imovie_app/core/error/app_failure.dart';
import 'package:imovie_app/domain/entities/movie_detail/movie_detail.dart';
import 'package:imovie_app/domain/entities/movie_detail/movie_stream_episode.dart';
import 'package:imovie_app/domain/entities/movie_detail/movie_stream_server.dart';

part 'movie_watch_state.freezed.dart';

@freezed
abstract class MovieWatchState with _$MovieWatchState implements BaseState {
  const MovieWatchState._();

  const factory MovieWatchState({
    required String slug,
    @Default(PageStatus.initial) PageStatus pageStatus,
    @Default(false) bool processing,
    AppFailure? failure,
    MovieDetail? detail,
    @Default(0) int selectedServerIndex,
    @Default(0) int selectedEpisodeIndex,
  }) = _MovieWatchState;

  List<MovieStreamServer> get servers => detail?.servers ?? const [];

  MovieStreamServer? get selectedServer {
    if (selectedServerIndex < 0 || selectedServerIndex >= servers.length) {
      return null;
    }
    return servers[selectedServerIndex];
  }

  MovieStreamEpisode? get selectedEpisode {
    final server = selectedServer;
    if (server == null ||
        selectedEpisodeIndex < 0 ||
        selectedEpisodeIndex >= server.episodes.length) {
      return null;
    }
    return server.episodes[selectedEpisodeIndex];
  }

  String get selectedStreamUrl => selectedEpisode?.m3u8Url.trim() ?? '';

  bool get hasSelectedServerEpisodes =>
      selectedServer?.episodes.isNotEmpty ?? false;

  String get originalTitleValue =>
      _valueOrFallback(detail?.originalTitle ?? '');

  String get runtimeValue => _valueOrFallback(detail?.runtime ?? '');

  String get qualityValue => _valueOrFallback(detail?.quality ?? '');

  String get languageValue => _valueOrFallback(detail?.language ?? '');

  String get selectedEpisodeName =>
      _valueOrFallback(selectedEpisode?.displayName ?? '');

  String _valueOrFallback(String value) {
    return value.trim().isEmpty ? '-' : value;
  }

  @override
  MovieWatchState copyWithBase({
    PageStatus? pageStatus,
    bool? processing,
    AppFailure? failure,
    bool clearFailure = false,
  }) {
    return copyWith(
      pageStatus: pageStatus ?? this.pageStatus,
      processing: processing ?? this.processing,
      failure: clearFailure ? null : failure ?? this.failure,
    );
  }
}
