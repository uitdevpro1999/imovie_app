import 'package:imovie_app/core/services/api_client.dart';
import 'package:imovie_app/data/models/response/home/home_feed_response.dart';
import 'package:imovie_app/data/models/response/home/home_genres_response.dart';

const _isFlutterTest = bool.fromEnvironment('FLUTTER_TEST');

abstract interface class HomeRemoteDataSource {
  Future<HomeFeedResponse> getHomeFeed();

  Future<HomeGenresResponse> getHomeGenres();

  Future<HomeGenresResponse> getCountries();

  Future<HomeFeedResponse> searchMovies({
    required String keyword,
    required int page,
    required int limit,
    required String sortField,
    required String sortType,
    required String country,
    required String year,
  });

  Future<HomeFeedResponse> getMoviesByGenre({
    required String slug,
    required int page,
    required int limit,
    required String sortField,
    required String sortType,
    required String country,
    required String year,
  });

  Future<HomeFeedResponse> getMoviesByList({
    required String slug,
    required int page,
    required int limit,
    required String sortField,
    required String sortType,
  });
}

class OPhimHomeRemoteDataSource implements HomeRemoteDataSource {
  const OPhimHomeRemoteDataSource({required this.apiClient});

  final ApiClient apiClient;

  @override
  Future<HomeFeedResponse> getHomeFeed() async {
    final json = await apiClient.getJson('home');
    return HomeFeedResponse.fromJson(json);
  }

  @override
  Future<HomeGenresResponse> getHomeGenres() async {
    final json = await apiClient.getJson('the-loai');
    return HomeGenresResponse.fromJson(json);
  }

  @override
  Future<HomeGenresResponse> getCountries() async {
    final json = await apiClient.getJson('quoc-gia');
    return HomeGenresResponse.fromJson(json);
  }

  @override
  Future<HomeFeedResponse> searchMovies({
    required String keyword,
    required int page,
    required int limit,
    required String sortField,
    required String sortType,
    required String country,
    required String year,
  }) async {
    final json = await apiClient.getJson(
      'tim-kiem',
      queryParameters: {
        'keyword': keyword.trim(),
        'page': page,
        'limit': limit,
        'sort_field': sortField,
        'sort_type': sortType,
        if (country.trim().isNotEmpty) 'country': country.trim(),
        if (year.trim().isNotEmpty) 'year': year.trim(),
      },
    );
    return HomeFeedResponse.fromJson(json);
  }

  @override
  Future<HomeFeedResponse> getMoviesByGenre({
    required String slug,
    required int page,
    required int limit,
    required String sortField,
    required String sortType,
    required String country,
    required String year,
  }) async {
    final json = await apiClient.getJson(
      'the-loai/$slug',
      queryParameters: {
        'page': page,
        'limit': limit,
        'sort_field': sortField,
        'sort_type': sortType,
        if (country.trim().isNotEmpty) 'country': country.trim(),
        if (year.trim().isNotEmpty) 'year': year.trim(),
      },
    );
    return HomeFeedResponse.fromJson(json);
  }

  @override
  Future<HomeFeedResponse> getMoviesByList({
    required String slug,
    required int page,
    required int limit,
    required String sortField,
    required String sortType,
  }) async {
    final json = await apiClient.getJson(
      'danh-sach/$slug',
      queryParameters: {
        'page': page,
        'limit': limit,
        'sort_field': sortField,
        'sort_type': sortType,
      },
    );
    return HomeFeedResponse.fromJson(json);
  }
}

class FakeHomeRemoteDataSource implements HomeRemoteDataSource {
  const FakeHomeRemoteDataSource();

  @override
  Future<HomeFeedResponse> getHomeFeed() async {
    return HomeFeedResponse.fromJson(_fakeHomeJson);
  }

  @override
  Future<HomeGenresResponse> getHomeGenres() async {
    return HomeGenresResponse.fromJson(_fakeGenresJson);
  }

