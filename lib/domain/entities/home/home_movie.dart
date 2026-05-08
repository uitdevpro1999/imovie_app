import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_movie.freezed.dart';

@freezed
abstract class HomeMovie with _$HomeMovie {
  const HomeMovie._();

  const factory HomeMovie({
    required String id,
    required String title,
    required String originalTitle,
    required String slug,
    required String posterUrl,
    required String durationLabel,
    required String episodeLabel,
    required String qualityLabel,
    required String languageLabel,
    required int year,
    required String type,
    required List<String> categories,
    required List<String> countries,
    required double rating,
    required DateTime? modifiedAt,
  }) = _HomeMovie;

  String get yearLabel => year > 0 ? year.toString() : 'N/A';

  bool get isTrailerOnly =>
      episodeLabel.trim().toLowerCase().contains('trailer');

  String get subtitleLabel {
    if (episodeLabel.trim().isNotEmpty) {
      return episodeLabel;
    }

    return yearLabel;
  }
}
