import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:imovie_app/core/bloc/base_state.dart';
import 'package:imovie_app/core/error/app_failure.dart';

part 'change_password_state.freezed.dart';

@freezed
abstract class ChangePasswordState
    with _$ChangePasswordState
    implements BaseState {
  const ChangePasswordState._();

  const factory ChangePasswordState({
    @Default(PageStatus.loaded) PageStatus pageStatus,
    @Default(false) bool processing,
    AppFailure? failure,
    @Default(false) bool currentPasswordVisible,
    @Default(false) bool newPasswordVisible,
    @Default(false) bool confirmPasswordVisible,
    String? successMessage,
  }) = _ChangePasswordState;

  @override
  ChangePasswordState copyWithBase({
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
