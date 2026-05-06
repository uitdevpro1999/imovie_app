import 'package:imovie_app/core/bloc/base_cubit.dart';
import 'package:imovie_app/core/error/app_failure.dart';
import 'package:imovie_app/domain/usecases/session/change_password_use_case.dart';
import 'package:imovie_app/presentation/ui/profile/change_password/change_password_state.dart';

class ChangePasswordCubit extends BaseCubit<ChangePasswordState> {
  ChangePasswordCubit({required ChangePasswordUseCase changePasswordUseCase})
    : _changePasswordUseCase = changePasswordUseCase,
      super(const ChangePasswordState());

  final ChangePasswordUseCase _changePasswordUseCase;

  void toggleCurrentPasswordVisible() {
    emit(state.copyWith(currentPasswordVisible: !state.currentPasswordVisible));
  }

  void toggleNewPasswordVisible() {
    emit(state.copyWith(newPasswordVisible: !state.newPasswordVisible));
  }

  void toggleConfirmPasswordVisible() {
    emit(state.copyWith(confirmPasswordVisible: !state.confirmPasswordVisible));
  }

  Future<bool> submit({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
    required ChangePasswordMessages messages,
  }) async {
    final validationFailure = _validate(
      currentPassword: currentPassword,
      newPassword: newPassword,
      confirmPassword: confirmPassword,
      messages: messages,
    );
    if (validationFailure != null) {
      emit(state.copyWith(failure: validationFailure, successMessage: null));
      showFailureToast(validationFailure);
      return false;
    }

    emit(state.copyWith(processing: true, failure: null, successMessage: null));

    final result = await _changePasswordUseCase(
      ChangePasswordParams(
        currentPassword: currentPassword,
        newPassword: newPassword,
      ),
    );
    return result.map(
      success: (_) {
        emit(
          state.copyWith(
            processing: false,
            failure: null,
            successMessage: messages.success,
          ),
        );
        showSuccessToast(messages.success);
        return true;
      },
      failure: (failure) {
        emit(
          state.copyWith(
            processing: false,
            failure: failure,
            successMessage: null,
          ),
        );
        showFailureToast(failure);
        return false;
      },
    );
  }

  AppFailure? _validate({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
    required ChangePasswordMessages messages,
  }) {
    if (currentPassword.length < 6) {
      return AppFailure.unknown(messages.invalidCurrentPassword);
    }

    if (newPassword.length < 6) {
      return AppFailure.unknown(messages.invalidNewPassword);
    }

    if (newPassword != confirmPassword) {
      return AppFailure.unknown(messages.passwordMismatch);
    }

    if (newPassword == currentPassword) {
      return AppFailure.unknown(messages.passwordUnchanged);
    }

    return null;
  }
}

class ChangePasswordMessages {
  const ChangePasswordMessages({
    required this.invalidCurrentPassword,
    required this.invalidNewPassword,
    required this.passwordMismatch,
    required this.passwordUnchanged,
    required this.success,
  });

  final String invalidCurrentPassword;
  final String invalidNewPassword;
  final String passwordMismatch;
  final String passwordUnchanged;
  final String success;
}
