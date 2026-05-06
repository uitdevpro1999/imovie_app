part of '../auth_page.dart';

class _AuthFooterLink extends StatelessWidget {
  const _AuthFooterLink({
    required this.prefix,
    required this.actionLabel,
    required this.onTap,
  });

  final String prefix;
  final String actionLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: RichText(
          text: TextSpan(
            style: AppTypography.body2Regular.copyWith(color: AppColors.white),
            children: [
              TextSpan(text: prefix),
              TextSpan(
                text: actionLabel,
                style: AppTypography.body2Medium.copyWith(
                  color: AppColors.yellow500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
