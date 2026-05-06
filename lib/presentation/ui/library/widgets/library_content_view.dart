import 'package:flutter/material.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/domain/entities/library/library_movie.dart';
import 'package:imovie_app/presentation/ui/library/widgets/library_empty_view.dart';
import 'package:imovie_app/presentation/ui/library/widgets/library_movie_card.dart';

class LibraryContentView extends StatelessWidget {
  const LibraryContentView({
    super.key,
    required this.movies,
    required this.emptyTitle,
    required this.emptySubtitle,
    required this.removeActionLabel,
    required this.onMovieTap,
    required this.onMovieRemove,
  });

  final List<LibraryMovie> movies;
  final String emptyTitle;
  final String emptySubtitle;
  final String removeActionLabel;
  final ValueChanged<LibraryMovie> onMovieTap;
  final Future<bool> Function(LibraryMovie item) onMovieRemove;

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) {
      return LibraryEmptyView(title: emptyTitle, subtitle: emptySubtitle);
    }

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      itemBuilder: (context, index) {
        final item = movies[index];
        return Dismissible(
          key: ValueKey(item.id),
          direction: DismissDirection.endToStart,
          background: _LibraryDeleteBackground(label: removeActionLabel),
          confirmDismiss: (_) => onMovieRemove(item),
          child: LibraryMovieCard(item: item, onTap: () => onMovieTap(item)),
        );
      },
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemCount: movies.length,
    );
  }
}

class _LibraryDeleteBackground extends StatelessWidget {
  const _LibraryDeleteBackground({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.danger,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.delete_outline_rounded,
                color: AppColors.white,
                size: 26,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: AppTypography.captionMedium.copyWith(
                  color: AppColors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
