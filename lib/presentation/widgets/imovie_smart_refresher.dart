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
    final completed = await widget.onRefresh();
    if (!mounted) {
      return;
    }

    if (completed) {
      _refreshController.refreshCompleted(resetFooterState: true);
    } else {
      _refreshController.refreshFailed();
    }
  }

  Future<void> _handleLoadMore() async {
    if (!widget.hasMore || widget.onLoadMore == null) {
      _refreshController.loadNoData();
      return;
    }

    final result = await widget.onLoadMore!();
    if (!mounted) {
      return;
    }

    if (!result.success) {
      _refreshController.loadFailed();
      return;
    }

    if (result.hasMore) {
      _refreshController.loadComplete();
    } else {
      _refreshController.loadNoData();
    }
  }
}
