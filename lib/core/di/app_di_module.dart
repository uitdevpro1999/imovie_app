import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:imovie_app/config/flavors/app_bootstrap.dart';
import 'package:imovie_app/core/services/api_client.dart';
import 'package:imovie_app/core/services/call/agora_call_service.dart';
import 'package:imovie_app/core/services/call/call_permission_service.dart';
import 'package:imovie_app/core/services/call/call_proximity_service.dart';
import 'package:imovie_app/core/services/call/callkit_service.dart';
import 'package:imovie_app/core/services/chat/agora_chat_service.dart';
import 'package:imovie_app/core/services/community_realtime_service.dart';
import 'package:imovie_app/core/services/local_storage_service.dart';
import 'package:imovie_app/core/services/location_service.dart';
import 'package:imovie_app/core/services/push_notification_service.dart';
import 'package:imovie_app/core/services/supabase_auth_service.dart';
import 'package:imovie_app/core/services/supabase_data_service.dart';
import 'package:imovie_app/data/datasources/call/call_remote_data_source.dart';
import 'package:imovie_app/data/datasources/chat/chat_remote_data_source.dart';
import 'package:imovie_app/data/datasources/community/community_remote_data_source.dart';
import 'package:imovie_app/data/datasources/home/home_remote_data_source.dart';
import 'package:imovie_app/data/datasources/library/library_remote_data_source.dart';
import 'package:imovie_app/data/datasources/movie_detail/movie_detail_remote_data_source.dart';
import 'package:imovie_app/data/datasources/notification/notification_remote_data_source.dart';
import 'package:imovie_app/data/datasources/profile/profile_remote_data_source.dart';
import 'package:imovie_app/data/datasources/session/session_remote_data_source.dart';
import 'package:imovie_app/data/repositories/call/call_repository_impl.dart';
import 'package:imovie_app/data/repositories/chat/chat_repository_impl.dart';
import 'package:imovie_app/data/repositories/community/community_repository_impl.dart';
import 'package:imovie_app/data/repositories/home/home_repository_impl.dart';
import 'package:imovie_app/data/repositories/library/library_repository_impl.dart';
import 'package:imovie_app/data/repositories/movie_detail/movie_detail_repository_impl.dart';
import 'package:imovie_app/data/repositories/notification/notification_repository_impl.dart';
import 'package:imovie_app/data/repositories/profile/profile_repository_impl.dart';
import 'package:imovie_app/data/repositories/session/session_repository_impl.dart';
import 'package:imovie_app/domain/entities/call/call_session.dart';
import 'package:imovie_app/domain/entities/community/community_post.dart';
import 'package:imovie_app/domain/entities/home/home_genre.dart';
import 'package:imovie_app/domain/entities/home/home_movie.dart';
import 'package:imovie_app/domain/entities/movie_detail/movie_detail.dart';
import 'package:imovie_app/domain/repositories/call_repository.dart';
import 'package:imovie_app/domain/repositories/chat_repository.dart';
import 'package:imovie_app/domain/repositories/community_repository.dart';
import 'package:imovie_app/domain/repositories/home_repository.dart';
import 'package:imovie_app/domain/repositories/library_repository.dart';
import 'package:imovie_app/domain/repositories/movie_detail_repository.dart';
import 'package:imovie_app/domain/repositories/notification_repository.dart';
import 'package:imovie_app/domain/repositories/profile_repository.dart';
import 'package:imovie_app/domain/repositories/session_repository.dart';
import 'package:imovie_app/domain/usecases/call/answer_call_use_case.dart';
import 'package:imovie_app/domain/usecases/call/decline_call_use_case.dart';
import 'package:imovie_app/domain/usecases/call/end_call_use_case.dart';
import 'package:imovie_app/domain/usecases/call/get_call_use_case.dart';
import 'package:imovie_app/domain/usecases/call/start_call_use_case.dart';
import 'package:imovie_app/domain/usecases/call/watch_call_use_case.dart';
import 'package:imovie_app/domain/usecases/chat/get_chat_conversations_use_case.dart';
import 'package:imovie_app/domain/usecases/chat/get_chat_messages_use_case.dart';
import 'package:imovie_app/domain/usecases/chat/get_or_create_direct_conversation_use_case.dart';
import 'package:imovie_app/domain/usecases/chat/mark_chat_conversation_read_use_case.dart';
import 'package:imovie_app/domain/usecases/chat/recall_chat_message_use_case.dart';
import 'package:imovie_app/domain/usecases/chat/send_chat_image_use_case.dart';
import 'package:imovie_app/domain/usecases/chat/send_chat_message_use_case.dart';
import 'package:imovie_app/domain/usecases/chat/toggle_chat_reaction_use_case.dart';
import 'package:imovie_app/domain/usecases/chat/watch_chat_conversations_use_case.dart';
import 'package:imovie_app/domain/usecases/chat/watch_chat_messages_use_case.dart';
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
import 'package:imovie_app/domain/usecases/get_current_session_use_case.dart';
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
import 'package:imovie_app/domain/usecases/session/reset_password_for_email_use_case.dart';
import 'package:imovie_app/domain/usecases/session/sign_in_with_password_use_case.dart';
import 'package:imovie_app/domain/usecases/session/sign_out_use_case.dart';
import 'package:imovie_app/domain/usecases/session/sign_up_with_password_use_case.dart';
import 'package:imovie_app/presentation/app/app_cubit.dart';
import 'package:imovie_app/presentation/ui/auth/forgot_password/forgot_password_cubit.dart';
import 'package:imovie_app/presentation/ui/auth/sign_in/sign_in_cubit.dart';
import 'package:imovie_app/presentation/ui/auth/sign_up/sign_up_cubit.dart';
import 'package:imovie_app/presentation/ui/browse/browse_cubit.dart';
import 'package:imovie_app/presentation/ui/call/active/active_call_cubit.dart';
import 'package:imovie_app/presentation/ui/chat/list/chat_list_cubit.dart';
import 'package:imovie_app/presentation/ui/chat/thread/chat_thread_cubit.dart';
import 'package:imovie_app/presentation/ui/community/compose/community_compose_cubit.dart';
import 'package:imovie_app/presentation/ui/community/feed/community_cubit.dart';
import 'package:imovie_app/presentation/ui/community/follow_list/community_follow_list_cubit.dart';
import 'package:imovie_app/presentation/ui/community/post_detail/community_post_detail_cubit.dart';
import 'package:imovie_app/presentation/ui/community/profile/community_profile_cubit.dart';
import 'package:imovie_app/presentation/ui/community/story_editor/community_story_editor_cubit.dart';
import 'package:imovie_app/presentation/ui/community/story_viewer/community_story_viewer_cubit.dart';
import 'package:imovie_app/presentation/ui/genre_movies/genre_movies_cubit.dart';
import 'package:imovie_app/presentation/ui/genres/genres_cubit.dart';
import 'package:imovie_app/presentation/ui/home/home_cubit.dart';
import 'package:imovie_app/presentation/ui/library/library_cubit.dart';
import 'package:imovie_app/presentation/ui/main/main_cubit.dart';
import 'package:imovie_app/presentation/ui/movie_detail/movie_detail_cubit.dart';
import 'package:imovie_app/presentation/ui/movie_list/movie_list_cubit.dart';
import 'package:imovie_app/presentation/ui/movie_trailer/movie_trailer_cubit.dart';
import 'package:imovie_app/presentation/ui/movie_watch/movie_watch_cubit.dart';
import 'package:imovie_app/presentation/ui/notifications/notification_center_cubit.dart';
import 'package:imovie_app/presentation/ui/notifications/notifications_cubit.dart';
import 'package:imovie_app/presentation/ui/profile/change_password/change_password_cubit.dart';
import 'package:imovie_app/presentation/ui/profile/edit_profile/edit_profile_cubit.dart';
import 'package:imovie_app/presentation/ui/profile/language/language_cubit.dart';
import 'package:imovie_app/presentation/ui/profile/settings/settings_cubit.dart';
import 'package:imovie_app/presentation/ui/splash/splash_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

