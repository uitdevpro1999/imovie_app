class HomeGenresResponse {
  const HomeGenresResponse({
    required this.status,
    required this.message,
    required this.items,
  });

  factory HomeGenresResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? const {};

    return HomeGenresResponse(
      status: json['status'] as String? ?? '',
      message: json['message'] as String? ?? '',
      items: (data['items'] as List<dynamic>? ?? const [])
          .whereType<Map<String, dynamic>>()
          .map(HomeGenreResponse.fromJson)
          .toList(growable: false),
    );
  }

  final String status;
  final String message;
  final List<HomeGenreResponse> items;
}

class HomeGenreResponse {
  const HomeGenreResponse({
    required this.id,
    required this.name,
    required this.slug,
  });

  factory HomeGenreResponse.fromJson(Map<String, dynamic> json) {
    return HomeGenreResponse(
      id: json['_id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
    );
  }

  final String id;
  final String name;
  final String slug;
}
