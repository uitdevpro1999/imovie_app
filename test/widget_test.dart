import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imovie_app/config/flavors/app_bootstrap.dart';
import 'package:imovie_app/config/flavors/app_environment.dart';
import 'package:imovie_app/config/navigation/app_router.dart';
import 'package:imovie_app/core/di/service_locator.dart';
import 'package:imovie_app/core/result/result.dart';
import 'package:imovie_app/data/datasources/home/home_remote_data_source.dart';
import 'package:imovie_app/data/datasources/movie_detail/movie_detail_remote_data_source.dart';
import 'package:imovie_app/data/repositories/home/home_repository_impl.dart';
import 'package:imovie_app/data/repositories/movie_detail/movie_detail_repository_impl.dart';
import 'package:imovie_app/domain/entities/library/library_movie.dart';
import 'package:imovie_app/domain/entities/movie_detail/movie_detail.dart';
import 'package:imovie_app/domain/entities/session/app_session.dart';
import 'package:imovie_app/domain/repositories/home_repository.dart';
import 'package:imovie_app/domain/repositories/library_repository.dart';
import 'package:imovie_app/domain/repositories/movie_detail_repository.dart';
import 'package:imovie_app/domain/repositories/session_repository.dart';
import 'package:imovie_app/domain/usecases/get_current_session_use_case.dart';
import 'package:imovie_app/domain/usecases/home/get_home_feed_use_case.dart';
import 'package:imovie_app/domain/usecases/home/get_home_genres_use_case.dart';
import 'package:imovie_app/domain/usecases/home/get_movie_list_use_case.dart';
import 'package:imovie_app/domain/usecases/library/add_movie_to_library_use_case.dart';
import 'package:imovie_app/domain/usecases/library/get_library_movies_use_case.dart';
import 'package:imovie_app/domain/usecases/library/remove_movie_from_library_use_case.dart';
import 'package:imovie_app/domain/usecases/movie_detail/get_movie_detail_use_case.dart';
import 'package:imovie_app/l10n/app_localizations.dart';
import 'package:imovie_app/l10n/app_localizations_vi.dart';
import 'package:imovie_app/presentation/app/app.dart';
import 'package:imovie_app/presentation/ui/home/home_cubit.dart';
import 'package:imovie_app/presentation/ui/library/widgets/library_content_view.dart';
import 'package:imovie_app/presentation/ui/movie_detail/movie_detail_cubit.dart';
import 'package:imovie_app/presentation/ui/movie_detail/movie_detail_page.dart';
import 'package:imovie_app/presentation/ui/movie_watch/movie_watch_cubit.dart';
import 'package:imovie_app/presentation/ui/movie_watch/movie_watch_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await configureDependencies(
      bootstrap: const AppBootstrap(
        environment: AppEnvironment(
          supabaseUrl: '',
          supabaseAnonKey: '',
          ophimApiBaseUrl: 'https://ophim1.com/v1/api/',
        ),
      ),
    );

    if (sl.isRegistered<HomeRemoteDataSource>()) {
      await sl.unregister<HomeRemoteDataSource>();
    }
    if (sl.isRegistered<HomeRepository>()) {
      await sl.unregister<HomeRepository>();
    }
    if (sl.isRegistered<MovieDetailRemoteDataSource>()) {
      await sl.unregister<MovieDetailRemoteDataSource>();
    }
    if (sl.isRegistered<MovieDetailRepository>()) {
      await sl.unregister<MovieDetailRepository>();
    }
    if (sl.isRegistered<LibraryRepository>()) {
      await sl.unregister<LibraryRepository>();
    }
    if (sl.isRegistered<SessionRepository>()) {
      await sl.unregister<SessionRepository>();
    }
    if (sl.isRegistered<GetHomeFeedUseCase>()) {
      await sl.unregister<GetHomeFeedUseCase>();
    }
    if (sl.isRegistered<GetHomeGenresUseCase>()) {
      await sl.unregister<GetHomeGenresUseCase>();
    }
    if (sl.isRegistered<GetMovieListUseCase>()) {
      await sl.unregister<GetMovieListUseCase>();
    }
    if (sl.isRegistered<GetMovieDetailUseCase>()) {
      await sl.unregister<GetMovieDetailUseCase>();
    }
    if (sl.isRegistered<GetLibraryMoviesUseCase>()) {
      await sl.unregister<GetLibraryMoviesUseCase>();
    }
    if (sl.isRegistered<AddMovieToLibraryUseCase>()) {
      await sl.unregister<AddMovieToLibraryUseCase>();
    }
    if (sl.isRegistered<RemoveMovieFromLibraryUseCase>()) {
      await sl.unregister<RemoveMovieFromLibraryUseCase>();
    }
    if (sl.isRegistered<GetCurrentSessionUseCase>()) {
      await sl.unregister<GetCurrentSessionUseCase>();
    }
    if (sl.isRegistered<HomeCubit>()) {
      await sl.unregister<HomeCubit>();
    }

    sl.registerLazySingleton<HomeRemoteDataSource>(
      () => const FakeHomeRemoteDataSource(),
    );
    sl.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(remoteDataSource: sl()),
    );
    sl.registerLazySingleton<MovieDetailRemoteDataSource>(
      () => const FakeMovieDetailRemoteDataSource(),
    );
    sl.registerLazySingleton<MovieDetailRepository>(
      () => MovieDetailRepositoryImpl(remoteDataSource: sl()),
    );
    sl.registerLazySingleton<LibraryRepository>(() => FakeLibraryRepository());
    sl.registerLazySingleton<SessionRepository>(
      () => const FakeSessionRepository.authenticated(),
    );
    sl.registerFactory(() => GetHomeFeedUseCase(sl()));
    sl.registerFactory(() => GetHomeGenresUseCase(sl()));
    sl.registerFactory(() => GetMovieListUseCase(sl()));
    sl.registerFactory(() => GetMovieDetailUseCase(sl()));
    sl.registerFactory(() => GetLibraryMoviesUseCase(sl()));
    sl.registerFactory(() => AddMovieToLibraryUseCase(sl()));
    sl.registerFactory(() => RemoveMovieFromLibraryUseCase(sl()));
    sl.registerFactory(() => GetCurrentSessionUseCase(sl()));
    sl.registerFactory(
      () => HomeCubit(
        getHomeFeedUseCase: sl(),
        getHomeGenresUseCase: sl(),
        getMovieListUseCase: sl(),
      ),
    );
    await appRouter.replaceAll([const AppSplashRoute()]);
  });

  tearDown(() async {
    await sl.reset();
  });

  testWidgets('renders home screen from Figma and home API mapping', (
    WidgetTester tester,
  ) async {
    final l10n = AppLocalizationsVi();

    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();

    expect(find.text(l10n.homeBadgeAdFree), findsOneWidget);
    expect(find.text(l10n.homeSectionFreshUpdates), findsAtLeastNWidgets(1));
    expect(find.byType(PageView), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text(l10n.homeSectionHighestRated),
      300,
      scrollable: _verticalScrollable(),
    );
    expect(find.text(l10n.homeSectionHighestRated), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text(l10n.homeSectionSeriesSpotlight),
      300,
      scrollable: _verticalScrollable(),
    );
    expect(find.text(l10n.homeSectionSeriesSpotlight), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text(l10n.homeSectionTvShows),
      300,
      scrollable: _verticalScrollable(),
    );
    expect(find.text(l10n.homeSectionTvShows), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text(l10n.homeSectionUpcoming),
      300,
      scrollable: _verticalScrollable(),
    );
    expect(find.text(l10n.homeSectionUpcoming), findsOneWidget);
    expect(find.text(l10n.homeSectionTopThisWeek), findsNothing);
    expect(find.text(l10n.homeBottomNavHome), findsOneWidget);
    expect(find.text(l10n.homeBottomNavBrowse), findsOneWidget);
  });

  testWidgets('keeps splash visible for 3 seconds before auth redirect', (
    WidgetTester tester,
  ) async {
    final l10n = AppLocalizationsVi();

    await tester.pumpWidget(const App());
    await tester.pump();

    expect(find.text('iMovie'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 2900));

    expect(find.text('iMovie'), findsOneWidget);
    expect(find.text(l10n.homeBottomNavHome), findsNothing);

    await tester.pump(const Duration(milliseconds: 100));
    await tester.pumpAndSettle();

    expect(find.text(l10n.homeBottomNavHome), findsOneWidget);
  });

  testWidgets('checks auth on app start and redirects guest to sign in', (
    WidgetTester tester,
  ) async {
    final l10n = AppLocalizationsVi();

    await sl.unregister<SessionRepository>();
    sl.registerLazySingleton<SessionRepository>(
      () => const FakeSessionRepository.guest(),
    );
    await appRouter.replaceAll([const AppSplashRoute()]);

    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();

    expect(find.text(l10n.authSignInTitle), findsOneWidget);
    expect(find.text(l10n.authRememberMe), findsOneWidget);
  });

  testWidgets('renders browse screen and searches movies', (
    WidgetTester tester,
  ) async {
    final l10n = AppLocalizationsVi();

    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();

    await appRouter.navigate(BrowseRoute());
    await tester.pumpAndSettle();

    expect(find.text(l10n.homeBottomNavBrowse), findsWidgets);
    expect(find.text(l10n.browseSearchHint), findsOneWidget);
    expect(find.text(l10n.movieDetailGenres), findsOneWidget);
    expect(find.text(l10n.browsePopularSection), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'linh');
    await tester.pump(const Duration(milliseconds: 600));
    await tester.pumpAndSettle();

    expect(find.text(l10n.browseSearchResults), findsOneWidget);
  });

  testWidgets('renders auth sign in and sign up screens', (
    WidgetTester tester,
  ) async {
    final l10n = AppLocalizationsVi();

    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();

    await appRouter.replaceAll([SignInRoute()]);
    await tester.pumpAndSettle();

    expect(find.text(l10n.authSignInTitle), findsOneWidget);
    expect(find.text(l10n.authRememberMe), findsOneWidget);
    expect(find.text(l10n.authForgotPassword), findsOneWidget);

    await tester.tap(find.text(l10n.authForgotPassword));
    await tester.pumpAndSettle();

    expect(find.text(l10n.authForgotPasswordTitle), findsOneWidget);
    expect(find.text(l10n.authForgotPasswordSubmit), findsOneWidget);

    await appRouter.replaceAll([SignUpRoute()]);
    await tester.pumpAndSettle();

    expect(find.text(l10n.authSignUpTitle), findsWidgets);
    expect(find.text(l10n.authConfirmPasswordLabel), findsOneWidget);
    expect(find.text(l10n.authAcceptTerms), findsOneWidget);
  });

  testWidgets('renders movie detail screen from API detail mapping', (
    WidgetTester tester,
  ) async {
    final l10n = AppLocalizationsVi();

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('vi'),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: BlocProvider(
          create: (_) => MovieDetailCubit(
            getMovieDetailUseCase: sl<GetMovieDetailUseCase>(),
            addMovieToLibraryUseCase: sl<AddMovieToLibraryUseCase>(),
            slug: 'linh-moi-phan-8',
          ),
          child: const MovieDetailPage(slug: 'linh-moi-phan-8'),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text(l10n.movieDetailInformation), findsOneWidget);
    expect(find.text(l10n.movieDetailRating), findsAtLeastNWidgets(1));
    expect(find.text(l10n.movieDetailActors), findsOneWidget);
    expect(find.text(l10n.movieDetailRecommended), findsNothing);

    await tester.tap(find.byTooltip(l10n.movieDetailActionWatchlist));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.bookmark_added_rounded), findsOneWidget);
  });

  test('loads actor images from peoples profile path', () async {
    final result = await sl<GetMovieDetailUseCase>()(
      const GetMovieDetailParams(slug: 'linh-moi-phan-8'),
    );

    final detail = result.map(
      success: (detail) => detail,
      failure: (failure) => throw TestFailure(failure.message),
    );

    expect(detail.actors, isNotEmpty);
    expect(
      detail.actors.first.profileUrl,
      'https://image.tmdb.org/t/p/w185/aW6vCxkUZtwb6iH2Wf88Uq0XNVv.jpg',
    );
  });

  testWidgets('removes a library item with swipe action', (
    WidgetTester tester,
  ) async {
    var movies = [_testLibraryMovie];
    var removed = false;

    await tester.pumpWidget(
      MaterialApp(
        home: StatefulBuilder(
          builder: (context, setState) {
            return LibraryContentView(
              movies: movies,
              emptyTitle: 'Empty',
              emptySubtitle: 'Add movies',
              removeActionLabel: 'Xóa',
              onMovieTap: (_) {},
              onMovieRemove: (item) async {
                removed = true;
                setState(() {
                  movies = const [];
                });
                return true;
              },
            );
          },
        ),
      ),
    );

    expect(find.byType(Dismissible), findsOneWidget);

    await tester.drag(find.byType(Dismissible), const Offset(-600, 0));
    await tester.pumpAndSettle();

    expect(removed, isTrue);
    expect(find.byType(Dismissible), findsNothing);
    expect(find.text('Empty'), findsOneWidget);
  });

  testWidgets('renders movie watch screen with server and episode picker', (
    WidgetTester tester,
  ) async {
    final l10n = AppLocalizationsVi();

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('vi'),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: BlocProvider(
          create: (_) => MovieWatchCubit(
            getMovieDetailUseCase: sl<GetMovieDetailUseCase>(),
            slug: 'linh-moi-phan-8',
          ),
          child: const MovieWatchPage(slug: 'linh-moi-phan-8'),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text(l10n.watchScreenTitle), findsOneWidget);
    expect(find.text(l10n.watchServerSection), findsAtLeastNWidgets(1));
    expect(find.text(l10n.watchEpisodeSection), findsAtLeastNWidgets(1));
    expect(find.text('Vietsub #1'), findsOneWidget);
    expect(find.text('Backup #1'), findsOneWidget);
  });
}