  @override
  Future<HomeGenresResponse> getCountries() async {
    return HomeGenresResponse.fromJson(_fakeCountriesJson);
  }

  @override
  Future<HomeFeedResponse> searchMovies({
    required String keyword,
    required int page,
    required int limit,
    required String sortField,
    required String sortType,
    required String country,
    required String year,
  }) async {
    return HomeFeedResponse.fromJson(_fakeHomeJson);
  }

  @override
  Future<HomeFeedResponse> getMoviesByGenre({
    required String slug,
    required int page,
    required int limit,
    required String sortField,
    required String sortType,
    required String country,
    required String year,
  }) async {
    return HomeFeedResponse.fromJson(_fakeHomeJson);
  }

  @override
  Future<HomeFeedResponse> getMoviesByList({
    required String slug,
    required int page,
    required int limit,
    required String sortField,
    required String sortType,
  }) async {
    return HomeFeedResponse.fromJson(_fakeHomeJson);
  }
}

HomeRemoteDataSource buildHomeRemoteDataSource(ApiClient apiClient) {
  if (_isFlutterTest) {
    return const FakeHomeRemoteDataSource();
  }

  return OPhimHomeRemoteDataSource(apiClient: apiClient);
}

final Map<String, dynamic> _fakeHomeJson = {
  'status': 'success',
  'message': '',
  'data': {
    'seoOnPage': {'titleHead': 'iMovie Home'},
    'APP_DOMAIN_CDN_IMAGE': 'https://img.ophim.live',
    'items': [
      {
        '_id': '1',
        'name': 'Lính Mới (Phần 8)',
        'origin_name': 'The Rookie (Season 8)',
        'slug': 'linh-moi-phan-8',
        'thumb_url': 'linh-moi-phan-8-thumb.jpg',
        'time': '43 phút/tập',
        'episode_current': 'Tập 17',
        'quality': 'HD',
        'lang': 'Vietsub',
        'year': 2026,
        'type': 'series',
        'category': [
          {'name': 'Hài Hước'},
          {'name': 'Hành Động'},
        ],
        'country': [
          {'name': 'Âu Mỹ'},
        ],
        'imdb': {'vote_average': 8.0},
        'tmdb': {'vote_average': 8.537},
        'modified': {'time': '2026-04-30T12:33:27.000Z'},
      },
      {
        '_id': '2',
        'name': 'Reborn',
        'origin_name': 'Reborn',
        'slug': 'reborn',
        'thumb_url': 'reborn-thumb.jpg',
        'time': '? phút/tập',
        'episode_current': 'Tập 2',
        'quality': 'HD',
        'lang': 'Vietsub',
        'year': 2026,
        'type': 'series',
        'category': [
          {'name': 'Bí ẩn'},
        ],
        'country': [
          {'name': 'Nhật Bản'},
        ],
        'imdb': {'vote_average': 0},
        'tmdb': {'vote_average': 7.0},
        'modified': {'time': '2026-04-30T11:46:25.000Z'},
      },
      {
        '_id': '3',
        'name': 'Bí mật triệu đô (Phần 2)',
        'origin_name': 'Million Dollar Secret (Season 2)',
        'slug': 'bi-mat-trieu-do-phan-2',
        'thumb_url': 'bi-mat-trieu-do-phan-2-thumb.jpg',
        'time': '55 phút/tập',
        'episode_current': 'Trailer',
        'quality': 'HD',
        'lang': 'Vietsub',
        'year': 2026,
        'type': 'series',
        'category': [
          {'name': 'Tâm Lý'},
        ],
        'country': [
          {'name': 'Âu Mỹ'},
        ],
        'imdb': {'vote_average': 7.6},
        'tmdb': {'vote_average': 7.6},
        'modified': {'time': '2026-04-30T11:33:35.000Z'},
      },
      {
        '_id': '4',
        'name': 'Bàn Long',
        'origin_name': 'Coiled Dragon',
        'slug': 'ban-long',
        'thumb_url': 'ban-long-thumb.jpg',
        'time': '? phút/tập',
        'episode_current': 'Tập 3',
        'quality': 'HD',
        'lang': 'Vietsub',
        'year': 2026,
        'type': 'hoathinh',
        'category': [
          {'name': 'Viễn Tưởng'},
          {'name': 'Khoa Học'},
        ],
        'country': [
          {'name': 'Trung Quốc'},
        ],
        'imdb': {'vote_average': 0},
        'tmdb': {'vote_average': 0},
        'modified': {'time': '2026-04-30T11:21:39.000Z'},
      },
      {
        '_id': '5',
        'name': 'Kiếm Lai (Phần 2)',
        'origin_name': 'Sword of Coming (Season 2)',
        'slug': 'kiem-lai-phan-2',
        'thumb_url': 'kiem-lai-phan-2-thumb.jpg',
        'time': '31 phút/tập',
        'episode_current': 'Tập 21',
        'quality': 'HD',
        'lang': 'Vietsub',
        'year': 2025,
        'type': 'hoathinh',
        'category': [
          {'name': 'Hành Động'},
          {'name': 'Viễn Tưởng'},
        ],
        'country': [
          {'name': 'Trung Quốc'},
        ],
        'imdb': {'vote_average': 8.1},
        'tmdb': {'vote_average': 8.6},
        'modified': {'time': '2026-04-30T11:18:47.000Z'},
      },
      {
        '_id': '6',
        'name': 'CIA (Phần 1)',
        'origin_name': 'CIA',
        'slug': 'cia-phan-1',
        'thumb_url': 'cia-phan-1-thumb.jpg',
        'time': '43 phút/tập',
        'episode_current': 'Tập 2',
        'quality': 'HD',
        'lang': 'Vietsub',
        'year': 2026,
        'type': 'series',
        'category': [
          {'name': 'Hành Động'},
          {'name': 'Hình Sự'},
        ],
        'country': [
          {'name': 'Âu Mỹ'},
        ],
        'imdb': {'vote_average': 0},
        'tmdb': {'vote_average': 8.1},
        'modified': {'time': '2026-04-29T23:22:43.000Z'},
      },
    ],
  },
};

