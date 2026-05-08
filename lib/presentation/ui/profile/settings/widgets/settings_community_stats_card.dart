import 'package:flutter/material.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/domain/entities/community/community_profile.dart';
import 'package:imovie_app/l10n/app_localizations.dart';

class SettingsCommunityStatsCard extends StatelessWidget {
  const SettingsCommunityStatsCard({
    super.key,
    required this.l10n,
    required this.communityProfile,
    required this.isLoading,
    required this.onPostsTap,
    required this.onFollowersTap,
    required this.onFollowingTap,
  });

  final AppLocalizations l10n;
  final CommunityProfile? communityProfile;
  final bool isLoading;
  final VoidCallback onPostsTap;
  final VoidCallback onFollowersTap;
  final VoidCallback onFollowingTap;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.grayscale900,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.white.withValues(alpha: 0.07)),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.22),
            blurRadius: 24,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
        child: Row(
          children: [
            Expanded(
              child: _SettingsStatItem(
                label: l10n.profileStatsPosts,
                value: communityProfile?.postCount,
                isLoading: isLoading && communityProfile == null,
                onTap: onPostsTap,
              ),
            ),
            const _SettingsStatDivider(),
            Expanded(
              child: _SettingsStatItem(
                label: l10n.profileStatsFollowers,
                value: communityProfile?.followerCount,
                isLoading: isLoading && communityProfile == null,
                onTap: onFollowersTap,
              ),
            ),
            const _SettingsStatDivider(),
            Expanded(
              child: _SettingsStatItem(
                label: l10n.profileStatsFollowing,
                value: communityProfile?.followingCount,
                isLoading: isLoading && communityProfile == null,
                onTap: onFollowingTap,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsStatItem extends StatelessWidget {
  const _SettingsStatItem({
    required this.label,
    required this.value,
    required this.isLoading,
    required this.onTap,
  });

  final String label;
  final int? value;
  final bool isLoading;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 26,
                child: Center(
                  child: isLoading
                      ? const SizedBox.square(
                          dimension: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.yellow500,
                          ),
                        )
                      : FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            _formatCount(value ?? 0),
                            textAlign: TextAlign.center,
                            style: AppTypography.h2.copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                label,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.captionMedium.copyWith(
                  color: AppColors.grayscale300,
                  height: 1.15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatCount(int count) {
    if (count < 1000) {
      return '$count';
    }
    final compact = count / 1000;
    final fractionDigits = compact >= 10 ? 0 : 1;
    return '${compact.toStringAsFixed(fractionDigits)}K';
  }
}

class _SettingsStatDivider extends StatelessWidget {
  const _SettingsStatDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 54,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      color: AppColors.white.withValues(alpha: 0.08),
    );
  }
}
