class HomeFeedResponse {
  const HomeFeedResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory HomeFeedResponse.fromJson(Map<String, dynamic> json) {
    return HomeFeedResponse(
      status: json['status'] as String? ?? '',
      message: json['message'] as String? ?? '',
      data: HomeFeedDataResponse.fromJson(
        json['data'] as Map<String, dynamic>? ?? const <String, dynamic>{},
      ),
    );
  }

  final String status;
  final String message;
  final HomeFeedDataResponse data;
}

class HomeFeedDataResponse {
  const HomeFeedDataResponse({
    required this.seoTitle,
    required this.imageBaseUrl,
    required this.items,
    required this.totalItems,
    required this.currentPage,
    required this.itemsPerPage,
  });

  factory HomeFeedDataResponse.fromJson(Map<String, dynamic> json) {
    final seoOnPage = json['seoOnPage'] as Map<String, dynamic>? ?? const {};
    final params = json['params'] as Map<String, dynamic>? ?? const {};
    final pagination =
        params['pagination'] as Map<String, dynamic>? ?? const {};

    return HomeFeedDataResponse(
      seoTitle: seoOnPage['titleHead'] as String? ?? '',
      imageBaseUrl: json['APP_DOMAIN_CDN_IMAGE'] as String? ?? '',
      items: (json['items'] as List<dynamic>? ?? const [])
          .whereType<Map<String, dynamic>>()
          .map(HomeMovieResponse.fromJson)
          .toList(growable: false),
      totalItems: (pagination['totalItems'] as num?)?.toInt() ?? 0,
      currentPage: (pagination['currentPage'] as num?)?.toInt() ?? 1,
      itemsPerPage: (pagination['totalItemsPerPage'] as num?)?.toInt() ?? 24,
    );
  }

  final String seoTitle;
  final String imageBaseUrl;
  final List<HomeMovieResponse> items;
  final int totalItems;
  final int currentPage;
  final int itemsPerPage;
}

class HomeMovieResponse {
  const HomeMovieResponse({
    required this.id,
    required this.name,
    required this.originName,
    required this.slug,
    required this.thumbUrl,
    required this.durationLabel,
    required this.episodeLabel,
    required this.qualityLabel,
    required this.languageLabel,
    required this.year,
    required this.type,
    required this.categories,
    required this.countries,
    required this.imdbRating,
    required this.tmdbRating,
    required this.modifiedTime,
  });

  factory HomeMovieResponse.fromJson(Map<String, dynamic> json) {
    final imdb = json['imdb'] as Map<String, dynamic>? ?? const {};
    final tmdb = json['tmdb'] as Map<String, dynamic>? ?? const {};
    final modified = json['modified'] as Map<String, dynamic>? ?? const {};

    return HomeMovieResponse(
      id: json['_id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      originName: json['origin_name'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
      thumbUrl: json['thumb_url'] as String? ?? '',
      durationLabel: json['time'] as String? ?? '',
      episodeLabel: json['episode_current'] as String? ?? '',
      qualityLabel: json['quality'] as String? ?? '',
      languageLabel: json['lang'] as String? ?? '',
      year: (json['year'] as num?)?.toInt() ?? 0,
      type: json['type'] as String? ?? '',
      categories: (json['category'] as List<dynamic>? ?? const [])
          .whereType<Map<String, dynamic>>()
          .map((item) => item['name'] as String? ?? '')
          .where((item) => item.trim().isNotEmpty)
          .toList(growable: false),
      countries: (json['country'] as List<dynamic>? ?? const [])
          .whereType<Map<String, dynamic>>()
          .map((item) => item['name'] as String? ?? '')
          .where((item) => item.trim().isNotEmpty)
          .toList(growable: false),
      imdbRating: (imdb['vote_average'] as num?)?.toDouble() ?? 0,
      tmdbRating: (tmdb['vote_average'] as num?)?.toDouble() ?? 0,
      modifiedTime: modified['time'] as String?,
    );
  }

  final String id;
  final String name;
  final String originName;
  final String slug;
  final String thumbUrl;
  final String durationLabel;
  final String episodeLabel;
  final String qualityLabel;
  final String languageLabel;
  final int year;
  final String type;
  final List<String> categories;
  final List<String> countries;
  final double imdbRating;
  final double tmdbRating;
  final String? modifiedTime;
}
