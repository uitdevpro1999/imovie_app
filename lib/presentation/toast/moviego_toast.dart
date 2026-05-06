import 'package:flutter/material.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/core/events/app_toast_event.dart';
import 'package:toastification/toastification.dart';

abstract final class MovieGoToast {
  static void show(AppToastEvent event) {
    toastification.show(
      type: _toastificationType(event.type),
      style: ToastificationStyle.fillColored,
      alignment: Alignment.topCenter,
      title: Text(event.message, style: AppTypography.body2Medium),
      autoCloseDuration: const Duration(seconds: 3),
      showProgressBar: false,
      closeOnClick: true,
      dragToClose: true,
    );
  }

  static ToastificationType _toastificationType(AppToastType type) {
    return switch (type) {
      AppToastType.success => ToastificationType.success,
      AppToastType.error => ToastificationType.error,
      AppToastType.info => ToastificationType.info,
      AppToastType.warning => ToastificationType.warning,
    };
  }
}
