import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/core/events/app_toast_event.dart';
import 'package:toastification/toastification.dart';

abstract final class IMovieToast {
  static void show(AppToastEvent event) {
    final style = _styleFor(event.type);
    toastification.show(
      type: _toastificationType(event.type),
      style: ToastificationStyle.flat,
      alignment: Alignment.topCenter,
      title: Text(
        event.message,
        style: AppTypography.body2Medium.copyWith(color: AppColors.white),
      ),
      icon: Icon(style.icon, color: style.color, size: 22),
      primaryColor: style.color,
      backgroundColor: AppColors.grayscale950,
      foregroundColor: AppColors.white,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: style.color, width: 1),
      boxShadow: const [
        BoxShadow(
          color: Color(0x66000000),
          blurRadius: 18,
          offset: Offset(0, 10),
        ),
      ],
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

  static _IMovieToastStyle _styleFor(AppToastType type) {
    return switch (type) {
      AppToastType.success => const _IMovieToastStyle(
        color: AppColors.green500,
        icon: FluentIcons.checkmark_circle_24_regular,
      ),
      AppToastType.error => const _IMovieToastStyle(
        color: AppColors.red500,
        icon: FluentIcons.error_circle_24_regular,
      ),
      AppToastType.warning => const _IMovieToastStyle(
        color: AppColors.yellow500,
        icon: FluentIcons.warning_24_regular,
      ),
      AppToastType.info => const _IMovieToastStyle(
        color: Color(0xFF38BDF8),
        icon: FluentIcons.info_24_regular,
      ),
    };
  }
}

class _IMovieToastStyle {
  const _IMovieToastStyle({required this.color, required this.icon});

  final Color color;
  final IconData icon;
}
