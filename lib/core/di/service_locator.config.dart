// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:imovie_app/config/flavors/app_bootstrap.dart' as _i638;
import 'package:imovie_app/core/di/app_di_module.dart' as _i186;
import 'package:imovie_app/core/services/api_client.dart' as _i1054;
import 'package:imovie_app/core/services/call/agora_call_service.dart' as _i760;
import 'package:imovie_app/core/services/call/call_permission_service.dart'
    as _i970;
import 'package:imovie_app/core/services/call/call_proximity_service.dart'
    as _i962;
import 'package:imovie_app/core/services/call/callkit_service.dart' as _i328;
import 'package:imovie_app/core/services/chat/agora_chat_service.dart' as _i428;
import 'package:imovie_app/core/services/community_realtime_service.dart'
    as _i12;
import 'package:imovie_app/core/services/local_storage_service.dart' as _i721;
import 'package:imovie_app/core/services/location_service.dart' as _i332;
import 'package:imovie_app/core/services/push_notification_service.dart'
    as _i911;
import 'package:imovie_app/core/services/supabase_auth_service.dart' as _i515;
import 'package:imovie_app/core/services/supabase_data_service.dart' as _i254;
import 'package:imovie_app/data/datasources/call/call_remote_data_source.dart'
    as _i137;
import 'package:imovie_app/data/datasources/chat/chat_remote_data_source.dart'
    as _i629;
import 'package:imovie_app/data/datasources/community/community_remote_data_source.dart'
    as _i956;
import 'package:imovie_app/data/datasources/home/home_remote_data_source.dart'
    as _i247;
import 'package:imovie_app/data/datasources/library/library_remote_data_source.dart'
    as _i874;
import 'package:imovie_app/data/datasources/movie_detail/movie_detail_remote_data_source.dart'
    as _i671;
import 'package:imovie_app/data/datasources/notification/notification_remote_data_source.dart'
    as _i569;
import 'package:imovie_app/data/datasources/profile/profile_remote_data_source.dart'
    as _i770;
import 'package:imovie_app/data/datasources/session/session_remote_data_source.dart'
    as _i1054;
import 'package:imovie_app/domain/entities/call/call_session.dart' as _i895;
import 'package:imovie_app/domain/entities/community/community_post.dart'
    as _i766;
import 'package:imovie_app/domain/entities/home/home_genre.dart' as _i263;
import 'package:imovie_app/domain/entities/movie_detail/movie_detail.dart'
    as _i1057;
import 'package:imovie_app/domain/repositories/call_repository.dart' as _i234;
import 'package:imovie_app/domain/repositories/chat_repository.dart' as _i385;
import 'package:imovie_app/domain/repositories/community_repository.dart'
    as _i911;
import 'package:imovie_app/domain/repositories/home_repository.dart' as _i3;
import 'package:imovie_app/domain/repositories/library_repository.dart'
    as _i863;
import 'package:imovie_app/domain/repositories/movie_detail_repository.dart'
    as _i873;
import 'package:imovie_app/domain/repositories/notification_repository.dart'
    as _i802;
import 'package:imovie_app/domain/repositories/profile_repository.dart'
    as _i628;
import 'package:imovie_app/domain/repositories/session_repository.dart'
    as _i900;
import 'package:imovie_app/domain/usecases/call/answer_call_use_case.dart'
    as _i11;
import 'package:imovie_app/domain/usecases/call/decline_call_use_case.dart'
    as _i1071;
import 'package:imovie_app/domain/usecases/call/end_call_use_case.dart' as _i39;
import 'package:imovie_app/domain/usecases/call/get_call_use_case.dart'
    as _i1002;
import 'package:imovie_app/domain/usecases/call/start_call_use_case.dart'
    as _i301;
import 'package:imovie_app/domain/usecases/call/watch_call_use_case.dart'
    as _i799;
import 'package:imovie_app/domain/usecases/chat/get_chat_conversations_use_case.dart'
    as _i162;
import 'package:imovie_app/domain/usecases/chat/get_chat_messages_use_case.dart'
    as _i1015;
import 'package:imovie_app/domain/usecases/chat/get_or_create_direct_conversation_use_case.dart'
    as _i337;
import 'package:imovie_app/domain/usecases/chat/mark_chat_conversation_read_use_case.dart'
    as _i925;
import 'package:imovie_app/domain/usecases/chat/recall_chat_message_use_case.dart'
    as _i1013;
import 'package:imovie_app/domain/usecases/chat/send_chat_image_use_case.dart'
    as _i395;
import 'package:imovie_app/domain/usecases/chat/send_chat_message_use_case.dart'
    as _i1059;
import 'package:imovie_app/domain/usecases/chat/toggle_chat_reaction_use_case.dart'
    as _i921;
import 'package:imovie_app/domain/usecases/chat/watch_chat_conversations_use_case.dart'
    as _i368;
import 'package:imovie_app/domain/usecases/chat/watch_chat_messages_use_case.dart'
    as _i969;
import 'package:imovie_app/domain/usecases/community/add_community_comment_use_case.dart'
    as _i456;
