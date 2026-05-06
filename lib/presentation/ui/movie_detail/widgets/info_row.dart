part of '../movie_detail_page.dart';

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final isCompact = MediaQuery.sizeOf(context).width < 340;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: isCompact
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTypography.body2Regular.copyWith(
                    color: AppColors.grayscale300,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: AppTypography.body2Regular.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    label,
                    style: AppTypography.body2Regular.copyWith(
                      color: AppColors.grayscale300,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    value,
                    style: AppTypography.body2Regular.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
