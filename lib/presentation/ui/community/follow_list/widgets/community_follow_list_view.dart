import 'package:flutter/material.dart';
import 'package:imovie_app/domain/entities/community/community_profile.dart';
import 'package:imovie_app/presentation/ui/community/feed/widgets/community_empty_view.dart';
import 'package:imovie_app/presentation/ui/community/follow_list/widgets/community_follow_user_tile.dart';
import 'package:imovie_app/presentation/widgets/imovie_smart_refresher.dart';

class CommunityFollowListView extends StatelessWidget {
  const CommunityFollowListView({
    super.key,
    required this.profiles,
    required this.hasMore,
    required this.emptyTitle,
    required this.emptySubtitle,
    required this.fallbackName,
    required this.postsLabel,
    required this.followersLabel,
    required this.onRefresh,
    required this.onLoadMore,
    required this.onProfileTap,
  });

  final List<CommunityProfile> profiles;
  final bool hasMore;
  final String emptyTitle;
  final String emptySubtitle;
  final String fallbackName;
  final String postsLabel;
  final String followersLabel;
  final Future<bool> Function() onRefresh;
  final Future<IMovieLoadMoreResult> Function() onLoadMore;
  final ValueChanged<String> onProfileTap;

  @override
  Widget build(BuildContext context) {
    return IMovieSmartRefresher(
      onRefresh: onRefresh,
      onLoadMore: onLoadMore,
      enablePullUp: profiles.isNotEmpty,
      hasMore: hasMore,
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 112),
        itemBuilder: (context, index) {
          if (profiles.isEmpty) {
            return CommunityEmptyView(
              title: emptyTitle,
              subtitle: emptySubtitle,
            );
          }

          final profile = profiles[index];
          return CommunityFollowUserTile(
            profile: profile,
            fallbackName: fallbackName,
            postsLabel: postsLabel,
            followersLabel: followersLabel,
            onTap: () => onProfileTap(profile.userId),
          );
        },
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemCount: profiles.isEmpty ? 1 : profiles.length,
      ),
    );
  }
}
