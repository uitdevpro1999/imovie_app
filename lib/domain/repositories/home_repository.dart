import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/domain/entities/home/home_country.dart';
import 'package:imovie_app/domain/entities/home/home_feed.dart';
import 'package:imovie_app/domain/entities/home/home_genre.dart';

abstract interface class HomeRepository {
  Future<Result<HomeFeed>> getHomeFeed();

  Future<Result<List<HomeGenre>>> getHomeGenres();

  Future<Result<List<HomeCountry>>> getCountries();

  Future<Result<HomeFeed>> searchMovies({required String keyword});

  Future<Result<HomeFeed>> getMoviesByGenre({
    required String slug,
    required int page,
    required int limit,
    required String sortField,
    required String sortType,
    required String country,
    required String year,
  });
}
