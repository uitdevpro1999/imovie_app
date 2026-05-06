import 'dart:math' as math;

import 'package:flutter/material.dart';

class AppScreenUtilInit extends StatelessWidget {
  const AppScreenUtilInit({
    super.key,
    required this.designSize,
    required this.child,
    this.minTextAdapt = true,
  });

  final Size designSize;
  final Widget child;
  final bool minTextAdapt;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final mediaQuery = MediaQuery.of(context);
        final screenSize = constraints.biggest;
        final width = screenSize.width == double.infinity
            ? mediaQuery.size.width
            : screenSize.width;
        final height = screenSize.height == double.infinity
            ? mediaQuery.size.height
            : screenSize.height;

        AppScreenUtil.configure(
          designSize: designSize,
          screenSize: Size(width, height),
          textScaleFactor: mediaQuery.textScaler.scale(1),
          minTextAdapt: minTextAdapt,
        );

        return child;
      },
    );
  }
}

final class AppScreenUtil {
  AppScreenUtil._();

  static Size _designSize = const Size(390, 844);
  static Size _screenSize = _designSize;
  static double _textScaleFactor = 1;
  static bool _minTextAdapt = true;

  static void configure({
    required Size designSize,
    required Size screenSize,
    required double textScaleFactor,
    required bool minTextAdapt,
  }) {
    _designSize = designSize;
    _screenSize = screenSize;
    _textScaleFactor = textScaleFactor;
    _minTextAdapt = minTextAdapt;
  }

  static double get screenWidth => _screenSize.width;
  static double get screenHeight => _screenSize.height;
  static double get scaleWidth => _screenSize.width / _designSize.width;
  static double get scaleHeight => _screenSize.height / _designSize.height;
  static double get scaleText =>
      (_minTextAdapt ? math.min(scaleWidth, scaleHeight) : scaleWidth) *
      _textScaleFactor;

  static double setWidth(num value) => value * scaleWidth;
  static double setHeight(num value) => value * scaleHeight;
  static double setSp(num value) => value * scaleText;
  static double radius(num value) => value * math.min(scaleWidth, scaleHeight);
}

extension AppScreenUtilNumExtension on num {
  double get w => AppScreenUtil.setWidth(this);
  double get h => AppScreenUtil.setHeight(this);
  double get sp => AppScreenUtil.setSp(this);
  double get r => AppScreenUtil.radius(this);
}
