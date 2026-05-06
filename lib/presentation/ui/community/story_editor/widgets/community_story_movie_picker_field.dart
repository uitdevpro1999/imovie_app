import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/config/styles/app_typography.dart';
import 'package:imovie_app/domain/entities/home/home_movie.dart';
import 'package:imovie_app/l10n/app_localizations.dart';
import 'package:imovie_app/presentation/ui/community/story_editor/community_story_editor_cubit.dart';
import 'package:imovie_app/presentation/ui/community/story_editor/community_story_editor_state.dart';
import 'package:imovie_app/presentation/widgets/imovie_remote_image.dart';

class CommunityStoryMoviePickerField extends StatelessWidget {
  const CommunityStoryMoviePickerField({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocBuilder<CommunityStoryEditorCubit, CommunityStoryEditorState>(
      buildWhen: (previous, current) =>
          previous.selectedMovieTitle != current.selectedMovieTitle ||
          previous.selectedMoviePosterUrl != current.selectedMoviePosterUrl,
      builder: (context, state) {
        final hasMovie = state.selectedMovieTitle.trim().isNotEmpty;
        return Material(
          color: AppColors.grayscale900,
          borderRadius: BorderRadius.circular(14),
          child: InkWell(
            onTap: () => _openPicker(context),
            borderRadius: BorderRadius.circular(14),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  if (hasMovie &&
                      state.selectedMoviePosterUrl.trim().isNotEmpty)
                    IMovieRemoteImage(
                      imageUrl: state.selectedMoviePosterUrl,
                      width: 44,
                      height: 62,
                      borderRadius: BorderRadius.circular(10),
                      placeholderLabel: state.selectedMovieTitle,
                    )
                  else
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: AppColors.grayscale800,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.movie_outlined,
                        color: AppColors.yellow500,
                      ),
                    ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          hasMovie
                              ? state.selectedMovieTitle
                              : l10n.communityMovieHint,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.body2Medium.copyWith(
                            color: hasMovie
                                ? AppColors.white
                                : AppColors.grayscale400,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          l10n.communityMovieSearchSubtitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.captionRegular1.copyWith(
                            color: AppColors.grayscale400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (hasMovie)
                    IconButton(
                      tooltip: l10n.communityMovieClearAction,
                      onPressed: context
                          .read<CommunityStoryEditorCubit>()
                          .clearSelectedMovie,
                      icon: const Icon(Icons.close_rounded),
                      color: AppColors.grayscale300,
                    )
                  else
                    const Icon(
                      Icons.chevron_right_rounded,
                      color: AppColors.grayscale400,
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _openPicker(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.grayscale950,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (_) => BlocProvider.value(
        value: context.read<CommunityStoryEditorCubit>(),
        child: const _StoryMoviePickerSheet(),
      ),
    );
  }
}

class _StoryMoviePickerSheet extends StatefulWidget {
  const _StoryMoviePickerSheet();

  @override
  State<_StoryMoviePickerSheet> createState() => _StoryMoviePickerSheetState();
}

class _StoryMoviePickerSheetState extends State<_StoryMoviePickerSheet> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final screenHeight = MediaQuery.sizeOf(context).height;
    final sheetHeight = (screenHeight * 0.72).clamp(440.0, 620.0);

    return SafeArea(
      top: false,
      child: SizedBox(
        height: sheetHeight,
        child:
            BlocBuilder<CommunityStoryEditorCubit, CommunityStoryEditorState>(
              builder: (context, state) {
                return Padding(
                  padding: EdgeInsets.fromLTRB(
                    16,
                    8,
                    16,
                    MediaQuery.viewInsetsOf(context).bottom + 16,
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 44,
                        height: 4,
                        decoration: BoxDecoration(
                          color: AppColors.grayscale600,
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        l10n.communityMoviePickerTitle,
                        style: AppTypography.h3.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                      const SizedBox(height: 14),
                      TextField(
                        controller: _controller,
                        autofocus: true,
                        style: AppTypography.body2Regular.copyWith(
                          color: AppColors.white,
                        ),
                        onChanged: context
                            .read<CommunityStoryEditorCubit>()
                            .searchMovies,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.search_rounded,
                            color: AppColors.grayscale400,
                          ),
                          hintText: l10n.communityMovieSearchHint,
                          hintStyle: AppTypography.body2Regular.copyWith(
                            color: AppColors.grayscale400,
                          ),
                          filled: true,
                          fillColor: AppColors.grayscale900,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: state.searchingMovies
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.yellow500,
                                ),
                              )
                            : state.movieSearchResults.isEmpty
                            ? Center(
                                child: Text(
                                  l10n.communityMovieSearchEmpty,
                                  textAlign: TextAlign.center,
                                  style: AppTypography.body2Regular.copyWith(
                                    color: AppColors.grayscale300,
                                  ),
                                ),
                              )
                            : ListView.separated(
                                itemBuilder: (context, index) {
                                  final movie = state.movieSearchResults[index];
                                  return _MovieSearchResultTile(
                                    movie: movie,
                                    onTap: () {
                                      context
                                          .read<CommunityStoryEditorCubit>()
                                          .selectMovie(movie);
                                      Navigator.of(context).pop();
                                    },
                                  );
                                },
                                separatorBuilder: (_, _) =>
                                    const SizedBox(height: 10),
                                itemCount: state.movieSearchResults.length,
                              ),
                      ),
                    ],
                  ),
                );
              },
            ),
      ),
    );
  }
}

class _MovieSearchResultTile extends StatelessWidget {
  const _MovieSearchResultTile({required this.movie, required this.onTap});

  final HomeMovie movie;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final subtitle = [
      movie.yearLabel,
      if (movie.qualityLabel.trim().isNotEmpty) movie.qualityLabel,
      if (movie.languageLabel.trim().isNotEmpty) movie.languageLabel,
    ].join(' • ');

    return Material(
      color: AppColors.grayscale900,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              IMovieRemoteImage(
                imageUrl: movie.posterUrl,
                width: 48,
                height: 70,
                borderRadius: BorderRadius.circular(10),
                placeholderLabel: movie.title,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.body2Medium.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                    if (movie.originalTitle.trim().isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        movie.originalTitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.captionRegular1.copyWith(
                          color: AppColors.grayscale300,
                        ),
                      ),
                    ],
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.captionRegular1.copyWith(
                        color: AppColors.grayscale400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