FutureOr<void> disposeMainCubit(MainCubit cubit) => cubit.close();

FutureOr<void> disposeNotificationCenterCubit(NotificationCenterCubit cubit) =>
    cubit.close();

@module
abstract class AppDiModule {
  @preResolve
  Future<SharedPreferences> get sharedPreferences =>
      SharedPreferences.getInstance();

  @lazySingleton
  ApiClient apiClient(AppBootstrap bootstrap) =>
      DioApiClient(baseUrl: bootstrap.environment.ophimApiBaseUrl);

  @lazySingleton
  SupabaseAuthService supabaseAuthService(AppBootstrap bootstrap) =>
      bootstrap.isSupabaseReady
      ? ConfiguredSupabaseAuthService(client: Supabase.instance.client)
      : const UnconfiguredSupabaseAuthService();

  @lazySingleton
  SupabaseDataService supabaseDataService(AppBootstrap bootstrap) =>
      bootstrap.isSupabaseReady
      ? ConfiguredSupabaseDataService(client: Supabase.instance.client)
      : const UnconfiguredSupabaseDataService();

  @lazySingleton
  CommunityRealtimeService communityRealtimeService(
    AppBootstrap bootstrap,
    SupabaseDataService dataService,
  ) => bootstrap.isSupabaseReady
      ? SupabaseCommunityRealtimeService(dataService: dataService)
      : const NoOpCommunityRealtimeService();

  @lazySingleton
  PushNotificationService pushNotificationService(
    AppBootstrap bootstrap,
    SupabaseDataService dataService,
    CallkitService callkitService,
    AnswerCallUseCase answerCallUseCase,
    DeclineCallUseCase declineCallUseCase,
  ) => DevicePushNotificationService(
    bootstrap: bootstrap,
    dataService: dataService,
    callkitService: callkitService,
    answerCallUseCase: answerCallUseCase,
    declineCallUseCase: declineCallUseCase,
  );

  @lazySingleton
  CallkitService get callkitService => const FlutterIncomingCallkitService();

  @lazySingleton
  CallPermissionService get callPermissionService =>
      const RuntimeCallPermissionService();

  @lazySingleton
  CallProximityService get callProximityService =>
      const NativeCallProximityService();

  @injectable
  AgoraCallService get agoraCallService =>
      RtcAgoraCallService(appId: '97224212f90f4cb1a697dc0a7b5e8d1c');

  @lazySingleton
  AgoraChatService agoraChatService(
    AppBootstrap bootstrap,
    SupabaseDataService dataService,
  ) => bootstrap.isSupabaseReady
      ? SdkAgoraChatService(
          dataService: dataService,
          appKey: '611142622#200031696',
        )
      : const NoOpAgoraChatService();

