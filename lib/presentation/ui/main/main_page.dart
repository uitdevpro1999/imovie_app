import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imovie_app/config/navigation/app_router.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/core/di/service_locator.dart';
import 'package:imovie_app/l10n/app_localizations.dart';
import 'package:imovie_app/presentation/ui/main/main_cubit.dart';
import 'package:imovie_app/presentation/ui/notifications/notification_center_cubit.dart';

@RoutePage()
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late final MainCubit _mainCubit;
  late final NotificationCenterCubit _notificationCenterCubit;

  @override
  void initState() {
    super.initState();
    _mainCubit = sl<MainCubit>();
    _notificationCenterCubit = sl<NotificationCenterCubit>();
    _mainCubit.load();
    _notificationCenterCubit.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _mainCubit),
        BlocProvider.value(value: _notificationCenterCubit),
      ],
      child: AutoTabsRouter(
        lazyLoad: true,
        duration: Duration.zero,
        transitionBuilder: (context, child, animation) => child,
        routes: [
          HomeRoute(),
          BrowseRoute(),
          CommunityRoute(),
          const LibraryRoute(),
          const SettingsRoute(),
        ],
        builder: (context, child) {
          final tabsRouter = AutoTabsRouter.of(context);
          return Scaffold(
            backgroundColor: AppColors.grayscale950,
            body: ColoredBox(color: AppColors.grayscale950, child: child),
            bottomNavigationBar: _MainBottomNavigationBar(
              activeIndex: tabsRouter.activeIndex,
              onTap: tabsRouter.setActiveIndex,
            ),
          );
        },
      ),
    );
  }
}

class _MainBottomNavigationBar extends StatelessWidget {
  const _MainBottomNavigationBar({
    required this.activeIndex,
    required this.onTap,
  });

  final int activeIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final textStyle = AppTypography.captionRegular1.copyWith(
      fontWeight: FontWeight.w500,
    );

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.grayscale900,
        border: Border(top: BorderSide(color: AppColors.grayscale800)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 72,
          child: Theme(
            data: Theme.of(context).copyWith(
              splashFactory: NoSplash.splashFactory,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              currentIndex: activeIndex,
              onTap: onTap,
              type: BottomNavigationBarType.fixed,
              backgroundColor: AppColors.grayscale900,
              elevation: 0,
              enableFeedback: false,
              selectedItemColor: AppColors.yellow500,
              unselectedItemColor: AppColors.grayscale300,
              selectedLabelStyle: textStyle,
              unselectedLabelStyle: textStyle,
              items: [
                BottomNavigationBarItem(
                  icon: const Icon(FluentIcons.home_24_regular),
                  activeIcon: const Icon(FluentIcons.home_24_filled),
                  label: l10n.homeBottomNavHome,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(FluentIcons.search_24_regular),
                  activeIcon: const Icon(FluentIcons.search_24_regular),
                  label: l10n.homeBottomNavBrowse,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(FluentIcons.people_community_24_regular),
                  activeIcon: const Icon(
                    FluentIcons.people_community_24_filled,
                  ),
                  label: l10n.homeBottomNavCommunity,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(FluentIcons.bookmark_24_regular),
                  activeIcon: const Icon(FluentIcons.bookmark_24_filled),
                  label: l10n.homeBottomNavLibrary,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(FluentIcons.person_24_regular),
                  activeIcon: const Icon(FluentIcons.person_24_filled),
                  label: l10n.homeBottomNavProfile,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
