import 'package:flutter/material.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';

class CommunityEmptyView extends StatelessWidget {
  const CommunityEmptyView({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
          decoration: BoxDecoration(
            color: AppColors.grayscale900,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.grayscale800),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 76,
                height: 76,
                decoration: BoxDecoration(
                  color: AppColors.yellow950,
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: AppColors.yellow900),
                ),
                child: const Icon(
                  Icons.forum_outlined,
                  color: AppColors.yellow500,
                  size: 36,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                title,
                textAlign: TextAlign.center,
                style: AppTypography.h3.copyWith(color: AppColors.white),
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: AppTypography.body2Regular.copyWith(
                  color: AppColors.grayscale300,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
