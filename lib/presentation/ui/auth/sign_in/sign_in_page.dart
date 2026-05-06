import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/core/di/service_locator.dart';
import 'package:imovie_app/l10n/app_localizations.dart';
import 'package:imovie_app/presentation/common/pages/base_page.dart';
import 'package:imovie_app/presentation/ui/auth/shared/widgets/auth_form_view.dart';
import 'package:imovie_app/presentation/ui/auth/sign_in/sign_in_cubit.dart';
import 'package:imovie_app/presentation/ui/auth/sign_in/sign_in_state.dart';

@RoutePage()
class SignInPage extends BasePage<SignInCubit, SignInState>
    implements AutoRouteWrapper {
  SignInPage({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(create: (_) => sl<SignInCubit>(), child: this);
  }

  @override
  Widget wrapPage(BuildContext context, SignInState state, Widget child) {
    return Scaffold(
      backgroundColor: AppColors.grayscale950,
      body: SafeArea(child: child),
    );
  }

  @override
  Widget buildPage(BuildContext context, SignInCubit cubit, SignInState state) {
    final l10n = AppLocalizations.of(context)!;
    return AuthFormView(
      l10n: l10n,
      isSignIn: true,
      processing: state.processing,
      passwordVisible: state.passwordVisible,
      rememberMe: state.rememberMe,
      acceptedTerms: true,
      emailController: _emailController,
      passwordController: _passwordController,
      confirmPasswordController: _confirmPasswordController,
      onToggleRememberMe: cubit.toggleRememberMe,
      onToggleAcceptedTerms: null,
      onTogglePasswordVisibility: cubit.togglePasswordVisibility,
      onSubmit: () => cubit.submit(
        email: _emailController.text,
        password: _passwordController.text,
        messages: SignInValidationMessages(
          invalidEmail: l10n.authInvalidEmail,
          invalidPassword: l10n.authInvalidPassword,
          success: l10n.authSignInSuccess,
        ),
      ),
    );
  }

  @override
  Widget buildError(
    BuildContext context,
    AppLocalizations l10n,
    String message,
    VoidCallback onRetry,
  ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: AppTypography.body1Regular.copyWith(color: AppColors.white),
        ),
      ),
    );
  }

  @override
  void onDispose(BuildContext context) {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }
}
