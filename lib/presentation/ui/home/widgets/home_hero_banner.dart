import 'package:flutter/material.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/l10n/app_localizations.dart';
import 'package:imovie_app/presentation/ui/home/home_state.dart';
import 'package:imovie_app/presentation/widgets/imovie_remote_image.dart';

class HomeHeroBanner extends StatelessWidget {
  const HomeHeroBanner({super.key, required this.movie});

  final HomeMovieViewData movie;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SizedBox(
      height: 205,
      child: Stack(
        children: [
          Positioned.fill(
            child: IMovieRemoteImage(
              imageUrl: movie.posterUrl,
              fit: BoxFit.cover,
              borderRadius: BorderRadius.circular(20),
              placeholderLabel: movie.title,
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, AppColors.black88],
                ),
              ),
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.3),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.play_arrow_rounded,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        movie.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.body1Regular.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        _buildSubtitle(l10n),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.captionRegular1.copyWith(
                          color: AppColors.grayscale300,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _buildSubtitle(AppLocalizations l10n) {
    final subtitle = movie.heroSubtitle;
    switch (subtitle.type) {
      case HomeHeroSubtitleType.episodeDuration:
        return l10n.homeMetaEpisode(subtitle.primary, subtitle.secondary);
      case HomeHeroSubtitleType.languageQuality:
        return l10n.homeMetaLanguage(subtitle.primary, subtitle.secondary);
      case HomeHeroSubtitleType.originalTitle:
        return subtitle.primary;
      case HomeHeroSubtitleType.fallback:
        return l10n.homeHeroDefaultSubtitle;
    }
  }
}
