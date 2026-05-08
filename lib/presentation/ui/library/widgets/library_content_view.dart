import 'package:flutter/material.dart';
import 'package:imovie_app/domain/entities/library/library_movie.dart';
import 'package:imovie_app/presentation/ui/library/widgets/library_empty_view.dart';
import 'package:imovie_app/presentation/ui/library/widgets/library_header.dart';
import 'package:imovie_app/presentation/ui/library/widgets/library_movie_card.dart';
import 'package:imovie_app/presentation/ui/library/widgets/library_swipe_action_tile.dart';

class LibraryContentView extends StatelessWidget {
  const LibraryContentView({
    super.key,
    required this.movies,
    required this.emptyTitle,
    required this.emptySubtitle,
    this.collectionTitle = 'Personal collection',
    this.collectionSubtitle = 'Movies you saved so you can return anytime.',
    this.savedMoviesLabel = 'Saved',
    this.playableMoviesLabel = 'Ready',
    this.swipeHint = 'Swipe left to remove',
    required this.removeActionLabel,
    this.removeConfirmTitle = 'Remove from library?',
    this.removeConfirmMessage = 'This movie will be removed from your library.',
    this.removeConfirmCancel = 'Cancel',
    this.removeConfirmAction = 'Remove',
    required this.onMovieTap,
    required this.onMovieRemove,
  });

  final List<LibraryMovie> movies;
  final String emptyTitle;
  final String emptySubtitle;
  final String collectionTitle;
  final String collectionSubtitle;
  final String savedMoviesLabel;
  final String playableMoviesLabel;
  final String swipeHint;
  final String removeActionLabel;
  final String removeConfirmTitle;
  final String removeConfirmMessage;
  final String removeConfirmCancel;
  final String removeConfirmAction;
  final ValueChanged<LibraryMovie> onMovieTap;
  final Future<bool> Function(LibraryMovie item) onMovieRemove;

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) {
      return LibraryEmptyView(title: emptyTitle, subtitle: emptySubtitle);
    }

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 24),
      itemBuilder: (context, index) {
        if (index == 0) {
          return LibraryHeader(
            movies: movies,
            title: collectionTitle,
            subtitle: collectionSubtitle,
            savedMoviesLabel: savedMoviesLabel,
            playableMoviesLabel: playableMoviesLabel,
          );
        }

        final item = movies[index - 1];
        return LibrarySwipeActionTile(
          key: ValueKey(item.id),
          removeActionLabel: removeActionLabel,
          confirmTitle: removeConfirmTitle,
          confirmMessage: removeConfirmMessage,
          confirmCancelLabel: removeConfirmCancel,
          confirmActionLabel: removeConfirmAction,
          onRemove: () => onMovieRemove(item),
          child: LibraryMovieCard(
            item: item,
            savedDateText: _formatSavedDate(context, item.createdAt),
            swipeHint: swipeHint,
            onTap: () => onMovieTap(item),
          ),
        );
      },
      separatorBuilder: (_, index) => SizedBox(height: index == 0 ? 16 : 12),
      itemCount: movies.length + 1,
    );
  }

  String _formatSavedDate(BuildContext context, DateTime? date) {
    if (date == null) {
      return '';
    }

    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();
    return '$day/$month/$year';
  }
}
