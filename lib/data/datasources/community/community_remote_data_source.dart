import 'package:imovie_app/core/error/app_exception.dart';
import 'package:imovie_app/core/error/app_failure.dart';
import 'package:imovie_app/core/logger/app_logger.dart';
import 'package:imovie_app/core/services/supabase_data_service.dart';
import 'package:imovie_app/data/models/response/community/community_post_response.dart';
import 'package:imovie_app/domain/repositories/community_repository.dart';

abstract interface class CommunityRemoteDataSource {
  Future<List<CommunityStoryResponse>> getStories();

  Future<CommunityStoryResponse> createStory({
    required CommunityImagePayload image,
    required String caption,
    required String movieTitle,
    required String movieSlug,
    required String moviePosterUrl,
    required String locationName,
    required double textPositionX,
    required double textPositionY,
    required double moviePositionX,
    required double moviePositionY,
    required double locationPositionX,
    required double locationPositionY,
  });

  Future<void> deleteStory(String id);

  Future<List<CommunityPostResponse>> getPosts({
    required bool mineOnly,
    required int page,
    required int limit,
  });

  Future<CommunityPostResponse> createPost({
    required String content,
    required String movieTitle,
    required String movieSlug,
    required String moviePosterUrl,
    required String locationName,
    CommunityImagePayload? image,
  });

  Future<CommunityPostResponse> updatePost({
    required String id,
    required String content,
    required String movieTitle,
    required String movieSlug,
    required String moviePosterUrl,
    required String locationName,
    CommunityImagePayload? image,
  });

  Future<void> deletePost(String id);

  Future<List<CommunityCommentResponse>> getComments(String postId);

  Future<CommunityCommentResponse> addComment({
    required String postId,
    required String content,
  });

  Future<CommunityPostResponse> toggleReaction(String postId);
}

class SupabaseCommunityRemoteDataSource implements CommunityRemoteDataSource {
  const SupabaseCommunityRemoteDataSource({required this.dataService});

  static const _postsTable = 'community_posts';
  static const _commentsTable = 'community_comments';
  static const _reactionsTable = 'community_reactions';
  static const _storiesTable = 'community_stories';
  static const _profilesTable = 'profiles';
  static const _postImagesBucket = 'community-posts';
  static const _storyImagesBucket = 'community-stories';

  final SupabaseDataService dataService;

  @override
  Future<List<CommunityStoryResponse>> getStories() async {
    final user = _currentUser();
    final rows = await dataService.selectList(
      table: _storiesTable,
      greaterThan: {'expires_at': DateTime.now().toUtc().toIso8601String()},
      orderBy: 'created_at',
      ascending: false,
    );

    return rows
        .map(
          (row) => CommunityStoryResponse.fromJson(
            json: row,
            currentUserId: user.id,
          ),
        )
        .where((story) => !story.toEntity().isExpired)
        .toList(growable: false);
  }

  @override
  Future<CommunityStoryResponse> createStory({
    required CommunityImagePayload image,
    required String caption,
    required String movieTitle,
    required String movieSlug,
    required String moviePosterUrl,
    required String locationName,
    required double textPositionX,
    required double textPositionY,
    required double moviePositionX,
    required double moviePositionY,
    required double locationPositionX,
    required double locationPositionY,
  }) async {
    final user = _currentUser();
    final author = await _currentAuthor(user);
    final uploadedImage = await _uploadStoryImage(user.id, image);
    final expiresAt = DateTime.now().toUtc().add(const Duration(hours: 24));

    try {
      final json = await dataService.insertAndSelectSingle(
        table: _storiesTable,
        values: {
          'user_id': user.id,
          'author_name': author.name,
          'author_avatar_url': author.avatarUrl,
          'image_url': uploadedImage.url,
          'image_path': uploadedImage.path,
          'caption': caption.trim(),
          'movie_title': movieTitle.trim(),
          'movie_slug': movieSlug.trim(),
          'movie_poster_url': moviePosterUrl.trim(),
          'location_name': locationName.trim(),
          'text_position_x': _normalizedPosition(textPositionX),
          'text_position_y': _normalizedPosition(textPositionY),
          'movie_position_x': _normalizedPosition(moviePositionX),
          'movie_position_y': _normalizedPosition(moviePositionY),
          'location_position_x': _normalizedPosition(locationPositionX),
          'location_position_y': _normalizedPosition(locationPositionY),
          'expires_at': expiresAt.toIso8601String(),
        },
      );

      AppLogger.info('Created community story.', name: 'Supabase.Community');
      return CommunityStoryResponse.fromJson(
        json: json,
        currentUserId: user.id,
      );
    } catch (_) {
      await _deleteStoryImageByPath(uploadedImage.path);
      rethrow;
    }
  }