  @lazySingleton
  LocationService get locationService => const DeviceLocationService();

  @lazySingleton
  HomeRemoteDataSource homeRemoteDataSource(ApiClient apiClient) =>
      buildHomeRemoteDataSource(apiClient);

  @lazySingleton
  SessionRemoteDataSource sessionRemoteDataSource(
    SupabaseAuthService authService,
  ) => SupabaseSessionRemoteDataSource(authService: authService);

  @lazySingleton
  ProfileRemoteDataSource profileRemoteDataSource(
    SupabaseDataService dataService,
  ) => SupabaseProfileRemoteDataSource(dataService: dataService);

  @lazySingleton
  LibraryRemoteDataSource libraryRemoteDataSource(
    SupabaseDataService dataService,
  ) => SupabaseLibraryRemoteDataSource(dataService: dataService);

  @lazySingleton
  CommunityRemoteDataSource communityRemoteDataSource(
    SupabaseDataService dataService,
  ) => SupabaseCommunityRemoteDataSource(dataService: dataService);

  @lazySingleton
  ChatRemoteDataSource chatRemoteDataSource(
    SupabaseDataService dataService,
    AgoraChatService agoraChatService,
  ) => SupabaseChatRemoteDataSource(
    dataService: dataService,
    agoraChatService: agoraChatService,
  );

  @lazySingleton
  CallRemoteDataSource callRemoteDataSource(SupabaseDataService dataService) =>
      SupabaseCallRemoteDataSource(dataService: dataService);

  @lazySingleton
  NotificationRemoteDataSource notificationRemoteDataSource(
    SupabaseDataService dataService,
  ) => SupabaseNotificationRemoteDataSource(dataService: dataService);

  @lazySingleton
  LocalStorageService localStorageService(SharedPreferences preferences) =>
      SharedPreferencesLocalStorageService(sharedPreferences: preferences);

  @lazySingleton
  MovieDetailRemoteDataSource movieDetailRemoteDataSource(
    ApiClient apiClient,
  ) => buildMovieDetailRemoteDataSource(apiClient);

  @lazySingleton
  HomeRepository homeRepository(HomeRemoteDataSource remoteDataSource) =>
      HomeRepositoryImpl(remoteDataSource: remoteDataSource);

  @lazySingleton
  MovieDetailRepository movieDetailRepository(
    MovieDetailRemoteDataSource remoteDataSource,
  ) => MovieDetailRepositoryImpl(remoteDataSource: remoteDataSource);

  @lazySingleton
  LibraryRepository libraryRepository(
    AppBootstrap bootstrap,
    LibraryRemoteDataSource remoteDataSource,
  ) => LibraryRepositoryImpl(
    bootstrap: bootstrap,
    remoteDataSource: remoteDataSource,
  );

  @lazySingleton
  CommunityRepository communityRepository(
    AppBootstrap bootstrap,
    CommunityRemoteDataSource remoteDataSource,
  ) => CommunityRepositoryImpl(
    bootstrap: bootstrap,
    remoteDataSource: remoteDataSource,
  );

  @lazySingleton
  ChatRepository chatRepository(
    AppBootstrap bootstrap,
    ChatRemoteDataSource remoteDataSource,
  ) => ChatRepositoryImpl(
    bootstrap: bootstrap,
    remoteDataSource: remoteDataSource,
  );

  @lazySingleton
  CallRepository callRepository(
    AppBootstrap bootstrap,
    CallRemoteDataSource remoteDataSource,
  ) => CallRepositoryImpl(
    bootstrap: bootstrap,
    remoteDataSource: remoteDataSource,
  );

  @lazySingleton
  NotificationRepository notificationRepository(
    AppBootstrap bootstrap,
    NotificationRemoteDataSource remoteDataSource,
  ) => NotificationRepositoryImpl(
    bootstrap: bootstrap,
    remoteDataSource: remoteDataSource,
  );

  @lazySingleton
  SessionRepository sessionRepository(
    AppBootstrap bootstrap,
    SessionRemoteDataSource remoteDataSource,
  ) => SessionRepositoryImpl(
    bootstrap: bootstrap,
    remoteDataSource: remoteDataSource,
  );

  @lazySingleton
  ProfileRepository profileRepository(
    AppBootstrap bootstrap,
    ProfileRemoteDataSource remoteDataSource,
    LocalStorageService localStorageService,
  ) => ProfileRepositoryImpl(
    bootstrap: bootstrap,
    remoteDataSource: remoteDataSource,
    localStorageService: localStorageService,
  );

  @injectable
  GetCurrentSessionUseCase getCurrentSessionUseCase(
    SessionRepository repository,
  ) => GetCurrentSessionUseCase(repository);

  @injectable
  GetChatConversationsUseCase getChatConversationsUseCase(
    ChatRepository repository,
  ) => GetChatConversationsUseCase(repository);

  @injectable
  GetOrCreateDirectConversationUseCase getOrCreateDirectConversationUseCase(
    ChatRepository repository,
  ) => GetOrCreateDirectConversationUseCase(repository);

  @injectable
  GetChatMessagesUseCase getChatMessagesUseCase(ChatRepository repository) =>
      GetChatMessagesUseCase(repository);

  @injectable
  SendChatMessageUseCase sendChatMessageUseCase(ChatRepository repository) =>
      SendChatMessageUseCase(repository);

