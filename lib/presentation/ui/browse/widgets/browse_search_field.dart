part of '../browse_page.dart';

class _BrowseSearchField extends StatelessWidget {
  const _BrowseSearchField({required this.controller, required this.onChanged});

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

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
