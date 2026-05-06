part of '../movie_detail_page.dart';

class _MovieDetailSuccessView extends StatelessWidget {
  const _MovieDetailSuccessView({required this.state});

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
                      LayoutBuilder(
                        builder: (context, constraints) {
                          if (constraints.maxWidth < 280) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                MovieGoButton(
                                  label: l10n.movieDetailPlay,
                                  leadingIcon: MovieGoButtonLeadingIcon.play,
                                  enabled: detail.hasPlayableContent,
                                  onPressed: () => _openWatch(context),
                                ),
                                const SizedBox(height: 12),
                                const Align(
                                  alignment: Alignment.centerRight,
                                  child: _SquareActionButton(
                                    icon: Icons.download_rounded,
                                  ),
                                ),
                              ],
                            );
                          }

                          return Row(
                            children: [
                              Expanded(
                                child: MovieGoButton(
                                  label: l10n.movieDetailPlay,
                                  leadingIcon: MovieGoButtonLeadingIcon.play,
                                  enabled: detail.hasPlayableContent,
                                  onPressed: () => _openWatch(context),
                                ),
                              ),
                              const SizedBox(width: 12),
                              const _SquareActionButton(
                                icon: Icons.download_rounded,
                              ),
                            ],
                          );
                        },
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
                            (
                              Icons.movie_creation_outlined,
                              l10n.movieDetailActionTrailer,
                            ),
                            (
                              Icons.add_rounded,
                              l10n.movieDetailActionWatchlist,
                            ),
                            (
                              Icons.star_border_rounded,
                              l10n.movieDetailActionRate,
                            ),
                            (Icons.share_outlined, l10n.movieDetailActionShare),
                          ];

                          return Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: [
                              for (final action in actions)
                                SizedBox(
                                  width: itemWidth,
                                  child: _QuickAction(
                                    icon: action.$1,
                                    label: action.$2,
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
                              return MovieGoActorCard(
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
                              MovieGoGenreChip(
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
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.grayscale800,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                l10n.movieDetailRateMovie,
                                style: AppTypography.body2Medium.copyWith(
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (state.recommendedMovieViewData.isNotEmpty) ...[
                        const SizedBox(height: 24),
                        MovieGoSectionHeader(
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
                                child: MovieGoPosterCard(
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
}
