import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:imovie_app/config/navigation/app_router.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/l10n/app_localizations.dart';

@RoutePage()
class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      lazyLoad: false,
      duration: Duration.zero,
      transitionBuilder: (context, child, animation) => child,
      routes: [
        HomeRoute(),
        BrowseRoute(),
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
          child: BottomNavigationBar(
            currentIndex: activeIndex,
            onTap: onTap,
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColors.grayscale900,
            elevation: 0,
            selectedItemColor: AppColors.yellow500,
            unselectedItemColor: AppColors.grayscale300,
            selectedLabelStyle: textStyle,
            unselectedLabelStyle: textStyle,
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.home_outlined),
                activeIcon: const Icon(Icons.home_rounded),
                label: l10n.homeBottomNavHome,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.search_rounded),
                activeIcon: const Icon(Icons.search_rounded),
                label: l10n.homeBottomNavBrowse,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.bookmark_border_rounded),
                activeIcon: const Icon(Icons.bookmark_rounded),
                label: l10n.homeBottomNavLibrary,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.person_outline_rounded),
                activeIcon: const Icon(Icons.person_rounded),
                label: l10n.homeBottomNavProfile,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
