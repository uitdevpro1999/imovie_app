import 'package:flutter/material.dart';
import 'package:imovie_app/config/refresh/imovie_refresh_config.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

typedef IMovieRefreshCallback = Future<bool> Function();
typedef IMovieLoadMoreCallback = Future<IMovieLoadMoreResult> Function();

class IMovieLoadMoreResult {
  const IMovieLoadMoreResult._({required this.success, required this.hasMore});

  const IMovieLoadMoreResult.success({required bool hasMore})
    : this._(success: true, hasMore: hasMore);

  const IMovieLoadMoreResult.failure() : this._(success: false, hasMore: true);

  final bool success;
  final bool hasMore;
}

class IMovieSmartRefresher extends StatefulWidget {
  const IMovieSmartRefresher({
    super.key,
    required this.child,
    required this.onRefresh,
    this.onLoadMore,
    this.enablePullUp = false,
    this.hasMore = false,
  });

  final Widget child;
  final IMovieRefreshCallback onRefresh;
  final IMovieLoadMoreCallback? onLoadMore;
  final bool enablePullUp;
  final bool hasMore;

  @override
  State<IMovieSmartRefresher> createState() => _IMovieSmartRefresherState();
}

class _IMovieSmartRefresherState extends State<IMovieSmartRefresher> {
  late final RefreshController _refreshController;
  bool _refreshing = false;
  bool _loadingMore = false;

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
      springDescription: IMovieRefreshConfig.springDescription,
      dragSpeedRatio: IMovieRefreshConfig.dragSpeedRatio,
      headerTriggerDistance: IMovieRefreshConfig.headerTriggerDistance,
      enableScrollWhenRefreshCompleted: true,
      child: SmartRefresher(
        controller: _refreshController,
        enablePullDown: IMovieRefreshConfig.enablePullDown,
        enablePullUp: widget.enablePullUp,
        header: IMovieRefreshConfig.header,
        footer: IMovieRefreshConfig.footer(),
        onRefresh: _handleRefresh,
        onLoading: widget.enablePullUp ? _handleLoadMore : null,
        child: widget.child,
      ),
    );
  }

  Future<void> _handleRefresh() async {
    if (_refreshing) {
      return;
    }

    _refreshing = true;
    final startedAt = DateTime.now();
    final completed = await widget.onRefresh();
    if (!mounted) {
      _refreshing = false;
      return;
    }

    final elapsed = DateTime.now().difference(startedAt);
    final remaining = IMovieRefreshConfig.minRefreshIndicatorDuration - elapsed;
    if (remaining > Duration.zero) {
      await Future<void>.delayed(remaining);
      if (!mounted) {
        _refreshing = false;
        return;
      }
    }

    if (completed) {
      _refreshController.refreshCompleted(resetFooterState: true);
    } else {
      _refreshController.refreshFailed();
    }
    _refreshing = false;
  }

  Future<void> _handleLoadMore() async {
    if (_loadingMore) {
      return;
    }

    if (!widget.hasMore || widget.onLoadMore == null) {
      _refreshController.loadNoData();
      return;
    }

    _loadingMore = true;
    final result = await widget.onLoadMore!();
    if (!mounted) {
      _loadingMore = false;
      return;
    }

    if (!result.success) {
      _refreshController.loadFailed();
      _loadingMore = false;
      return;
    }

    if (result.hasMore) {
      _refreshController.loadComplete();
    } else {
      _refreshController.loadNoData();
    }
    _loadingMore = false;
  }
}