  @injectable
  SendChatImageUseCase sendChatImageUseCase(ChatRepository repository) =>
      SendChatImageUseCase(repository);

  @injectable
  RecallChatMessageUseCase recallChatMessageUseCase(
    ChatRepository repository,
  ) => RecallChatMessageUseCase(repository: repository);

  @injectable
  ToggleChatReactionUseCase toggleChatReactionUseCase(
    ChatRepository repository,
  ) => ToggleChatReactionUseCase(repository: repository);

  @injectable
  MarkChatConversationReadUseCase markChatConversationReadUseCase(
    ChatRepository repository,
  ) => MarkChatConversationReadUseCase(repository);

  @injectable
  WatchChatConversationsUseCase watchChatConversationsUseCase(
    ChatRepository repository,
  ) => WatchChatConversationsUseCase(repository);

  @injectable
  WatchChatMessagesUseCase watchChatMessagesUseCase(
    ChatRepository repository,
  ) => WatchChatMessagesUseCase(repository);

  @injectable
  StartCallUseCase startCallUseCase(CallRepository repository) =>
      StartCallUseCase(repository);

  @injectable
  AnswerCallUseCase answerCallUseCase(CallRepository repository) =>
      AnswerCallUseCase(repository);

  @injectable
  DeclineCallUseCase declineCallUseCase(CallRepository repository) =>
      DeclineCallUseCase(repository);

  @injectable
  EndCallUseCase endCallUseCase(CallRepository repository) =>
      EndCallUseCase(repository);

  @injectable
  GetCallUseCase getCallUseCase(CallRepository repository) =>
      GetCallUseCase(repository);

  @injectable
  WatchCallUseCase watchCallUseCase(CallRepository repository) =>
      WatchCallUseCase(repository);

  @injectable
  GetCommunityStoriesUseCase getCommunityStoriesUseCase(
    CommunityRepository repository,
  ) => GetCommunityStoriesUseCase(repository);

  @injectable
  GetCommunityFollowedUserIdsUseCase getCommunityFollowedUserIdsUseCase(
    CommunityRepository repository,
  ) => GetCommunityFollowedUserIdsUseCase(repository);

  @injectable
  GetCommunityProfileUseCase getCommunityProfileUseCase(
    CommunityRepository repository,
  ) => GetCommunityProfileUseCase(repository);

  @injectable
  GetCommunityFollowersUseCase getCommunityFollowersUseCase(
    CommunityRepository repository,
  ) => GetCommunityFollowersUseCase(repository);

  @injectable
  GetCommunityFollowingUseCase getCommunityFollowingUseCase(
    CommunityRepository repository,
  ) => GetCommunityFollowingUseCase(repository);

  @injectable
  FollowCommunityUserUseCase followCommunityUserUseCase(
    CommunityRepository repository,
  ) => FollowCommunityUserUseCase(repository);

  @injectable
  UnfollowCommunityUserUseCase unfollowCommunityUserUseCase(
    CommunityRepository repository,
  ) => UnfollowCommunityUserUseCase(repository);

  @injectable
  GetCommunityStoryByIdUseCase getCommunityStoryByIdUseCase(
    CommunityRepository repository,
  ) => GetCommunityStoryByIdUseCase(repository);

  @injectable
  CreateCommunityStoryUseCase createCommunityStoryUseCase(
    CommunityRepository repository,
  ) => CreateCommunityStoryUseCase(repository);

  @injectable
  DeleteCommunityStoryUseCase deleteCommunityStoryUseCase(
    CommunityRepository repository,
  ) => DeleteCommunityStoryUseCase(repository);

  @injectable
  GetCommunityPostByIdUseCase getCommunityPostByIdUseCase(
    CommunityRepository repository,
  ) => GetCommunityPostByIdUseCase(repository);

  @injectable
  GetCommunityPostsUseCase getCommunityPostsUseCase(
    CommunityRepository repository,
  ) => GetCommunityPostsUseCase(repository);

  @injectable
  CreateCommunityPostUseCase createCommunityPostUseCase(
    CommunityRepository repository,
  ) => CreateCommunityPostUseCase(repository);

  @injectable
  UpdateCommunityPostUseCase updateCommunityPostUseCase(
    CommunityRepository repository,
  ) => UpdateCommunityPostUseCase(repository);

  @injectable
  DeleteCommunityPostUseCase deleteCommunityPostUseCase(
    CommunityRepository repository,
  ) => DeleteCommunityPostUseCase(repository);

  @injectable
  GetCommunityCommentsUseCase getCommunityCommentsUseCase(
    CommunityRepository repository,
  ) => GetCommunityCommentsUseCase(repository);

  @injectable
  AddCommunityCommentUseCase addCommunityCommentUseCase(
    CommunityRepository repository,
  ) => AddCommunityCommentUseCase(repository);

  @injectable
  ToggleCommunityReactionUseCase toggleCommunityReactionUseCase(
    CommunityRepository repository,
  ) => ToggleCommunityReactionUseCase(repository);

  @injectable
  GetHomeFeedUseCase getHomeFeedUseCase(HomeRepository repository) =>
      GetHomeFeedUseCase(repository);

  @injectable
  GetHomeGenresUseCase getHomeGenresUseCase(HomeRepository repository) =>
      GetHomeGenresUseCase(repository);

  @injectable
  GetCountriesUseCase getCountriesUseCase(HomeRepository repository) =>
      GetCountriesUseCase(repository);

