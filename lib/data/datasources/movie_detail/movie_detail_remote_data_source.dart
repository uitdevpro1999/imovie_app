import 'package:imovie_app/core/services/api_client.dart';
import 'package:imovie_app/data/models/response/movie_detail/movie_detail_response.dart';

const _isFlutterTest = bool.fromEnvironment('FLUTTER_TEST');

abstract interface class MovieDetailRemoteDataSource {
  Future<MovieDetailResponse> getMovieDetail(String slug);

  Future<MoviePeopleResponse> getMoviePeoples(String slug);
}

class OPhimMovieDetailRemoteDataSource implements MovieDetailRemoteDataSource {
  const OPhimMovieDetailRemoteDataSource({required this.apiClient});

  final ApiClient apiClient;

  @override
  Future<MovieDetailResponse> getMovieDetail(String slug) async {
    final json = await apiClient.getJson('phim/$slug');
    return MovieDetailResponse.fromJson(json);
  }

  @override
  Future<MoviePeopleResponse> getMoviePeoples(String slug) async {
    final json = await apiClient.getJson('phim/$slug/peoples');
    return MoviePeopleResponse.fromJson(json);
  }
}

class FakeMovieDetailRemoteDataSource implements MovieDetailRemoteDataSource {
  const FakeMovieDetailRemoteDataSource();

  @override
  Future<MovieDetailResponse> getMovieDetail(String slug) async {
    return MovieDetailResponse.fromJson(_fakeMovieDetailJson);
  }

  @override
  Future<MoviePeopleResponse> getMoviePeoples(String slug) async {
    return MoviePeopleResponse.fromJson(_fakeMoviePeoplesJson);
  }
}

MovieDetailRemoteDataSource buildMovieDetailRemoteDataSource(
  ApiClient apiClient,
) {
  if (_isFlutterTest) {
    return const FakeMovieDetailRemoteDataSource();
  }

  return OPhimMovieDetailRemoteDataSource(apiClient: apiClient);
}

final Map<String, dynamic> _fakeMovieDetailJson = {
  'data': {
    'APP_DOMAIN_CDN_IMAGE': 'https://img.ophim.live',
    'item': {
      '_id': '1',
      'name': 'Linh Moi (Phan 8)',
      'slug': 'linh-moi-phan-8',
      'origin_name': 'The Rookie (Season 8)',
      'content':
          '<p>The Rookie season 8 follows John Nolan and the LAPD through high-risk missions, personal setbacks and a new international threat.</p>',
      'status': 'ongoing',
      'type': 'series',
      'thumb_url': 'linh-moi-phan-8-thumb.jpg',
      'poster_url': 'linh-moi-phan-8-poster.jpg',
      'trailer_url': 'https://www.youtube.com/watch?v=8BPlx6eK1vc',
      'time': '43 phut/tap',
      'episode_current': 'Tap 17',
      'episode_total': '18 Tap',
      'quality': 'HD',
      'lang': 'Vietsub',
      'year': 2026,
      'actor': [
        'Nathan Fillion',
        'Melissa O\'Neil',
        'Eric Winter',
        'Alyssa Diaz',
      ],
      'director': ['Alexi Hawley'],
      'category': [
        {'name': 'Hai Huoc'},
        {'name': 'Hanh Dong'},
      ],
      'country': [
        {'name': 'Au My'},
        {'name': 'Canada'},
      ],
      'episodes': [
        {
          'server_name': 'Vietsub #1',
          'is_ai': false,
          'server_data': [
            {
              'name': '1',
              'slug': 'tap-1',
              'filename': 'episode-1',
              'link_embed': '',
              'link_m3u8': 'https://test-streams.mux.dev/x36xhzz/x36xhzz.m3u8',
            },
            {
              'name': '2',
              'slug': 'tap-2',
              'filename': 'episode-2',
              'link_embed': '',
              'link_m3u8': 'https://test-streams.mux.dev/test_001/stream.m3u8',
            },
          ],
        },
        {
          'server_name': 'Backup #1',
          'is_ai': false,
          'server_data': [
            {
              'name': '1',
              'slug': 'tap-1',
              'filename': 'episode-1',
              'link_embed': '',
              'link_m3u8': 'https://test-streams.mux.dev/x36xhzz/x36xhzz.m3u8',
            },
          ],
        },
      ],
      'imdb': {'id': 'tt7587890', 'vote_average': 8.0, 'vote_count': 120183},
      'tmdb': {
        'id': 79744,
        'type': 'tv',
        'vote_average': 8.537,
        'vote_count': 3108,
      },
    },
  },
};

final Map<String, dynamic> _fakeMoviePeoplesJson = {
  'success': true,
  'message': 'success',
  'status_code': 200,
  'data': {
    'profile_sizes': {
      'w185': 'https://image.tmdb.org/t/p/w185',
      'h632': 'https://image.tmdb.org/t/p/h632',
      'original': 'https://image.tmdb.org/t/p/original',
    },
    'peoples': [
      {
        'tmdb_people_id': 51797,
        'name': 'Nathan Fillion',
        'original_name': 'Nathan Fillion',
        'character': '',
        'known_for_department': 'Production',
        'profile_path': '/aW6vCxkUZtwb6iH2Wf88Uq0XNVv.jpg',
      },
      {
        'tmdb_people_id': 1234713,
        'name': 'Melissa O\'Neil',
        'original_name': 'Melissa O\'Neil',
        'character': 'Lucy Chen',
        'known_for_department': 'Acting',
        'profile_path': '/jDR0MFSeoFeqLZ4YkbN8kZj75Fu.jpg',
      },
      {
        'tmdb_people_id': 74409,
        'name': 'Eric Winter',
        'original_name': 'Eric Winter',
        'character': 'Tim Bradford',
        'known_for_department': 'Acting',
        'profile_path': '/5fnokeM7Bi562ubR6wZnmyNTzqg.jpg',
      },
      {
        'tmdb_people_id': 134180,
        'name': 'Alyssa Diaz',
        'original_name': 'Alyssa Diaz',
        'character': 'Angela Lopez',
        'known_for_department': 'Acting',
        'profile_path': '/ihLNjM4E1Fjx5h4l8EL6r3iDRTa.jpg',
      },
    ],
  },
};
