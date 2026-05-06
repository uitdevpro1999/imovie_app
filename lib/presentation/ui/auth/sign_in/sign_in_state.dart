import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:imovie_app/core/bloc/base_state.dart';
import 'package:imovie_app/core/error/app_failure.dart';

part 'sign_in_state.freezed.dart';

@freezed
abstract class SignInState with _$SignInState implements BaseState {
  const SignInState._();

  const factory SignInState({
    @Default(PageStatus.loaded) PageStatus pageStatus,
    @Default(false) bool processing,
    AppFailure? failure,
    @Default(true) bool rememberMe,
    @Default(false) bool passwordVisible,
    String? successMessage,
  }) = _SignInState;

  @override
  SignInState copyWithBase({
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
