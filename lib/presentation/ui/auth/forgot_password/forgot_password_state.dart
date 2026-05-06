import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:imovie_app/core/bloc/base_state.dart';
import 'package:imovie_app/core/error/app_failure.dart';

part 'forgot_password_state.freezed.dart';

@freezed
abstract class ForgotPasswordState
    with _$ForgotPasswordState
    implements BaseState {
  const ForgotPasswordState._();

  const factory ForgotPasswordState({
    @Default(PageStatus.loaded) PageStatus pageStatus,
    @Default(false) bool processing,
    AppFailure? failure,
    String? successMessage,
  }) = _ForgotPasswordState;

  @override
  ForgotPasswordState copyWithBase({
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
