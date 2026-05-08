import 'package:get_it/get_it.dart';
import 'package:imovie_app/config/flavors/app_bootstrap.dart';
import 'package:imovie_app/core/services/api_client.dart';
import 'package:imovie_app/core/services/community_realtime_service.dart';
import 'package:imovie_app/core/services/local_storage_service.dart';
import 'package:imovie_app/core/services/location_service.dart';
import 'package:imovie_app/core/services/push_notification_service.dart';
import 'package:imovie_app/core/services/supabase_auth_service.dart';
import 'package:imovie_app/core/services/supabase_data_service.dart';
import 'package:imovie_app/data/datasources/community/community_remote_data_source.dart';
import 'package:imovie_app/data/datasources/home/home_remote_data_source.dart';
import 'package:imovie_app/data/datasources/library/library_remote_data_source.dart';
import 'package:imovie_app/data/datasources/movie_detail/movie_detail_remote_data_source.dart';
import 'package:imovie_app/data/datasources/notification/notification_remote_data_source.dart';
import 'package:imovie_app/data/datasources/profile/profile_remote_data_source.dart';
import 'package:imovie_app/data/datasources/session/session_remote_data_source.dart';
import 'package:imovie_app/data/repositories/community/community_repository_impl.dart';
import 'package:imovie_app/data/repositories/home/home_repository_impl.dart';
import 'package:imovie_app/data/repositories/library/library_repository_impl.dart';
import 'package:imovie_app/data/repositories/movie_detail/movie_detail_repository_impl.dart';
import 'package:imovie_app/data/repositories/notification/notification_repository_impl.dart';
import 'package:imovie_app/data/repositories/profile/profile_repository_impl.dart';
import 'package:imovie_app/data/repositories/session/session_repository_impl.dart';
import 'package:imovie_app/domain/entities/home/home_movie.dart';
import 'package:imovie_app/domain/entities/home/home_genre.dart';
import 'package:imovie_app/domain/entities/community/community_post.dart';
import 'package:imovie_app/domain/entities/movie_detail/movie_detail.dart';
import 'package:imovie_app/domain/repositories/community_repository.dart';
import 'package:imovie_app/domain/repositories/home_repository.dart';
import 'package:imovie_app/domain/repositories/library_repository.dart';
import 'package:imovie_app/domain/repositories/movie_detail_repository.dart';
import 'package:imovie_app/domain/repositories/notification_repository.dart';
import 'package:imovie_app/domain/repositories/profile_repository.dart';
import 'package:imovie_app/domain/repositories/session_repository.dart';
import 'package:imovie_app/domain/usecases/get_current_session_use_case.dart';
import 'package:imovie_app/domain/usecases/community/add_community_comment_use_case.dart';
import 'package:imovie_app/domain/usecases/community/create_community_post_use_case.dart';
import 'package:imovie_app/domain/usecases/community/create_community_story_use_case.dart';
import 'package:imovie_app/domain/usecases/community/delete_community_post_use_case.dart';
import 'package:imovie_app/domain/usecases/community/delete_community_story_use_case.dart';
import 'package:imovie_app/domain/usecases/community/follow_community_user_use_case.dart';
import 'package:imovie_app/domain/usecases/community/get_community_comments_use_case.dart';
import 'package:imovie_app/domain/usecases/community/get_community_followed_user_ids_use_case.dart';
import 'package:imovie_app/domain/usecases/community/get_community_followers_use_case.dart';
import 'package:imovie_app/domain/usecases/community/get_community_following_use_case.dart';
import 'package:imovie_app/domain/usecases/community/get_community_post_by_id_use_case.dart';
import 'package:imovie_app/domain/usecases/community/get_community_posts_use_case.dart';
import 'package:imovie_app/domain/usecases/community/get_community_profile_use_case.dart';
import 'package:imovie_app/domain/usecases/community/get_community_story_by_id_use_case.dart';
import 'package:imovie_app/domain/usecases/community/get_community_stories_use_case.dart';
import 'package:imovie_app/domain/usecases/community/toggle_community_reaction_use_case.dart';
import 'package:imovie_app/domain/usecases/community/unfollow_community_user_use_case.dart';
import 'package:imovie_app/domain/usecases/community/update_community_post_use_case.dart';
import 'package:imovie_app/domain/usecases/home/get_countries_use_case.dart';
import 'package:imovie_app/domain/usecases/home/get_genre_movies_use_case.dart';
import 'package:imovie_app/domain/usecases/home/get_home_feed_use_case.dart';
import 'package:imovie_app/domain/usecases/home/get_home_genres_use_case.dart';
import 'package:imovie_app/domain/usecases/home/get_movie_list_use_case.dart';
import 'package:imovie_app/domain/usecases/home/search_movies_use_case.dart';
import 'package:imovie_app/domain/usecases/library/add_movie_to_library_use_case.dart';
import 'package:imovie_app/domain/usecases/library/get_library_movies_use_case.dart';
import 'package:imovie_app/domain/usecases/library/remove_movie_from_library_use_case.dart';
import 'package:imovie_app/domain/usecases/movie_detail/get_movie_detail_use_case.dart';
import 'package:imovie_app/domain/usecases/notification/get_notifications_use_case.dart';
import 'package:imovie_app/domain/usecases/notification/get_unread_notification_count_use_case.dart';
import 'package:imovie_app/domain/usecases/notification/mark_all_notifications_read_use_case.dart';
import 'package:imovie_app/domain/usecases/notification/mark_notification_read_use_case.dart';
import 'package:imovie_app/domain/usecases/notification/watch_notifications_use_case.dart';
import 'package:imovie_app/domain/usecases/profile/clear_cached_profile_use_case.dart';
import 'package:imovie_app/domain/usecases/profile/get_cached_profile_use_case.dart';
import 'package:imovie_app/domain/usecases/profile/get_current_profile_use_case.dart';
import 'package:imovie_app/domain/usecases/profile/update_profile_avatar_use_case.dart';
import 'package:imovie_app/domain/usecases/profile/update_profile_cover_use_case.dart';
import 'package:imovie_app/domain/usecases/profile/update_profile_use_case.dart';
import 'package:imovie_app/domain/usecases/session/change_password_use_case.dart';
import 'package:imovie_app/domain/usecases/session/sign_in_with_password_use_case.dart';
import 'package:imovie_app/domain/usecases/session/sign_out_use_case.dart';
import 'package:imovie_app/domain/usecases/session/sign_up_with_password_use_case.dart';
import 'package:imovie_app/domain/usecases/session/reset_password_for_email_use_case.dart';
import 'package:imovie_app/presentation/app/app_cubit.dart';
import 'package:imovie_app/presentation/ui/auth/forgot_password/forgot_password_cubit.dart';
import 'package:imovie_app/presentation/ui/auth/sign_in/sign_in_cubit.dart';
import 'package:imovie_app/presentation/ui/auth/sign_up/sign_up_cubit.dart';
import 'package:imovie_app/presentation/ui/browse/browse_cubit.dart';
import 'package:imovie_app/presentation/ui/community/compose/community_compose_cubit.dart';
import 'package:imovie_app/presentation/ui/community/feed/community_cubit.dart';
import 'package:imovie_app/presentation/ui/community/follow_list/community_follow_list_cubit.dart';
import 'package:imovie_app/presentation/ui/community/post_detail/community_post_detail_cubit.dart';
import 'package:imovie_app/presentation/ui/community/profile/community_profile_cubit.dart';
import 'package:imovie_app/presentation/ui/community/story_viewer/community_story_viewer_cubit.dart';
import 'package:imovie_app/presentation/ui/community/story_editor/community_story_editor_cubit.dart';
import 'package:imovie_app/presentation/ui/genre_movies/genre_movies_cubit.dart';
import 'package:imovie_app/presentation/ui/genres/genres_cubit.dart';
import 'package:imovie_app/presentation/ui/home/home_cubit.dart';
import 'package:imovie_app/presentation/ui/library/library_cubit.dart';
import 'package:imovie_app/presentation/ui/main/main_cubit.dart';
import 'package:imovie_app/presentation/ui/movie_detail/movie_detail_cubit.dart';
import 'package:imovie_app/presentation/ui/notifications/notification_center_cubit.dart';
import 'package:imovie_app/presentation/ui/notifications/notifications_cubit.dart';
import 'package:imovie_app/presentation/ui/movie_list/movie_list_cubit.dart';
import 'package:imovie_app/presentation/ui/movie_trailer/movie_trailer_cubit.dart';
import 'package:imovie_app/presentation/ui/movie_watch/movie_watch_cubit.dart';
import 'package:imovie_app/presentation/ui/profile/change_password/change_password_cubit.dart';
import 'package:imovie_app/presentation/ui/profile/edit_profile/edit_profile_cubit.dart';
import 'package:imovie_app/presentation/ui/profile/language/language_cubit.dart';
import 'package:imovie_app/presentation/ui/profile/settings/settings_cubit.dart';
import 'package:imovie_app/presentation/ui/splash/splash_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final GetIt sl = GetIt.instance;