import 'package:imovie_app/domain/usecases/community/create_community_post_use_case.dart'
    as _i928;
import 'package:imovie_app/domain/usecases/community/create_community_story_use_case.dart'
    as _i770;
import 'package:imovie_app/domain/usecases/community/delete_community_post_use_case.dart'
    as _i420;
import 'package:imovie_app/domain/usecases/community/delete_community_story_use_case.dart'
    as _i606;
import 'package:imovie_app/domain/usecases/community/follow_community_user_use_case.dart'
    as _i1006;
import 'package:imovie_app/domain/usecases/community/get_community_comments_use_case.dart'
    as _i218;
import 'package:imovie_app/domain/usecases/community/get_community_followed_user_ids_use_case.dart'
    as _i869;
import 'package:imovie_app/domain/usecases/community/get_community_followers_use_case.dart'
    as _i484;
import 'package:imovie_app/domain/usecases/community/get_community_following_use_case.dart'
    as _i222;
import 'package:imovie_app/domain/usecases/community/get_community_post_by_id_use_case.dart'
    as _i469;
import 'package:imovie_app/domain/usecases/community/get_community_posts_use_case.dart'
    as _i922;
import 'package:imovie_app/domain/usecases/community/get_community_profile_use_case.dart'
    as _i205;
import 'package:imovie_app/domain/usecases/community/get_community_stories_use_case.dart'
    as _i890;
import 'package:imovie_app/domain/usecases/community/get_community_story_by_id_use_case.dart'
    as _i657;
import 'package:imovie_app/domain/usecases/community/toggle_community_reaction_use_case.dart'
    as _i926;
import 'package:imovie_app/domain/usecases/community/unfollow_community_user_use_case.dart'
    as _i879;
import 'package:imovie_app/domain/usecases/community/update_community_post_use_case.dart'
    as _i861;
import 'package:imovie_app/domain/usecases/get_current_session_use_case.dart'
    as _i53;
import 'package:imovie_app/domain/usecases/home/get_countries_use_case.dart'
    as _i57;
import 'package:imovie_app/domain/usecases/home/get_genre_movies_use_case.dart'
    as _i887;
import 'package:imovie_app/domain/usecases/home/get_home_feed_use_case.dart'
    as _i671;
import 'package:imovie_app/domain/usecases/home/get_home_genres_use_case.dart'
    as _i694;
import 'package:imovie_app/domain/usecases/home/get_movie_list_use_case.dart'
    as _i209;
import 'package:imovie_app/domain/usecases/home/search_movies_use_case.dart'
    as _i40;
import 'package:imovie_app/domain/usecases/library/add_movie_to_library_use_case.dart'
    as _i299;
import 'package:imovie_app/domain/usecases/library/get_library_movies_use_case.dart'
    as _i852;
import 'package:imovie_app/domain/usecases/library/remove_movie_from_library_use_case.dart'
    as _i323;
import 'package:imovie_app/domain/usecases/movie_detail/get_movie_detail_use_case.dart'
    as _i792;
import 'package:imovie_app/domain/usecases/notification/get_notifications_use_case.dart'
    as _i739;
import 'package:imovie_app/domain/usecases/notification/get_unread_notification_count_use_case.dart'
    as _i748;
import 'package:imovie_app/domain/usecases/notification/mark_all_notifications_read_use_case.dart'
    as _i551;
import 'package:imovie_app/domain/usecases/notification/mark_notification_read_use_case.dart'
    as _i814;
import 'package:imovie_app/domain/usecases/notification/watch_notifications_use_case.dart'
    as _i682;
import 'package:imovie_app/domain/usecases/profile/clear_cached_profile_use_case.dart'
    as _i34;
import 'package:imovie_app/domain/usecases/profile/get_cached_profile_use_case.dart'
    as _i699;
import 'package:imovie_app/domain/usecases/profile/get_current_profile_use_case.dart'
    as _i545;
import 'package:imovie_app/domain/usecases/profile/update_profile_avatar_use_case.dart'
    as _i811;
import 'package:imovie_app/domain/usecases/profile/update_profile_cover_use_case.dart'
    as _i5;
import 'package:imovie_app/domain/usecases/profile/update_profile_use_case.dart'
    as _i905;
import 'package:imovie_app/domain/usecases/session/change_password_use_case.dart'
    as _i223;
import 'package:imovie_app/domain/usecases/session/reset_password_for_email_use_case.dart'
    as _i738;
import 'package:imovie_app/domain/usecases/session/sign_in_with_password_use_case.dart'
    as _i871;
import 'package:imovie_app/domain/usecases/session/sign_out_use_case.dart'
    as _i678;
import 'package:imovie_app/domain/usecases/session/sign_up_with_password_use_case.dart'
    as _i229;
import 'package:imovie_app/presentation/app/app_cubit.dart' as _i848;
import 'package:imovie_app/presentation/ui/auth/forgot_password/forgot_password_cubit.dart'
    as _i214;
import 'package:imovie_app/presentation/ui/auth/sign_in/sign_in_cubit.dart'
    as _i366;
