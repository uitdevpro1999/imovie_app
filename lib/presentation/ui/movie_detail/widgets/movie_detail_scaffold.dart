part of '../movie_detail_page.dart';

class _MovieDetailScaffold extends StatefulWidget {
  const _MovieDetailScaffold({required this.child});

  final Widget child;

  @override
  State<_MovieDetailScaffold> createState() => _MovieDetailScaffoldState();
}

class _MovieDetailScaffoldState extends State<_MovieDetailScaffold> {
  bool _isAppBarSolid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grayscale950,
      extendBodyBehindAppBar: true,
      appBar: IMovieAppBar(
        backgroundColor: _isAppBarSolid
            ? AppColors.grayscale950
            : Colors.transparent,
        titleWidget: const SizedBox.shrink(),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: _handleScrollNotification,
        child: widget.child,
      ),
    );
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification.depth != 0 || notification.metrics.axis != Axis.vertical) {
      return false;
    }

    final shouldBeSolid =
        notification.metrics.pixels >= _appBarSolidScrollOffset(context);
    if (shouldBeSolid != _isAppBarSolid && mounted) {
      setState(() => _isAppBarSolid = shouldBeSolid);
    }

    return false;
  }

  double _appBarSolidScrollOffset(BuildContext context) {
    final heroHeight = math.max(
      _movieDetailHeroBaseHeight,
      _movieDetailHeroBaseHeight.h,
    );
    final blackSectionTop = heroHeight - _movieDetailContentOverlap;
    final appBarHeight = MediaQuery.paddingOf(context).top + kToolbarHeight;
    return math.max(0, blackSectionTop - appBarHeight);
  }
}
