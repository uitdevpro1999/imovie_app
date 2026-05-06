import 'package:imovie_app/core/bloc/base_cubit.dart';
import 'package:imovie_app/core/error/app_failure.dart';
import 'package:imovie_app/domain/usecases/session/reset_password_for_email_use_case.dart';
import 'package:imovie_app/presentation/ui/auth/forgot_password/forgot_password_state.dart';

class ForgotPasswordCubit extends BaseCubit<ForgotPasswordState> {
  ForgotPasswordCubit({
    required ResetPasswordForEmailUseCase resetPasswordForEmailUseCase,
  }) : _resetPasswordForEmailUseCase = resetPasswordForEmailUseCase,
       super(const ForgotPasswordState());

  final ResetPasswordForEmailUseCase _resetPasswordForEmailUseCase;

  Future<void> submit({
    required String email,
    required ForgotPasswordMessages messages,
  }) async {
    final normalizedEmail = email.trim();
    if (normalizedEmail.isEmpty || !normalizedEmail.contains('@')) {
      emit(
        state.copyWith(
          failure: AppFailure.unknown(messages.invalidEmail),
          successMessage: null,
        ),
      );
      showErrorToast(messages.invalidEmail);
      return;
    }

    emit(state.copyWith(processing: true, failure: null, successMessage: null));
    final result = await _resetPasswordForEmailUseCase(
      ResetPasswordForEmailParams(email: normalizedEmail),
    );
    emit(
      result.map(
        success: (_) => state.copyWith(
          processing: false,
          failure: null,
          successMessage: messages.success,
        ),
        failure: (failure) => state.copyWith(
          processing: false,
          failure: failure,
          successMessage: null,
        ),
      ),
    );
    result.map(
      success: (_) => showSuccessToast(messages.success),
      failure: showFailureToast,
    );
  }
}

class ForgotPasswordMessages {
  const ForgotPasswordMessages({
    required this.invalidEmail,
    required this.success,
  });

  final String invalidEmail;
  final String success;
}