Finder _verticalScrollable() {
  return find
      .byWidgetPredicate(
        (widget) =>
            widget is Scrollable && widget.axisDirection == AxisDirection.down,
      )
      .first;
}

final _testLibraryMovie = LibraryMovie(
  id: 'library-row-1',
  userId: 'test-user',
  createdAt: DateTime.utc(2026, 1, 1),
  movie: const MovieDetail(
    id: '1',
    slug: 'linh-moi-phan-8',
    title: 'Linh Moi (Phan 8)',
    originalTitle: 'The Rookie (Season 8)',
    posterUrl: '',
    backdropUrl: '',
    description: '',
    status: 'ongoing',
    type: 'series',
    quality: 'HD',
    language: 'Vietsub',
    runtime: '43 phut/tap',
    currentEpisode: 'Tap 17',
    totalEpisodes: '18 Tap',
    year: 2026,
    rating: 8,
    ratingCount: 120183,
    genres: ['Hanh Dong'],
    countries: ['Au My'],
    actors: [],
    directors: [],
    trailerUrl: '',
    servers: [],
  ),
);

class FakeLibraryRepository implements LibraryRepository {
  final List<LibraryMovie> _movies = [];

  @override
  Future<Result<List<LibraryMovie>>> getLibraryMovies() async {
    return Success(List.unmodifiable(_movies));
  }

