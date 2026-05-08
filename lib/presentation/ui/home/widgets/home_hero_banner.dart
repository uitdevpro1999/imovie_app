import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/l10n/app_localizations.dart';
import 'package:imovie_app/presentation/ui/home/home_state.dart';
import 'package:imovie_app/presentation/widgets/imovie_remote_image.dart';

class HomeHeroBanner extends StatelessWidget {
  const HomeHeroBanner({
    super.key,
    required this.movie,
    required this.onPlayTap,
    required this.onTrailerTap,
  });

  final HomeMovieViewData movie;
  final VoidCallback onPlayTap;
  final VoidCallback onTrailerTap;

  static double heightFor(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return (width * 0.78).clamp(276.0, 312.0).toDouble();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isTrailerOnly = movie.movie.isTrailerOnly;

    return SizedBox(
      height: heightFor(context),
      child: Stack(
        children: [
          Positioned.fill(
            child: IMovieRemoteImage(
              imageUrl: movie.posterUrl,
              fit: BoxFit.cover,
              borderRadius: BorderRadius.circular(26),
              placeholderLabel: movie.title,
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(26),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.black.withValues(alpha: 0.08),
                    AppColors.black.withValues(alpha: 0.25),
                    AppColors.black.withValues(alpha: 0.92),
                  ],
                  stops: const [0, 0.38, 1],
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(26),
                border: Border.all(
                  color: AppColors.white.withValues(alpha: 0.08),
                ),
              ),
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            top: 16,
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _HeroMetaChip(
                  icon: FluentIcons.star_24_filled,
                  label: movie.ratingLabel,
                  highlighted: true,
                ),
                if (movie.movie.year > 0)
                  _HeroMetaChip(label: movie.movie.yearLabel),
                if (movie.movie.qualityLabel.trim().isNotEmpty)
                  _HeroMetaChip(label: movie.movie.qualityLabel),
                if (movie.movie.languageLabel.trim().isNotEmpty)
                  _HeroMetaChip(label: movie.movie.languageLabel),
              ],
            ),
          ),
          Positioned(
            left: 18,
            right: 18,
            bottom: 18,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  movie.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.h1.copyWith(
                    color: AppColors.white,
                    height: 1.12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _buildSubtitle(l10n),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.body2Regular.copyWith(
                    color: AppColors.grayscale200,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _HeroPrimaryPill(
                      label: isTrailerOnly
                          ? l10n.movieDetailActionTrailer
                          : l10n.movieDetailPlay,
                      icon: isTrailerOnly
                          ? FluentIcons.movies_and_tv_24_regular
                          : FluentIcons.play_24_filled,
                      onTap: isTrailerOnly ? onTrailerTap : onPlayTap,
                    ),
                    if (!isTrailerOnly) ...[
                      const SizedBox(width: 10),
                      Flexible(
                        child: _HeroOutlinePill(
                          label: movie.subtitleLabel,
                          icon: FluentIcons.movies_and_tv_24_regular,
                        ),
                      ),
                    ],
                  ],
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

class _HeroPrimaryPill extends StatelessWidget {
  const _HeroPrimaryPill({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white.withValues(alpha: 0.16),
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: Container(
          height: 44,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: AppColors.white.withValues(alpha: 0.18)),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: 0.18),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: AppColors.white, size: 20),
              const SizedBox(width: 8),
              Text(
                label,
                style: AppTypography.button2Semibold.copyWith(
                  color: AppColors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeroOutlinePill extends StatelessWidget {
  const _HeroOutlinePill({required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.white.withValues(alpha: 0.12)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: AppColors.grayscale200),
          const SizedBox(width: 7),
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.captionMedium.copyWith(
                color: AppColors.grayscale100,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroMetaChip extends StatelessWidget {
  const _HeroMetaChip({
    required this.label,
    this.icon,
    this.highlighted = false,
  });

  final String label;
  final IconData? icon;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: highlighted
            ? AppColors.yellow500.withValues(alpha: 0.94)
            : AppColors.black.withValues(alpha: 0.48),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: highlighted
              ? AppColors.yellow300.withValues(alpha: 0.55)
              : AppColors.white.withValues(alpha: 0.12),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: icon == null ? 10 : 8,
          right: 10,
          top: 6,
          bottom: 6,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 14,
                color: highlighted ? AppColors.grayscale950 : AppColors.white,
              ),
              const SizedBox(width: 4),
            ],
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.captionMedium.copyWith(
                color: highlighted ? AppColors.grayscale950 : AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
