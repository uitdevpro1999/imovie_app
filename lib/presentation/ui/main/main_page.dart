import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imovie_app/config/navigation/app_router.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/core/di/service_locator.dart';
import 'package:imovie_app/l10n/app_localizations.dart';
import 'package:imovie_app/presentation/ui/main/main_cubit.dart';

@RoutePage()
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late final MainCubit _mainCubit;

  @override
  void initState() {
    super.initState();
    _mainCubit = sl<MainCubit>();
    _mainCubit.load();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _mainCubit,
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
                  icon: const Icon(Icons.groups_2_outlined),
                  activeIcon: const Icon(Icons.groups_2_rounded),
                  label: l10n.homeBottomNavCommunity,
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
      ),
    );
  }
}