  @injectable
  GetGenreMoviesUseCase getGenreMoviesUseCase(HomeRepository repository) =>
      GetGenreMoviesUseCase(repository);

  @injectable
  GetMovieListUseCase getMovieListUseCase(HomeRepository repository) =>
      GetMovieListUseCase(repository);

  @injectable
  SearchMoviesUseCase searchMoviesUseCase(HomeRepository repository) =>
      SearchMoviesUseCase(repository);

  @injectable
  GetMovieDetailUseCase getMovieDetailUseCase(
    MovieDetailRepository repository,
  ) => GetMovieDetailUseCase(repository);

  @injectable
  GetNotificationsUseCase getNotificationsUseCase(
    NotificationRepository repository,
  ) => GetNotificationsUseCase(repository);

  @injectable
  GetUnreadNotificationCountUseCase getUnreadNotificationCountUseCase(
    NotificationRepository repository,
  ) => GetUnreadNotificationCountUseCase(repository);

  @injectable
  MarkNotificationReadUseCase markNotificationReadUseCase(
    NotificationRepository repository,
  ) => MarkNotificationReadUseCase(repository);

  @injectable
  MarkAllNotificationsReadUseCase markAllNotificationsReadUseCase(
    NotificationRepository repository,
  ) => MarkAllNotificationsReadUseCase(repository);

  @injectable
  WatchNotificationsUseCase watchNotificationsUseCase(
    NotificationRepository repository,
  ) => WatchNotificationsUseCase(repository);

  @injectable
  GetLibraryMoviesUseCase getLibraryMoviesUseCase(
    LibraryRepository repository,
  ) => GetLibraryMoviesUseCase(repository);

  @injectable
  AddMovieToLibraryUseCase addMovieToLibraryUseCase(
    LibraryRepository repository,
  ) => AddMovieToLibraryUseCase(repository);

  @injectable
  RemoveMovieFromLibraryUseCase removeMovieFromLibraryUseCase(
    LibraryRepository repository,
  ) => RemoveMovieFromLibraryUseCase(repository);

  @injectable
  GetCachedProfileUseCase getCachedProfileUseCase(
    ProfileRepository repository,
  ) => GetCachedProfileUseCase(repository);

  @injectable
  GetCurrentProfileUseCase getCurrentProfileUseCase(
    ProfileRepository repository,
  ) => GetCurrentProfileUseCase(repository);

  @injectable
  ClearCachedProfileUseCase clearCachedProfileUseCase(
    ProfileRepository repository,
  ) => ClearCachedProfileUseCase(repository);

  @injectable
  UpdateProfileUseCase updateProfileUseCase(ProfileRepository repository) =>
      UpdateProfileUseCase(repository);

  @injectable
  UpdateProfileAvatarUseCase updateProfileAvatarUseCase(
    ProfileRepository repository,
  ) => UpdateProfileAvatarUseCase(repository);

  @injectable
  UpdateProfileCoverUseCase updateProfileCoverUseCase(
    ProfileRepository repository,
  ) => UpdateProfileCoverUseCase(repository);

  @injectable
  ChangePasswordUseCase changePasswordUseCase(SessionRepository repository) =>
      ChangePasswordUseCase(repository);

  @injectable
  SignInWithPasswordUseCase signInWithPasswordUseCase(
    SessionRepository repository,
  ) => SignInWithPasswordUseCase(repository);

  @injectable
  SignUpWithPasswordUseCase signUpWithPasswordUseCase(
    SessionRepository repository,
  ) => SignUpWithPasswordUseCase(repository);

  @injectable
  ResetPasswordForEmailUseCase resetPasswordForEmailUseCase(
    SessionRepository repository,
  ) => ResetPasswordForEmailUseCase(repository);

  @injectable
  SignOutUseCase signOutUseCase(SessionRepository repository) =>
      SignOutUseCase(repository);

  @injectable
  AppCubit appCubit(
    GetCurrentSessionUseCase getCurrentSessionUseCase,
    LocalStorageService localStorageService,
  ) => AppCubit(
    getCurrentSessionUseCase: getCurrentSessionUseCase,
    localStorageService: localStorageService,
  );

  @injectable
  SplashCubit splashCubit(GetCurrentSessionUseCase getCurrentSessionUseCase) =>
      SplashCubit(getCurrentSessionUseCase: getCurrentSessionUseCase);

  @LazySingleton(dispose: disposeMainCubit)
  MainCubit mainCubit(
    GetCurrentSessionUseCase getCurrentSessionUseCase,
    GetCurrentProfileUseCase getCurrentProfileUseCase,
    GetCachedProfileUseCase getCachedProfileUseCase,
    ClearCachedProfileUseCase clearCachedProfileUseCase,
    SignOutUseCase signOutUseCase,
  ) => MainCubit(
    getCurrentSessionUseCase: getCurrentSessionUseCase,
    getCurrentProfileUseCase: getCurrentProfileUseCase,
    getCachedProfileUseCase: getCachedProfileUseCase,
    clearCachedProfileUseCase: clearCachedProfileUseCase,
    signOutUseCase: signOutUseCase,
  );

