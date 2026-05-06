class MovieDetailResponse {
  const MovieDetailResponse({required this.imageBaseUrl, required this.item});

  factory MovieDetailResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? const {};
    return MovieDetailResponse(
      imageBaseUrl: data['APP_DOMAIN_CDN_IMAGE'] as String? ?? '',
      item: MovieDetailItemResponse.fromJson(
        data['item'] as Map<String, dynamic>? ?? const {},
      ),
    );
  }

  final String imageBaseUrl;
  final MovieDetailItemResponse item;
}

class MoviePeopleResponse {
  const MoviePeopleResponse({
    required this.profileImageBaseUrl,
    required this.peoples,
  });

  factory MoviePeopleResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? const {};
    final profileSizes =
        data['profile_sizes'] as Map<String, dynamic>? ?? const {};

    return MoviePeopleResponse(
      profileImageBaseUrl:
          profileSizes['w185'] as String? ??
          profileSizes['h632'] as String? ??
          profileSizes['original'] as String? ??
          '',
      peoples: (data['peoples'] as List<dynamic>? ?? const [])
          .whereType<Map<String, dynamic>>()
          .map(MoviePersonResponse.fromJson)
          .where((person) => person.name.trim().isNotEmpty)
          .toList(growable: false),
    );
  }

  final String profileImageBaseUrl;
  final List<MoviePersonResponse> peoples;
}

class MoviePersonResponse {
  const MoviePersonResponse({
    required this.id,
    required this.name,
    required this.originalName,
    required this.character,
    required this.department,
    required this.profilePath,
  });

  factory MoviePersonResponse.fromJson(Map<String, dynamic> json) {
    return MoviePersonResponse(
      id: (json['tmdb_people_id'] as Object?)?.toString() ?? '',
      name: json['name'] as String? ?? '',
      originalName: json['original_name'] as String? ?? '',
      character: json['character'] as String? ?? '',
      department: json['known_for_department'] as String? ?? '',
      profilePath: json['profile_path'] as String? ?? '',
    );
  }

  final String id;
  final String name;
  final String originalName;
  final String character;
  final String department;
  final String profilePath;
}

class MovieDetailItemResponse {
  const MovieDetailItemResponse({
    required this.id,
    required this.slug,
    required this.name,
    required this.originName,
    required this.content,
    required this.status,
    required this.type,
    required this.thumbUrl,
    required this.posterUrl,
    required this.trailerUrl,
    required this.time,
    required this.episodeCurrent,
    required this.episodeTotal,
    required this.quality,
    required this.lang,
    required this.year,
    required this.actors,
    required this.directors,
    required this.categories,
    required this.countries,
    required this.episodes,
    required this.imdbVoteAverage,
    required this.imdbVoteCount,
    required this.tmdbVoteAverage,
    required this.tmdbVoteCount,
  });

  factory MovieDetailItemResponse.fromJson(Map<String, dynamic> json) {
    final imdb = json['imdb'] as Map<String, dynamic>? ?? const {};
    final tmdb = json['tmdb'] as Map<String, dynamic>? ?? const {};

    return MovieDetailItemResponse(
      id: json['_id'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
      name: json['name'] as String? ?? '',
      originName: json['origin_name'] as String? ?? '',
      content: json['content'] as String? ?? '',
      status: json['status'] as String? ?? '',
      type: json['type'] as String? ?? '',
      thumbUrl: json['thumb_url'] as String? ?? '',
      posterUrl: json['poster_url'] as String? ?? '',
      trailerUrl: json['trailer_url'] as String? ?? '',
      time: json['time'] as String? ?? '',
      episodeCurrent: json['episode_current'] as String? ?? '',
      episodeTotal: json['episode_total'] as String? ?? '',
      quality: json['quality'] as String? ?? '',
      lang: json['lang'] as String? ?? '',
      year: (json['year'] as num?)?.toInt() ?? 0,
      actors: (json['actor'] as List<dynamic>? ?? const [])
          .whereType<String>()
          .where((item) => item.trim().isNotEmpty)
          .toList(growable: false),
      directors: (json['director'] as List<dynamic>? ?? const [])
          .whereType<String>()
          .where((item) => item.trim().isNotEmpty)
          .toList(growable: false),
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
      episodes: (json['episodes'] as List<dynamic>? ?? const [])
          .whereType<Map<String, dynamic>>()
          .map(MovieEpisodeServerResponse.fromJson)
          .toList(growable: false),
      imdbVoteAverage: (imdb['vote_average'] as num?)?.toDouble() ?? 0,
      imdbVoteCount: (imdb['vote_count'] as num?)?.toInt() ?? 0,
      tmdbVoteAverage: (tmdb['vote_average'] as num?)?.toDouble() ?? 0,
      tmdbVoteCount: (tmdb['vote_count'] as num?)?.toInt() ?? 0,
    );
  }

  final String id;
  final String slug;
  final String name;
  final String originName;
  final String content;
  final String status;
  final String type;
  final String thumbUrl;
  final String posterUrl;
  final String trailerUrl;
  final String time;
  final String episodeCurrent;
  final String episodeTotal;
  final String quality;
  final String lang;
  final int year;
  final List<String> actors;
  final List<String> directors;
  final List<String> categories;
  final List<String> countries;
  final List<MovieEpisodeServerResponse> episodes;
  final double imdbVoteAverage;
  final int imdbVoteCount;
  final double tmdbVoteAverage;
  final int tmdbVoteCount;
}

class MovieEpisodeServerResponse {
  const MovieEpisodeServerResponse({
    required this.serverName,
    required this.isAi,
    required this.serverData,
  });

  factory MovieEpisodeServerResponse.fromJson(Map<String, dynamic> json) {
    return MovieEpisodeServerResponse(
      serverName: json['server_name'] as String? ?? '',
      isAi: json['is_ai'] as bool? ?? false,
      serverData: (json['server_data'] as List<dynamic>? ?? const [])
          .whereType<Map<String, dynamic>>()
          .map(MovieEpisodeStreamResponse.fromJson)
          .toList(growable: false),
    );
  }

  final String serverName;
  final bool isAi;
  final List<MovieEpisodeStreamResponse> serverData;
}

class MovieEpisodeStreamResponse {
  const MovieEpisodeStreamResponse({
    required this.name,
    required this.slug,
    required this.fileName,
    required this.linkEmbed,
    required this.linkM3u8,
  });

  factory MovieEpisodeStreamResponse.fromJson(Map<String, dynamic> json) {
    return MovieEpisodeStreamResponse(
      name: json['name'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
      fileName: json['filename'] as String? ?? '',
      linkEmbed: json['link_embed'] as String? ?? '',
      linkM3u8: json['link_m3u8'] as String? ?? '',
    );
  }

  final String name;
  final String slug;
  final String fileName;
  final String linkEmbed;
  final String linkM3u8;
}
