import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

abstract final class IMovieRefreshConfig {
  static const int pageSize = 24;
  static const int communityPageSize = 10;
  static const bool enablePullDown = true;
  static const double footerSpinnerSize = 22;
  static const double footerSpinnerStrokeWidth = 2;
  static const double dragSpeedRatio = 0.9;
  static const double headerTriggerDistance = 76;
  static const Duration minRefreshIndicatorDuration = Duration(
    milliseconds: 420,
  );
  static const springDescription = SpringDescription(
    mass: 1.9,
    stiffness: 170,
    damping: 16,
  );

  static const String loadingText = '';
  static const String idleText = '';
  static const String canLoadingText = '';
  static const String noDataText = '';
  static const String failedText = '';

  static const header = MaterialClassicHeader(
    color: AppColors.yellow500,
    backgroundColor: AppColors.grayscale900,
  );

  static ClassicFooter footer() {
    return ClassicFooter(
      loadingText: loadingText,
      idleText: idleText,
      canLoadingText: canLoadingText,
      noDataText: noDataText,
      failedText: failedText,
      loadingIcon: const SizedBox.square(
        dimension: footerSpinnerSize,
        child: CircularProgressIndicator(
          strokeWidth: footerSpinnerStrokeWidth,
          color: AppColors.yellow500,
        ),
      ),
      canLoadingIcon: const Icon(
        FluentIcons.chevron_up_24_regular,
        color: AppColors.grayscale400,
      ),
      idleIcon: const Icon(
        FluentIcons.chevron_up_24_regular,
        color: AppColors.grayscale500,
      ),
      failedIcon: const Icon(
        FluentIcons.error_circle_24_regular,
        color: AppColors.red400,
      ),
    );
  }
}
