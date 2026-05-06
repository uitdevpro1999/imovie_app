import 'package:imovie_app/core/bloc/base_cubit.dart';
import 'package:imovie_app/core/error/app_failure.dart';
import 'package:imovie_app/core/events/app_auth_event.dart';
import 'package:imovie_app/core/events/app_event_bus.dart';
import 'package:imovie_app/domain/usecases/session/sign_up_with_password_use_case.dart';
import 'package:imovie_app/presentation/ui/auth/sign_up/sign_up_state.dart';

class SignUpCubit extends BaseCubit<SignUpState> {
  SignUpCubit({required SignUpWithPasswordUseCase signUpWithPasswordUseCase})
    : _signUpWithPasswordUseCase = signUpWithPasswordUseCase,
      super(const SignUpState());

  final SignUpWithPasswordUseCase _signUpWithPasswordUseCase;

  void toggleAcceptedTerms() {
    emit(state.copyWith(acceptedTerms: !state.acceptedTerms));
  }

  void togglePasswordVisibility() {
    emit(state.copyWith(passwordVisible: !state.passwordVisible));
  }

  Future<void> submit({
    required String email,
    required String password,
    required String confirmPassword,
    required SignUpValidationMessages messages,
  }) async {
    final validationFailure = _validate(
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      messages: messages,
    );
    if (validationFailure != null) {
      emit(state.copyWith(failure: validationFailure, successMessage: null));
      showFailureToast(validationFailure);
      return;
    }

    emit(state.copyWith(processing: true, failure: null, successMessage: null));

    final result = await _signUpWithPasswordUseCase(
      SignUpWithPasswordParams(email: email.trim(), password: password),
    );
    result.map(
      success: (_) {
        emit(
          state.copyWith(
            processing: false,
            failure: null,
            successMessage: messages.success,
          ),
        );
        showSuccessToast(messages.success);
        appEventBus.emitAuth(AppAuthEvent.authenticated());
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
      },
    );
  }

  AppFailure? _validate({
    required String email,
    required String password,
    required String confirmPassword,
    required SignUpValidationMessages messages,
  }) {
    final normalizedEmail = email.trim();
    if (normalizedEmail.isEmpty || !normalizedEmail.contains('@')) {
      return AppFailure.unknown(messages.invalidEmail);
    }

    if (password.length < 6) {
      return AppFailure.unknown(messages.invalidPassword);
    }

    if (password != confirmPassword) {
      return AppFailure.unknown(messages.passwordMismatch);
    }

    if (!state.acceptedTerms) {
      return AppFailure.unknown(messages.acceptTerms);
    }

    return null;
  }
}

class SignUpValidationMessages {
  const SignUpValidationMessages({
    required this.invalidEmail,
    required this.invalidPassword,
    required this.passwordMismatch,
    required this.acceptTerms,
    required this.success,
  });

  final String invalidEmail;
  final String invalidPassword;
  final String passwordMismatch;
  final String acceptTerms;
  final String success;
}