import 'package:imovie_app/presentation/ui/auth/sign_up/sign_up_cubit.dart'
    as _i800;
import 'package:imovie_app/presentation/ui/browse/browse_cubit.dart' as _i699;
import 'package:imovie_app/presentation/ui/call/active/active_call_cubit.dart'
    as _i880;
import 'package:imovie_app/presentation/ui/chat/list/chat_list_cubit.dart'
    as _i1000;
import 'package:imovie_app/presentation/ui/chat/thread/chat_thread_cubit.dart'
    as _i808;
import 'package:imovie_app/presentation/ui/community/compose/community_compose_cubit.dart'
    as _i606;
import 'package:imovie_app/presentation/ui/community/feed/community_cubit.dart'
    as _i464;
import 'package:imovie_app/presentation/ui/community/follow_list/community_follow_list_cubit.dart'
    as _i947;
import 'package:imovie_app/presentation/ui/community/post_detail/community_post_detail_cubit.dart'
    as _i690;
import 'package:imovie_app/presentation/ui/community/profile/community_profile_cubit.dart'
    as _i615;
import 'package:imovie_app/presentation/ui/community/story_editor/community_story_editor_cubit.dart'
    as _i324;
import 'package:imovie_app/presentation/ui/community/story_viewer/community_story_viewer_cubit.dart'
    as _i556;
import 'package:imovie_app/presentation/ui/genre_movies/genre_movies_cubit.dart'
    as _i118;
import 'package:imovie_app/presentation/ui/genres/genres_cubit.dart' as _i791;
import 'package:imovie_app/presentation/ui/home/home_cubit.dart' as _i445;
import 'package:imovie_app/presentation/ui/library/library_cubit.dart' as _i700;
import 'package:imovie_app/presentation/ui/main/main_cubit.dart' as _i396;
import 'package:imovie_app/presentation/ui/movie_detail/movie_detail_cubit.dart'
    as _i1010;
import 'package:imovie_app/presentation/ui/movie_list/movie_list_cubit.dart'
    as _i714;
import 'package:imovie_app/presentation/ui/movie_trailer/movie_trailer_cubit.dart'
    as _i711;
import 'package:imovie_app/presentation/ui/movie_watch/movie_watch_cubit.dart'
    as _i1054;
import 'package:imovie_app/presentation/ui/notifications/notification_center_cubit.dart'
    as _i254;
import 'package:imovie_app/presentation/ui/notifications/notifications_cubit.dart'
    as _i135;
import 'package:imovie_app/presentation/ui/profile/change_password/change_password_cubit.dart'
    as _i215;
import 'package:imovie_app/presentation/ui/profile/edit_profile/edit_profile_cubit.dart'
    as _i577;
import 'package:imovie_app/presentation/ui/profile/language/language_cubit.dart'
    as _i1014;
import 'package:imovie_app/presentation/ui/profile/settings/settings_cubit.dart'
    as _i237;