  @override
  Future<void> deleteStory(String id) async {
    final user = _currentUser();
    final row = await dataService.selectMaybeSingle(
      table: _storiesTable,
      columns: 'image_path, image_url',
      equals: {'id': id, 'user_id': user.id},
    );
    await dataService.delete(
      table: _storiesTable,
      equals: {'id': id, 'user_id': user.id},
    );

    final imagePath = row?['image_path']?.toString() ?? '';
    if (imagePath.trim().isNotEmpty) {
      await _deleteStoryImageByPath(imagePath);
    } else {
      await _deleteStoryImageByUrl(row?['image_url']?.toString() ?? '');
    }
    AppLogger.info('Deleted community story.', name: 'Supabase.Community');
  }

  @override
  Future<List<CommunityPostResponse>> getPosts({
    required bool mineOnly,
    required int page,
    required int limit,
  }) async {
    final user = _currentUser();
    final normalizedPage = page < 1 ? 1 : page;
    final normalizedLimit = limit < 1 ? 1 : limit;
    final from = (normalizedPage - 1) * normalizedLimit;
    final to = from + normalizedLimit - 1;
    final postRows = await dataService.selectList(
      table: _postsTable,
      equals: mineOnly ? {'user_id': user.id} : const {},
      orderBy: 'created_at',
      ascending: false,
      rangeFrom: from,
      rangeTo: to,
    );
    final reactedPostIds = await _reactedPostIds(
      user.id,
      postRows
          .map((row) => row['id']?.toString() ?? '')
          .toList(growable: false),
    );

    return postRows
        .map(
          (row) => CommunityPostResponse.fromJson(
            json: row,
            currentUserId: user.id,
            reactedPostIds: reactedPostIds,
          ),
        )
        .toList(growable: false);
  }

  @override
  Future<CommunityPostResponse> createPost({
    required String content,
    required String movieTitle,
    required String movieSlug,
    required String moviePosterUrl,
    required String locationName,
    CommunityImagePayload? image,
  }) async {
    final user = _currentUser();
    final author = await _currentAuthor(user);
    final imageUrl = image == null
        ? ''
        : await _uploadPostImage(user.id, image);
    final json = await dataService.insertAndSelectSingle(
      table: _postsTable,
      values: {
        'user_id': user.id,
        'author_name': author.name,
        'author_avatar_url': author.avatarUrl,
        'content': content.trim(),
        'image_url': imageUrl,
        'movie_title': movieTitle.trim(),
        'movie_slug': movieSlug.trim(),
        'movie_poster_url': moviePosterUrl.trim(),
        'location_name': locationName.trim(),
      },
    );

    AppLogger.info('Created community post.', name: 'Supabase.Community');
    return CommunityPostResponse.fromJson(
      json: json,
      currentUserId: user.id,
      reactedPostIds: const {},
    );
  }

