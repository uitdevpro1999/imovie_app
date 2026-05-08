import 'package:flutter/material.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/domain/entities/profile/app_profile.dart';
import 'package:imovie_app/presentation/widgets/imovie_remote_image.dart';

class SettingsProfileHeader extends StatelessWidget {
  const SettingsProfileHeader({super.key, required this.profile});

  final AppProfile profile;

  @override
  Widget build(BuildContext context) {
    final displayName = profile.fullName.trim().isEmpty
        ? 'User'
        : profile.fullName.trim();
    final initials = displayName.characters.first.toUpperCase();

    return Column(
      children: [
        SizedBox(
          height: 184,
          width: double.infinity,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Positioned.fill(
                bottom: 42,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      _SettingsCover(profile: profile),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              AppColors.black.withValues(alpha: 0.06),
                              AppColors.black.withValues(alpha: 0.62),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: 90,
                  height: 90,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.grayscale950,
                    border: Border.all(
                      color: AppColors.yellow500.withValues(alpha: 0.42),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withValues(alpha: 0.35),
                        blurRadius: 22,
                        offset: const Offset(0, 12),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: DecoratedBox(
                      decoration: const BoxDecoration(
                        color: AppColors.grayscale800,
                      ),
                      child: profile.avatarUrl.trim().isEmpty
                          ? _SettingsInitialsAvatar(initials: initials)
                          : IMovieRemoteImage(
                              imageUrl: profile.avatarUrl,
                              fit: BoxFit.cover,
                              placeholderLabel: initials,
                            ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Text(
          displayName,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTypography.h2.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          _handleFromEmail(profile.email),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTypography.body2Regular.copyWith(
            color: AppColors.grayscale300,
          ),
        ),
      ],
    );
  }

  String _handleFromEmail(String email) {
    final prefix = email.split('@').first.trim();
    return prefix.isEmpty ? '@user' : '@$prefix';
  }
}

class _SettingsCover extends StatelessWidget {
  const _SettingsCover({required this.profile});

  final AppProfile profile;

  @override
  Widget build(BuildContext context) {
    if (profile.coverUrl.trim().isNotEmpty) {
      return IMovieRemoteImage(
        imageUrl: profile.coverUrl,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        placeholderLabel: profile.fullName,
      );
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.yellow500.withValues(alpha: 0.85),
            AppColors.red400.withValues(alpha: 0.55),
            AppColors.grayscale800,
          ],
        ),
      ),
    );
  }
}

class _SettingsInitialsAvatar extends StatelessWidget {
  const _SettingsInitialsAvatar({required this.initials});

  final String initials;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        initials,
        style: AppTypography.h1.copyWith(color: AppColors.yellow500),
      ),
    );
  }
}
