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

    return TextField(
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
          Icons.search_rounded,
          color: AppColors.grayscale200,
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 4),
          child: Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                tooltip: 'Bộ lọc',
                onPressed: onFilterTap,
                icon: Icon(
                  Icons.tune_rounded,
                  color: activeFilterCount > 0
                      ? AppColors.yellow500
                      : AppColors.grayscale200,
                ),
              ),
              if (activeFilterCount > 0)
                Positioned(
                  top: 9,
                  right: 9,
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
        fillColor: AppColors.grayscale900,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.yellow500),
        ),
      ),
    );
  }
}
