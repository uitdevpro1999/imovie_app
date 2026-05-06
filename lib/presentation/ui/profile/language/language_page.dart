import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/core/di/service_locator.dart';
import 'package:imovie_app/l10n/app_localizations.dart';
import 'package:imovie_app/presentation/app/app_cubit.dart';
import 'package:imovie_app/presentation/common/pages/base_page.dart';
import 'package:imovie_app/presentation/ui/profile/language/language_cubit.dart';
import 'package:imovie_app/presentation/ui/profile/language/language_state.dart';
import 'package:imovie_app/presentation/ui/profile/language/widgets/language_option_tile.dart';
import 'package:imovie_app/presentation/widgets/imovie_app_bar.dart';

@RoutePage()
class LanguagePage extends BasePage<LanguageCubit, LanguageState>
    implements AutoRouteWrapper {
  const LanguagePage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<LanguageCubit>(param1: context.read<AppCubit>()),
      child: this,
    );
  }

  @override
  Widget wrapPage(BuildContext context, LanguageState state, Widget child) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.grayscale950,
      appBar: IMovieAppBar(title: l10n.languageSelectTitle),
      body: SafeArea(top: false, child: child),
    );
  }

  @override
  Widget buildPage(
    BuildContext context,
    LanguageCubit cubit,
    LanguageState state,
  ) {
    final l10n = AppLocalizations.of(context)!;
    final messages = LanguageMessages(
      success: l10n.languageChangeSuccess,
      error: l10n.languageChangeError,
    );

    return Stack(
      children: [
        ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          children: [
            Text(
              l10n.languageSelectSubtitle,
              style: AppTypography.body2Regular.copyWith(
                color: AppColors.grayscale300,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 20),
            LanguageOptionTile(
              flagEmoji: '🇻🇳',
              title: l10n.languageVietnameseTitle,
              subtitle: l10n.languageVietnameseSubtitle,
              selected: state.selectedLanguageCode == 'vi',
              onTap: state.processing
                  ? null
                  : () => cubit.selectLanguage(
                      languageCode: 'vi',
                      messages: messages,
                    ),
            ),
            const SizedBox(height: 12),
            LanguageOptionTile(
              flagEmoji: '🇺🇸',
              title: l10n.languageEnglishTitle,
              subtitle: l10n.languageEnglishSubtitle,
              selected: state.selectedLanguageCode == 'en',
              onTap: state.processing
                  ? null
                  : () => cubit.selectLanguage(
                      languageCode: 'en',
                      messages: messages,
                    ),
            ),
          ],
        ),
        if (state.processing)
          const Positioned.fill(
            child: ColoredBox(
              color: Colors.black38,
              child: Center(
                child: CircularProgressIndicator(color: AppColors.yellow500),
              ),
            ),
          ),
      ],
    );
  }
}