  @override
  Future<CommunityPostResponse> updatePost({
    required String id,
    required String content,
    required String movieTitle,
    required String movieSlug,
    required String moviePosterUrl,
    required String locationName,
    CommunityImagePayload? image,
  }) async {
    final user = _currentUser();
    final oldImageUrl = image == null
        ? ''
        : await _ownedPostImageUrl(postId: id, userId: user.id);
    final payload = <String, dynamic>{
      'content': content.trim(),
      'movie_title': movieTitle.trim(),
      'movie_slug': movieSlug.trim(),
      'movie_poster_url': moviePosterUrl.trim(),
      'location_name': locationName.trim(),
      'updated_at': DateTime.now().toUtc().toIso8601String(),
    };
    var uploadedImageUrl = '';

    if (image != null) {
      uploadedImageUrl = await _uploadPostImage(user.id, image);
      payload['image_url'] = uploadedImageUrl;
    }

    try {
      final json = await dataService.updateAndSelectSingle(
        table: _postsTable,
        values: payload,
        equals: {'id': id, 'user_id': user.id},
      );
      final reactedPostIds = await _reactedPostIds(user.id, [id]);

      if (image != null && oldImageUrl.trim().isNotEmpty) {
        await _deletePostImageByUrl(oldImageUrl);
      }

      AppLogger.info('Updated community post.', name: 'Supabase.Community');
      return CommunityPostResponse.fromJson(
        json: json,
        currentUserId: user.id,
        reactedPostIds: reactedPostIds,
      );
    } catch (_) {
      await _deletePostImageByUrl(uploadedImageUrl);
      rethrow;
    }
  }

  @override
  Future<void> deletePost(String id) async {
    final user = _currentUser();
    final imageUrl = await _ownedPostImageUrl(postId: id, userId: user.id);
    await dataService.delete(
      table: _postsTable,
      equals: {'id': id, 'user_id': user.id},
    );
    await _deletePostImageByUrl(imageUrl);
    AppLogger.info('Deleted community post.', name: 'Supabase.Community');
  }

  @override
  Future<List<CommunityCommentResponse>> getComments(String postId) async {
    final user = _currentUser();
    final rows = await dataService.selectList(
      table: _commentsTable,
      equals: {'post_id': postId},
      orderBy: 'created_at',
    );

    return rows
        .whereType<Map<String, dynamic>>()
        .map(
          (row) => CommunityCommentResponse.fromJson(
            json: row,
            currentUserId: user.id,
          ),
        )
        .toList(growable: false);
  }

  @override
  Future<CommunityCommentResponse> addComment({
    required String postId,
    required String content,
  }) async {
    final user = _currentUser();
    final author = await _currentAuthor(user);
    final json = await dataService.insertAndSelectSingle(
      table: _commentsTable,
      values: {
        'post_id': postId,
        'user_id': user.id,
        'author_name': author.name,
        'author_avatar_url': author.avatarUrl,
        'content': content.trim(),
      },
    );

    return CommunityCommentResponse.fromJson(
      json: json,
      currentUserId: user.id,
    );
  }

  @override
  Future<CommunityPostResponse> toggleReaction(String postId) async {
    final user = _currentUser();
    final existing = await dataService.selectMaybeSingle(
      table: _reactionsTable,
      columns: 'id',
      equals: {'post_id': postId, 'user_id': user.id},
    );

    if (existing == null) {
      await dataService.insert(
        table: _reactionsTable,
        values: {
          'post_id': postId,
          'user_id': user.id,
          'reaction_type': 'like',
        },
      );
    } else {
      await dataService.delete(
        table: _reactionsTable,
        equals: {'post_id': postId, 'user_id': user.id},
      );
    }

    return _getPost(postId);
  }

  Future<CommunityPostResponse> _getPost(String postId) async {
    final user = _currentUser();
    final json = await dataService.selectSingle(
      table: _postsTable,
      equals: {'id': postId},
    );
    final reactedPostIds = await _reactedPostIds(user.id, [postId]);
    return CommunityPostResponse.fromJson(
      json: json,
      currentUserId: user.id,
      reactedPostIds: reactedPostIds,
    );
  }

  Future<Set<String>> _reactedPostIds(
    String userId,
    List<String> postIds,
  ) async {
    final normalizedPostIds = postIds
        .where((id) => id.trim().isNotEmpty)
        .toSet()
        .toList(growable: false);
    if (normalizedPostIds.isEmpty) {
      return const {};
    }

    final rows = await dataService.selectList(
      table: _reactionsTable,
      columns: 'post_id',
      equals: {'user_id': userId},
      inFilters: {'post_id': normalizedPostIds},
    );

    return rows
        .whereType<Map<String, dynamic>>()
        .map((row) => row['post_id']?.toString() ?? '')
        .where((id) => id.isNotEmpty)
        .toSet();
  }

