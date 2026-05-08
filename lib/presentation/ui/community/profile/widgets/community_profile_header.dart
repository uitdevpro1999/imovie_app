import 'package:flutter/material.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/domain/entities/community/community_profile.dart';
import 'package:imovie_app/presentation/widgets/imovie_remote_image.dart';

class CommunityProfileHeader extends StatelessWidget {
  const CommunityProfileHeader({
    super.key,
    required this.profile,
    required this.fallbackName,
    required this.followLabel,
    required this.followingLabel,
    required this.followersLabel,
    required this.followingCountLabel,
    required this.postsLabel,
    required this.storiesLabel,
    required this.followProcessing,
    required this.onFollowTap,
  });

  final CommunityProfile profile;
  final String fallbackName;
  final String followLabel;
  final String followingLabel;
  final String followersLabel;
  final String followingCountLabel;
  final String postsLabel;
  final String storiesLabel;
  final bool followProcessing;
  final VoidCallback onFollowTap;

  @override
  Widget build(BuildContext context) {
    final displayName = profile.displayName.trim().isEmpty
        ? fallbackName
        : profile.displayName.trim();
    final initials = displayName.characters.first.toUpperCase();
    return Container(
      decoration: BoxDecoration(
        color: AppColors.grayscale900,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.grayscale800),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.2),
            blurRadius: 22,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Container(
            height: 96,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(color: AppColors.grayscale800),
            child: profile.coverUrl.trim().isEmpty
                ? DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColors.yellow500.withValues(alpha: 0.9),
                          AppColors.red400.withValues(alpha: 0.58),
                          AppColors.grayscale800,
                        ],
                      ),
                    ),
                  )
                : IMovieRemoteImage(
                    imageUrl: profile.coverUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    placeholderLabel: displayName,
                  ),
          ),
          Transform.translate(
            offset: const Offset(0, -38),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
              child: Column(
                children: [
                  Container(
                    width: 92,
                    height: 92,
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: AppColors.grayscale900,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.yellow500, width: 2),
                    ),
                    child: ClipOval(
                      child: DecoratedBox(
                        decoration: const BoxDecoration(
                          color: AppColors.grayscale800,
                        ),
                        child: profile.avatarUrl.trim().isEmpty
                            ? Center(
                                child: Text(
                                  initials,
                                  style: AppTypography.h2.copyWith(
                                    color: AppColors.yellow500,
                                  ),
                                ),
                              )
                            : IMovieRemoteImage(
                                imageUrl: profile.avatarUrl,
                                placeholderLabel: displayName,
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    displayName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: AppTypography.h3.copyWith(color: AppColors.white),
                  ),
                  const SizedBox(height: 18),
                  _ProfileMetricRow(
                    metrics: [
                      _ProfileMetricData(
                        value: profile.followerCount,
                        label: followersLabel,
                      ),
                      _ProfileMetricData(
                        value: profile.followingCount,
                        label: followingCountLabel,
                      ),
                      _ProfileMetricData(
                        value: profile.postCount,
                        label: postsLabel,
                      ),
                      _ProfileMetricData(
                        value: profile.storyCount,
                        label: storiesLabel,
                      ),
                    ],
                  ),
                  if (!profile.isMe) ...[
                    const SizedBox(height: 18),
                    _FollowButton(
                      label: profile.isFollowing ? followingLabel : followLabel,
                      active: profile.isFollowing,
                      processing: followProcessing,
                      onTap: onFollowTap,
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 2),
        ],
      ),
    );
  }
}

class _ProfileMetricData {
  const _ProfileMetricData({required this.value, required this.label});

  final int value;
  final String label;
}

class _ProfileMetricRow extends StatelessWidget {
  const _ProfileMetricRow({required this.metrics});

  final List<_ProfileMetricData> metrics;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth = constraints.maxWidth / metrics.length;
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final metric in metrics)
              SizedBox(
                width: itemWidth,
                child: _ProfileMetric(value: metric.value, label: metric.label),
              ),
          ],
        );
      },
    );
  }
}

class _ProfileMetric extends StatelessWidget {
  const _ProfileMetric({required this.value, required this.label});

  final int value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: Column(
          children: [
            SizedBox(
              height: 22,
              child: Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    value.toString(),
                    maxLines: 1,
                    style: AppTypography.button1Semibold.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4),
            SizedBox(
              height: 28,
              child: Center(
                child: Text(
                  label,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: AppTypography.captionRegular1.copyWith(
                    color: AppColors.grayscale300,
                    height: 1.15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FollowButton extends StatelessWidget {
  const _FollowButton({
    required this.label,
    required this.active,
    required this.processing,
    required this.onTap,
  });

  final String label;
  final bool active;
  final bool processing;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: active ? AppColors.grayscale800 : AppColors.yellow500,
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        onTap: processing ? null : onTap,
        borderRadius: BorderRadius.circular(999),
        child: SizedBox(
          height: 46,
          child: Center(
            child: processing
                ? SizedBox.square(
                    dimension: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: active
                          ? AppColors.yellow500
                          : AppColors.grayscale950,
                    ),
                  )
                : Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.button2Semibold.copyWith(
                      color: active ? AppColors.white : AppColors.grayscale950,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