final Map<String, dynamic> _fakeGenresJson = {
  'status': 'success',
  'message': '',
  'data': {
    'items': [
      {
        '_id': '620a21b2e0fc277084dfd0c5',
        'name': 'Hành Động',
        'slug': 'hanh-dong',
      },
      {
        '_id': '620a220de0fc277084dfd16d',
        'name': 'Tình Cảm',
        'slug': 'tinh-cam',
      },
      {
        '_id': '620a221de0fc277084dfd1c1',
        'name': 'Hài Hước',
        'slug': 'hai-huoc',
      },
      {
        '_id': '620a222fe0fc277084dfd23d',
        'name': 'Cổ Trang',
        'slug': 'co-trang',
      },
      {'_id': '620a2238e0fc277084dfd291', 'name': 'Tâm Lý', 'slug': 'tam-ly'},
      {'_id': '620a2249e0fc277084dfd2e5', 'name': 'Hình Sự', 'slug': 'hinh-su'},
      {
        '_id': '620a2253e0fc277084dfd339',
        'name': 'Chiến Tranh',
        'slug': 'chien-tranh',
      },
    ],
  },
};

final Map<String, dynamic> _fakeCountriesJson = {
  'status': 'success',
  'message': '',
  'data': {
    'items': [
      {
        '_id': '62093063196e9f4ab6b448b8',
        'name': 'Trung Quốc',
        'slug': 'trung-quoc',
      },
      {
        '_id': '620a2300e0fc277084dfd6d2',
        'name': 'Hàn Quốc',
        'slug': 'han-quoc',
      },
      {
        '_id': '620a2307e0fc277084dfd726',
        'name': 'Nhật Bản',
        'slug': 'nhat-ban',
      },
      {'_id': '620a231fe0fc277084dfd7ce', 'name': 'Âu Mỹ', 'slug': 'au-my'},
    ],
  },
};
