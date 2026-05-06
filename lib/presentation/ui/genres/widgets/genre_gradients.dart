part of '../genres_page.dart';

abstract final class _GenreGradients {
  static const _gradients = [
    LinearGradient(colors: [Color(0xFFFF7A45), Color(0xFFEBAB13)]),
    LinearGradient(colors: [Color(0xFF2DD4BF), Color(0xFF0F766E)]),
    LinearGradient(colors: [Color(0xFF60A5FA), Color(0xFF1D4ED8)]),
    LinearGradient(colors: [Color(0xFFF472B6), Color(0xFFBE185D)]),
    LinearGradient(colors: [Color(0xFFA78BFA), Color(0xFF6D28D9)]),
    LinearGradient(colors: [Color(0xFF34D399), Color(0xFF15803D)]),
    LinearGradient(colors: [Color(0xFFFACC15), Color(0xFFCA8A04)]),
    LinearGradient(colors: [Color(0xFFFB7185), Color(0xFFE11D48)]),
  ];

  static LinearGradient byIndex(int index) {
    return _gradients[index % _gradients.length];
  }
}
