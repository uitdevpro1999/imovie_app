import 'package:get_it/get_it.dart';
import 'package:imovie_app/config/flavors/app_bootstrap.dart';
import 'package:imovie_app/core/services/api_client.dart';
import 'package:imovie_app/core/services/supabase_auth_service.dart';
import 'package:imovie_app/data/datasources/home/home_remote_data_source.dart';
import 'package:imovie_app/data/datasources/movie_detail/movie_detail_remote_data_source.dart';
import 'package:imovie_app/data/datasources/profile/profile_remote_data_source.dart';
import 'package:imovie_app/data/datasources/session/session_remote_data_source.dart';
import 'package:imovie_app/data/repositories/home/home_repository_impl.dart';
import 'package:imovie_app/data/repositories/movie_detail/movie_detail_repository_impl.dart';
import 'package:imovie_app/data/repositories/profile/profile_repository_impl.dart';
import 'package:imovie_app/data/repositories/session/session_repository_impl.dart';
import 'package:imovie_app/domain/entities/home/home_movie.dart';
import 'package:imovie_app/domain/entities/movie_detail/movie_detail.dart';
import 'package:imovie_app/domain/repositories/home_repository.dart';
import 'package:imovie_app/domain/repositories/movie_detail_repository.dart';
import 'package:imovie_app/domain/repositories/profile_repository.dart';
import 'package:imovie_app/domain/repositories/session_repository.dart';
import 'package:imovie_app/domain/usecases/get_current_session_use_case.dart';
import 'package:imovie_app/domain/usecases/home/get_countries_use_case.dart';
import 'package:imovie_app/domain/usecases/home/get_genre_movies_use_case.dart';
import 'package:imovie_app/domain/usecases/home/get_home_feed_use_case.dart';
import 'package:imovie_app/domain/usecases/home/get_home_genres_use_case.dart';
import 'package:imovie_app/domain/usecases/home/search_movies_use_case.dart';
import 'package:imovie_app/domain/usecases/movie_detail/get_movie_detail_use_case.dart';
import 'package:imovie_app/domain/usecases/profile/get_current_profile_use_case.dart';
import 'package:imovie_app/domain/usecases/profile/update_profile_avatar_use_case.dart';
import 'package:imovie_app/domain/usecases/profile/update_profile_use_case.dart';
import 'package:imovie_app/domain/usecases/session/sign_in_with_password_use_case.dart';
import 'package:imovie_app/domain/usecases/session/sign_out_use_case.dart';
import 'package:imovie_app/domain/usecases/session/sign_up_with_password_use_case.dart';
import 'package:imovie_app/domain/usecases/session/reset_password_for_email_use_case.dart';
import 'package:imovie_app/presentation/app/app_cubit.dart';
import 'package:imovie_app/presentation/ui/auth/auth_cubit.dart';
import 'package:imovie_app/presentation/ui/auth/auth_state.dart';
import 'package:imovie_app/presentation/ui/auth/forgot_password_cubit.dart';
import 'package:imovie_app/presentation/ui/browse/browse_cubit.dart';
import 'package:imovie_app/presentation/ui/genre_movies/genre_movies_cubit.dart';
import 'package:imovie_app/presentation/ui/home/home_cubit.dart';
import 'package:imovie_app/presentation/ui/movie_detail/movie_detail_cubit.dart';
import 'package:imovie_app/presentation/ui/movie_watch/movie_watch_cubit.dart';
import 'package:imovie_app/presentation/ui/profile/profile_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final GetIt sl = GetIt.instance;

Future<void> configureDependencies({required AppBootstrap bootstrap}) async {
  await sl.reset();

  sl.registerSingleton<AppBootstrap>(bootstrap);
  sl.registerLazySingleton<ApiClient>(
    () => DioApiClient(baseUrl: bootstrap.environment.ophimApiBaseUrl),
  );
  sl.registerLazySingleton<SupabaseAuthService>(
    () => bootstrap.isSupabaseReady
        ? ConfiguredSupabaseAuthService(client: Supabase.instance.client)
        : const UnconfiguredSupabaseAuthService(),
  );
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => buildHomeRemoteDataSource(sl()),
  );
  sl.registerLazySingleton<SessionRemoteDataSource>(
    () => SupabaseSessionRemoteDataSource(authService: sl()),
  );
  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => bootstrap.isSupabaseReady
        ? SupabaseProfileRemoteDataSource(client: Supabase.instance.client)
        : const UnconfiguredProfileRemoteDataSource(),
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
  sl.registerLazySingleton<SessionRepository>(
    () => SessionRepositoryImpl(bootstrap: sl(), remoteDataSource: sl()),
  );
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(bootstrap: sl(), remoteDataSource: sl()),
  );

  sl.registerFactory(() => GetCurrentSessionUseCase(sl()));
  sl.registerFactory(() => GetHomeFeedUseCase(sl()));
  sl.registerFactory(() => GetHomeGenresUseCase(sl()));
  sl.registerFactory(() => GetCountriesUseCase(sl()));
  sl.registerFactory(() => GetGenreMoviesUseCase(sl()));
  sl.registerFactory(() => SearchMoviesUseCase(sl()));
  sl.registerFactory(() => GetMovieDetailUseCase(sl()));
  sl.registerFactory(() => GetCurrentProfileUseCase(sl()));
  sl.registerFactory(() => UpdateProfileUseCase(sl()));
  sl.registerFactory(() => UpdateProfileAvatarUseCase(sl()));
  sl.registerFactory(() => SignInWithPasswordUseCase(sl()));
  sl.registerFactory(() => SignUpWithPasswordUseCase(sl()));
  sl.registerFactory(() => ResetPasswordForEmailUseCase(sl()));
  sl.registerFactory(() => SignOutUseCase(sl()));
  sl.registerFactory(() => AppCubit(getCurrentSessionUseCase: sl()));
  sl.registerFactory(
    () => HomeCubit(getHomeFeedUseCase: sl(), getHomeGenresUseCase: sl()),
  );
  sl.registerFactory(
    () => BrowseCubit(
      getHomeFeedUseCase: sl(),
      getHomeGenresUseCase: sl(),
      searchMoviesUseCase: sl(),
    ),
  );
  sl.registerFactoryParam<AuthCubit, AuthMode, void>(
    (mode, _) => AuthCubit(
      mode: mode,
      signInWithPasswordUseCase: sl(),
      signUpWithPasswordUseCase: sl(),
    ),
  );
  sl.registerFactory(
    () => ForgotPasswordCubit(resetPasswordForEmailUseCase: sl()),
  );
  sl.registerFactoryParam<MovieDetailCubit, String, List<dynamic>?>(
    (slug, relatedMovies) => MovieDetailCubit(
      getMovieDetailUseCase: sl(),
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
  sl.registerFactoryParam<MovieWatchCubit, String, MovieDetail?>(
    (slug, initialDetail) => MovieWatchCubit(
      getMovieDetailUseCase: sl(),
      slug: slug,
      initialDetail: initialDetail,
    ),
  );
  sl.registerFactory(
    () => ProfileCubit(
      getCurrentSessionUseCase: sl(),
      getCurrentProfileUseCase: sl(),
      updateProfileUseCase: sl(),
      updateProfileAvatarUseCase: sl(),
      signOutUseCase: sl(),
    ),
  );
}