  @override
  Future<Result<LibraryMovie>> addMovie(MovieDetail movie) async {
    final item = LibraryMovie(
      id: movie.slug,
      userId: 'test-user',
      movie: movie,
      createdAt: DateTime.utc(2026, 1, 1),
    );
    _movies.removeWhere((saved) => saved.movie.slug == movie.slug);
    _movies.insert(0, item);
    return Success(item);
  }

  @override
  Future<Result<void>> removeMovie(String id) async {
    _movies.removeWhere((saved) => saved.id == id);
    return const Success(null);
  }
}

class FakeSessionRepository implements SessionRepository {
  const FakeSessionRepository.authenticated() : _authenticated = true;

  const FakeSessionRepository.guest() : _authenticated = false;

  final bool _authenticated;

  @override
  Future<Result<AppSession>> getCurrentSession() async {
    return Success(
      _authenticated
          ? AppSession.authenticated(
              userId: 'test-user',
              email: 'test@example.com',
            )
          : AppSession.guest(),
    );
  }

  @override
  Future<Result<AppSession>> signInWithPassword({
    required String email,
    required String password,
  }) async {
    return Success(AppSession.authenticated(userId: 'test-user', email: email));
  }

  @override
  Future<Result<AppSession>> signUp({
    required String email,
    required String password,
  }) async {
    return Success(AppSession.authenticated(userId: 'test-user', email: email));
  }

  @override
  Future<Result<void>> resetPasswordForEmail({required String email}) async {
    return const Success(null);
  }

  @override
  Future<Result<void>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    return const Success(null);
  }

  @override
  Future<Result<void>> signOut() async => const Success(null);
}