import 'package:imovie_app/presentation/ui/splash/splash_cubit.dart' as _i23;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appDiModule = _$AppDiModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => appDiModule.sharedPreferences,
      preResolve: true,
    );
    gh.factory<_i760.AgoraCallService>(() => appDiModule.agoraCallService);
    gh.lazySingleton<_i328.CallkitService>(() => appDiModule.callkitService);
    gh.lazySingleton<_i970.CallPermissionService>(
      () => appDiModule.callPermissionService,
    );
    gh.lazySingleton<_i962.CallProximityService>(
      () => appDiModule.callProximityService,
    );
    gh.lazySingleton<_i332.LocationService>(() => appDiModule.locationService);
    gh.factoryParam<_i1014.LanguageCubit, _i848.AppCubit, dynamic>(
      (appCubit, _) => appDiModule.languageCubit(appCubit),
    );
    gh.factoryParam<_i791.GenresCubit, List<_i263.HomeGenre>, dynamic>(
      (genres, _) => appDiModule.genresCubit(genres),
    );
    gh.factoryParam<_i711.MovieTrailerCubit, String, String>(
      (title, trailerUrl) => appDiModule.movieTrailerCubit(title, trailerUrl),
    );
    gh.lazySingleton<_i721.LocalStorageService>(
      () => appDiModule.localStorageService(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i1054.ApiClient>(
      () => appDiModule.apiClient(gh<_i638.AppBootstrap>()),
    );
    gh.lazySingleton<_i515.SupabaseAuthService>(
      () => appDiModule.supabaseAuthService(gh<_i638.AppBootstrap>()),
    );
    gh.lazySingleton<_i254.SupabaseDataService>(
      () => appDiModule.supabaseDataService(gh<_i638.AppBootstrap>()),
    );
    gh.lazySingleton<_i1054.SessionRemoteDataSource>(
      () =>
          appDiModule.sessionRemoteDataSource(gh<_i515.SupabaseAuthService>()),
    );
    gh.lazySingleton<_i12.CommunityRealtimeService>(
      () => appDiModule.communityRealtimeService(
        gh<_i638.AppBootstrap>(),
        gh<_i254.SupabaseDataService>(),
      ),
    );
    gh.lazySingleton<_i428.AgoraChatService>(
      () => appDiModule.agoraChatService(
        gh<_i638.AppBootstrap>(),
        gh<_i254.SupabaseDataService>(),
      ),
    );
    gh.lazySingleton<_i900.SessionRepository>(
      () => appDiModule.sessionRepository(
        gh<_i638.AppBootstrap>(),
        gh<_i1054.SessionRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i770.ProfileRemoteDataSource>(
      () =>
          appDiModule.profileRemoteDataSource(gh<_i254.SupabaseDataService>()),
    );
    gh.lazySingleton<_i874.LibraryRemoteDataSource>(
      () =>
          appDiModule.libraryRemoteDataSource(gh<_i254.SupabaseDataService>()),
    );
    gh.lazySingleton<_i956.CommunityRemoteDataSource>(
      () => appDiModule.communityRemoteDataSource(
        gh<_i254.SupabaseDataService>(),
      ),
    );
    gh.lazySingleton<_i137.CallRemoteDataSource>(
      () => appDiModule.callRemoteDataSource(gh<_i254.SupabaseDataService>()),
    );
    gh.lazySingleton<_i569.NotificationRemoteDataSource>(
      () => appDiModule.notificationRemoteDataSource(
        gh<_i254.SupabaseDataService>(),
      ),
    );
    gh.factory<_i53.GetCurrentSessionUseCase>(
      () => appDiModule.getCurrentSessionUseCase(gh<_i900.SessionRepository>()),
    );
    gh.factory<_i223.ChangePasswordUseCase>(
      () => appDiModule.changePasswordUseCase(gh<_i900.SessionRepository>()),
    );
    gh.factory<_i871.SignInWithPasswordUseCase>(
      () =>
          appDiModule.signInWithPasswordUseCase(gh<_i900.SessionRepository>()),
    );
    gh.factory<_i229.SignUpWithPasswordUseCase>(
      () =>
          appDiModule.signUpWithPasswordUseCase(gh<_i900.SessionRepository>()),
    );
    gh.factory<_i738.ResetPasswordForEmailUseCase>(
      () => appDiModule.resetPasswordForEmailUseCase(
        gh<_i900.SessionRepository>(),
      ),
    );
    gh.factory<_i678.SignOutUseCase>(
      () => appDiModule.signOutUseCase(gh<_i900.SessionRepository>()),
    );
    gh.lazySingleton<_i802.NotificationRepository>(
      () => appDiModule.notificationRepository(
        gh<_i638.AppBootstrap>(),
        gh<_i569.NotificationRemoteDataSource>(),
      ),
    );
    gh.factory<_i739.GetNotificationsUseCase>(
      () => appDiModule.getNotificationsUseCase(
        gh<_i802.NotificationRepository>(),
      ),
    );
    gh.factory<_i748.GetUnreadNotificationCountUseCase>(
      () => appDiModule.getUnreadNotificationCountUseCase(
        gh<_i802.NotificationRepository>(),
      ),
    );
    gh.factory<_i814.MarkNotificationReadUseCase>(
      () => appDiModule.markNotificationReadUseCase(
        gh<_i802.NotificationRepository>(),
      ),
    );
    gh.factory<_i551.MarkAllNotificationsReadUseCase>(
      () => appDiModule.markAllNotificationsReadUseCase(
        gh<_i802.NotificationRepository>(),
      ),
    );
    gh.factory<_i682.WatchNotificationsUseCase>(
      () => appDiModule.watchNotificationsUseCase(
        gh<_i802.NotificationRepository>(),
      ),
    );
    gh.lazySingleton<_i247.HomeRemoteDataSource>(
      () => appDiModule.homeRemoteDataSource(gh<_i1054.ApiClient>()),
    );
    gh.lazySingleton<_i671.MovieDetailRemoteDataSource>(
      () => appDiModule.movieDetailRemoteDataSource(gh<_i1054.ApiClient>()),
    );
    gh.lazySingleton<_i628.ProfileRepository>(
      () => appDiModule.profileRepository(
        gh<_i638.AppBootstrap>(),
        gh<_i770.ProfileRemoteDataSource>(),
        gh<_i721.LocalStorageService>(),
      ),
    );
    gh.lazySingleton<_i3.HomeRepository>(
      () => appDiModule.homeRepository(gh<_i247.HomeRemoteDataSource>()),
    );
    gh.factory<_i366.SignInCubit>(
      () => appDiModule.signInCubit(gh<_i871.SignInWithPasswordUseCase>()),
    );
    gh.lazySingleton<_i629.ChatRemoteDataSource>(
      () => appDiModule.chatRemoteDataSource(
        gh<_i254.SupabaseDataService>(),
        gh<_i428.AgoraChatService>(),
      ),
    );
    gh.factory<_i699.GetCachedProfileUseCase>(
      () => appDiModule.getCachedProfileUseCase(gh<_i628.ProfileRepository>()),
    );
    gh.factory<_i545.GetCurrentProfileUseCase>(
      () => appDiModule.getCurrentProfileUseCase(gh<_i628.ProfileRepository>()),
    );
    gh.factory<_i34.ClearCachedProfileUseCase>(
      () =>
          appDiModule.clearCachedProfileUseCase(gh<_i628.ProfileRepository>()),
    );
    gh.factory<_i905.UpdateProfileUseCase>(
      () => appDiModule.updateProfileUseCase(gh<_i628.ProfileRepository>()),
    );
    gh.factory<_i811.UpdateProfileAvatarUseCase>(
      () =>
          appDiModule.updateProfileAvatarUseCase(gh<_i628.ProfileRepository>()),
    );
    gh.factory<_i5.UpdateProfileCoverUseCase>(
      () =>
          appDiModule.updateProfileCoverUseCase(gh<_i628.ProfileRepository>()),
    );
    gh.factory<_i23.SplashCubit>(
      () => appDiModule.splashCubit(gh<_i53.GetCurrentSessionUseCase>()),
    );
    gh.lazySingleton<_i234.CallRepository>(
      () => appDiModule.callRepository(
        gh<_i638.AppBootstrap>(),
        gh<_i137.CallRemoteDataSource>(),
      ),
    );
    gh.factory<_i800.SignUpCubit>(
      () => appDiModule.signUpCubit(gh<_i229.SignUpWithPasswordUseCase>()),
    );
    gh.factory<_i135.NotificationsCubit>(
      () => appDiModule.notificationsCubit(
        gh<_i739.GetNotificationsUseCase>(),
        gh<_i814.MarkNotificationReadUseCase>(),
        gh<_i551.MarkAllNotificationsReadUseCase>(),
      ),
    );
    gh.factory<_i848.AppCubit>(
      () => appDiModule.appCubit(
        gh<_i53.GetCurrentSessionUseCase>(),
        gh<_i721.LocalStorageService>(),
      ),
    );
    gh.lazySingleton<_i863.LibraryRepository>(
      () => appDiModule.libraryRepository(
        gh<_i638.AppBootstrap>(),
        gh<_i874.LibraryRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i254.NotificationCenterCubit>(
      () => appDiModule.notificationCenterCubit(
        gh<_i748.GetUnreadNotificationCountUseCase>(),
        gh<_i682.WatchNotificationsUseCase>(),
      ),
      dispose: _i186.disposeNotificationCenterCubit,
    );
    gh.factory<_i215.ChangePasswordCubit>(
      () => appDiModule.changePasswordCubit(gh<_i223.ChangePasswordUseCase>()),
    );
    gh.lazySingleton<_i873.MovieDetailRepository>(
      () => appDiModule.movieDetailRepository(
        gh<_i671.MovieDetailRemoteDataSource>(),
      ),
    );
    gh.factory<_i852.GetLibraryMoviesUseCase>(
      () => appDiModule.getLibraryMoviesUseCase(gh<_i863.LibraryRepository>()),
    );
    gh.factory<_i299.AddMovieToLibraryUseCase>(
      () => appDiModule.addMovieToLibraryUseCase(gh<_i863.LibraryRepository>()),
    );
    gh.factory<_i323.RemoveMovieFromLibraryUseCase>(
      () => appDiModule.removeMovieFromLibraryUseCase(
        gh<_i863.LibraryRepository>(),
      ),
    );
    gh.lazySingleton<_i911.CommunityRepository>(
      () => appDiModule.communityRepository(
        gh<_i638.AppBootstrap>(),
        gh<_i956.CommunityRemoteDataSource>(),
      ),
    );
    gh.factory<_i214.ForgotPasswordCubit>(
      () => appDiModule.forgotPasswordCubit(
        gh<_i738.ResetPasswordForEmailUseCase>(),
      ),
    );
    gh.lazySingleton<_i396.MainCubit>(
      () => appDiModule.mainCubit(
        gh<_i53.GetCurrentSessionUseCase>(),
        gh<_i545.GetCurrentProfileUseCase>(),
        gh<_i699.GetCachedProfileUseCase>(),
        gh<_i34.ClearCachedProfileUseCase>(),
        gh<_i678.SignOutUseCase>(),
      ),
      dispose: _i186.disposeMainCubit,
    );
    gh.factory<_i792.GetMovieDetailUseCase>(
      () =>
          appDiModule.getMovieDetailUseCase(gh<_i873.MovieDetailRepository>()),
    );
    gh.factory<_i301.StartCallUseCase>(
      () => appDiModule.startCallUseCase(gh<_i234.CallRepository>()),
    );
    gh.factory<_i11.AnswerCallUseCase>(
      () => appDiModule.answerCallUseCase(gh<_i234.CallRepository>()),
    );
    gh.factory<_i1071.DeclineCallUseCase>(
      () => appDiModule.declineCallUseCase(gh<_i234.CallRepository>()),
    );
    gh.factory<_i39.EndCallUseCase>(
      () => appDiModule.endCallUseCase(gh<_i234.CallRepository>()),
    );
    gh.factory<_i1002.GetCallUseCase>(
      () => appDiModule.getCallUseCase(gh<_i234.CallRepository>()),
    );
    gh.factory<_i799.WatchCallUseCase>(
      () => appDiModule.watchCallUseCase(gh<_i234.CallRepository>()),
    );
    gh.factory<_i671.GetHomeFeedUseCase>(
      () => appDiModule.getHomeFeedUseCase(gh<_i3.HomeRepository>()),
    );
    gh.factory<_i694.GetHomeGenresUseCase>(
      () => appDiModule.getHomeGenresUseCase(gh<_i3.HomeRepository>()),
    );
    gh.factory<_i57.GetCountriesUseCase>(
      () => appDiModule.getCountriesUseCase(gh<_i3.HomeRepository>()),
    );
    gh.factory<_i887.GetGenreMoviesUseCase>(
      () => appDiModule.getGenreMoviesUseCase(gh<_i3.HomeRepository>()),
    );
    gh.factory<_i209.GetMovieListUseCase>(
      () => appDiModule.getMovieListUseCase(gh<_i3.HomeRepository>()),
    );
    gh.factory<_i40.SearchMoviesUseCase>(
      () => appDiModule.searchMoviesUseCase(gh<_i3.HomeRepository>()),
    );
    gh.factory<_i890.GetCommunityStoriesUseCase>(
      () => appDiModule.getCommunityStoriesUseCase(
        gh<_i911.CommunityRepository>(),
      ),
    );
    gh.factory<_i869.GetCommunityFollowedUserIdsUseCase>(
      () => appDiModule.getCommunityFollowedUserIdsUseCase(
        gh<_i911.CommunityRepository>(),
      ),
    );
    gh.factory<_i205.GetCommunityProfileUseCase>(
      () => appDiModule.getCommunityProfileUseCase(
        gh<_i911.CommunityRepository>(),
      ),
    );
    gh.factory<_i484.GetCommunityFollowersUseCase>(
      () => appDiModule.getCommunityFollowersUseCase(
        gh<_i911.CommunityRepository>(),
      ),
    );
    gh.factory<_i222.GetCommunityFollowingUseCase>(
      () => appDiModule.getCommunityFollowingUseCase(
        gh<_i911.CommunityRepository>(),
      ),
    );
    gh.factory<_i1006.FollowCommunityUserUseCase>(
      () => appDiModule.followCommunityUserUseCase(
        gh<_i911.CommunityRepository>(),
      ),
    );
    gh.factory<_i879.UnfollowCommunityUserUseCase>(
      () => appDiModule.unfollowCommunityUserUseCase(
        gh<_i911.CommunityRepository>(),
      ),
    );
    gh.factory<_i657.GetCommunityStoryByIdUseCase>(
      () => appDiModule.getCommunityStoryByIdUseCase(
        gh<_i911.CommunityRepository>(),
      ),
    );
    gh.factory<_i770.CreateCommunityStoryUseCase>(
      () => appDiModule.createCommunityStoryUseCase(
        gh<_i911.CommunityRepository>(),
      ),
    );
    gh.factory<_i606.DeleteCommunityStoryUseCase>(
      () => appDiModule.deleteCommunityStoryUseCase(
        gh<_i911.CommunityRepository>(),
      ),
    );
    gh.factory<_i469.GetCommunityPostByIdUseCase>(
      () => appDiModule.getCommunityPostByIdUseCase(
        gh<_i911.CommunityRepository>(),
      ),
    );
    gh.factory<_i922.GetCommunityPostsUseCase>(
      () =>
          appDiModule.getCommunityPostsUseCase(gh<_i911.CommunityRepository>()),
    );
    gh.factory<_i928.CreateCommunityPostUseCase>(
      () => appDiModule.createCommunityPostUseCase(
        gh<_i911.CommunityRepository>(),
      ),
    );
    gh.factory<_i861.UpdateCommunityPostUseCase>(
      () => appDiModule.updateCommunityPostUseCase(
        gh<_i911.CommunityRepository>(),
      ),
    );
    gh.factory<_i420.DeleteCommunityPostUseCase>(
      () => appDiModule.deleteCommunityPostUseCase(
        gh<_i911.CommunityRepository>(),
      ),
    );
    gh.factory<_i218.GetCommunityCommentsUseCase>(
      () => appDiModule.getCommunityCommentsUseCase(
        gh<_i911.CommunityRepository>(),
      ),
    );
    gh.factory<_i456.AddCommunityCommentUseCase>(
      () => appDiModule.addCommunityCommentUseCase(
        gh<_i911.CommunityRepository>(),
      ),
    );
    gh.factory<_i926.ToggleCommunityReactionUseCase>(
      () => appDiModule.toggleCommunityReactionUseCase(
        gh<_i911.CommunityRepository>(),
      ),
    );
    gh.factory<_i700.LibraryCubit>(
      () => appDiModule.libraryCubit(
        gh<_i852.GetLibraryMoviesUseCase>(),
        gh<_i323.RemoveMovieFromLibraryUseCase>(),
      ),
    );
    gh.lazySingleton<_i385.ChatRepository>(
      () => appDiModule.chatRepository(
        gh<_i638.AppBootstrap>(),
        gh<_i629.ChatRemoteDataSource>(),
      ),
    );
    gh.factoryParam<_i464.CommunityCubit, bool, dynamic>(
      (mineOnly, _) => appDiModule.communityCubit(
        mineOnly,
        gh<_i254.SupabaseDataService>(),
        gh<_i869.GetCommunityFollowedUserIdsUseCase>(),
        gh<_i890.GetCommunityStoriesUseCase>(),
        gh<_i606.DeleteCommunityStoryUseCase>(),
        gh<_i469.GetCommunityPostByIdUseCase>(),
        gh<_i922.GetCommunityPostsUseCase>(),
        gh<_i420.DeleteCommunityPostUseCase>(),
        gh<_i926.ToggleCommunityReactionUseCase>(),
        gh<_i218.GetCommunityCommentsUseCase>(),
        gh<_i456.AddCommunityCommentUseCase>(),
      ),
    );
    gh.factory<_i162.GetChatConversationsUseCase>(
      () => appDiModule.getChatConversationsUseCase(gh<_i385.ChatRepository>()),
    );
    gh.factory<_i337.GetOrCreateDirectConversationUseCase>(
      () => appDiModule.getOrCreateDirectConversationUseCase(
        gh<_i385.ChatRepository>(),
      ),
    );
    gh.factory<_i1015.GetChatMessagesUseCase>(
      () => appDiModule.getChatMessagesUseCase(gh<_i385.ChatRepository>()),
    );
    gh.factory<_i1059.SendChatMessageUseCase>(
      () => appDiModule.sendChatMessageUseCase(gh<_i385.ChatRepository>()),
    );
    gh.factory<_i395.SendChatImageUseCase>(
      () => appDiModule.sendChatImageUseCase(gh<_i385.ChatRepository>()),
    );
    gh.factory<_i1013.RecallChatMessageUseCase>(
      () => appDiModule.recallChatMessageUseCase(gh<_i385.ChatRepository>()),
    );
    gh.factory<_i921.ToggleChatReactionUseCase>(
      () => appDiModule.toggleChatReactionUseCase(gh<_i385.ChatRepository>()),
    );
    gh.factory<_i925.MarkChatConversationReadUseCase>(
      () => appDiModule.markChatConversationReadUseCase(
        gh<_i385.ChatRepository>(),
      ),
    );
    gh.factory<_i368.WatchChatConversationsUseCase>(
      () =>
          appDiModule.watchChatConversationsUseCase(gh<_i385.ChatRepository>()),
    );
    gh.factory<_i969.WatchChatMessagesUseCase>(
      () => appDiModule.watchChatMessagesUseCase(gh<_i385.ChatRepository>()),
    );
    gh.factory<_i699.BrowseCubit>(
      () => appDiModule.browseCubit(
        gh<_i671.GetHomeFeedUseCase>(),
        gh<_i694.GetHomeGenresUseCase>(),
        gh<_i57.GetCountriesUseCase>(),
        gh<_i40.SearchMoviesUseCase>(),
      ),
    );
    gh.factoryParam<_i606.CommunityComposeCubit, _i766.CommunityPost?, dynamic>(
      (initialPost, _) => appDiModule.communityComposeCubit(
        initialPost,
        gh<_i928.CreateCommunityPostUseCase>(),
        gh<_i861.UpdateCommunityPostUseCase>(),
        gh<_i40.SearchMoviesUseCase>(),
        gh<_i332.LocationService>(),
      ),
    );
    gh.factory<_i577.EditProfileCubit>(
      () => appDiModule.editProfileCubit(
        gh<_i396.MainCubit>(),
        gh<_i699.GetCachedProfileUseCase>(),
        gh<_i905.UpdateProfileUseCase>(),
        gh<_i811.UpdateProfileAvatarUseCase>(),
        gh<_i5.UpdateProfileCoverUseCase>(),
      ),
    );
    gh.factory<_i445.HomeCubit>(
      () => appDiModule.homeCubit(
        gh<_i671.GetHomeFeedUseCase>(),
        gh<_i694.GetHomeGenresUseCase>(),
        gh<_i209.GetMovieListUseCase>(),
        gh<_i792.GetMovieDetailUseCase>(),
      ),
    );
    gh.factoryParam<_i118.GenreMoviesCubit, String, String>(
      (slug, title) => appDiModule.genreMoviesCubit(
        slug,
        title,
        gh<_i887.GetGenreMoviesUseCase>(),
        gh<_i57.GetCountriesUseCase>(),
      ),
    );
    gh.factoryParam<_i1010.MovieDetailCubit, String, List<dynamic>?>(
      (slug, relatedMovies) => appDiModule.movieDetailCubit(
        slug,
        relatedMovies,
        gh<_i792.GetMovieDetailUseCase>(),
        gh<_i299.AddMovieToLibraryUseCase>(),
      ),
    );
    gh.factory<_i1000.ChatListCubit>(
      () => appDiModule.chatListCubit(
        gh<_i162.GetChatConversationsUseCase>(),
        gh<_i368.WatchChatConversationsUseCase>(),
      ),
    );
    gh.factory<_i324.CommunityStoryEditorCubit>(
      () => appDiModule.communityStoryEditorCubit(
        gh<_i770.CreateCommunityStoryUseCase>(),
        gh<_i40.SearchMoviesUseCase>(),
        gh<_i332.LocationService>(),
      ),
    );
    gh.factoryParam<_i714.MovieListCubit, String, String>(
      (slug, title) => appDiModule.movieListCubit(
        slug,
        title,
        gh<_i209.GetMovieListUseCase>(),
      ),
    );
    gh.factoryParam<_i556.CommunityStoryViewerCubit, String, dynamic>(
      (storyId, _) => appDiModule.communityStoryViewerCubit(
        storyId,
        gh<_i254.SupabaseDataService>(),
        gh<_i657.GetCommunityStoryByIdUseCase>(),
        gh<_i890.GetCommunityStoriesUseCase>(),
        gh<_i606.DeleteCommunityStoryUseCase>(),
      ),
    );
    gh.factoryParam<_i880.ActiveCallCubit, _i895.CallSession, dynamic>(
      (call, _) => appDiModule.activeCallCubit(
        call,
        gh<_i760.AgoraCallService>(),
        gh<_i328.CallkitService>(),
        gh<_i970.CallPermissionService>(),
        gh<_i962.CallProximityService>(),
        gh<_i39.EndCallUseCase>(),
        gh<_i799.WatchCallUseCase>(),
      ),
    );
    gh.factoryParam<_i808.ChatThreadCubit, String, String>(
      (conversationId, title) => appDiModule.chatThreadCubit(
        conversationId,
        title,
        gh<_i1015.GetChatMessagesUseCase>(),
        gh<_i1059.SendChatMessageUseCase>(),
        gh<_i395.SendChatImageUseCase>(),
        gh<_i1013.RecallChatMessageUseCase>(),
        gh<_i921.ToggleChatReactionUseCase>(),
        gh<_i925.MarkChatConversationReadUseCase>(),
        gh<_i969.WatchChatMessagesUseCase>(),
        gh<_i301.StartCallUseCase>(),
      ),
    );
    gh.factoryParam<_i1054.MovieWatchCubit, String, _i1057.MovieDetail?>(
      (slug, initialDetail) => appDiModule.movieWatchCubit(
        slug,
        initialDetail,
        gh<_i792.GetMovieDetailUseCase>(),
      ),
    );
    gh.lazySingleton<_i911.PushNotificationService>(
      () => appDiModule.pushNotificationService(
        gh<_i638.AppBootstrap>(),
        gh<_i254.SupabaseDataService>(),
        gh<_i328.CallkitService>(),
        gh<_i11.AnswerCallUseCase>(),
        gh<_i1071.DeclineCallUseCase>(),
      ),
    );
    gh.factoryParam<_i947.CommunityFollowListCubit, String, String>(
      (userId, typeSlug) => appDiModule.communityFollowListCubit(
        userId,
        typeSlug,
        gh<_i484.GetCommunityFollowersUseCase>(),
        gh<_i222.GetCommunityFollowingUseCase>(),
      ),
    );
    gh.factory<_i237.SettingsCubit>(
      () => appDiModule.settingsCubit(
        gh<_i396.MainCubit>(),
        gh<_i699.GetCachedProfileUseCase>(),
        gh<_i205.GetCommunityProfileUseCase>(),
      ),
    );
    gh.factoryParam<_i615.CommunityProfileCubit, String, dynamic>(
      (userId, _) => appDiModule.communityProfileCubit(
        userId,
        gh<_i254.SupabaseDataService>(),
        gh<_i205.GetCommunityProfileUseCase>(),
        gh<_i337.GetOrCreateDirectConversationUseCase>(),
        gh<_i1006.FollowCommunityUserUseCase>(),
        gh<_i879.UnfollowCommunityUserUseCase>(),
        gh<_i890.GetCommunityStoriesUseCase>(),
        gh<_i606.DeleteCommunityStoryUseCase>(),
        gh<_i469.GetCommunityPostByIdUseCase>(),
        gh<_i922.GetCommunityPostsUseCase>(),
        gh<_i420.DeleteCommunityPostUseCase>(),
        gh<_i926.ToggleCommunityReactionUseCase>(),
        gh<_i218.GetCommunityCommentsUseCase>(),
        gh<_i456.AddCommunityCommentUseCase>(),
      ),
    );
    gh.factoryParam<_i690.CommunityPostDetailCubit, String, dynamic>(
      (postId, _) => appDiModule.communityPostDetailCubit(
        postId,
        gh<_i254.SupabaseDataService>(),
        gh<_i469.GetCommunityPostByIdUseCase>(),
        gh<_i926.ToggleCommunityReactionUseCase>(),
        gh<_i218.GetCommunityCommentsUseCase>(),
        gh<_i456.AddCommunityCommentUseCase>(),
        gh<_i420.DeleteCommunityPostUseCase>(),
      ),
    );
    return this;
  }
}

class _$AppDiModule extends _i186.AppDiModule {}
