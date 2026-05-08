import 'package:flutter/material.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/domain/entities/community/community_profile.dart';
import 'package:imovie_app/presentation/widgets/imovie_remote_image.dart';

class CommunityFollowUserTile extends StatelessWidget {
  const CommunityFollowUserTile({
    super.key,
    required this.profile,
    required this.fallbackName,
    required this.postsLabel,
    required this.followersLabel,
    required this.onTap,
  });

  final CommunityProfile profile;
  final String fallbackName;
  final String postsLabel;
  final String followersLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final displayName = profile.displayName.trim().isEmpty
        ? fallbackName
        : profile.displayName.trim();
    final initials = displayName.characters.first.toUpperCase();

    return Material(
      color: AppColors.grayscale900,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.grayscale800),
          ),
          child: Row(
            children: [
              SizedBox.square(
                dimension: 52,
                child: ClipOval(
                  child: profile.avatarUrl.trim().isEmpty
                      ? _CommunityFollowInitialsAvatar(initials: initials)
                      : IMovieRemoteImage(
                          imageUrl: profile.avatarUrl,
                          placeholderLabel: displayName,
                        ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      displayName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.body2Medium.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${profile.postCount} $postsLabel • '
                      '${profile.followerCount} $followersLabel',
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
      ),
    );
  }
}

class _CommunityFollowInitialsAvatar extends StatelessWidget {
  const _CommunityFollowInitialsAvatar({required this.initials});

  final String initials;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.grayscale700, AppColors.grayscale900],
        ),
      ),
      child: Center(
        child: Text(
          initials,
          style: AppTypography.body1Regular.copyWith(
            color: AppColors.yellow500,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
