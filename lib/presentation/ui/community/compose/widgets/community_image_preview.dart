import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/presentation/widgets/imovie_remote_image.dart';

class CommunityImagePreview extends StatelessWidget {
  const CommunityImagePreview({
    super.key,
    required this.selectedImage,
    required this.existingImageUrl,
    required this.onPickTap,
    required this.onRemoveTap,
    required this.pickLabel,
    required this.removeLabel,
  });

  final XFile? selectedImage;
  final String existingImageUrl;
  final VoidCallback onPickTap;
  final VoidCallback onRemoveTap;
  final String pickLabel;
  final String removeLabel;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.grayscale900,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (selectedImage != null)
              FutureBuilder(
                future: selectedImage!.readAsBytes(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const SizedBox(
                      height: 180,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColors.yellow500,
                        ),
                      ),
                    );
                  }

                  return ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.memory(
                      snapshot.data!,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              )
            else if (existingImageUrl.trim().isNotEmpty)
              SizedBox(
                height: 180,
                child: IMovieRemoteImage(
                  imageUrl: existingImageUrl,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onPickTap,
                    icon: const Icon(Icons.image_outlined),
                    label: Text(pickLabel),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.white,
                      side: const BorderSide(color: AppColors.grayscale700),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      textStyle: AppTypography.captionMedium,
                    ),
                  ),
                ),
                if (selectedImage != null) ...[
                  const SizedBox(width: 10),
                  IconButton(
                    tooltip: removeLabel,
                    onPressed: onRemoveTap,
                    icon: const Icon(Icons.close_rounded),
                    color: AppColors.red400,
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