  Future<String> _uploadPostImage(
    String userId,
    CommunityImagePayload image,
  ) async {
    final extension = _extensionFor(
      fileName: image.fileName,
      contentType: image.contentType,
    );
    final path = '$userId/${DateTime.now().microsecondsSinceEpoch}$extension';
    await dataService.uploadBinary(
      bucket: _postImagesBucket,
      path: path,
      bytes: image.bytes,
      contentType: image.contentType,
      upsert: false,
    );

    return dataService.getPublicUrl(bucket: _postImagesBucket, path: path);
  }

  Future<_UploadedImage> _uploadStoryImage(
    String userId,
    CommunityImagePayload image,
  ) async {
    final extension = _extensionFor(
      fileName: image.fileName,
      contentType: image.contentType,
    );
    final path = '$userId/${DateTime.now().microsecondsSinceEpoch}$extension';
    await dataService.uploadBinary(
      bucket: _storyImagesBucket,
      path: path,
      bytes: image.bytes,
      contentType: image.contentType,
      upsert: false,
    );

    return _UploadedImage(
      path: path,
      url: dataService.getPublicUrl(bucket: _storyImagesBucket, path: path),
    );
  }

  Future<String> _ownedPostImageUrl({
    required String postId,
    required String userId,
  }) async {
    final row = await dataService.selectMaybeSingle(
      table: _postsTable,
      columns: 'image_url',
      equals: {'id': postId, 'user_id': userId},
    );

    return row?['image_url']?.toString() ?? '';
  }

