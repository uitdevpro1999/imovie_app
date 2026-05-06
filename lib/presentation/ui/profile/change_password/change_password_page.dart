import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/core/di/service_locator.dart';
import 'package:imovie_app/l10n/app_localizations.dart';
import 'package:imovie_app/presentation/common/pages/base_page.dart';
import 'package:imovie_app/presentation/ui/profile/change_password/change_password_cubit.dart';
import 'package:imovie_app/presentation/ui/profile/change_password/change_password_state.dart';
import 'package:imovie_app/presentation/ui/profile/change_password/widgets/password_field.dart';
import 'package:imovie_app/presentation/widgets/imovie_app_bar.dart';
import 'package:imovie_app/presentation/widgets/imovie_buttons.dart';

@RoutePage()
class ChangePasswordPage
    extends BasePage<ChangePasswordCubit, ChangePasswordState>
    implements AutoRouteWrapper {
  ChangePasswordPage({super.key});

  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(create: (_) => sl<ChangePasswordCubit>(), child: this);
  }

  @override
  Widget wrapPage(
    BuildContext context,
    ChangePasswordState state,
    Widget child,
  ) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.grayscale950,
      appBar: IMovieAppBar(title: l10n.changePasswordTitle),
      body: SafeArea(top: false, child: child),
    );
  }

  @override
  Widget buildPage(
    BuildContext context,
    ChangePasswordCubit cubit,
    ChangePasswordState state,
  ) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            children: [
              Text(
                l10n.changePasswordSubtitle,
                style: AppTypography.body2Regular.copyWith(
                  color: AppColors.grayscale300,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 24),
              ChangePasswordField(
                label: l10n.changePasswordCurrentLabel,
                hintText: l10n.changePasswordCurrentHint,
                controller: _currentPasswordController,
                obscureText: !state.currentPasswordVisible,
                onToggleVisibility: cubit.toggleCurrentPasswordVisible,
              ),
              const SizedBox(height: 16),
              ChangePasswordField(
                label: l10n.changePasswordNewLabel,
                hintText: l10n.changePasswordNewHint,
                controller: _newPasswordController,
                obscureText: !state.newPasswordVisible,
                onToggleVisibility: cubit.toggleNewPasswordVisible,
              ),
              const SizedBox(height: 16),
              ChangePasswordField(
                label: l10n.changePasswordConfirmLabel,
                hintText: l10n.changePasswordConfirmHint,
                controller: _confirmPasswordController,
                obscureText: !state.confirmPasswordVisible,
                onToggleVisibility: cubit.toggleConfirmPasswordVisible,
              ),
            ],
          ),
        ),
        SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: SizedBox(
              width: double.infinity,
              child: IMovieButton(
                label: l10n.changePasswordSaveAction,
                type: IMovieButtonType.filled,
                showLeadingIcon: false,
                enabled: !state.processing,
                onPressed: () async {
                  final changed = await cubit.submit(
                    currentPassword: _currentPasswordController.text,
                    newPassword: _newPasswordController.text,
                    confirmPassword: _confirmPasswordController.text,
                    messages: ChangePasswordMessages(
                      invalidCurrentPassword: l10n.changePasswordInvalidCurrent,
                      invalidNewPassword: l10n.changePasswordInvalidNew,
                      passwordMismatch: l10n.authPasswordMismatch,
                      passwordUnchanged: l10n.changePasswordUnchanged,
                      success: l10n.changePasswordSuccess,
                    ),
                  );
                  if (changed && context.mounted) {
                    await context.router.maybePop();
                  }
                },
              ),
            ),
          ),
        ),
      ],
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
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
  }
}
