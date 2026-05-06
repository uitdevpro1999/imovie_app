import 'package:imovie_app/core/bloc/base_cubit.dart';
import 'package:imovie_app/core/error/app_failure.dart';
import 'package:imovie_app/core/events/app_auth_event.dart';
import 'package:imovie_app/core/events/app_event_bus.dart';
import 'package:imovie_app/domain/usecases/session/sign_in_with_password_use_case.dart';
import 'package:imovie_app/presentation/ui/auth/sign_in/sign_in_state.dart';

class SignInCubit extends BaseCubit<SignInState> {
  SignInCubit({required SignInWithPasswordUseCase signInWithPasswordUseCase})
    : _signInWithPasswordUseCase = signInWithPasswordUseCase,
      super(const SignInState());

  final SignInWithPasswordUseCase _signInWithPasswordUseCase;

  void toggleRememberMe() {
    emit(state.copyWith(rememberMe: !state.rememberMe));
  }

  void togglePasswordVisibility() {
    emit(state.copyWith(passwordVisible: !state.passwordVisible));
  }

  Future<void> submit({
    required String email,
    required String password,
    required SignInValidationMessages messages,
  }) async {
    final validationFailure = _validate(
      email: email,
      password: password,
      messages: messages,
    );
    if (validationFailure != null) {
      emit(state.copyWith(failure: validationFailure, successMessage: null));
      showFailureToast(validationFailure);
      return;
    }

    emit(state.copyWith(processing: true, failure: null, successMessage: null));

    final result = await _signInWithPasswordUseCase(
      SignInWithPasswordParams(email: email.trim(), password: password),
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
    required SignInValidationMessages messages,
  }) {
    final normalizedEmail = email.trim();
    if (normalizedEmail.isEmpty || !normalizedEmail.contains('@')) {
      return AppFailure.unknown(messages.invalidEmail);
    }

    if (password.length < 6) {
      return AppFailure.unknown(messages.invalidPassword);
    }

    return null;
  }
}

class SignInValidationMessages {
  const SignInValidationMessages({
    required this.invalidEmail,
    required this.invalidPassword,
    required this.success,
  });

  final String invalidEmail;
  final String invalidPassword;
  final String success;
}
