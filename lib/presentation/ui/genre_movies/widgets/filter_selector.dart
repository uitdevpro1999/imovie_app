part of '../genre_movies_page.dart';

class _FilterSelector<T> extends StatelessWidget {
  const _FilterSelector({
    required this.title,
    required this.value,
    required this.items,
    required this.labelBuilder,
    required this.onChanged,
  });

  final String title;
  final T value;
  final List<T> items;
  final String Function(T item) labelBuilder;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () async {
        final selected = await showModalBottomSheet<T>(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (_) => _SelectorSheet<T>(
            title: title,
            value: value,
            items: items,
            labelBuilder: labelBuilder,
          ),
        );

        if (selected != null) {
          onChanged(selected);
        }
      },
      child: Ink(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.grayscale900,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.grayscale800),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTypography.body2Regular.copyWith(
                      color: AppColors.grayscale400,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    labelBuilder(value),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.body1Regular.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: AppColors.grayscale300,
            ),
          ],
        ),
      ),
    );
  }
}

class _SelectorSheet<T> extends StatelessWidget {
  const _SelectorSheet({
    required this.title,
    required this.value,
    required this.items,
    required this.labelBuilder,
  });

  final String title;
  final T value;
  final List<T> items;
  final String Function(T item) labelBuilder;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.grayscale950,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: AppColors.grayscale800),
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.sizeOf(context).height * 0.74,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 44,
                  height: 4,
                  margin: const EdgeInsets.only(top: 12, bottom: 16),
                  decoration: BoxDecoration(
                    color: AppColors.grayscale600,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 8, 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: AppTypography.h3.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(
                          Icons.close_rounded,
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: ListView.separated(
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 16),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      final selected = item == value;
                      return InkWell(
                        borderRadius: BorderRadius.circular(14),
                        onTap: () => Navigator.of(context).pop(item),
                        child: Ink(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            color: selected
                                ? AppColors.yellow950
                                : AppColors.grayscale900,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: selected
                                  ? AppColors.yellow500
                                  : AppColors.grayscale800,
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  labelBuilder(item),
                                  style: AppTypography.body1Regular.copyWith(
                                    color: selected
                                        ? AppColors.yellow300
                                        : AppColors.white,
                                  ),
                                ),
                              ),
                              if (selected)
                                const Icon(
                                  Icons.check_rounded,
                                  color: AppColors.yellow500,
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (_, _) => const SizedBox(height: 8),
                    itemCount: items.length,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
