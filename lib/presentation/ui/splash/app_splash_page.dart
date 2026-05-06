import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/core/di/service_locator.dart';
import 'package:imovie_app/gen/assets.gen.dart';
import 'package:imovie_app/l10n/app_localizations.dart';
import 'package:imovie_app/presentation/common/pages/base_page.dart';
import 'package:imovie_app/presentation/ui/splash/splash_cubit.dart';
import 'package:imovie_app/presentation/ui/splash/splash_state.dart';

@RoutePage()
class AppSplashPage extends BasePage<SplashCubit, SplashState>
    implements AutoRouteWrapper {
  const AppSplashPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(create: (_) => sl<SplashCubit>(), child: this);
  }

  @override
  Widget wrapPage(BuildContext context, SplashState state, Widget child) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.grayscale950,
        body: SafeArea(child: child),
      ),
    );
  }

  @override
  Widget buildPage(BuildContext context, SplashCubit cubit, SplashState state) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Assets.images.logo.image(
                  width: 88,
                  height: 88,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'iMovie',
                textAlign: TextAlign.center,
                style: AppTypography.h1.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w700,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 84,
          child: SizedBox.square(
            dimension: 48,
            child: CircularProgressIndicator(
              strokeWidth: 7,
              color: AppColors.yellow500,
              backgroundColor: AppColors.yellow950,
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
}
