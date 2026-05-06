import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:imovie_app/core/bloc/base_state.dart';
import 'package:imovie_app/core/error/app_failure.dart';

part 'auth_state.freezed.dart';

enum AuthMode { signIn, signUp }

@freezed
abstract class AuthState with _$AuthState implements BaseState {
  const AuthState._();

  const factory AuthState({
    required AuthMode mode,
    @Default(PageStatus.loaded) PageStatus pageStatus,
    @Default(false) bool processing,
    AppFailure? failure,
    @Default(true) bool rememberMe,
    @Default(true) bool acceptedTerms,
    @Default(false) bool passwordVisible,
    String? successMessage,
  }) = _AuthState;

  bool get isSignIn => mode == AuthMode.signIn;

  @override
  AuthState copyWithBase({
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
