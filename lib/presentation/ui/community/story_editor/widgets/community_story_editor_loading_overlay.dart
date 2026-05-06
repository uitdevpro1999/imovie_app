import 'package:flutter/material.dart';
import 'package:imovie_app/config/styles/app_colors.dart';

class CommunityStoryEditorLoadingOverlay extends StatelessWidget {
  const CommunityStoryEditorLoadingOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.black38,
      child: const Center(
        child: CircularProgressIndicator(color: AppColors.yellow500),
      ),
    );
  }
}
