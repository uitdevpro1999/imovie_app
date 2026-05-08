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
          useSafeArea: true,
          backgroundColor: AppColors.grayscale950,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          clipBehavior: Clip.antiAlias,
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
              FluentIcons.chevron_down_24_regular,
              color: AppColors.grayscale300,
            ),
          ],
        ),
      ),
    );
  }
}

class _SelectorSheet<T> extends StatefulWidget {
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
  State<_SelectorSheet<T>> createState() => _SelectorSheetState<T>();
}

class _SelectorSheetState<T> extends State<_SelectorSheet<T>> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController(keepScrollOffset: false);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.paddingOf(context).bottom + 16;
    final maxHeight = MediaQuery.sizeOf(context).height * 0.82;
    final itemCount = widget.items.length;
    final separatorHeight = itemCount > 1 ? (itemCount - 1) * 8 : 0;
    final contentHeight =
        100.0 + (itemCount * 52) + separatorHeight + bottomPadding;
    final sheetHeight = contentHeight > maxHeight ? maxHeight : contentHeight;

    return SizedBox(
      height: sheetHeight,
      child: Column(
        children: [
          _SelectorSheetHeader(title: widget.title),
          Expanded(
            child: ListView.separated(
              controller: _scrollController,
              primary: false,
              padding: EdgeInsets.fromLTRB(16, 8, 16, bottomPadding),
              itemBuilder: (context, index) {
                final item = widget.items[index];
                final selected = item == widget.value;
                return InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: () => Navigator.of(context).pop(item),
                  child: Ink(
                    height: 52,
                    padding: const EdgeInsets.symmetric(horizontal: 14),
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
                            widget.labelBuilder(item),
                            style: AppTypography.body1Regular.copyWith(
                              color: selected
                                  ? AppColors.yellow300
                                  : AppColors.white,
                            ),
                          ),
                        ),
                        if (selected)
                          const Icon(
                            FluentIcons.checkmark_24_regular,
                            color: AppColors.yellow500,
                          ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (_, _) => const SizedBox(height: 8),
              itemCount: widget.items.length,
            ),
          ),
        ],
      ),
    );
  }
}

class _SelectorSheetHeader extends StatelessWidget {
  const _SelectorSheetHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.grayscale950,
        border: Border(bottom: BorderSide(color: AppColors.grayscale900)),
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
                    style: AppTypography.h3.copyWith(color: AppColors.white),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(
                    FluentIcons.dismiss_24_regular,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