  Future<void> _deletePostImageByUrl(String imageUrl) async {
    final path = _postImagePathFromUrl(imageUrl);
    if (path == null) {
      return;
    }

    try {
      await dataService.removeStorageObjects(
        bucket: _postImagesBucket,
        paths: [path],
      );
    } catch (error, stackTrace) {
      AppLogger.warning(
        'Unable to delete community post image from storage.',
        name: 'Supabase.Community',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> _deleteStoryImageByPath(String imagePath) async {
    final normalizedPath = imagePath.trim();
    if (normalizedPath.isEmpty) {
      return;
    }

    try {
      await dataService.removeStorageObjects(
        bucket: _storyImagesBucket,
        paths: [normalizedPath],
      );
    } catch (error, stackTrace) {
      AppLogger.warning(
        'Unable to delete community story image from storage.',
        name: 'Supabase.Community',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> _deleteStoryImageByUrl(String imageUrl) async {
    final path = _storageImagePathFromUrl(
      imageUrl: imageUrl,
      bucket: _storyImagesBucket,
    );
    if (path == null) {
      return;
    }

    await _deleteStoryImageByPath(path);
  }

  String? _postImagePathFromUrl(String imageUrl) {
    return _storageImagePathFromUrl(
      imageUrl: imageUrl,
      bucket: _postImagesBucket,
    );
  }

  String? _storageImagePathFromUrl({
    required String imageUrl,
    required String bucket,
  }) {
    final normalizedUrl = imageUrl.trim();
    if (normalizedUrl.isEmpty) {
      return null;
    }

    final uri = Uri.tryParse(normalizedUrl);
    if (uri == null) {
      return null;
    }

    final segments = uri.pathSegments;
    final storageIndex = segments.indexOf('storage');
    final objectIndex = segments.indexOf('object');
    final bucketIndex = segments.indexOf(bucket);
    if (storageIndex < 0 ||
        objectIndex < 0 ||
        bucketIndex <= objectIndex ||
        bucketIndex >= segments.length - 1) {
      return null;
    }

    return segments.skip(bucketIndex + 1).join('/');
  }

  Future<_CommunityAuthor> _currentAuthor(SupabaseDataUser user) async {
    final profile = await dataService.selectMaybeSingle(
      table: _profilesTable,
      columns: 'full_name, avatar_url, email',
      equals: {'id': user.id},
    );
    final fallbackName = user.email?.split('@').first.trim() ?? 'iMovie user';
    return _CommunityAuthor(
      name: profile?['full_name']?.toString().trim().isNotEmpty == true
          ? profile!['full_name'].toString()
          : fallbackName,
      avatarUrl: profile?['avatar_url']?.toString() ?? '',
    );
  }

  SupabaseDataUser _currentUser() {
    return dataService.requireCurrentUser(
      unauthorizedMessage: 'Sign in before using community features.',
      logName: 'Supabase.Community',
      blockedLogMessage:
          'Community request blocked because no Supabase user is signed in.',
    );
  }

  String _extensionFor({
    required String fileName,
    required String contentType,
  }) {
    final lowerName = fileName.toLowerCase();
    final dotIndex = lowerName.lastIndexOf('.');
    if (dotIndex >= 0 && dotIndex < lowerName.length - 1) {
      final extension = lowerName.substring(dotIndex);
      if (extension.length <= 6) {
        return extension;
      }
    }

    return switch (contentType.toLowerCase()) {
      'image/png' => '.png',
      'image/gif' => '.gif',
      'image/webp' => '.webp',
      _ => '.jpg',
    };
  }

  double _normalizedPosition(double value) {
    return value.clamp(0.0, 1.0);
  }
}

class UnconfiguredCommunityRemoteDataSource
    implements CommunityRemoteDataSource {
  const UnconfiguredCommunityRemoteDataSource();

  @override
  Future<List<CommunityStoryResponse>> getStories() async {
    throw const AppException(_configurationFailure);
  }

  @override
  Future<CommunityStoryResponse> createStory({
    required CommunityImagePayload image,
    required String caption,
    required String movieTitle,
    required String movieSlug,
    required String moviePosterUrl,
    required String locationName,
    required double textPositionX,
    required double textPositionY,
    required double moviePositionX,
    required double moviePositionY,
    required double locationPositionX,
    required double locationPositionY,
  }) async {
    throw const AppException(_configurationFailure);
  }

  @override
  Future<void> deleteStory(String id) async {
    throw const AppException(_configurationFailure);
  }

  @override
  Future<List<CommunityPostResponse>> getPosts({
    required bool mineOnly,
    required int page,
    required int limit,
  }) async {
    throw const AppException(_configurationFailure);
  }

  @override
  Future<CommunityPostResponse> createPost({
    required String content,
    required String movieTitle,
    required String movieSlug,
    required String moviePosterUrl,
    required String locationName,
    CommunityImagePayload? image,
  }) async {
    throw const AppException(_configurationFailure);
  }

  @override
  Future<CommunityPostResponse> updatePost({
    required String id,
    required String content,
    required String movieTitle,
    required String movieSlug,
    required String moviePosterUrl,
    required String locationName,
    CommunityImagePayload? image,
  }) async {
    throw const AppException(_configurationFailure);
  }

  @override
  Future<void> deletePost(String id) async {
    throw const AppException(_configurationFailure);
  }

  @override
  Future<List<CommunityCommentResponse>> getComments(String postId) async {
    throw const AppException(_configurationFailure);
  }

  @override
  Future<CommunityCommentResponse> addComment({
    required String postId,
    required String content,
  }) async {
    throw const AppException(_configurationFailure);
  }

  @override
  Future<CommunityPostResponse> toggleReaction(String postId) async {
    throw const AppException(_configurationFailure);
  }
}

class _CommunityAuthor {
  const _CommunityAuthor({required this.name, required this.avatarUrl});

  final String name;
  final String avatarUrl;
}

class _UploadedImage {
  const _UploadedImage({required this.path, required this.url});

  final String path;
  final String url;
}

const _configurationFailure = AppFailure(
  type: FailureType.configuration,
  message:
      'Supabase is not configured. Provide SUPABASE_URL and SUPABASE_ANON_KEY via --dart-define.',
);
