import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:imovie_app/config/navigation/app_router.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/gen/assets.gen.dart';
import 'package:imovie_app/l10n/app_localizations.dart';
import 'package:imovie_app/presentation/ui/auth/shared/widgets/auth_checkbox_row.dart';
import 'package:imovie_app/presentation/ui/auth/shared/widgets/auth_footer_link.dart';
import 'package:imovie_app/presentation/ui/auth/shared/widgets/auth_form_field.dart';
import 'package:imovie_app/presentation/widgets/imovie_buttons.dart';

class AuthFormView extends StatelessWidget {
  const AuthFormView({
    super.key,
    required this.l10n,
    required this.isSignIn,
    required this.processing,
    required this.passwordVisible,
    required this.rememberMe,
    required this.acceptedTerms,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.onToggleRememberMe,
    required this.onToggleAcceptedTerms,
    required this.onTogglePasswordVisibility,
    required this.onSubmit,
  });

  final AppLocalizations l10n;
  final bool isSignIn;
  final bool processing;
  final bool passwordVisible;
  final bool rememberMe;
  final bool acceptedTerms;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final VoidCallback? onToggleRememberMe;
  final VoidCallback? onToggleAcceptedTerms;
  final VoidCallback onTogglePasswordVisibility;
  final Future<void> Function() onSubmit;

  @override
  Widget build(BuildContext context) {
    final title = isSignIn ? l10n.authSignInTitle : l10n.authSignUpTitle;
    final subtitle = isSignIn
        ? l10n.authSignInSubtitle
        : l10n.authSignUpSubtitle;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight:
              MediaQuery.sizeOf(context).height -
              MediaQuery.paddingOf(context).vertical -
              36,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Assets.images.logo.image(
                width: 88,
                height: 88,
                fit: BoxFit.contain,
                semanticLabel: 'iMovie',
              ),
            ),
            const SizedBox(height: 24),
            Text(
              title,
              style: AppTypography.h2.copyWith(color: AppColors.white),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: AppTypography.body2Regular.copyWith(
                color: AppColors.grayscale300,
              ),
            ),
            const SizedBox(height: 28),
            AuthFormField(
              label: l10n.authEmailLabel,
              hintText: l10n.authEmailHint,
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            AuthFormField(
              label: l10n.authPasswordLabel,
              hintText: l10n.authPasswordHint,
              controller: passwordController,
              obscureText: !passwordVisible,
              suffixIcon: IconButton(
                onPressed: onTogglePasswordVisibility,
                icon: Icon(
                  passwordVisible
                      ? FluentIcons.eye_24_regular
                      : FluentIcons.eye_off_24_regular,
                  color: AppColors.white,
                ),
              ),
            ),
            if (!isSignIn) ...[
              const SizedBox(height: 16),
              AuthFormField(
                label: l10n.authConfirmPasswordLabel,
                hintText: l10n.authConfirmPasswordHint,
                controller: confirmPasswordController,
                obscureText: !passwordVisible,
                suffixIcon: IconButton(
                  onPressed: onTogglePasswordVisibility,
                  icon: Icon(
                    passwordVisible
                        ? FluentIcons.eye_24_regular
                        : FluentIcons.eye_off_24_regular,
                    color: AppColors.white,
                  ),
                ),
              ),
            ],
            const SizedBox(height: 22),
            if (isSignIn)
              Row(
                children: [
                  Expanded(
                    child: AuthCheckboxRow(
                      label: l10n.authRememberMe,
                      isChecked: rememberMe,
                      onTap: onToggleRememberMe ?? () {},
                    ),
                  ),
                  GestureDetector(
                    onTap: () =>
                        context.router.root.push(ForgotPasswordRoute()),
                    child: Text(
                      l10n.authForgotPassword,
                      style: AppTypography.body2Medium.copyWith(
                        color: AppColors.yellow500,
                      ),
                    ),
                  ),
                ],
              )
            else
              AuthCheckboxRow(
                label: l10n.authAcceptTerms,
                isChecked: acceptedTerms,
                onTap: onToggleAcceptedTerms ?? () {},
              ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: IMovieButton(
                type: IMovieButtonType.filled,
                label: isSignIn ? l10n.authSignInAction : l10n.authSignUpAction,
                showLeadingIcon: false,
                enabled: !processing,
                onPressed: onSubmit,
              ),
            ),
            const SizedBox(height: 48),
            Center(
              child: AuthFooterLink(
                prefix: isSignIn
                    ? l10n.authSignInFooterPrefix
                    : l10n.authSignUpFooterPrefix,
                actionLabel: isSignIn
                    ? l10n.authSignUpAction
                    : l10n.authSignInAction,
                onTap: () => context.router.root.replace(
                  isSignIn ? SignUpRoute() : SignInRoute(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
