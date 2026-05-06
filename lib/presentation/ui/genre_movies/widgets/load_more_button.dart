part of '../genre_movies_page.dart';

class _LoadMoreButton extends StatelessWidget {
  const _LoadMoreButton({required this.loadingMore, required this.onLoadMore});

  final bool loadingMore;
  final VoidCallback onLoadMore;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton(
          onPressed: loadingMore ? null : onLoadMore,
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.yellow500,
            side: const BorderSide(color: AppColors.yellow500),
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
          child: loadingMore
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Tải thêm'),
        ),
      ),
    );
  }
}
