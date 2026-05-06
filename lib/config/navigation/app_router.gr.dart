// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [AppSplashPage]
class AppSplashRoute extends PageRouteInfo<void> {
  const AppSplashRoute({List<PageRouteInfo>? children})
    : super(AppSplashRoute.name, initialChildren: children);

  static const String name = 'AppSplashRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AppSplashPage();
    },
  );
}

/// generated route for
/// [BrowsePage]
class BrowseRoute extends PageRouteInfo<BrowseRouteArgs> {
  BrowseRoute({Key? key, List<PageRouteInfo>? children})
    : super(
        BrowseRoute.name,
        args: BrowseRouteArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'BrowseRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<BrowseRouteArgs>(
        orElse: () => const BrowseRouteArgs(),
      );
      return WrappedRoute(child: BrowsePage(key: args.key));
    },
  );
}

class BrowseRouteArgs {
  const BrowseRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'BrowseRouteArgs{key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! BrowseRouteArgs) return false;
    return key == other.key;
  }

  @override
  int get hashCode => key.hashCode;
}

/// generated route for
/// [ForgotPasswordPage]
class ForgotPasswordRoute extends PageRouteInfo<ForgotPasswordRouteArgs> {
  ForgotPasswordRoute({Key? key, List<PageRouteInfo>? children})
    : super(
        ForgotPasswordRoute.name,
        args: ForgotPasswordRouteArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'ForgotPasswordRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ForgotPasswordRouteArgs>(
        orElse: () => const ForgotPasswordRouteArgs(),
      );
      return WrappedRoute(child: ForgotPasswordPage(key: args.key));
    },
  );
}

class ForgotPasswordRouteArgs {
  const ForgotPasswordRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'ForgotPasswordRouteArgs{key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ForgotPasswordRouteArgs) return false;
    return key == other.key;
  }

  @override
  int get hashCode => key.hashCode;
}

/// generated route for
/// [GenreMoviesPage]
class GenreMoviesRoute extends PageRouteInfo<GenreMoviesRouteArgs> {
  GenreMoviesRoute({
    Key? key,
    required String slug,
    String title = '',
    List<PageRouteInfo>? children,
  }) : super(
         GenreMoviesRoute.name,
         args: GenreMoviesRouteArgs(key: key, slug: slug, title: title),
         rawPathParams: {'slug': slug},
         initialChildren: children,
       );

  static const String name = 'GenreMoviesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<GenreMoviesRouteArgs>(
        orElse: () => GenreMoviesRouteArgs(slug: pathParams.getString('slug')),
      );
      return WrappedRoute(
        child: GenreMoviesPage(
          key: args.key,
          slug: args.slug,
          title: args.title,
        ),
      );
    },
  );
}

class GenreMoviesRouteArgs {
  const GenreMoviesRouteArgs({this.key, required this.slug, this.title = ''});

  final Key? key;

  final String slug;

  final String title;

  @override
  String toString() {
    return 'GenreMoviesRouteArgs{key: $key, slug: $slug, title: $title}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! GenreMoviesRouteArgs) return false;
    return key == other.key && slug == other.slug && title == other.title;
  }

  @override
  int get hashCode => key.hashCode ^ slug.hashCode ^ title.hashCode;
}

/// generated route for
/// [GenresPage]
class GenresRoute extends PageRouteInfo<GenresRouteArgs> {
  GenresRoute({
    Key? key,
    List<HomeGenre> genres = const [],
    List<PageRouteInfo>? children,
  }) : super(
         GenresRoute.name,
         args: GenresRouteArgs(key: key, genres: genres),
         initialChildren: children,
       );

  static const String name = 'GenresRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<GenresRouteArgs>(
        orElse: () => const GenresRouteArgs(),
      );
      return GenresPage(key: args.key, genres: args.genres);
    },
  );
}

class GenresRouteArgs {
  const GenresRouteArgs({this.key, this.genres = const []});

  final Key? key;

  final List<HomeGenre> genres;

  @override
  String toString() {
    return 'GenresRouteArgs{key: $key, genres: $genres}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! GenresRouteArgs) return false;
    return key == other.key &&
        const ListEquality<HomeGenre>().equals(genres, other.genres);
  }

  @override
  int get hashCode =>
      key.hashCode ^ const ListEquality<HomeGenre>().hash(genres);
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const HomePage());
    },
  );
}

/// generated route for
/// [LibraryPage]
class LibraryRoute extends PageRouteInfo<void> {
  const LibraryRoute({List<PageRouteInfo>? children})
    : super(LibraryRoute.name, initialChildren: children);

  static const String name = 'LibraryRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LibraryPage();
    },
  );
}