  @LazySingleton(dispose: disposeNotificationCenterCubit)
  NotificationCenterCubit notificationCenterCubit(
    GetUnreadNotificationCountUseCase getUnreadNotificationCountUseCase,
    WatchNotificationsUseCase watchNotificationsUseCase,
  ) => NotificationCenterCubit(
    getUnreadNotificationCountUseCase: getUnreadNotificationCountUseCase,
    watchNotificationsUseCase: watchNotificationsUseCase,
  );

  @injectable
  HomeCubit homeCubit(
    GetHomeFeedUseCase getHomeFeedUseCase,
    GetHomeGenresUseCase getHomeGenresUseCase,
    GetMovieListUseCase getMovieListUseCase,
    GetMovieDetailUseCase getMovieDetailUseCase,
  ) => HomeCubit(
    getHomeFeedUseCase: getHomeFeedUseCase,
    getHomeGenresUseCase: getHomeGenresUseCase,
    getMovieListUseCase: getMovieListUseCase,
    getMovieDetailUseCase: getMovieDetailUseCase,
  );

  @injectable
  NotificationsCubit notificationsCubit(
    GetNotificationsUseCase getNotificationsUseCase,
    MarkNotificationReadUseCase markNotificationReadUseCase,
    MarkAllNotificationsReadUseCase markAllNotificationsReadUseCase,
  ) => NotificationsCubit(
    getNotificationsUseCase: getNotificationsUseCase,
    markNotificationReadUseCase: markNotificationReadUseCase,
    markAllNotificationsReadUseCase: markAllNotificationsReadUseCase,
  );

  @injectable
  BrowseCubit browseCubit(
    GetHomeFeedUseCase getHomeFeedUseCase,
    GetHomeGenresUseCase getHomeGenresUseCase,
    GetCountriesUseCase getCountriesUseCase,
    SearchMoviesUseCase searchMoviesUseCase,
  ) => BrowseCubit(
    getHomeFeedUseCase: getHomeFeedUseCase,
    getHomeGenresUseCase: getHomeGenresUseCase,
    getCountriesUseCase: getCountriesUseCase,
    searchMoviesUseCase: searchMoviesUseCase,
  );

  @injectable
  ChatListCubit chatListCubit(
    GetChatConversationsUseCase getChatConversationsUseCase,
    WatchChatConversationsUseCase watchChatConversationsUseCase,
  ) => ChatListCubit(
    getChatConversationsUseCase: getChatConversationsUseCase,
    watchChatConversationsUseCase: watchChatConversationsUseCase,
  );

  @injectable
  ChatThreadCubit chatThreadCubit(
    @factoryParam String conversationId,
    @factoryParam String title,
    GetChatMessagesUseCase getChatMessagesUseCase,
    SendChatMessageUseCase sendChatMessageUseCase,
    SendChatImageUseCase sendChatImageUseCase,
    RecallChatMessageUseCase recallChatMessageUseCase,
    ToggleChatReactionUseCase toggleChatReactionUseCase,
    MarkChatConversationReadUseCase markChatConversationReadUseCase,
    WatchChatMessagesUseCase watchChatMessagesUseCase,
    StartCallUseCase startCallUseCase,
  ) => ChatThreadCubit(
    conversationId: conversationId,
    title: title,
    getChatMessagesUseCase: getChatMessagesUseCase,
    sendChatMessageUseCase: sendChatMessageUseCase,
    sendChatImageUseCase: sendChatImageUseCase,
    recallChatMessageUseCase: recallChatMessageUseCase,
    toggleChatReactionUseCase: toggleChatReactionUseCase,
    markChatConversationReadUseCase: markChatConversationReadUseCase,
    watchChatMessagesUseCase: watchChatMessagesUseCase,
    startCallUseCase: startCallUseCase,
  );

  @injectable
  ActiveCallCubit activeCallCubit(
    @factoryParam CallSession call,
    AgoraCallService agoraCallService,
    CallkitService callkitService,
    CallPermissionService callPermissionService,
    CallProximityService callProximityService,
    EndCallUseCase endCallUseCase,
    WatchCallUseCase watchCallUseCase,
  ) => ActiveCallCubit(
    call: call,
    agoraCallService: agoraCallService,
    callkitService: callkitService,
    callPermissionService: callPermissionService,
    callProximityService: callProximityService,
    endCallUseCase: endCallUseCase,
    watchCallUseCase: watchCallUseCase,
  );

  @injectable
  CommunityCubit communityCubit(
    @factoryParam bool mineOnly,
    SupabaseDataService dataService,
    GetCommunityFollowedUserIdsUseCase getCommunityFollowedUserIdsUseCase,
    GetCommunityStoriesUseCase getCommunityStoriesUseCase,
    DeleteCommunityStoryUseCase deleteCommunityStoryUseCase,
    GetCommunityPostByIdUseCase getCommunityPostByIdUseCase,
    GetCommunityPostsUseCase getCommunityPostsUseCase,
    DeleteCommunityPostUseCase deleteCommunityPostUseCase,
    ToggleCommunityReactionUseCase toggleCommunityReactionUseCase,
    GetCommunityCommentsUseCase getCommunityCommentsUseCase,
    AddCommunityCommentUseCase addCommunityCommentUseCase,
  ) => CommunityCubit(
    mineOnly: mineOnly,
    currentUserId: dataService.getCurrentUserId(),
    getCommunityFollowedUserIdsUseCase: getCommunityFollowedUserIdsUseCase,
    getCommunityStoriesUseCase: getCommunityStoriesUseCase,
    deleteCommunityStoryUseCase: deleteCommunityStoryUseCase,
    getCommunityPostByIdUseCase: getCommunityPostByIdUseCase,
    getCommunityPostsUseCase: getCommunityPostsUseCase,
    deleteCommunityPostUseCase: deleteCommunityPostUseCase,
    toggleCommunityReactionUseCase: toggleCommunityReactionUseCase,
    getCommunityCommentsUseCase: getCommunityCommentsUseCase,
    addCommunityCommentUseCase: addCommunityCommentUseCase,
  );

