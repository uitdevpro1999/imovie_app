import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/l10n/app_localizations.dart';

@RoutePage()
class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.grayscale950,
      body: SafeArea(
        child: Center(
          child: Text(
            l10n.homeBottomNavLibrary,
            style: AppTypography.h2.copyWith(color: AppColors.white),
          ),
        ),
      ),
    );
  }
}
