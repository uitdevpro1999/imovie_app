import 'dart:async';

import 'package:imovie_app/core/bloc/base_cubit.dart';
import 'package:imovie_app/core/bloc/base_state.dart';
import 'package:imovie_app/core/usecase/use_case.dart';
import 'package:imovie_app/domain/usecases/profile/get_cached_profile_use_case.dart';
import 'package:imovie_app/presentation/ui/main/main_cubit.dart';
import 'package:imovie_app/presentation/ui/main/main_state.dart';
import 'package:imovie_app/presentation/ui/profile/settings/settings_state.dart';

class SettingsCubit extends BaseCubit<SettingsState> {
  SettingsCubit({
    required MainCubit mainCubit,
    required GetCachedProfileUseCase getCachedProfileUseCase,
  }) : _mainCubit = mainCubit,
       _getCachedProfileUseCase = getCachedProfileUseCase,
       super(const SettingsState()) {
    _mainSubscription = _mainCubit.stream.listen(_syncMainState);
  }

  final MainCubit _mainCubit;
  final GetCachedProfileUseCase _getCachedProfileUseCase;
  late final StreamSubscription<MainState> _mainSubscription;

  @override
  Future<void> initData() async {
    await _loadCachedProfile();
    _syncMainState(_mainCubit.state);
    if (_mainCubit.state.pageStatus == PageStatus.initial ||
        _mainCubit.state.pageStatus == PageStatus.error) {
      await _mainCubit.load();
    }
  }

  Future<void> signOut({required String failureMessage}) async {
    await _mainCubit.signOut(failureMessage: failureMessage);
  }

  void _syncMainState(MainState mainState) {
    if (mainState.pageStatus == PageStatus.initial) {
      return;
    }

    if (mainState.pageStatus == PageStatus.loading && state.profile != null) {
      emit(state.copyWith(processing: mainState.processing, failure: null));
      return;
    }

    if (mainState.pageStatus == PageStatus.error && state.profile != null) {
      emit(
        state.copyWith(
          pageStatus: PageStatus.loaded,
          processing: false,
          failure: mainState.failure,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        pageStatus: mainState.pageStatus,
        isAuthenticated: mainState.isAuthenticated,
        profile: mainState.profile,
        processing: mainState.processing,
        failure: mainState.failure,
      ),
    );
  }

  Future<void> _loadCachedProfile() async {
    final result = await _getCachedProfileUseCase(const NoParams());
    final cachedProfile = result.map(
      success: (profile) => profile,
      failure: (_) => null,
    );
    if (cachedProfile == null) {
      return;
    }

    emit(
      state.copyWith(
        pageStatus: PageStatus.loaded,
        isAuthenticated: true,
        profile: cachedProfile,
        failure: null,
      ),
    );
  }

  @override
  Future<void> close() async {
    await _mainSubscription.cancel();
    return super.close();
  }
}
