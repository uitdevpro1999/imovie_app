import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:imovie_app/config/navigation/app_router.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_screen_util.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/core/di/service_locator.dart';
import 'package:imovie_app/l10n/app_localizations.dart';
import 'package:imovie_app/presentation/app/app_cubit.dart';
import 'package:imovie_app/presentation/app/app_state.dart';
import 'package:imovie_app/presentation/toast/app_toast_listener.dart';
import 'package:toastification/toastification.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    const colorScheme = ColorScheme.light(
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      secondary: AppColors.success,
      onSecondary: AppColors.white,
      surface: AppColors.surface,
      onSurface: AppColors.textPrimary,
      error: AppColors.danger,
      onError: AppColors.white,
    );

    return BlocProvider(
      create: (_) => sl<AppCubit>()..loadLocale(),
      child: BlocConsumer<AppCubit, AppState>(
        listenWhen: (previous, current) =>
            previous.authStatus != current.authStatus,
        listener: (context, state) {
          if (appRouter.current.name == ActiveCallRoute.name) {
            return;
          }

          switch (state.authStatus) {
            case AppAuthStatus.authenticated:
              if (_shouldRedirectAuthenticatedRoute(appRouter.current.name)) {
                appRouter.replaceAll([const MainRoute()]);
              }
            case AppAuthStatus.unauthenticated:
              appRouter.replaceAll([SignInRoute()]);
            case AppAuthStatus.initial:
            case AppAuthStatus.checking:
              break;
          }
        },
        buildWhen: (previous, current) =>
            previous.localeCode != current.localeCode,
        builder: (context, state) {
          return ToastificationWrapper(
            child: AppToastListener(
              child: MaterialApp.router(
                locale: state.locale,
                onGenerateTitle: (context) =>
                    AppLocalizations.of(context)!.appTitle,
                builder: (context, child) {
                  return AppScreenUtilInit(
                    designSize: const Size(390, 844),
                    child: child ?? const SizedBox.shrink(),
                  );
                },
                theme: ThemeData(
                  useMaterial3: true,
                  brightness: Brightness.light,
                  fontFamily: AppTypography.fontFamily,
                  colorScheme: colorScheme,
                  scaffoldBackgroundColor: AppColors.background,
                  canvasColor: AppColors.background,
                  cardColor: AppColors.surface,
                  dividerColor: AppColors.surfaceStroke,
                  appBarTheme: const AppBarTheme(
                    backgroundColor: AppColors.background,
                    foregroundColor: AppColors.textPrimary,
                    surfaceTintColor: Colors.transparent,
                    elevation: 0,
                    centerTitle: false,
                  ),
                  textTheme: AppTypography.textTheme,
                ),
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: AppLocalizations.supportedLocales,
                routerConfig: appRouter.config(),
              ),
            ),
          );
        },
      ),
    );
  }
}

bool _shouldRedirectAuthenticatedRoute(String routeName) {
  return routeName == AppSplashRoute.name ||
      routeName == SignInRoute.name ||
      routeName == SignUpRoute.name ||
      routeName == ForgotPasswordRoute.name;
}
