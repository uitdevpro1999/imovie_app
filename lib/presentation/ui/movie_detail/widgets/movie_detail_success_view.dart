part of '../movie_detail_page.dart';

class _MovieDetailSuccessView extends StatelessWidget {
  const _MovieDetailSuccessView({required this.cubit, required this.state});

  final MovieDetailCubit cubit;
  final MovieDetailState state;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final detail = state.detail!;
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isCompact = screenWidth < 360;
    final recommendedCardWidth = isCompact ? 124.0 : 140.0;

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _DetailHero(detail: detail),
              Transform.translate(
                offset: const Offset(0, -24),
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: AppColors.grayscale950,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                  ),
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        detail.title,
                        style: AppTypography.display.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 16,
                        runSpacing: 8,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          _PillLabel(text: detail.ageRatingLabel),
                          if (state.runtimeValue != '-')
                            Text(
                              state.runtimeValue,
                              style: AppTypography.body2Regular.copyWith(
                                color: AppColors.grayscale300,
                              ),
                            ),
                          if (detail.yearLabel.isNotEmpty)
                            Text(
                              detail.yearLabel,
                              style: AppTypography.body2Regular.copyWith(
                                color: AppColors.grayscale300,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      IMovieButton(
                        label: l10n.movieDetailPlay,
                        leadingIcon: IMovieButtonLeadingIcon.play,
                        enabled: detail.hasPlayableContent,
                        onPressed: () => _openWatch(context),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        detail.description,
                        style: AppTypography.body1Regular.copyWith(
                          color: AppColors.grayscale300,
                        ),
                      ),
                      const SizedBox(height: 16),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final columns = constraints.maxWidth < 320 ? 2 : 4;
                          final itemWidth =
                              (constraints.maxWidth - ((columns - 1) * 12)) /
                              columns;
                          final actions = [
                            _MovieDetailActionData(
                              icon: Icons.movie_creation_outlined,
                              label: l10n.movieDetailActionTrailer,
                              onTap: () => _openTrailer(context),
                            ),
                            _MovieDetailActionData(
                              icon: state.addedToLibrary
                                  ? Icons.bookmark_added_rounded
                                  : Icons.bookmark_add_outlined,
                              label: state.addedToLibrary
                                  ? l10n.movieDetailActionInLibrary
                                  : l10n.movieDetailActionWatchlist,
                              processing: state.addingToLibrary,
                              onTap: () => cubit.addToLibrary(
                                messages: MovieDetailLibraryMessages(
                                  emptyMovie: l10n.movieDetailLibraryEmptyMovie,
                                  success: l10n.movieDetailLibraryAddSuccess,
                                ),
                              ),
                            ),
                            _MovieDetailActionData(
                              icon: Icons.star_border_rounded,
                              label: l10n.movieDetailActionRate,
                              onTap: () => unawaited(_openRating(context)),
                            ),
                            _MovieDetailActionData(
                              icon: Icons.share_outlined,
                              label: l10n.movieDetailActionShare,
                            ),
                          ];

                          return Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: [
                              for (final action in actions)
                                SizedBox(
                                  width: itemWidth,
                                  child: _QuickAction(
                                    icon: action.icon,
                                    label: action.label,
                                    processing: action.processing,
                                    onTap: action.onTap,
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 24),
                      if (detail.actors.isNotEmpty) ...[
                        Text(
                          l10n.movieDetailActors,
                          style: AppTypography.h3.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: math.max(116.0, 116.h),
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final actor = state.actorViewData[index];
                              return IMovieActorCard(
                                imageUrl: actor.avatarUrl,
                                name: actor.name,
                                textColor: AppColors.white,
                              );
                            },
                            separatorBuilder: (_, _) => SizedBox(width: 12.w),
                            itemCount: state.actorViewData.length,
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                      if (detail.genres.isNotEmpty) ...[
                        Text(
                          l10n.movieDetailGenres,
                          style: AppTypography.h3.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: [
                            for (final genre in detail.genres)
                              IMovieGenreChip(
                                label: genre,
                                backgroundColor: AppColors.grayscale900,
                                textColor: AppColors.white,
                              ),
                          ],
                        ),
                        const SizedBox(height: 24),
                      ],
                      Text(
                        l10n.movieDetailInformation,
                        style: AppTypography.h3.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _InfoRow(
                        label: l10n.movieDetailInfoOriginalTitle,
                        value: state.originalTitleValue,
                      ),
                      _InfoRow(
                        label: l10n.movieDetailInfoStatus,
                        value: state.statusValue,
                      ),
                      _InfoRow(
                        label: l10n.movieDetailInfoYear,
                        value: state.yearValue,
                      ),
                      _InfoRow(
                        label: l10n.movieDetailInfoRuntime,
                        value: state.runtimeValue,
                      ),
                      _InfoRow(
                        label: l10n.movieDetailInfoLanguage,
                        value: state.languageValue,
                      ),
                      _InfoRow(
                        label: l10n.movieDetailInfoQuality,
                        value: state.qualityValue,
                      ),
                      _InfoRow(
                        label: l10n.movieDetailInfoDirector,
                        value: state.directorsValue,
                      ),
                      const SizedBox(height: 24),
                      Text(
                        l10n.movieDetailRating,
                        style: AppTypography.h3.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.grayscale900,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Text(
                              state.ratingLabel,
                              style: AppTypography.display.copyWith(
                                color: AppColors.yellow500,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              l10n.movieDetailReviews(detail.ratingCount),
                              style: AppTypography.body2Regular.copyWith(
                                color: AppColors.grayscale300,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Material(
                              color: AppColors.grayscale800,
                              borderRadius: BorderRadius.circular(10),
                              child: InkWell(
                                onTap: () => unawaited(_openRating(context)),
                                borderRadius: BorderRadius.circular(10),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 10,
                                  ),
                                  child: Text(
                                    l10n.movieDetailRateMovie,
                                    style: AppTypography.body2Medium.copyWith(
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (state.recommendedMovieViewData.isNotEmpty) ...[
                        const SizedBox(height: 24),
                        IMovieSectionHeader(
                          title: l10n.movieDetailRecommended,
                          actionLabel: l10n.homeSectionViewMore,
                          titleColor: AppColors.white,
                          actionColor: AppColors.yellow500,
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: math.max(258.0, 258.h),
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final item =
                                  state.recommendedMovieViewData[index];
                              final movie = item.movie;
                              return GestureDetector(
                                onTap: () => _openMovie(context, movie),
                                child: IMoviePosterCard(
                                  imageUrl: movie.posterUrl,
                                  title: movie.title,
                                  subtitle: movie.yearLabel,
                                  badgeText: item.ratingLabel,
                                  width: recommendedCardWidth,
                                  titleColor: AppColors.white,
                                  subtitleColor: AppColors.grayscale300,
                                ),
                              );
                            },
                            separatorBuilder: (_, _) => SizedBox(width: 12.w),
                            itemCount: state.recommendedMovieViewData.length,
                          ),
                        ),
                      ],
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _openRating(BuildContext context) async {
    final source = await showModalBottomSheet<_RatingSource>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: AppColors.grayscale950,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      clipBehavior: Clip.antiAlias,
      builder: (_) => _RatingSourceSheet(sources: _ratingSources(context)),
    );

    if (!context.mounted || source == null) {
      return;
    }

    await _openRatingSource(context, source);
  }

  List<_RatingSource> _ratingSources(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return [
      _RatingSource(
        type: _RatingSourceType.imdb,
        title: 'IMDb',
        subtitle: l10n.movieDetailRatingSourceImdbSubtitle,
        icon: Icons.star_rate_rounded,
      ),
      _RatingSource(
        type: _RatingSourceType.tmdb,
        title: 'TMDb',
        subtitle: l10n.movieDetailRatingSourceTmdbSubtitle,
        icon: Icons.movie_filter_rounded,
      ),
    ];
  }

  Future<void> _openRatingSource(
    BuildContext context,
    _RatingSource source,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    final detail = state.detail!;
    final uri = switch (source.type) {
      _RatingSourceType.imdb => _imdbRatingUri(detail),
      _RatingSourceType.tmdb => _tmdbRatingUri(detail),
    };
    final failureMessage = switch (source.type) {
      _RatingSourceType.imdb => l10n.movieDetailImdbOpenError,
      _RatingSourceType.tmdb => l10n.movieDetailTmdbOpenError,
    };

    try {
      final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!opened) {
        _showOpenRatingError(failureMessage);
      }
    } catch (_) {
      _showOpenRatingError(failureMessage);
    }
  }

  Uri _imdbRatingUri(MovieDetail detail) {
    final imdbId = detail.imdbId.trim();
    if (RegExp(r'^tt\d+$').hasMatch(imdbId)) {
      return Uri.https('www.imdb.com', '/title/$imdbId/ratings/');
    }

    return Uri.https('www.imdb.com', '/find/', {
      'q': _ratingSearchQuery(detail),
    });
  }

  Uri _tmdbRatingUri(MovieDetail detail) {
    final tmdbId = detail.tmdbId.trim();
    if (RegExp(r'^\d+$').hasMatch(tmdbId)) {
      return Uri.https(
        'www.themoviedb.org',
        '/${_tmdbMediaPath(detail)}/$tmdbId/reviews',
      );
    }

    return Uri.https('www.themoviedb.org', '/search', {
      'query': _ratingSearchQuery(detail),
    });
  }

  String _tmdbMediaPath(MovieDetail detail) {
    final tmdbType = detail.tmdbType.trim().toLowerCase();
    if (tmdbType == 'tv' || tmdbType == 'series') {
      return 'tv';
    }
    if (tmdbType == 'movie') {
      return 'movie';
    }

    final detailType = detail.type.trim().toLowerCase();
    if (detailType == 'series' ||
        detailType == 'tvshows' ||
        detailType.contains('tv')) {
      return 'tv';
    }

    return 'movie';
  }

  String _ratingSearchQuery(MovieDetail detail) {
    final title = [detail.originalTitle, detail.title, detail.slug]
        .map((item) => item.trim())
        .firstWhere((item) => item.isNotEmpty, orElse: () => 'movie');
    return [
      title,
      if (detail.year > 0) detail.year.toString(),
    ].where((item) => item.isNotEmpty).join(' ');
  }

  void _showOpenRatingError(String message) {
    appEventBus.emitToast(AppToastEvent.warning(message));
  }

  void _openMovie(BuildContext context, HomeMovie movie) {
    context.router.replace(
      MovieDetailRoute(slug: movie.slug, relatedMovies: state.relatedMovies),
    );
  }

  void _openWatch(BuildContext context) {
    final detail = state.detail!;
    context.router.push(
      MovieWatchRoute(slug: detail.slug, initialDetail: detail),
    );
  }

  void _openTrailer(BuildContext context) {
    final detail = state.detail!;
    final videoId = YoutubePlayer.convertUrlToId(detail.trailerUrl);
    if (videoId == null || videoId.trim().isEmpty) {
      appEventBus.emitToast(
        AppToastEvent.warning(
          AppLocalizations.of(context)!.movieTrailerUnavailable,
        ),
      );
      return;
    }

    showDialog<void>(
      context: context,
      barrierColor: AppColors.black.withValues(alpha: 0.82),
      builder: (_) => _MovieTrailerPopup(title: detail.title, videoId: videoId),
    );
  }
}

class _MovieDetailActionData {
  const _MovieDetailActionData({
    required this.icon,
    required this.label,
    this.processing = false,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final bool processing;
  final VoidCallback? onTap;
}
