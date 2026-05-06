import 'package:flutter/material.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

abstract final class IMovieRefreshConfig {
  static const int pageSize = 24;
  static const int communityPageSize = 10;
  static const bool enablePullDown = true;
  static const double footerSpinnerSize = 22;
  static const double footerSpinnerStrokeWidth = 2;

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
        Icons.keyboard_arrow_up_rounded,
        color: AppColors.grayscale400,
      ),
      idleIcon: const Icon(
        Icons.keyboard_arrow_up_rounded,
        color: AppColors.grayscale500,
      ),
      failedIcon: const Icon(
        Icons.error_outline_rounded,
        color: AppColors.red400,
      ),
    );
  }
}
