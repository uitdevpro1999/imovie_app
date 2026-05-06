import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:imovie_app/domain/entities/home/home_movie.dart';

part 'home_feed.freezed.dart';

@freezed
abstract class HomeFeed with _$HomeFeed {
  const HomeFeed._();

  const factory HomeFeed({
    required String seoTitle,
    required List<HomeMovie> movies,
    HomeMovie? featuredMovie,
    @Default(0) int totalItems,
    @Default(1) int currentPage,
    @Default(24) int itemsPerPage,
  }) = _HomeFeed;

  bool get isEmpty => movies.isEmpty;

  bool get hasMore => movies.length < totalItems;
}
