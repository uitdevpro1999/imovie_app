import 'package:imovie_app/core/bloc/base_cubit.dart';
import 'package:imovie_app/core/error/app_failure.dart';
import 'package:imovie_app/domain/usecases/session/sign_in_with_password_use_case.dart';
import 'package:imovie_app/domain/usecases/session/sign_up_with_password_use_case.dart';
import 'package:imovie_app/presentation/ui/auth/auth_state.dart';

class AuthCubit extends BaseCubit<AuthState> {
  AuthCubit({
    required AuthMode mode,
    required SignInWithPasswordUseCase signInWithPasswordUseCase,
    required SignUpWithPasswordUseCase signUpWithPasswordUseCase,
  }) : _signInWithPasswordUseCase = signInWithPasswordUseCase,
       _signUpWithPasswordUseCase = signUpWithPasswordUseCase,
       super(AuthState(mode: mode));

  final SignInWithPasswordUseCase _signInWithPasswordUseCase;
  final SignUpWithPasswordUseCase _signUpWithPasswordUseCase;

  void toggleRememberMe() {
    emit(state.copyWith(rememberMe: !state.rememberMe));
  }

  void toggleAcceptedTerms() {
    emit(state.copyWith(acceptedTerms: !state.acceptedTerms));
  }

  void togglePasswordVisibility() {
    emit(state.copyWith(passwordVisible: !state.passwordVisible));
  }

  Future<bool> submit({
    required String email,
    required String password,
    required String confirmPassword,
    required AuthValidationMessages validationMessages,
  }) async {
    final validationFailure = _validate(
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      messages: validationMessages,
    );
    if (validationFailure != null) {
      emit(state.copyWith(failure: validationFailure, successMessage: null));
      showFailureToast(validationFailure);
      return false;
    }

    emit(state.copyWith(processing: true, failure: null, successMessage: null));

    final result = state.isSignIn
        ? await _signInWithPasswordUseCase(
            SignInWithPasswordParams(email: email.trim(), password: password),
          )
        : await _signUpWithPasswordUseCase(
            SignUpWithPasswordParams(email: email.trim(), password: password),
          );

    return result.map(
      success: (_) {
        final message = state.isSignIn
            ? validationMessages.signInSuccess
            : validationMessages.signUpSuccess;
        emit(
          state.copyWith(
            processing: false,
            failure: null,
            successMessage: message,
          ),
        );
        showSuccessToast(message);
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
    required String email,
    required String password,
    required String confirmPassword,
    required AuthValidationMessages messages,
  }) {
    final normalizedEmail = email.trim();
    if (normalizedEmail.isEmpty || !normalizedEmail.contains('@')) {
      return AppFailure.unknown(messages.invalidEmail);
    }

    if (password.length < 6) {
      return AppFailure.unknown(messages.invalidPassword);
    }

    if (!state.isSignIn && password != confirmPassword) {
      return AppFailure.unknown(messages.passwordMismatch);
    }

    if (!state.isSignIn && !state.acceptedTerms) {
      return AppFailure.unknown(messages.acceptTerms);
    }

    return null;
  }
}

class AuthValidationMessages {
  const AuthValidationMessages({
    required this.invalidEmail,
    required this.invalidPassword,
    required this.passwordMismatch,
    required this.acceptTerms,
    required this.signInSuccess,
    required this.signUpSuccess,
  });

  final String invalidEmail;
  final String invalidPassword;
  final String passwordMismatch;
  final String acceptTerms;
  final String signInSuccess;
  final String signUpSuccess;
}
