import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imovie_app/core/events/app_auth_event.dart';
import 'package:imovie_app/core/events/app_event_bus.dart';
import 'package:imovie_app/core/services/local_storage_service.dart';
import 'package:imovie_app/core/usecase/use_case.dart';
import 'package:imovie_app/domain/usecases/get_current_session_use_case.dart';
import 'package:imovie_app/presentation/app/app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit({
    required GetCurrentSessionUseCase getCurrentSessionUseCase,
    required LocalStorageService localStorageService,
  }) : _localStorageService = localStorageService,
       _getCurrentSessionUseCase = getCurrentSessionUseCase,
       super(const AppState()) {
    _authSubscription = appEventBus.authStream.listen(_handleAuthEvent);
  }

  static const _localeStorageKey = 'app_locale_code';
  static const _supportedLocaleCodes = {'en', 'vi'};

  final LocalStorageService _localStorageService;
  final GetCurrentSessionUseCase _getCurrentSessionUseCase;
  late final StreamSubscription<AppAuthEvent> _authSubscription;

  Future<void> loadLocale() async {
    final storedCode = await _localStorageService.readString(_localeStorageKey);
    final localeCode = _normalizeLocaleCode(storedCode);
    if (localeCode != state.localeCode) {
      emit(state.copyWith(localeCode: localeCode));
    }
  }

  Future<void> updateLocale(String localeCode) async {
    final normalizedCode = _normalizeLocaleCode(localeCode);
    await _localStorageService.writeString(_localeStorageKey, normalizedCode);
    if (normalizedCode != state.localeCode) {
      emit(state.copyWith(localeCode: normalizedCode));
    }
  }

  String _normalizeLocaleCode(String? localeCode) {
    final normalizedCode = localeCode?.trim().toLowerCase() ?? '';
    return _supportedLocaleCodes.contains(normalizedCode)
        ? normalizedCode
        : 'vi';
  }

  Future<void> checkAuthentication() async {
    emit(state.copyWith(authStatus: AppAuthStatus.checking, failure: null));

    final result = await _getCurrentSessionUseCase(const NoParams());
    emit(
      result.map(
        success: (session) => AppState(
          authStatus: session.isAuthenticated
              ? AppAuthStatus.authenticated
              : AppAuthStatus.unauthenticated,
          localeCode: state.localeCode,
        ),
        failure: (failure) => AppState(
          authStatus: AppAuthStatus.unauthenticated,
          localeCode: state.localeCode,
          failure: failure,
        ),
      ),
    );
  }

  void _markAuthenticated() {
    emit(state.copyWith(authStatus: AppAuthStatus.authenticated));
  }

  void _markUnauthenticated() {
    emit(state.copyWith(authStatus: AppAuthStatus.unauthenticated));
  }

  void _handleAuthEvent(AppAuthEvent event) {
    switch (event.status) {
      case AppAuthEventStatus.authenticated:
        _markAuthenticated();
      case AppAuthEventStatus.unauthenticated:
        _markUnauthenticated();
    }
  }

  @override
  Future<void> close() async {
    await _authSubscription.cancel();
    return super.close();
  }
}
