import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imovie_app/config/navigation/app_router.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/gen/assets.gen.dart';
import 'package:imovie_app/l10n/app_localizations.dart';
import 'package:imovie_app/presentation/app/app_cubit.dart';
import 'package:imovie_app/presentation/common/pages/base_page.dart';
import 'package:imovie_app/presentation/ui/auth/auth_cubit.dart';
import 'package:imovie_app/presentation/ui/auth/auth_state.dart';
import 'package:imovie_app/presentation/widgets/moviego_buttons.dart';

part 'widgets/auth_checkbox_row.dart';
part 'widgets/auth_footer_link.dart';
part 'widgets/auth_form_field.dart';
part 'widgets/auth_success_view.dart';

class AuthPage extends BasePage<AuthCubit, AuthState> {
  AuthPage({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget wrapPage(BuildContext context, AuthState state, Widget child) {
    return Scaffold(
      backgroundColor: AppColors.grayscale950,
      body: SafeArea(child: child),
    );
  }

  @override
  Widget buildPage(BuildContext context, AuthCubit cubit, AuthState state) {
    final l10n = AppLocalizations.of(context)!;

    return BlocSelector<AuthCubit, AuthState, AuthState>(
      selector: (state) => state,
      builder: (context, state) {
        return _AuthSuccessView(
          l10n: l10n,
          state: state,
          emailController: _emailController,
          passwordController: _passwordController,
          confirmPasswordController: _confirmPasswordController,
          onToggleRememberMe: cubit.toggleRememberMe,
          onToggleAcceptedTerms: cubit.toggleAcceptedTerms,
          onTogglePasswordVisibility: cubit.togglePasswordVisibility,
          onSubmit: () async {
            final authenticated = await cubit.submit(
              email: _emailController.text,
              password: _passwordController.text,
              confirmPassword: _confirmPasswordController.text,
              validationMessages: AuthValidationMessages(
                invalidEmail: l10n.authInvalidEmail,
                invalidPassword: l10n.authInvalidPassword,
                passwordMismatch: l10n.authPasswordMismatch,
                acceptTerms: l10n.authAcceptTermsError,
                signInSuccess: l10n.authSignInSuccess,
                signUpSuccess: l10n.authSignUpSuccess,
              ),
            );
            if (authenticated && context.mounted) {
              context.read<AppCubit>().markAuthenticated();
            }
          },
        );
      },
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