  @injectable
  CommunityComposeCubit communityComposeCubit(
    @factoryParam CommunityPost? initialPost,
    CreateCommunityPostUseCase createCommunityPostUseCase,
    UpdateCommunityPostUseCase updateCommunityPostUseCase,
    SearchMoviesUseCase searchMoviesUseCase,
    LocationService locationService,
  ) => CommunityComposeCubit(
    initialPost: initialPost,
    createCommunityPostUseCase: createCommunityPostUseCase,
    updateCommunityPostUseCase: updateCommunityPostUseCase,
    searchMoviesUseCase: searchMoviesUseCase,
    locationService: locationService,
  );

  @injectable
  CommunityStoryEditorCubit communityStoryEditorCubit(
    CreateCommunityStoryUseCase createCommunityStoryUseCase,
    SearchMoviesUseCase searchMoviesUseCase,
    LocationService locationService,
  ) => CommunityStoryEditorCubit(
    createCommunityStoryUseCase: createCommunityStoryUseCase,
    searchMoviesUseCase: searchMoviesUseCase,
    locationService: locationService,
  );

  @injectable
  CommunityStoryViewerCubit communityStoryViewerCubit(
    @factoryParam String storyId,
    SupabaseDataService dataService,
    GetCommunityStoryByIdUseCase getCommunityStoryByIdUseCase,
    GetCommunityStoriesUseCase getCommunityStoriesUseCase,
    DeleteCommunityStoryUseCase deleteCommunityStoryUseCase,
  ) => CommunityStoryViewerCubit(
    storyId: storyId,
    currentUserId: dataService.getCurrentUserId(),
    getCommunityStoryByIdUseCase: getCommunityStoryByIdUseCase,
    getCommunityStoriesUseCase: getCommunityStoriesUseCase,
    deleteCommunityStoryUseCase: deleteCommunityStoryUseCase,
  );

  @injectable
  CommunityPostDetailCubit communityPostDetailCubit(
    @factoryParam String postId,
    SupabaseDataService dataService,
    GetCommunityPostByIdUseCase getCommunityPostByIdUseCase,
    ToggleCommunityReactionUseCase toggleCommunityReactionUseCase,
    GetCommunityCommentsUseCase getCommunityCommentsUseCase,
    AddCommunityCommentUseCase addCommunityCommentUseCase,
    DeleteCommunityPostUseCase deleteCommunityPostUseCase,
  ) => CommunityPostDetailCubit(
    postId: postId,
    currentUserId: dataService.getCurrentUserId(),
    getCommunityPostByIdUseCase: getCommunityPostByIdUseCase,
    toggleCommunityReactionUseCase: toggleCommunityReactionUseCase,
    getCommunityCommentsUseCase: getCommunityCommentsUseCase,
    addCommunityCommentUseCase: addCommunityCommentUseCase,
    deleteCommunityPostUseCase: deleteCommunityPostUseCase,
  );

  @injectable
  CommunityFollowListCubit communityFollowListCubit(
    @factoryParam String userId,
    @factoryParam String typeSlug,
    GetCommunityFollowersUseCase getCommunityFollowersUseCase,
    GetCommunityFollowingUseCase getCommunityFollowingUseCase,
  ) => CommunityFollowListCubit(
    userId: userId,
    typeSlug: typeSlug,
    getCommunityFollowersUseCase: getCommunityFollowersUseCase,
    getCommunityFollowingUseCase: getCommunityFollowingUseCase,
  );

  @injectable
  CommunityProfileCubit communityProfileCubit(
    @factoryParam String userId,
    SupabaseDataService dataService,
    GetCommunityProfileUseCase getCommunityProfileUseCase,
    GetOrCreateDirectConversationUseCase getOrCreateDirectConversationUseCase,
    FollowCommunityUserUseCase followCommunityUserUseCase,
    UnfollowCommunityUserUseCase unfollowCommunityUserUseCase,
    GetCommunityStoriesUseCase getCommunityStoriesUseCase,
    DeleteCommunityStoryUseCase deleteCommunityStoryUseCase,
    GetCommunityPostByIdUseCase getCommunityPostByIdUseCase,
    GetCommunityPostsUseCase getCommunityPostsUseCase,
    DeleteCommunityPostUseCase deleteCommunityPostUseCase,
    ToggleCommunityReactionUseCase toggleCommunityReactionUseCase,
    GetCommunityCommentsUseCase getCommunityCommentsUseCase,
    AddCommunityCommentUseCase addCommunityCommentUseCase,
  ) => CommunityProfileCubit(
    userId: userId,
    currentUserId: dataService.getCurrentUserId(),
    getCommunityProfileUseCase: getCommunityProfileUseCase,
    getOrCreateDirectConversationUseCase: getOrCreateDirectConversationUseCase,
    followCommunityUserUseCase: followCommunityUserUseCase,
    unfollowCommunityUserUseCase: unfollowCommunityUserUseCase,
    getCommunityStoriesUseCase: getCommunityStoriesUseCase,
    deleteCommunityStoryUseCase: deleteCommunityStoryUseCase,
    getCommunityPostByIdUseCase: getCommunityPostByIdUseCase,
    getCommunityPostsUseCase: getCommunityPostsUseCase,
    deleteCommunityPostUseCase: deleteCommunityPostUseCase,
    toggleCommunityReactionUseCase: toggleCommunityReactionUseCase,
    getCommunityCommentsUseCase: getCommunityCommentsUseCase,
    addCommunityCommentUseCase: addCommunityCommentUseCase,
  );