/// generated route for
/// [MainPage]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute({List<PageRouteInfo>? children})
    : super(MainRoute.name, initialChildren: children);

  static const String name = 'MainRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MainPage();
    },
  );
}

/// generated route for
/// [MovieDetailPage]
class MovieDetailRoute extends PageRouteInfo<MovieDetailRouteArgs> {
  MovieDetailRoute({
    Key? key,
    required String slug,
    List<HomeMovie> relatedMovies = const [],
    List<PageRouteInfo>? children,
  }) : super(
         MovieDetailRoute.name,
         args: MovieDetailRouteArgs(
           key: key,
           slug: slug,
           relatedMovies: relatedMovies,
         ),
         rawPathParams: {'slug': slug},
         initialChildren: children,
       );

  static const String name = 'MovieDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<MovieDetailRouteArgs>(
        orElse: () => MovieDetailRouteArgs(slug: pathParams.getString('slug')),
      );
      return WrappedRoute(
        child: MovieDetailPage(
          key: args.key,
          slug: args.slug,
          relatedMovies: args.relatedMovies,
        ),
      );
    },
  );
}

class MovieDetailRouteArgs {
  const MovieDetailRouteArgs({
    this.key,
    required this.slug,
    this.relatedMovies = const [],
  });

  final Key? key;

  final String slug;

  final List<HomeMovie> relatedMovies;

  @override
  String toString() {
    return 'MovieDetailRouteArgs{key: $key, slug: $slug, relatedMovies: $relatedMovies}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! MovieDetailRouteArgs) return false;
    return key == other.key &&
        slug == other.slug &&
        const ListEquality<HomeMovie>().equals(
          relatedMovies,
          other.relatedMovies,
        );
  }

  @override
  int get hashCode =>
      key.hashCode ^
      slug.hashCode ^
      const ListEquality<HomeMovie>().hash(relatedMovies);
}

/// generated route for
/// [MovieWatchPage]
class MovieWatchRoute extends PageRouteInfo<MovieWatchRouteArgs> {
  MovieWatchRoute({
    Key? key,
    required String slug,
    MovieDetail? initialDetail,
    List<PageRouteInfo>? children,
  }) : super(
         MovieWatchRoute.name,
         args: MovieWatchRouteArgs(
           key: key,
           slug: slug,
           initialDetail: initialDetail,
         ),
         rawPathParams: {'slug': slug},
         initialChildren: children,
       );

  static const String name = 'MovieWatchRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<MovieWatchRouteArgs>(
        orElse: () => MovieWatchRouteArgs(slug: pathParams.getString('slug')),
      );
      return WrappedRoute(
        child: MovieWatchPage(
          key: args.key,
          slug: args.slug,
          initialDetail: args.initialDetail,
        ),
      );
    },
  );
}

class MovieWatchRouteArgs {
  const MovieWatchRouteArgs({this.key, required this.slug, this.initialDetail});

  final Key? key;

  final String slug;

  final MovieDetail? initialDetail;

  @override
  String toString() {
    return 'MovieWatchRouteArgs{key: $key, slug: $slug, initialDetail: $initialDetail}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! MovieWatchRouteArgs) return false;
    return key == other.key &&
        slug == other.slug &&
        initialDetail == other.initialDetail;
  }

  @override
  int get hashCode => key.hashCode ^ slug.hashCode ^ initialDetail.hashCode;
}

/// generated route for
/// [ProfilePage]
class ProfileRoute extends PageRouteInfo<ProfileRouteArgs> {
  ProfileRoute({Key? key, List<PageRouteInfo>? children})
    : super(
        ProfileRoute.name,
        args: ProfileRouteArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'ProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProfileRouteArgs>(
        orElse: () => const ProfileRouteArgs(),
      );
      return WrappedRoute(child: ProfilePage(key: args.key));
    },
  );
}

class ProfileRouteArgs {
  const ProfileRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'ProfileRouteArgs{key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ProfileRouteArgs) return false;
    return key == other.key;
  }

  @override
  int get hashCode => key.hashCode;
}

/// generated route for
/// [SettingsPage]
class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute({List<PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const SettingsPage());
    },
  );
}

/// generated route for
/// [SignInPage]
class SignInRoute extends PageRouteInfo<void> {
  const SignInRoute({List<PageRouteInfo>? children})
    : super(SignInRoute.name, initialChildren: children);

  static const String name = 'SignInRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const SignInPage());
    },
  );
}

/// generated route for
/// [SignUpPage]
class SignUpRoute extends PageRouteInfo<void> {
  const SignUpRoute({List<PageRouteInfo>? children})
    : super(SignUpRoute.name, initialChildren: children);

  static const String name = 'SignUpRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const SignUpPage());
    },
  );
}
