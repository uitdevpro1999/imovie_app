import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/gen/assets.gen.dart';
import 'package:imovie_app/presentation/app/app_cubit.dart';

@RoutePage()
class AppSplashPage extends StatefulWidget {
  const AppSplashPage({super.key});

  @override
  State<AppSplashPage> createState() => _AppSplashPageState();
}

class _AppSplashPageState extends State<AppSplashPage> {
  static const _splashDuration = Duration(seconds: 3);

  @override
  void initState() {
    super.initState();
    _checkAuthenticationAfterSplash();
  }

  Future<void> _checkAuthenticationAfterSplash() async {
    await Future<void>.delayed(_splashDuration);
    if (!mounted) {
      return;
    }
    await context.read<AppCubit>().checkAuthentication();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.grayscale950,
        body: SafeArea(
          child: Stack(
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
                      'Movie GO',
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
          ),
        ),
      ),
    );
  }
}
