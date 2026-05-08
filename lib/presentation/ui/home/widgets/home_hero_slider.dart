import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:imovie_app/config/navigation/app_router.dart';
import 'package:imovie_app/config/styles/app_colors.dart';
import 'package:imovie_app/domain/entities/home/home_movie.dart';
import 'package:imovie_app/presentation/ui/home/home_state.dart';
import 'package:imovie_app/presentation/ui/home/widgets/home_hero_banner.dart';

class HomeHeroSlider extends StatefulWidget {
  const HomeHeroSlider({
    super.key,
    required this.movies,
    required this.relatedMovies,
    required this.onPlayMovie,
    required this.onOpenTrailer,
  });

  final List<HomeMovieViewData> movies;
  final List<HomeMovie> relatedMovies;
  final ValueChanged<HomeMovie> onPlayMovie;
  final ValueChanged<HomeMovie> onOpenTrailer;

  @override
  State<HomeHeroSlider> createState() => _HomeHeroSliderState();
}

class _HomeHeroSliderState extends State<HomeHeroSlider> {
  static const _autoSlideDuration = Duration(seconds: 5);
  static const _slideAnimationDuration = Duration(milliseconds: 350);

  late final PageController _pageController;
  Timer? _autoSlideTimer;
  int _activeIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.92);
    _startAutoSlideTimer();
  }

  @override
  void didUpdateWidget(covariant HomeHeroSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.movies.length != oldWidget.movies.length) {
      _activeIndex = 0;
      if (_pageController.hasClients) {
        _pageController.jumpToPage(0);
      }
      _startAutoSlideTimer();
    }
  }

  @override
  void dispose() {
    _autoSlideTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoSlideTimer() {
    _autoSlideTimer?.cancel();
    if (widget.movies.length < 2) {
      return;
    }

    _autoSlideTimer = Timer.periodic(_autoSlideDuration, (_) {
      if (!mounted || !_pageController.hasClients || widget.movies.isEmpty) {
        return;
      }

      final nextIndex = (_activeIndex + 1) % widget.movies.length;
      _pageController.animateToPage(
        nextIndex,
        duration: _slideAnimationDuration,
        curve: Curves.easeOutCubic,
      );
    });
  }

  void _openMovie(BuildContext context, HomeMovie movie) {
    context.router.push(
      MovieDetailRoute(slug: movie.slug, relatedMovies: widget.relatedMovies),
    );
  }

  @override
  Widget build(BuildContext context) {
    final movies = widget.movies;
    if (movies.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        SizedBox(
          height: HomeHeroBanner.heightFor(context),
          child: PageView.builder(
            controller: _pageController,
            itemCount: movies.length,
            onPageChanged: (index) {
              setState(() {
                _activeIndex = index;
              });
            },
            itemBuilder: (context, index) {
              final movie = movies[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: GestureDetector(
                  onTap: () => _openMovie(context, movie.movie),
                  child: HomeHeroBanner(
                    movie: movie,
                    onPlayTap: () => widget.onPlayMovie(movie.movie),
                    onTrailerTap: () => widget.onOpenTrailer(movie.movie),
                  ),
                ),
              );
            },
          ),
        ),
        if (movies.length > 1) ...[
          const SizedBox(height: 12),
          _HomeHeroSliderDots(count: movies.length, activeIndex: _activeIndex),
        ],
      ],
    );
  }
}

class _HomeHeroSliderDots extends StatelessWidget {
  const _HomeHeroSliderDots({required this.count, required this.activeIndex});

  final int count;
  final int activeIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(count, (index) {
        final isActive = index == activeIndex;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: isActive ? 18 : 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
            color: isActive ? AppColors.yellow500 : AppColors.grayscale700,
            borderRadius: BorderRadius.circular(99),
          ),
        );
      }),
    );
  }
}
