import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie_person.freezed.dart';

@freezed
abstract class MoviePerson with _$MoviePerson {
  const MoviePerson._();

  const factory MoviePerson({
    required String id,
    required String name,
    required String originalName,
    required String character,
    required String department,
    required String profileUrl,
  }) = _MoviePerson;

  bool get hasProfileImage => profileUrl.trim().isNotEmpty;
}
