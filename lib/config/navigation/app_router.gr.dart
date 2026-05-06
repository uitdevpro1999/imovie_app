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
      return WrappedRoute(child: const AppSplashPage());
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
/// [ChangePasswordPage]
class ChangePasswordRoute extends PageRouteInfo<ChangePasswordRouteArgs> {
  ChangePasswordRoute({Key? key, List<PageRouteInfo>? children})
    : super(
        ChangePasswordRoute.name,
        args: ChangePasswordRouteArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'ChangePasswordRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ChangePasswordRouteArgs>(
        orElse: () => const ChangePasswordRouteArgs(),
      );
      return WrappedRoute(child: ChangePasswordPage(key: args.key));
    },
  );
}

class ChangePasswordRouteArgs {
  const ChangePasswordRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'ChangePasswordRouteArgs{key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ChangePasswordRouteArgs) return false;
    return key == other.key;
  }

  @override
  int get hashCode => key.hashCode;
}

/// generated route for
/// [CommunityComposePage]
class CommunityComposeRoute extends PageRouteInfo<CommunityComposeRouteArgs> {
  CommunityComposeRoute({
    Key? key,
    CommunityPost? initialPost,
    List<PageRouteInfo>? children,
  }) : super(
         CommunityComposeRoute.name,
         args: CommunityComposeRouteArgs(key: key, initialPost: initialPost),
         initialChildren: children,
       );

  static const String name = 'CommunityComposeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CommunityComposeRouteArgs>(
        orElse: () => const CommunityComposeRouteArgs(),
      );
      return WrappedRoute(
        child: CommunityComposePage(
          key: args.key,
          initialPost: args.initialPost,
        ),
      );
    },
  );
}

class CommunityComposeRouteArgs {
  const CommunityComposeRouteArgs({this.key, this.initialPost});

  final Key? key;

  final CommunityPost? initialPost;

  @override
  String toString() {
    return 'CommunityComposeRouteArgs{key: $key, initialPost: $initialPost}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CommunityComposeRouteArgs) return false;
    return key == other.key && initialPost == other.initialPost;
  }

  @override
  int get hashCode => key.hashCode ^ initialPost.hashCode;
}

/// generated route for
/// [CommunityMinePage]
class CommunityMineRoute extends PageRouteInfo<void> {
  const CommunityMineRoute({List<PageRouteInfo>? children})
    : super(CommunityMineRoute.name, initialChildren: children);

  static const String name = 'CommunityMineRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const CommunityMinePage());
    },
  );
}

/// generated route for
/// [CommunityPage]
class CommunityRoute extends PageRouteInfo<CommunityRouteArgs> {
  CommunityRoute({
    Key? key,
    bool mineOnly = false,
    List<PageRouteInfo>? children,
  }) : super(
         CommunityRoute.name,
         args: CommunityRouteArgs(key: key, mineOnly: mineOnly),
         initialChildren: children,
       );

  static const String name = 'CommunityRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CommunityRouteArgs>(
        orElse: () => const CommunityRouteArgs(),
      );
      return WrappedRoute(
        child: CommunityPage(key: args.key, mineOnly: args.mineOnly),
      );
    },
  );
}

class CommunityRouteArgs {
  const CommunityRouteArgs({this.key, this.mineOnly = false});

  final Key? key;

  final bool mineOnly;

  @override
  String toString() {
    return 'CommunityRouteArgs{key: $key, mineOnly: $mineOnly}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CommunityRouteArgs) return false;
    return key == other.key && mineOnly == other.mineOnly;
  }

  @override
  int get hashCode => key.hashCode ^ mineOnly.hashCode;
}

/// generated route for
/// [CommunityStoryEditorPage]
class CommunityStoryEditorRoute extends PageRouteInfo<void> {
  const CommunityStoryEditorRoute({List<PageRouteInfo>? children})
    : super(CommunityStoryEditorRoute.name, initialChildren: children);

  static const String name = 'CommunityStoryEditorRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const CommunityStoryEditorPage());
    },
  );
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
      return WrappedRoute(
        child: GenresPage(key: args.key, genres: args.genres),
      );
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
/// [LanguagePage]
class LanguageRoute extends PageRouteInfo<void> {
  const LanguageRoute({List<PageRouteInfo>? children})
    : super(LanguageRoute.name, initialChildren: children);

  static const String name = 'LanguageRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return WrappedRoute(child: const LanguagePage());
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
      return WrappedRoute(child: const LibraryPage());
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
/// [MovieListPage]
class MovieListRoute extends PageRouteInfo<MovieListRouteArgs> {
  MovieListRoute({
    Key? key,
    required String slug,
    String title = '',
    List<PageRouteInfo>? children,
  }) : super(
         MovieListRoute.name,
         args: MovieListRouteArgs(key: key, slug: slug, title: title),
         rawPathParams: {'slug': slug},
         initialChildren: children,
       );

  static const String name = 'MovieListRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<MovieListRouteArgs>(
        orElse: () => MovieListRouteArgs(slug: pathParams.getString('slug')),
      );
      return WrappedRoute(
        child: MovieListPage(key: args.key, slug: args.slug, title: args.title),
      );
    },
  );
}

class MovieListRouteArgs {
  const MovieListRouteArgs({this.key, required this.slug, this.title = ''});

  final Key? key;

  final String slug;

  final String title;

  @override
  String toString() {
    return 'MovieListRouteArgs{key: $key, slug: $slug, title: $title}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! MovieListRouteArgs) return false;
    return key == other.key && slug == other.slug && title == other.title;
  }

  @override
  int get hashCode => key.hashCode ^ slug.hashCode ^ title.hashCode;
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
class SignInRoute extends PageRouteInfo<SignInRouteArgs> {
  SignInRoute({Key? key, List<PageRouteInfo>? children})
    : super(
        SignInRoute.name,
        args: SignInRouteArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'SignInRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SignInRouteArgs>(
        orElse: () => const SignInRouteArgs(),
      );
      return WrappedRoute(child: SignInPage(key: args.key));
    },
  );
}

class SignInRouteArgs {
  const SignInRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'SignInRouteArgs{key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SignInRouteArgs) return false;
    return key == other.key;
  }

  @override
  int get hashCode => key.hashCode;
}

/// generated route for
/// [SignUpPage]
class SignUpRoute extends PageRouteInfo<SignUpRouteArgs> {
  SignUpRoute({Key? key, List<PageRouteInfo>? children})
    : super(
        SignUpRoute.name,
        args: SignUpRouteArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'SignUpRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SignUpRouteArgs>(
        orElse: () => const SignUpRouteArgs(),
      );
      return WrappedRoute(child: SignUpPage(key: args.key));
    },
  );
}

class SignUpRouteArgs {
  const SignUpRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'SignUpRouteArgs{key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SignUpRouteArgs) return false;
    return key == other.key;
  }

  @override
  int get hashCode => key.hashCode;
}
