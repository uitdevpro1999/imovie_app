import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:imovie_app/core/error/app_failure.dart';

part 'app_state.freezed.dart';

enum AppAuthStatus { initial, checking, authenticated, unauthenticated }

@freezed
abstract class AppState with _$AppState {
  const AppState._();

  const factory AppState({
    @Default(AppAuthStatus.initial) AppAuthStatus authStatus,
    AppFailure? failure,
  }) = _AppState;

  bool get isChecking =>
      authStatus == AppAuthStatus.initial ||
      authStatus == AppAuthStatus.checking;
}
