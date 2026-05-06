import 'package:flutter/material.dart';

abstract final class AppColors {
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color black88 = Color(0xCC000000);

  // Figma node 262:18440 - shared palette tokens
  static const Color sheetBackground = Color(0xFFEDEFFF);
  static const Color sheetSurface = Color(0xFFFFFFFF);
  static const Color tableBorder = Color(0xFFE6E6E6);
  static const Color chipBackground = Color(0xFFF5F5F5);

  static const Color yellow50 = Color(0xFFFDFAE9);
  static const Color yellow100 = Color(0xFFFBF4C6);
  static const Color yellow200 = Color(0xFFF9E68F);
  static const Color yellow300 = Color(0xFFF5D14F);
  static const Color yellow400 = Color(0xFFF0BB1F);
  static const Color yellow500 = Color(0xFFEBAB13);
  static const Color yellow600 = Color(0xFFC17D0D);
  static const Color yellow700 = Color(0xFF9A5A0E);
  static const Color yellow800 = Color(0xFF804713);
  static const Color yellow900 = Color(0xFF6D3A16);
  static const Color yellow950 = Color(0xFF2B240D);

  static const Color red50 = Color(0xFFFEF2F2);
  static const Color red100 = Color(0xFFFFE1E1);
  static const Color red200 = Color(0xFFFFC9C9);
  static const Color red300 = Color(0xFFFEA3A3);
  static const Color red400 = Color(0xFFFC6D6D);
  static const Color red500 = Color(0xFFF55555);
  static const Color red600 = Color(0xFFE12121);
  static const Color red700 = Color(0xFFBD1818);
  static const Color red800 = Color(0xFF9C1818);
  static const Color red900 = Color(0xFF821A1A);
  static const Color red950 = Color(0xFF431D1F);

  static const Color green50 = Color(0xFFF2FBF2);
  static const Color green100 = Color(0xFFE2F7E1);
  static const Color green200 = Color(0xFFC4EEC4);
  static const Color green300 = Color(0xFF96E095);
  static const Color green400 = Color(0xFF5FC95F);
  static const Color green500 = Color(0xFF3BB33B);
  static const Color green600 = Color(0xFF2A8F2A);
  static const Color green700 = Color(0xFF247125);
  static const Color green800 = Color(0xFF215A22);
  static const Color green900 = Color(0xFF1D4A1E);
  static const Color green950 = Color(0xFF11371B);

  static const Color grayscale50 = Color(0xFFF5F5F5);
  static const Color grayscale100 = Color(0xFFE7E7E7);
  static const Color grayscale200 = Color(0xFFD1D1D1);
  static const Color grayscale300 = Color(0xFFB0B0B0);
  static const Color grayscale400 = Color(0xFF888888);
  static const Color grayscale500 = Color(0xFF6D6D6D);
  static const Color grayscale600 = Color(0xFF5D5D5D);
  static const Color grayscale700 = Color(0xFF4F4F4F);
  static const Color grayscale800 = Color(0xFF292929);
  static const Color grayscale900 = Color(0xFF222222);
  static const Color grayscale950 = Color(0xFF181818);

  static const Color background = white;
  static const Color surface = white;
  static const Color surfaceAlt = grayscale50;
  static const Color surfaceMuted = grayscale100;
  static const Color surfaceStroke = grayscale100;
  static const Color primary = yellow500;
  static const Color success = green500;
  static const Color danger = red500;
  static const Color dangerContainer = red50;
  static const Color borderBrand = yellow500;
  static const Color borderMuted = grayscale50;
  static const Color fieldSurface = grayscale50;
  static const Color fieldIcon = grayscale400;
  static const Color textPrimary = grayscale950;
  static const Color textSecondary = grayscale400;
  static const Color onPrimary = grayscale950;
}