  @injectable
  GenresCubit genresCubit(@factoryParam List<HomeGenre> genres) =>
      GenresCubit(genres: genres);

  @injectable
  LibraryCubit libraryCubit(
    GetLibraryMoviesUseCase getLibraryMoviesUseCase,
    RemoveMovieFromLibraryUseCase removeMovieFromLibraryUseCase,
  ) => LibraryCubit(
    getLibraryMoviesUseCase: getLibraryMoviesUseCase,
    removeMovieFromLibraryUseCase: removeMovieFromLibraryUseCase,
  );

  @injectable
  SignInCubit signInCubit(
    SignInWithPasswordUseCase signInWithPasswordUseCase,
  ) => SignInCubit(signInWithPasswordUseCase: signInWithPasswordUseCase);

  @injectable
  SignUpCubit signUpCubit(
    SignUpWithPasswordUseCase signUpWithPasswordUseCase,
  ) => SignUpCubit(signUpWithPasswordUseCase: signUpWithPasswordUseCase);

  @injectable
  ForgotPasswordCubit forgotPasswordCubit(
    ResetPasswordForEmailUseCase resetPasswordForEmailUseCase,
  ) => ForgotPasswordCubit(
    resetPasswordForEmailUseCase: resetPasswordForEmailUseCase,
  );

  @injectable
  MovieDetailCubit movieDetailCubit(
    @factoryParam String slug,
    @factoryParam List<dynamic>? relatedMovies,
    GetMovieDetailUseCase getMovieDetailUseCase,
    AddMovieToLibraryUseCase addMovieToLibraryUseCase,
  ) => MovieDetailCubit(
    getMovieDetailUseCase: getMovieDetailUseCase,
    addMovieToLibraryUseCase: addMovieToLibraryUseCase,
    slug: slug,
    relatedMovies:
        relatedMovies?.whereType<HomeMovie>().toList(growable: false) ??
        const [],
  );

  @injectable
  GenreMoviesCubit genreMoviesCubit(
    @factoryParam String slug,
    @factoryParam String title,
    GetGenreMoviesUseCase getGenreMoviesUseCase,
    GetCountriesUseCase getCountriesUseCase,
  ) => GenreMoviesCubit(
    getGenreMoviesUseCase: getGenreMoviesUseCase,
    getCountriesUseCase: getCountriesUseCase,
    slug: slug,
    title: title,
  );

  @injectable
  MovieListCubit movieListCubit(
    @factoryParam String slug,
    @factoryParam String title,
    GetMovieListUseCase getMovieListUseCase,
  ) => MovieListCubit(
    getMovieListUseCase: getMovieListUseCase,
    slug: slug,
    title: title,
  );

  @injectable
  MovieTrailerCubit movieTrailerCubit(
    @factoryParam String title,
    @factoryParam String trailerUrl,
  ) => MovieTrailerCubit(title: title, trailerUrl: trailerUrl);

  @injectable
  MovieWatchCubit movieWatchCubit(
    @factoryParam String slug,
    @factoryParam MovieDetail? initialDetail,
    GetMovieDetailUseCase getMovieDetailUseCase,
  ) => MovieWatchCubit(
    getMovieDetailUseCase: getMovieDetailUseCase,
    slug: slug,
    initialDetail: initialDetail,
  );

  @injectable
  ChangePasswordCubit changePasswordCubit(
    ChangePasswordUseCase changePasswordUseCase,
  ) => ChangePasswordCubit(changePasswordUseCase: changePasswordUseCase);

  @injectable
  LanguageCubit languageCubit(@factoryParam AppCubit appCubit) =>
      LanguageCubit(appCubit: appCubit);

  @injectable
  SettingsCubit settingsCubit(
    MainCubit mainCubit,
    GetCachedProfileUseCase getCachedProfileUseCase,
    GetCommunityProfileUseCase getCommunityProfileUseCase,
  ) => SettingsCubit(
    mainCubit: mainCubit,
    getCachedProfileUseCase: getCachedProfileUseCase,
    getCommunityProfileUseCase: getCommunityProfileUseCase,
  );

  @injectable
  EditProfileCubit editProfileCubit(
    MainCubit mainCubit,
    GetCachedProfileUseCase getCachedProfileUseCase,
    UpdateProfileUseCase updateProfileUseCase,
    UpdateProfileAvatarUseCase updateProfileAvatarUseCase,
    UpdateProfileCoverUseCase updateProfileCoverUseCase,
  ) => EditProfileCubit(
    mainCubit: mainCubit,
    getCachedProfileUseCase: getCachedProfileUseCase,
    updateProfileUseCase: updateProfileUseCase,
    updateProfileAvatarUseCase: updateProfileAvatarUseCase,
    updateProfileCoverUseCase: updateProfileCoverUseCase,
  );
}
