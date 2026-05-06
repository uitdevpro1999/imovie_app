import 'package:imovie_app/core/bloc/base_cubit.dart';
import 'package:imovie_app/core/bloc/base_state.dart';
import 'package:imovie_app/core/usecase/use_case.dart';
import 'package:imovie_app/domain/usecases/home/get_home_feed_use_case.dart';
import 'package:imovie_app/domain/usecases/home/get_home_genres_use_case.dart';
import 'package:imovie_app/presentation/ui/home/home_state.dart';

class HomeCubit extends BaseCubit<HomeState> {
  HomeCubit({
    required GetHomeFeedUseCase getHomeFeedUseCase,
    required GetHomeGenresUseCase getHomeGenresUseCase,
  }) : _getHomeFeedUseCase = getHomeFeedUseCase,
       _getHomeGenresUseCase = getHomeGenresUseCase,
       super(const HomeState());

  final GetHomeFeedUseCase _getHomeFeedUseCase;
  final GetHomeGenresUseCase _getHomeGenresUseCase;

  @override
  Future<void> initData() => load();

  Future<void> load() async {
    emit(
      state.copyWithBase(pageStatus: PageStatus.loading, clearFailure: true),
    );

    final feedResult = await _getHomeFeedUseCase(const NoParams());
    final feed = feedResult.map(
      success: (feed) => feed,
      failure: (failure) {
        emit(state.copyWith(pageStatus: PageStatus.error, failure: failure));
        return null;
      },
    );
    if (feed == null) {
      return;
    }

    final genresResult = await _getHomeGenresUseCase(const NoParams());
    emit(
      genresResult.map(
        success: (genres) => state.copyWith(
          pageStatus: PageStatus.loaded,
          feed: feed,
          genres: genres,
          failure: null,
        ),
        failure: (failure) =>
            state.copyWith(pageStatus: PageStatus.error, failure: failure),
      ),
    );
  }
}
