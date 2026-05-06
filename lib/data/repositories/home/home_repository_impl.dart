import 'package:imovie_app/core/error/app_exception.dart';
import 'package:imovie_app/core/error/app_failure.dart';
import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/data/datasources/home/home_remote_data_source.dart';
import 'package:imovie_app/data/models/response/home/home_feed_response.dart';
import 'package:imovie_app/domain/entities/home/home_country.dart';
import 'package:imovie_app/domain/entities/home/home_feed.dart';
import 'package:imovie_app/domain/entities/home/home_genre.dart';
import 'package:imovie_app/domain/entities/home/home_movie.dart';
import 'package:imovie_app/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  const HomeRepositoryImpl({required this.remoteDataSource});

  final HomeRemoteDataSource remoteDataSource;

  @override
  Future<Result<HomeFeed>> getHomeFeed() async {
    try {
      final response = await remoteDataSource.getHomeFeed();
      return Success(_mapFeed(response));
    } on AppException catch (error) {
      return FailureResult(error.failure);
    } catch (error) {
      return FailureResult(
        AppFailure.unknown(
          'Unexpected error while loading home feed.',
          details: error.toString(),
        ),
      );
    }
  }

  @override
  Future<Result<List<HomeGenre>>> getHomeGenres() async {
    try {
      final response = await remoteDataSource.getHomeGenres();
      final genres = response.items
          .where((item) => item.name.trim().isNotEmpty)
          .map(
            (item) => HomeGenre(id: item.id, name: item.name, slug: item.slug),
          )
          .toList(growable: false);

      return Success(genres);
    } on AppException catch (error) {
      return FailureResult(error.failure);
    } catch (error) {
      return FailureResult(
        AppFailure.unknown(
          'Unexpected error while loading home genres.',
          details: error.toString(),
        ),
      );
    }
  }

  @override
  Future<Result<List<HomeCountry>>> getCountries() async {
    try {
      final response = await remoteDataSource.getCountries();
      final countries = response.items
          .where((item) => item.name.trim().isNotEmpty)
          .map(
            (item) =>
                HomeCountry(id: item.id, name: item.name, slug: item.slug),
          )
          .toList(growable: false);

      return Success([HomeCountry.all, ...countries]);
    } on AppException catch (error) {
      return FailureResult(error.failure);
    } catch (error) {
      return FailureResult(
        AppFailure.unknown(
          'Unexpected error while loading countries.',
          details: error.toString(),
        ),
      );
    }
  }

  @override
  Future<Result<HomeFeed>> searchMovies({required String keyword}) async {
    try {
      final response = await remoteDataSource.searchMovies(keyword: keyword);
      return Success(_mapFeed(response));
    } on AppException catch (error) {
      return FailureResult(error.failure);
    } catch (error) {
      return FailureResult(
        AppFailure.unknown(
          'Unexpected error while searching movies.',
          details: error.toString(),
        ),
      );
    }
  }

  @override
  Future<Result<HomeFeed>> getMoviesByGenre({
    required String slug,
    required int page,
    required int limit,
    required String sortField,
    required String sortType,
    required String country,
    required String year,
  }) async {
    try {
      final response = await remoteDataSource.getMoviesByGenre(
        slug: slug,
        page: page,
        limit: limit,
        sortField: sortField,
        sortType: sortType,
        country: country,
        year: year,
      );
      return Success(_mapFeed(response));
    } on AppException catch (error) {
      return FailureResult(error.failure);
    } catch (error) {
      return FailureResult(
        AppFailure.unknown(
          'Unexpected error while loading genre movies.',
          details: error.toString(),
        ),
      );
    }
  }

  HomeFeed _mapFeed(HomeFeedResponse response) {
    final imageBaseUrl = response.data.imageBaseUrl;
    final movies = response.data.items
        .map((item) => _mapMovie(item, imageBaseUrl))
        .toList(growable: false);

    return HomeFeed(
      seoTitle: response.data.seoTitle,
      movies: movies,
      featuredMovie: movies.isEmpty ? null : movies.first,
      totalItems: response.data.totalItems == 0
          ? movies.length
          : response.data.totalItems,
      currentPage: response.data.currentPage,
      itemsPerPage: response.data.itemsPerPage,
    );
  }

  HomeMovie _mapMovie(dynamic item, String imageBaseUrl) {
    final rating = item.imdbRating > 0 ? item.imdbRating : item.tmdbRating;
    final posterPath = item.thumbUrl.trim();
    final resolvedPosterUrl = posterPath.isEmpty
        ? ''
        : Uri.parse(
            imageBaseUrl,
          ).resolve('uploads/movies/$posterPath').toString();

    return HomeMovie(
      id: item.id,
      title: item.name,
      originalTitle: item.originName,
      slug: item.slug,
      posterUrl: resolvedPosterUrl,
      durationLabel: item.durationLabel,
      episodeLabel: item.episodeLabel,
      qualityLabel: item.qualityLabel,
      languageLabel: item.languageLabel,
      year: item.year,
      type: item.type,
      categories: item.categories,
      countries: item.countries,
      rating: rating,
      modifiedAt: DateTime.tryParse(item.modifiedTime ?? ''),
    );
  }
}
