import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imovie_app/config/navigation/app_router.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/core/di/service_locator.dart';
import 'package:imovie_app/l10n/app_localizations.dart';
import 'package:imovie_app/presentation/common/pages/base_page.dart';
import 'package:imovie_app/presentation/ui/community/follow_list/community_follow_list_cubit.dart';
import 'package:imovie_app/presentation/ui/community/follow_list/community_follow_list_state.dart';
import 'package:imovie_app/presentation/ui/community/follow_list/community_follow_list_type.dart';
import 'package:imovie_app/presentation/ui/community/follow_list/widgets/community_follow_list_view.dart';
import 'package:imovie_app/presentation/widgets/imovie_app_bar.dart';
import 'package:imovie_app/presentation/widgets/imovie_buttons.dart';
import 'package:imovie_app/presentation/widgets/imovie_smart_refresher.dart';

@RoutePage()
class CommunityFollowListPage
    extends BasePage<CommunityFollowListCubit, CommunityFollowListState>
    implements AutoRouteWrapper {
  const CommunityFollowListPage({
    super.key,
    @PathParam('userId') this.userId = '',
    @PathParam('listType') this.listType = CommunityFollowListSlugs.followers,
  });

  final String userId;
  final String listType;

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          sl<CommunityFollowListCubit>(param1: userId, param2: listType),
      child: this,
    );
  }

  @override
  Widget wrapPage(
    BuildContext context,
    CommunityFollowListState state,
    Widget child,
  ) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.grayscale950,
      appBar: IMovieAppBar(
        title: state.type.isFollowers
            ? l10n.communityFollowersTitle
            : l10n.communityFollowingTitle,
        centerTitle: false,
      ),
      body: SafeArea(top: false, child: child),
    );
  }

  @override
  Widget buildPage(
    BuildContext context,
    CommunityFollowListCubit cubit,
    CommunityFollowListState state,
  ) {
    final l10n = AppLocalizations.of(context)!;
    return CommunityFollowListView(
      profiles: state.profiles,
      hasMore: state.hasMore,
      emptyTitle: state.type.isFollowers
          ? l10n.communityFollowersEmptyTitle
          : l10n.communityFollowingEmptyTitle,
      emptySubtitle: state.type.isFollowers
          ? l10n.communityFollowersEmptySubtitle
          : l10n.communityFollowingEmptySubtitle,
      fallbackName: l10n.communityUserFallbackName,
      postsLabel: l10n.communityPostsLabel,
      followersLabel: l10n.communityFollowersLabel,
      onRefresh: cubit.refresh,
      onLoadMore: () async {
        final success = await cubit.loadMore();
        return success
            ? IMovieLoadMoreResult.success(hasMore: cubit.state.hasMore)
            : const IMovieLoadMoreResult.failure();
      },
      onProfileTap: (targetUserId) => _openProfile(context, targetUserId),
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message.isEmpty ? l10n.communityLoadError : message,
              textAlign: TextAlign.center,
              style: AppTypography.body1Regular.copyWith(
                color: AppColors.white,
              ),
            ),
            const SizedBox(height: 16),
            IMovieButton(
              label: l10n.retry,
              showLeadingIcon: false,
              foregroundColor: AppColors.textPrimary,
              onPressed: onRetry,
            ),
          ],
        ),
      ),
    );
  }

  void _openProfile(BuildContext context, String targetUserId) {
    final normalizedUserId = targetUserId.trim();
    if (normalizedUserId.isEmpty) {
      return;
    }

    context.router.root.push(CommunityProfileRoute(userId: normalizedUserId));
  }
}
