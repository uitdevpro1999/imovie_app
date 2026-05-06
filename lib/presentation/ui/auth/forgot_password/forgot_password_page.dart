import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/core/di/service_locator.dart';
import 'package:imovie_app/l10n/app_localizations.dart';
import 'package:imovie_app/presentation/common/pages/base_page.dart';
import 'package:imovie_app/presentation/ui/auth/forgot_password/forgot_password_cubit.dart';
import 'package:imovie_app/presentation/ui/auth/forgot_password/forgot_password_state.dart';
import 'package:imovie_app/presentation/widgets/imovie_app_bar.dart';
import 'package:imovie_app/presentation/widgets/imovie_buttons.dart';

@RoutePage()
class ForgotPasswordPage
    extends BasePage<ForgotPasswordCubit, ForgotPasswordState>
    implements AutoRouteWrapper {
  ForgotPasswordPage({super.key});

  final TextEditingController _emailController = TextEditingController();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(create: (_) => sl<ForgotPasswordCubit>(), child: this);
  }

  @override
  Widget wrapPage(
    BuildContext context,
    ForgotPasswordState state,
    Widget child,
  ) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.grayscale950,
      appBar: IMovieAppBar(title: l10n.authForgotPasswordTitle),
      body: SafeArea(top: false, child: child),
    );
  }

  @override
  Widget buildPage(
    BuildContext context,
    ForgotPasswordCubit cubit,
    ForgotPasswordState state,
  ) {
    final l10n = AppLocalizations.of(context)!;

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
            Text(
              l10n.authForgotPasswordSubtitle,
              style: AppTypography.body2Regular.copyWith(
                color: AppColors.grayscale300,
              ),
            ),
            const SizedBox(height: 28),
            Text(
              l10n.authEmailLabel,
              style: AppTypography.body2Medium.copyWith(color: AppColors.white),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              style: AppTypography.body2Regular.copyWith(
                color: AppColors.white,
              ),
              cursorColor: AppColors.yellow500,
              decoration: InputDecoration(
                hintText: l10n.authEmailHint,
                hintStyle: AppTypography.body2Regular.copyWith(
                  color: AppColors.grayscale300,
                ),
                filled: true,
                fillColor: AppColors.grayscale900,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 16,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.yellow500),
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: IMovieButton(
                type: IMovieButtonType.filled,
                label: l10n.authForgotPasswordSubmit,
                showLeadingIcon: false,
                enabled: !state.processing,
                onPressed: () => cubit.submit(
                  email: _emailController.text,
                  messages: ForgotPasswordMessages(
                    invalidEmail: l10n.authInvalidEmail,
                    success: l10n.authForgotPasswordSuccess,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void onDispose(BuildContext context) {
    _emailController.dispose();
  }
}
