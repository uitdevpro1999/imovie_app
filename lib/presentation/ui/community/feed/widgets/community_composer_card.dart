import 'package:flutter/material.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';

class CommunityComposerCard extends StatelessWidget {
  const CommunityComposerCard({
    super.key,
    required this.prompt,
    required this.createLabel,
    required this.movieLabel,
    required this.imageLabel,
    required this.onTap,
  });

  final String prompt;
  final String createLabel;
  final String movieLabel;
  final String imageLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.grayscale900,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Ink(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.grayscale800),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: AppColors.yellow950,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.groups_2_rounded,
                      color: AppColors.yellow500,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      prompt,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.body1Regular.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  _ComposerCreateBadge(label: createLabel),
                ],
              ),
              const SizedBox(height: 14),
              const Divider(height: 1, color: AppColors.grayscale800),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _ComposerHintChip(
                      icon: Icons.movie_filter_rounded,
                      label: movieLabel,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _ComposerHintChip(
                      icon: Icons.image_outlined,
                      label: imageLabel,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ComposerCreateBadge extends StatelessWidget {
  const _ComposerCreateBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.yellow500,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.add_rounded,
            size: 18,
            color: AppColors.grayscale950,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.captionMedium.copyWith(
              color: AppColors.grayscale950,
            ),
          ),
        ],
      ),
    );
  }
}

class _ComposerHintChip extends StatelessWidget {
  const _ComposerHintChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: AppColors.grayscale800,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 16, color: AppColors.grayscale300),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTypography.captionMedium.copyWith(
                color: AppColors.grayscale300,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
