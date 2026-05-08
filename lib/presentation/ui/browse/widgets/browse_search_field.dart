part of '../browse_page.dart';

class _BrowseSearchField extends StatelessWidget {
  const _BrowseSearchField({
    required this.controller,
    required this.onChanged,
    required this.activeFilterCount,
    required this.onFilterTap,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final int activeFilterCount;
  final VoidCallback onFilterTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.grayscale900,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.white.withValues(alpha: 0.07)),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.18),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: AppTypography.body2Regular.copyWith(color: AppColors.white),
        cursorColor: AppColors.yellow500,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: l10n.browseSearchHint,
          hintStyle: AppTypography.body2Regular.copyWith(
            color: AppColors.grayscale300,
          ),
          prefixIcon: const Icon(
            FluentIcons.search_24_regular,
            color: AppColors.grayscale200,
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 6),
            child: Stack(
              alignment: Alignment.center,
              children: [
                IconButton(
                  tooltip: 'Bộ lọc',
                  onPressed: onFilterTap,
                  icon: DecoratedBox(
                    decoration: BoxDecoration(
                      color: activeFilterCount > 0
                          ? AppColors.yellow500.withValues(alpha: 0.12)
                          : AppColors.grayscale800,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Icon(
                        FluentIcons.options_24_regular,
                        size: 18,
                        color: activeFilterCount > 0
                            ? AppColors.yellow500
                            : AppColors.grayscale200,
                      ),
                    ),
                  ),
                ),
                if (activeFilterCount > 0)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: DecoratedBox(
                      decoration: const BoxDecoration(
                        color: AppColors.yellow500,
                        shape: BoxShape.circle,
                      ),
                      child: SizedBox.square(
                        dimension: 16,
                        child: Center(
                          child: Text(
                            activeFilterCount.toString(),
                            style: AppTypography.captionMedium.copyWith(
                              color: AppColors.grayscale950,
                              height: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          filled: true,
          fillColor: Colors.transparent,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 18,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(color: AppColors.yellow500),
          ),
        ),
      ),
    );
  }
}
