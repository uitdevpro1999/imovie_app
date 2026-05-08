import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imovie_app/config/navigation/app_router.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/core/bloc/base_state.dart';
import 'package:imovie_app/core/di/service_locator.dart';
import 'package:imovie_app/l10n/app_localizations.dart';
import 'package:imovie_app/presentation/ui/community/follow_list/community_follow_list_type.dart';
import 'package:imovie_app/presentation/ui/main/main_cubit.dart';
import 'package:imovie_app/presentation/ui/profile/settings/settings_cubit.dart';
import 'package:imovie_app/presentation/ui/profile/settings/settings_state.dart';
import 'package:imovie_app/presentation/ui/profile/settings/widgets/settings_content.dart';
import 'package:imovie_app/presentation/ui/profile/settings/widgets/settings_feedback_views.dart';
import 'package:imovie_app/presentation/ui/profile/settings/widgets/settings_sections.dart';
import 'package:imovie_app/presentation/widgets/imovie_app_bar.dart';

@RoutePage()
class SettingsPage extends StatelessWidget implements AutoRouteWrapper {
  const SettingsPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: sl<MainCubit>()),
        BlocProvider(create: (_) => sl<SettingsCubit>()..initData()),
      ],
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.grayscale950,
      appBar: IMovieAppBar(
        title: l10n.profileTitle,
        centerTitle: false,
        automaticallyImplyLeading: false,
        actions: [
          Center(child: SettingsAdFreeBadge(label: l10n.homeBadgeAdFree)),
          const SizedBox(width: 16),
        ],
      ),
      body: SafeArea(
        top: false,
        child: Stack(
          children: [
            Positioned.fill(
              child: BlocBuilder<SettingsCubit, SettingsState>(
                buildWhen: (previous, current) =>
                    previous.pageStatus != current.pageStatus ||
                    previous.failure != current.failure ||
                    previous.isAuthenticated != current.isAuthenticated ||
                    previous.profile != current.profile ||
                    previous.communityProfile != current.communityProfile ||
                    previous.communityStatsLoading !=
                        current.communityStatsLoading,
                builder: (context, state) => _buildBody(context, l10n, state),
              ),
            ),
            Positioned.fill(
              child: BlocSelector<SettingsCubit, SettingsState, bool>(
                selector: (state) => state.processing,
                builder: (context, processing) {
                  return processing
                      ? const SettingsProcessingOverlay()
                      : const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    AppLocalizations l10n,
    SettingsState state,
  ) {
    switch (state.pageStatus) {
      case PageStatus.initial:
      case PageStatus.loading:
        return const Center(
          child: CircularProgressIndicator(color: AppColors.yellow500),
        );
      case PageStatus.error:
        return SettingsErrorView(
          message: state.failure?.message ?? l10n.retry,
          onRetry: context.read<SettingsCubit>().retry,
          l10n: l10n,
        );
      case PageStatus.loaded:
        if (state.isAuthenticated && state.profile != null) {
          final profile = state.profile!;
          return SettingsContent(
            l10n: l10n,
            profile: profile,
            communityProfile: state.communityProfile,
            communityStatsLoading: state.communityStatsLoading,
            onPostsTap: () =>
                context.router.root.push(const CommunityMineRoute()),
            onFollowersTap: () => context.router.root.push(
              CommunityFollowListRoute(
                userId: profile.id,
                listType: CommunityFollowListType.followers.slug,
              ),
            ),
            onFollowingTap: () => context.router.root.push(
              CommunityFollowListRoute(
                userId: profile.id,
                listType: CommunityFollowListType.following.slug,
              ),
            ),
            onCommunityProfileTap: () => context.router.root.push(
              CommunityProfileRoute(userId: profile.id),
            ),
            onSignOut: () async {
              await context.read<SettingsCubit>().signOut(
                failureMessage: l10n.profileSignOutError,
              );
            },
          );
        }

        return SignedOutSettingsView(
          l10n: l10n,
          onSignInTap: () => context.router.root.push(SignInRoute()),
        );
    }
  }
}
