import 'package:flutter/material.dart';
import 'package:imovie_app/config/styles/app_colors.dart';

abstract final class AppTypography {
  static const String fontFamily = 'Inter';

  static const TextStyle display = TextStyle(
    fontFamily: fontFamily,
    color: AppColors.textPrimary,
    fontSize: 28,
    fontWeight: FontWeight.w700,
    height: 1.3,
  );

  static const TextStyle h1 = TextStyle(
    fontFamily: fontFamily,
    color: AppColors.textPrimary,
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 1.3,
  );

  static const TextStyle h2 = TextStyle(
    fontFamily: fontFamily,
    color: AppColors.textPrimary,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );

  static const TextStyle h3 = TextStyle(
    fontFamily: fontFamily,
    color: AppColors.textPrimary,
    fontSize: 18,
    fontWeight: FontWeight.w500,
    height: 1.3,
  );

  static const TextStyle h4 = TextStyle(
    fontFamily: fontFamily,
    color: AppColors.textPrimary,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.3,
  );

  static const TextStyle body1Regular = TextStyle(
    fontFamily: fontFamily,
    color: AppColors.textPrimary,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.3,
  );

  static const TextStyle body2Regular = TextStyle(
    fontFamily: fontFamily,
    color: AppColors.textPrimary,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.3,
  );

  static const TextStyle body2Medium = TextStyle(
    fontFamily: fontFamily,
    color: AppColors.textPrimary,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.3,
  );

  static const TextStyle captionRegular1 = TextStyle(
    fontFamily: fontFamily,
    color: AppColors.textPrimary,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.3,
  );

  static const TextStyle captionRegular2 = TextStyle(
    fontFamily: fontFamily,
    color: AppColors.textPrimary,
    fontSize: 10,
    fontWeight: FontWeight.w400,
    height: 1.3,
  );

  static const TextStyle captionMedium = TextStyle(
    fontFamily: fontFamily,
    color: AppColors.textPrimary,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.3,
  );

  static const TextStyle button1Semibold = TextStyle(
    fontFamily: fontFamily,
    color: AppColors.textPrimary,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );

  static const TextStyle button2Semibold = TextStyle(
    fontFamily: fontFamily,
    color: AppColors.textPrimary,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );

  // Figma node 109:5641 uses medium-weight button labels with 1.4 line height.
  static const TextStyle button1Medium = TextStyle(
    fontFamily: fontFamily,
    color: AppColors.textPrimary,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.4,
  );

  static const TextStyle button2Medium = TextStyle(
    fontFamily: fontFamily,
    color: AppColors.textPrimary,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.4,
  );

  static const TextTheme textTheme = TextTheme(
    displaySmall: display,
    headlineLarge: h1,
    headlineMedium: h2,
    headlineSmall: h3,
    titleLarge: h4,
    titleMedium: body2Medium,
    bodyLarge: body1Regular,
    bodyMedium: body2Regular,
    bodySmall: captionRegular1,
    labelLarge: button1Semibold,
    labelMedium: button2Semibold,
    labelSmall: captionMedium,
  );
}
