import 'package:imovie_app/config/flavors/app_bootstrap.dart';
import 'package:imovie_app/core/error/app_exception.dart';
import 'package:imovie_app/core/error/app_failure.dart';
import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/data/datasources/community/community_remote_data_source.dart';
import 'package:imovie_app/domain/entities/community/community_comment.dart';
import 'package:imovie_app/domain/entities/community/community_post.dart';
import 'package:imovie_app/domain/entities/community/community_profile.dart';
import 'package:imovie_app/domain/entities/community/community_story.dart';
import 'package:imovie_app/domain/repositories/community_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CommunityRepositoryImpl implements CommunityRepository {
  const CommunityRepositoryImpl({
    required this.bootstrap,
    required this.remoteDataSource,
  });

  final AppBootstrap bootstrap;
  final CommunityRemoteDataSource remoteDataSource;

  @override
  Future<Result<CommunityStory>> getStoryById(String id) async {
    return _run(
      request: () async {
        final response = await remoteDataSource.getStoryById(id);
        return response.toEntity();
      },
      authMessage: 'Unable to load this story.',
      unknownMessage: 'Unexpected error while loading this story.',
    );
  }

  @override
  Future<Result<List<CommunityStory>>> getStories({
    required String userId,
    required bool followedOnly,
  }) async {
    return _run(
      request: () async {
        final response = await remoteDataSource.getStories(
          userId: userId,
          followedOnly: followedOnly,
        );
        return response.map((item) => item.toEntity()).toList(growable: false);
      },
      authMessage: 'Unable to load community stories.',
      unknownMessage: 'Unexpected error while loading community stories.',
    );
  }

  @override
  Future<Result<List<String>>> getFollowedUserIds() async {
    return _run(
      request: () => remoteDataSource.getFollowedUserIds(),
      authMessage: 'Unable to load followed users.',
      unknownMessage: 'Unexpected error while loading followed users.',
    );
  }

  @override
  Future<Result<CommunityStory>> createStory({
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
    return _run(
      request: () async {
        final response = await remoteDataSource.createStory(
          image: image,
          caption: caption,
          movieTitle: movieTitle,
          movieSlug: movieSlug,
          moviePosterUrl: moviePosterUrl,
          locationName: locationName,
          textPositionX: textPositionX,
          textPositionY: textPositionY,
          moviePositionX: moviePositionX,
          moviePositionY: moviePositionY,
          locationPositionX: locationPositionX,
          locationPositionY: locationPositionY,
        );
        return response.toEntity();
      },
      authMessage: 'Unable to create this story.',
      unknownMessage: 'Unexpected error while creating this story.',
    );
  }

  @override
  Future<Result<void>> deleteStory(String id) async {
    return _run(
      request: () => remoteDataSource.deleteStory(id),
      authMessage: 'Unable to delete this story.',
      unknownMessage: 'Unexpected error while deleting this story.',
    );
  }

  @override
  Future<Result<CommunityPost>> getPostById(String id) async {
    return _run(
      request: () async {
        final response = await remoteDataSource.getPostById(id);
        return response.toEntity();
      },
      authMessage: 'Unable to load this post.',
      unknownMessage: 'Unexpected error while loading this post.',
    );
  }

  @override
  Future<Result<List<CommunityPost>>> getPosts({
    required bool mineOnly,
    required String userId,
    required int page,
    required int limit,
  }) async {
    return _run(
      request: () async {
        final response = await remoteDataSource.getPosts(
          mineOnly: mineOnly,
          userId: userId,
          page: page,
          limit: limit,
        );
        return response.map((item) => item.toEntity()).toList(growable: false);
      },
      authMessage: 'Unable to load community posts.',
      unknownMessage: 'Unexpected error while loading community posts.',
    );
  }

  @override
  Future<Result<CommunityProfile>> getProfile(String userId) async {
    return _run(
      request: () async {
        final response = await remoteDataSource.getProfile(userId);
        return response.toEntity();
      },
      authMessage: 'Unable to load this community profile.',
      unknownMessage: 'Unexpected error while loading this community profile.',
    );
  }

  @override
  Future<Result<List<CommunityProfile>>> getFollowers({
    required String userId,
    required int page,
    required int limit,
  }) async {
    return _run(
      request: () async {
        final response = await remoteDataSource.getFollowers(
          userId: userId,
          page: page,
          limit: limit,
        );
        return response.map((item) => item.toEntity()).toList(growable: false);
      },
      authMessage: 'Unable to load followers.',
      unknownMessage: 'Unexpected error while loading followers.',
    );
  }

  @override
  Future<Result<List<CommunityProfile>>> getFollowing({
    required String userId,
    required int page,
    required int limit,
  }) async {
    return _run(
      request: () async {
        final response = await remoteDataSource.getFollowing(
          userId: userId,
          page: page,
          limit: limit,
        );
        return response.map((item) => item.toEntity()).toList(growable: false);
      },
      authMessage: 'Unable to load following users.',
      unknownMessage: 'Unexpected error while loading following users.',
    );
  }

  @override
  Future<Result<CommunityProfile>> followUser(String userId) async {
    return _run(
      request: () async {
        final response = await remoteDataSource.followUser(userId);
        return response.toEntity();
      },
      authMessage: 'Unable to follow this user.',
      unknownMessage: 'Unexpected error while following this user.',
    );
  }

  @override
  Future<Result<CommunityProfile>> unfollowUser(String userId) async {
    return _run(
      request: () async {
        final response = await remoteDataSource.unfollowUser(userId);
        return response.toEntity();
      },
      authMessage: 'Unable to unfollow this user.',
      unknownMessage: 'Unexpected error while unfollowing this user.',
    );
  }

  @override
  Future<Result<CommunityPost>> createPost({
    required String content,
    required String movieTitle,
    required String movieSlug,
    required String moviePosterUrl,
    required String locationName,
    required List<CommunityImagePayload> images,
  }) async {
    return _run(
      request: () async {
        final response = await remoteDataSource.createPost(
          content: content,
          movieTitle: movieTitle,
          movieSlug: movieSlug,
          moviePosterUrl: moviePosterUrl,
          locationName: locationName,
          images: images,
        );
        return response.toEntity();
      },
      authMessage: 'Unable to create this post.',
      unknownMessage: 'Unexpected error while creating this post.',
    );
  }

  @override
  Future<Result<CommunityPost>> updatePost({
    required String id,
    required String content,
    required String movieTitle,
    required String movieSlug,
    required String moviePosterUrl,
    required String locationName,
    required List<String> keptImageUrls,
    required List<CommunityImagePayload> images,
  }) async {
    return _run(
      request: () async {
        final response = await remoteDataSource.updatePost(
          id: id,
          content: content,
          movieTitle: movieTitle,
          movieSlug: movieSlug,
          moviePosterUrl: moviePosterUrl,
          locationName: locationName,
          keptImageUrls: keptImageUrls,
          images: images,
        );
        return response.toEntity();
      },
      authMessage: 'Unable to update this post.',
      unknownMessage: 'Unexpected error while updating this post.',
    );
  }

  @override
  Future<Result<void>> deletePost(String id) async {
    return _run(
      request: () => remoteDataSource.deletePost(id),
      authMessage: 'Unable to delete this post.',
      unknownMessage: 'Unexpected error while deleting this post.',
    );
  }

  @override
  Future<Result<List<CommunityComment>>> getComments(String postId) async {
    return _run(
      request: () async {
        final response = await remoteDataSource.getComments(postId);
        return response.map((item) => item.toEntity()).toList(growable: false);
      },
      authMessage: 'Unable to load comments.',
      unknownMessage: 'Unexpected error while loading comments.',
    );
  }

  @override
  Future<Result<CommunityComment>> addComment({
    required String postId,
    required String content,
  }) async {
    return _run(
      request: () async {
        final response = await remoteDataSource.addComment(
          postId: postId,
          content: content,
        );
        return response.toEntity();
      },
      authMessage: 'Unable to add this comment.',
      unknownMessage: 'Unexpected error while adding this comment.',
    );
  }

  @override
  Future<Result<CommunityPost>> toggleReaction(String postId) async {
    return _run(
      request: () async {
        final response = await remoteDataSource.toggleReaction(postId);
        return response.toEntity();
      },
      authMessage: 'Unable to update this reaction.',
      unknownMessage: 'Unexpected error while updating this reaction.',
    );
  }

  Future<Result<T>> _run<T>({
    required Future<T> Function() request,
    required String authMessage,
    required String unknownMessage,
  }) async {
    final readinessFailure = _readinessFailure();
    if (readinessFailure != null) {
      return FailureResult(readinessFailure);
    }

    try {
      return Success(await request());
    } on AppException catch (error) {
      return FailureResult(error.failure);
    } on AuthException catch (error) {
      return FailureResult(
        AppFailure.unauthorized(authMessage, details: error.message),
      );
    } on StorageException catch (error) {
      return FailureResult(
        AppFailure.network(authMessage, details: error.message),
      );
    } on PostgrestException catch (error) {
      return FailureResult(
        AppFailure.network(authMessage, details: error.message),
      );
    } catch (error) {
      return FailureResult(
        AppFailure.unknown(unknownMessage, details: error.toString()),
      );
    }
  }

  AppFailure? _readinessFailure() {
    if (!bootstrap.environment.isSupabaseConfigured) {
      return AppFailure.configuration(
        'Supabase is not configured. Provide SUPABASE_URL and SUPABASE_ANON_KEY via --dart-define.',
      );
    }

    return bootstrap.initializationFailure;
  }
}
