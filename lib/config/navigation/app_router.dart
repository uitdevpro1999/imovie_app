import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:imovie_app/domain/entities/home/home_genre.dart';
import 'package:imovie_app/domain/entities/home/home_movie.dart';
import 'package:imovie_app/domain/entities/community/community_post.dart';
import 'package:imovie_app/domain/entities/movie_detail/movie_detail.dart';
import 'package:imovie_app/presentation/ui/auth/forgot_password/forgot_password_page.dart';
import 'package:imovie_app/presentation/ui/auth/sign_in/sign_in_page.dart';
import 'package:imovie_app/presentation/ui/auth/sign_up/sign_up_page.dart';
import 'package:imovie_app/presentation/ui/browse/browse_page.dart';
import 'package:imovie_app/presentation/ui/community/compose/community_compose_page.dart';
import 'package:imovie_app/presentation/ui/community/feed/community_mine_page.dart';
import 'package:imovie_app/presentation/ui/community/feed/community_page.dart';
import 'package:imovie_app/presentation/ui/community/story_editor/community_story_editor_page.dart';
import 'package:imovie_app/presentation/ui/genre_movies/genre_movies_page.dart';
import 'package:imovie_app/presentation/ui/genres/genres_page.dart';
import 'package:imovie_app/presentation/ui/home/home_page.dart';
import 'package:imovie_app/presentation/ui/library/library_page.dart';
import 'package:imovie_app/presentation/ui/main/main_page.dart';
import 'package:imovie_app/presentation/ui/movie_detail/movie_detail_page.dart';
import 'package:imovie_app/presentation/ui/movie_list/movie_list_page.dart';
import 'package:imovie_app/presentation/ui/movie_watch/movie_watch_page.dart';
import 'package:imovie_app/presentation/ui/profile/edit_profile/profile_page.dart';
import 'package:imovie_app/presentation/ui/profile/change_password/change_password_page.dart';
import 'package:imovie_app/presentation/ui/profile/language/language_page.dart';
import 'package:imovie_app/presentation/ui/profile/settings/settings_page.dart';
import 'package:imovie_app/presentation/ui/splash/app_splash_page.dart';

part 'app_router.gr.dart';

final appRouter = AppRouter();

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => RouteType.custom(
    transitionsBuilder: TransitionsBuilders.noTransition,
    duration: Duration.zero,
    reverseDuration: Duration.zero,
    opaque: true,
  );

  @override
  List<AutoRoute> get routes => [
    AutoRoute(path: '/', page: AppSplashRoute.page, initial: true),
    AutoRoute(
      path: '/main',
      page: MainRoute.page,
      children: [
        AutoRoute(path: '', page: HomeRoute.page, initial: true),
        AutoRoute(path: 'browse', page: BrowseRoute.page),
        AutoRoute(path: 'community', page: CommunityRoute.page),
        AutoRoute(path: 'library', page: LibraryRoute.page),
        AutoRoute(path: 'profile', page: SettingsRoute.page),
      ],
    ),
    AutoRoute(path: '/profile/edit', page: ProfileRoute.page),
    AutoRoute(path: '/profile/change-password', page: ChangePasswordRoute.page),
    AutoRoute(path: '/profile/language', page: LanguageRoute.page),
    AutoRoute(path: '/community/mine', page: CommunityMineRoute.page),
    AutoRoute(path: '/community/compose', page: CommunityComposeRoute.page),
    AutoRoute(
      path: '/community/story-editor',
      page: CommunityStoryEditorRoute.page,
    ),
    AutoRoute(path: '/sign-in', page: SignInRoute.page),
    AutoRoute(path: '/sign-up', page: SignUpRoute.page),
    AutoRoute(path: '/forgot-password', page: ForgotPasswordRoute.page),
    AutoRoute(path: '/genres', page: GenresRoute.page),
    AutoRoute(path: '/genres/:slug', page: GenreMoviesRoute.page),
    AutoRoute(path: '/lists/:slug', page: MovieListRoute.page),
    AutoRoute(path: '/movie/:slug', page: MovieDetailRoute.page),
    AutoRoute(path: '/watch/:slug', page: MovieWatchRoute.page),
  ];
}
