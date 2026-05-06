import 'package:imovie_app/domain/entities/movie_detail/movie_detail.dart';

class LibraryMovie {
  const LibraryMovie({
    required this.id,
    required this.userId,
    required this.movie,
    required this.createdAt,
  });

  final String id;
  final String userId;
  final MovieDetail movie;
  final DateTime? createdAt;
}
