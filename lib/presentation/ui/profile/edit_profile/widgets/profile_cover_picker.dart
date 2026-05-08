import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/domain/entities/profile/app_profile.dart';
import 'package:imovie_app/presentation/widgets/imovie_remote_image.dart';

class ProfileCoverPicker extends StatelessWidget {
  const ProfileCoverPicker({
    super.key,
    required this.profile,
    required this.pendingCoverBytes,
    required this.label,
    required this.onPickCover,
  });

  final AppProfile profile;
  final Uint8List? pendingCoverBytes;
  final String label;
  final VoidCallback onPickCover;

  @override
  Widget build(BuildContext context) {
    final displayName = profile.fullName.trim().isEmpty
        ? 'iMovie'
        : profile.fullName.trim();

    return SizedBox(
      height: 150,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: DecoratedBox(
                decoration: const BoxDecoration(color: AppColors.grayscale900),
                child: _coverImage(displayName),
              ),
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      AppColors.black.withValues(alpha: 0.5),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 12,
            bottom: 12,
            child: Material(
              color: AppColors.grayscale950.withValues(alpha: 0.86),
              borderRadius: BorderRadius.circular(999),
              child: InkWell(
                onTap: onPickCover,
                borderRadius: BorderRadius.circular(999),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        FluentIcons.image_24_regular,
                        color: AppColors.yellow500,
                        size: 18,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.captionMedium.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _coverImage(String displayName) {
    final coverBytes = pendingCoverBytes;
    if (coverBytes != null) {
      return Image.memory(
        coverBytes,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        gaplessPlayback: true,
      );
    }

    if (profile.coverUrl.trim().isNotEmpty) {
      return IMovieRemoteImage(
        imageUrl: profile.coverUrl,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        placeholderLabel: displayName,
      );
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.yellow500.withValues(alpha: 0.8),
            AppColors.red400.withValues(alpha: 0.52),
            AppColors.grayscale800,
          ],
        ),
      ),
      child: Center(
        child: Icon(
          FluentIcons.image_24_regular,
          color: AppColors.white.withValues(alpha: 0.72),
          size: 42,
        ),
      ),
    );
  }
}