Future<void> configureDependencies({required AppBootstrap bootstrap}) async {
  await sl.reset();

  final sharedPreferences = await SharedPreferences.getInstance();

  sl.registerSingleton<AppBootstrap>(bootstrap);
  sl.registerSingleton<SharedPreferences>(sharedPreferences);
  sl.registerLazySingleton<ApiClient>(
    () => DioApiClient(baseUrl: bootstrap.environment.ophimApiBaseUrl),
  );
  sl.registerLazySingleton<SupabaseAuthService>(
    () => bootstrap.isSupabaseReady
        ? ConfiguredSupabaseAuthService(client: Supabase.instance.client)
        : const UnconfiguredSupabaseAuthService(),
  );
  sl.registerLazySingleton<SupabaseDataService>(
    () => bootstrap.isSupabaseReady
        ? ConfiguredSupabaseDataService(client: Supabase.instance.client)
        : const UnconfiguredSupabaseDataService(),
  );
  sl.registerLazySingleton<CommunityRealtimeService>(
    () => bootstrap.isSupabaseReady
        ? SupabaseCommunityRealtimeService(dataService: sl())
        : const NoOpCommunityRealtimeService(),
  );
  sl.registerLazySingleton<PushNotificationService>(
    () => DevicePushNotificationService(bootstrap: sl(), dataService: sl()),
  );
  sl.registerLazySingleton<LocationService>(
    () => const DeviceLocationService(),
  );
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => buildHomeRemoteDataSource(sl()),
  );
  sl.registerLazySingleton<SessionRemoteDataSource>(
    () => SupabaseSessionRemoteDataSource(authService: sl()),
  );
  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => SupabaseProfileRemoteDataSource(dataService: sl()),
  );
  sl.registerLazySingleton<LibraryRemoteDataSource>(
    () => SupabaseLibraryRemoteDataSource(dataService: sl()),
  );
  sl.registerLazySingleton<CommunityRemoteDataSource>(
    () => SupabaseCommunityRemoteDataSource(dataService: sl()),
  );
  sl.registerLazySingleton<NotificationRemoteDataSource>(
    () => SupabaseNotificationRemoteDataSource(dataService: sl()),
  );
  sl.registerLazySingleton<LocalStorageService>(
    () => SharedPreferencesLocalStorageService(sharedPreferences: sl()),
  );
  sl.registerLazySingleton<MovieDetailRemoteDataSource>(
    () => buildMovieDetailRemoteDataSource(sl()),
  );
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<MovieDetailRepository>(
    () => MovieDetailRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<LibraryRepository>(
    () => LibraryRepositoryImpl(bootstrap: sl(), remoteDataSource: sl()),
  );
  sl.registerLazySingleton<CommunityRepository>(
    () => CommunityRepositoryImpl(bootstrap: sl(), remoteDataSource: sl()),
  );
  sl.registerLazySingleton<NotificationRepository>(
    () => NotificationRepositoryImpl(bootstrap: sl(), remoteDataSource: sl()),
  );
  sl.registerLazySingleton<SessionRepository>(
    () => SessionRepositoryImpl(bootstrap: sl(), remoteDataSource: sl()),
  );
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(
      bootstrap: sl(),
      remoteDataSource: sl(),
      localStorageService: sl(),
    ),
  );

  sl.registerFactory(() => GetCurrentSessionUseCase(sl()));
  sl.registerFactory(() => GetCommunityStoriesUseCase(sl()));
  sl.registerFactory(() => GetCommunityFollowedUserIdsUseCase(sl()));
  sl.registerFactory(() => GetCommunityProfileUseCase(sl()));
  sl.registerFactory(() => GetCommunityFollowersUseCase(sl()));
  sl.registerFactory(() => GetCommunityFollowingUseCase(sl()));
  sl.registerFactory(() => FollowCommunityUserUseCase(sl()));
  sl.registerFactory(() => UnfollowCommunityUserUseCase(sl()));
  sl.registerFactory(() => GetCommunityStoryByIdUseCase(sl()));
  sl.registerFactory(() => CreateCommunityStoryUseCase(sl()));
  sl.registerFactory(() => DeleteCommunityStoryUseCase(sl()));
  sl.registerFactory(() => GetCommunityPostByIdUseCase(sl()));
  sl.registerFactory(() => GetCommunityPostsUseCase(sl()));
  sl.registerFactory(() => CreateCommunityPostUseCase(sl()));
  sl.registerFactory(() => UpdateCommunityPostUseCase(sl()));
  sl.registerFactory(() => DeleteCommunityPostUseCase(sl()));
  sl.registerFactory(() => GetCommunityCommentsUseCase(sl()));
  sl.registerFactory(() => AddCommunityCommentUseCase(sl()));
  sl.registerFactory(() => ToggleCommunityReactionUseCase(sl()));
  sl.registerFactory(() => GetHomeFeedUseCase(sl()));
  sl.registerFactory(() => GetHomeGenresUseCase(sl()));
  sl.registerFactory(() => GetCountriesUseCase(sl()));
  sl.registerFactory(() => GetGenreMoviesUseCase(sl()));
  sl.registerFactory(() => GetMovieListUseCase(sl()));
  sl.registerFactory(() => SearchMoviesUseCase(sl()));
  sl.registerFactory(() => GetMovieDetailUseCase(sl()));
  sl.registerFactory(() => GetNotificationsUseCase(sl()));
  sl.registerFactory(() => GetUnreadNotificationCountUseCase(sl()));
  sl.registerFactory(() => MarkNotificationReadUseCase(sl()));
  sl.registerFactory(() => MarkAllNotificationsReadUseCase(sl()));
  sl.registerFactory(() => WatchNotificationsUseCase(sl()));
  sl.registerFactory(() => GetLibraryMoviesUseCase(sl()));
  sl.registerFactory(() => AddMovieToLibraryUseCase(sl()));
  sl.registerFactory(() => RemoveMovieFromLibraryUseCase(sl()));
  sl.registerFactory(() => GetCachedProfileUseCase(sl()));
  sl.registerFactory(() => GetCurrentProfileUseCase(sl()));
  sl.registerFactory(() => ClearCachedProfileUseCase(sl()));
  sl.registerFactory(() => UpdateProfileUseCase(sl()));
  sl.registerFactory(() => UpdateProfileAvatarUseCase(sl()));
  sl.registerFactory(() => UpdateProfileCoverUseCase(sl()));
  sl.registerFactory(() => ChangePasswordUseCase(sl()));
  sl.registerFactory(() => SignInWithPasswordUseCase(sl()));
  sl.registerFactory(() => SignUpWithPasswordUseCase(sl()));
  sl.registerFactory(() => ResetPasswordForEmailUseCase(sl()));
  sl.registerFactory(() => SignOutUseCase(sl()));
  sl.registerFactory(
    () => AppCubit(getCurrentSessionUseCase: sl(), localStorageService: sl()),
  );
  sl.registerFactory(() => SplashCubit(getCurrentSessionUseCase: sl()));
  sl.registerLazySingleton(
    () => MainCubit(
      getCurrentSessionUseCase: sl(),
      getCurrentProfileUseCase: sl(),
      getCachedProfileUseCase: sl(),
      clearCachedProfileUseCase: sl(),
      signOutUseCase: sl(),
    ),
    dispose: (cubit) => cubit.close(),
  );
  sl.registerLazySingleton(
    () => NotificationCenterCubit(
      getUnreadNotificationCountUseCase: sl(),
      watchNotificationsUseCase: sl(),
    ),
    dispose: (cubit) => cubit.close(),
  );
  sl.registerFactory(
    () => HomeCubit(
      getHomeFeedUseCase: sl(),
      getHomeGenresUseCase: sl(),
      getMovieListUseCase: sl(),
      getMovieDetailUseCase: sl(),
    ),
  );
  sl.registerFactory(
    () => NotificationsCubit(
      getNotificationsUseCase: sl(),
      markNotificationReadUseCase: sl(),
      markAllNotificationsReadUseCase: sl(),
    ),
  );
  sl.registerFactory(
    () => BrowseCubit(
      getHomeFeedUseCase: sl(),
      getHomeGenresUseCase: sl(),
      getCountriesUseCase: sl(),
      searchMoviesUseCase: sl(),
    ),
  );
  sl.registerFactoryParam<CommunityCubit, bool, void>(
    (mineOnly, _) => CommunityCubit(
      mineOnly: mineOnly,
      currentUserId: sl<SupabaseDataService>().getCurrentUserId(),
      getCommunityFollowedUserIdsUseCase: sl(),
      getCommunityStoriesUseCase: sl(),
      deleteCommunityStoryUseCase: sl(),
      getCommunityPostByIdUseCase: sl(),
      getCommunityPostsUseCase: sl(),
      deleteCommunityPostUseCase: sl(),
      toggleCommunityReactionUseCase: sl(),
      getCommunityCommentsUseCase: sl(),
      addCommunityCommentUseCase: sl(),
    ),
  );
  sl.registerFactoryParam<CommunityComposeCubit, CommunityPost?, void>(
    (initialPost, _) => CommunityComposeCubit(
      initialPost: initialPost,
      createCommunityPostUseCase: sl(),
      updateCommunityPostUseCase: sl(),
      searchMoviesUseCase: sl(),
      locationService: sl(),
    ),
  );
  sl.registerFactory(
    () => CommunityStoryEditorCubit(
      createCommunityStoryUseCase: sl(),
      searchMoviesUseCase: sl(),
      locationService: sl(),
    ),
  );
  sl.registerFactoryParam<CommunityStoryViewerCubit, String, void>(
    (storyId, _) => CommunityStoryViewerCubit(
      storyId: storyId,
      currentUserId: sl<SupabaseDataService>().getCurrentUserId(),
      getCommunityStoryByIdUseCase: sl(),
      getCommunityStoriesUseCase: sl(),
    ),
  );
  sl.registerFactoryParam<CommunityPostDetailCubit, String, void>(
    (postId, _) => CommunityPostDetailCubit(
      postId: postId,
      currentUserId: sl<SupabaseDataService>().getCurrentUserId(),
      getCommunityPostByIdUseCase: sl(),
      toggleCommunityReactionUseCase: sl(),
      getCommunityCommentsUseCase: sl(),
      addCommunityCommentUseCase: sl(),
      deleteCommunityPostUseCase: sl(),
    ),
  );
  sl.registerFactoryParam<CommunityFollowListCubit, String, String>(
    (userId, typeSlug) => CommunityFollowListCubit(
      userId: userId,
      typeSlug: typeSlug,
      getCommunityFollowersUseCase: sl(),
      getCommunityFollowingUseCase: sl(),
    ),
  );
  sl.registerFactoryParam<CommunityProfileCubit, String, void>(
    (userId, _) => CommunityProfileCubit(
      userId: userId,
      currentUserId: sl<SupabaseDataService>().getCurrentUserId(),
      getCommunityProfileUseCase: sl(),
      followCommunityUserUseCase: sl(),
      unfollowCommunityUserUseCase: sl(),
      getCommunityStoriesUseCase: sl(),
      deleteCommunityStoryUseCase: sl(),
      getCommunityPostByIdUseCase: sl(),
      getCommunityPostsUseCase: sl(),
      deleteCommunityPostUseCase: sl(),
      toggleCommunityReactionUseCase: sl(),
      getCommunityCommentsUseCase: sl(),
      addCommunityCommentUseCase: sl(),
    ),
  );
  sl.registerFactoryParam<GenresCubit, List<HomeGenre>, void>(
    (genres, _) => GenresCubit(genres: genres),
  );
  sl.registerFactory(
    () => LibraryCubit(
      getLibraryMoviesUseCase: sl(),
      removeMovieFromLibraryUseCase: sl(),
    ),
  );
  sl.registerFactory(() => SignInCubit(signInWithPasswordUseCase: sl()));
  sl.registerFactory(() => SignUpCubit(signUpWithPasswordUseCase: sl()));
  sl.registerFactory(
    () => ForgotPasswordCubit(resetPasswordForEmailUseCase: sl()),
  );
  sl.registerFactoryParam<MovieDetailCubit, String, List<dynamic>?>(
    (slug, relatedMovies) => MovieDetailCubit(
      getMovieDetailUseCase: sl(),
      addMovieToLibraryUseCase: sl(),
      slug: slug,
      relatedMovies:
          relatedMovies?.whereType<HomeMovie>().toList(growable: false) ??
          const [],
    ),
  );
  sl.registerFactoryParam<GenreMoviesCubit, String, String>(
    (slug, title) => GenreMoviesCubit(
      getGenreMoviesUseCase: sl(),
      getCountriesUseCase: sl(),
      slug: slug,
      title: title,
    ),
  );
  sl.registerFactoryParam<MovieListCubit, String, String>(
    (slug, title) =>
        MovieListCubit(getMovieListUseCase: sl(), slug: slug, title: title),
  );
  sl.registerFactoryParam<MovieTrailerCubit, String, String>(
    (title, trailerUrl) =>
        MovieTrailerCubit(title: title, trailerUrl: trailerUrl),
  );
  sl.registerFactoryParam<MovieWatchCubit, String, MovieDetail?>(
    (slug, initialDetail) => MovieWatchCubit(
      getMovieDetailUseCase: sl(),
      slug: slug,
      initialDetail: initialDetail,
    ),
  );
  sl.registerFactory(() => ChangePasswordCubit(changePasswordUseCase: sl()));
  sl.registerFactoryParam<LanguageCubit, AppCubit, void>(
    (appCubit, _) => LanguageCubit(appCubit: appCubit),
  );
  sl.registerFactory(
    () => SettingsCubit(
      mainCubit: sl(),
      getCachedProfileUseCase: sl(),
      getCommunityProfileUseCase: sl(),
    ),
  );
  sl.registerFactory(
    () => EditProfileCubit(
      mainCubit: sl(),
      getCachedProfileUseCase: sl(),
      updateProfileUseCase: sl(),
      updateProfileAvatarUseCase: sl(),
      updateProfileCoverUseCase: sl(),
    ),
  );
}
