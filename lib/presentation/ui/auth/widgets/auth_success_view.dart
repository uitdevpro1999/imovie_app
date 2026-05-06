part of '../auth_page.dart';

class _AuthSuccessView extends StatelessWidget {
  const _AuthSuccessView({
    required this.l10n,
    required this.state,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.onToggleRememberMe,
    required this.onToggleAcceptedTerms,
    required this.onTogglePasswordVisibility,
    required this.onSubmit,
  });

  final AppLocalizations l10n;
  final AuthState state;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final VoidCallback onToggleRememberMe;
  final VoidCallback onToggleAcceptedTerms;
  final VoidCallback onTogglePasswordVisibility;
  final Future<void> Function() onSubmit;

  @override
  Widget build(BuildContext context) {
    final isSignIn = state.isSignIn;
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
                semanticLabel: 'MovieGo',
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
            _AuthFormField(
              label: l10n.authEmailLabel,
              hintText: l10n.authEmailHint,
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            _AuthFormField(
              label: l10n.authPasswordLabel,
              hintText: l10n.authPasswordHint,
              controller: passwordController,
              obscureText: !state.passwordVisible,
              suffixIcon: IconButton(
                onPressed: onTogglePasswordVisibility,
                icon: Icon(
                  state.passwordVisible
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: AppColors.white,
                ),
              ),
            ),
            if (!isSignIn) ...[
              const SizedBox(height: 16),
              _AuthFormField(
                label: l10n.authConfirmPasswordLabel,
                hintText: l10n.authConfirmPasswordHint,
                controller: confirmPasswordController,
                obscureText: !state.passwordVisible,
                suffixIcon: IconButton(
                  onPressed: onTogglePasswordVisibility,
                  icon: Icon(
                    state.passwordVisible
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
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
                    child: _AuthCheckboxRow(
                      label: l10n.authRememberMe,
                      isChecked: state.rememberMe,
                      onTap: onToggleRememberMe,
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
              _AuthCheckboxRow(
                label: l10n.authAcceptTerms,
                isChecked: state.acceptedTerms,
                onTap: onToggleAcceptedTerms,
              ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: MovieGoButton(
                type: MovieGoButtonType.filled,
                label: isSignIn ? l10n.authSignInAction : l10n.authSignUpAction,
                showLeadingIcon: false,
                enabled: !state.processing,
                onPressed: onSubmit,
              ),
            ),
            const SizedBox(height: 48),
            Center(
              child: _AuthFooterLink(
                prefix: isSignIn
                    ? l10n.authSignInFooterPrefix
                    : l10n.authSignUpFooterPrefix,
                actionLabel: isSignIn
                    ? l10n.authSignUpAction
                    : l10n.authSignInAction,
                onTap: () => context.router.root.replace(
                  isSignIn ? const SignUpRoute() : const SignInRoute(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
