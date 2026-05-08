import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_vi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('vi'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'iMovie'**
  String get appTitle;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @homeFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get homeFilterAll;

  /// No description provided for @homeFilterUpdated.
  ///
  /// In en, this message translates to:
  /// **'Updated'**
  String get homeFilterUpdated;

  /// No description provided for @homeFilterSeries.
  ///
  /// In en, this message translates to:
  /// **'Series'**
  String get homeFilterSeries;

  /// No description provided for @homeFilterAnimation.
  ///
  /// In en, this message translates to:
  /// **'Animation'**
  String get homeFilterAnimation;

  /// No description provided for @homeFilterYear.
  ///
  /// In en, this message translates to:
  /// **'2026'**
  String get homeFilterYear;

  /// No description provided for @homeBadgeAdFree.
  ///
  /// In en, this message translates to:
  /// **'No ADS'**
  String get homeBadgeAdFree;

  /// No description provided for @homeSectionFreshUpdates.
  ///
  /// In en, this message translates to:
  /// **'Fresh updates'**
  String get homeSectionFreshUpdates;

  /// No description provided for @homeSectionHighestRated.
  ///
  /// In en, this message translates to:
  /// **'Highest rated'**
  String get homeSectionHighestRated;

  /// No description provided for @homeSectionSeriesSpotlight.
  ///
  /// In en, this message translates to:
  /// **'Series spotlight'**
  String get homeSectionSeriesSpotlight;

  /// No description provided for @homeSectionAnimationPicks.
  ///
  /// In en, this message translates to:
  /// **'Animation picks'**
  String get homeSectionAnimationPicks;

  /// No description provided for @homeSectionTvShows.
  ///
  /// In en, this message translates to:
  /// **'TV Shows'**
  String get homeSectionTvShows;

  /// No description provided for @homeSectionUpcoming.
  ///
  /// In en, this message translates to:
  /// **'Coming soon'**
  String get homeSectionUpcoming;

  /// No description provided for @homeSectionTopThisWeek.
  ///
  /// In en, this message translates to:
  /// **'Top this week'**
  String get homeSectionTopThisWeek;

  /// No description provided for @homeSectionViewMore.
  ///
  /// In en, this message translates to:
  /// **'View more'**
  String get homeSectionViewMore;

  /// No description provided for @homeBottomNavHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeBottomNavHome;

  /// No description provided for @homeBottomNavBrowse.
  ///
  /// In en, this message translates to:
  /// **'Browse'**
  String get homeBottomNavBrowse;

  /// No description provided for @homeBottomNavCommunity.
  ///
  /// In en, this message translates to:
  /// **'Community'**
  String get homeBottomNavCommunity;

  /// No description provided for @homeBottomNavLibrary.
  ///
  /// In en, this message translates to:
  /// **'Library'**
  String get homeBottomNavLibrary;

  /// No description provided for @homeBottomNavProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get homeBottomNavProfile;

  /// No description provided for @homeHeroDefaultSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Recently updated titles from the latest feed'**
  String get homeHeroDefaultSubtitle;

  /// No description provided for @homeErrorLoadFeed.
  ///
  /// In en, this message translates to:
  /// **'Unable to load the home feed.'**
  String get homeErrorLoadFeed;

  /// No description provided for @homeMetaEpisode.
  ///
  /// In en, this message translates to:
  /// **'{episode} • {duration}'**
  String homeMetaEpisode(Object episode, Object duration);

  /// No description provided for @homeMetaLanguage.
  ///
  /// In en, this message translates to:
  /// **'{language} • {quality}'**
  String homeMetaLanguage(Object language, Object quality);

  /// No description provided for @homeMetaYear.
  ///
  /// In en, this message translates to:
  /// **'{year}'**
  String homeMetaYear(Object year);

  /// No description provided for @movieDetailErrorLoad.
  ///
  /// In en, this message translates to:
  /// **'Unable to load the movie details.'**
  String get movieDetailErrorLoad;

  /// No description provided for @movieDetailPlay.
  ///
  /// In en, this message translates to:
  /// **'Play'**
  String get movieDetailPlay;

  /// No description provided for @movieDetailActionTrailer.
  ///
  /// In en, this message translates to:
  /// **'Trailer'**
  String get movieDetailActionTrailer;

  /// No description provided for @movieTrailerUnavailable.
  ///
  /// In en, this message translates to:
  /// **'No trailer is available for this movie.'**
  String get movieTrailerUnavailable;

  /// No description provided for @movieDetailActionWatchlist.
  ///
  /// In en, this message translates to:
  /// **'Watchlist'**
  String get movieDetailActionWatchlist;

  /// No description provided for @movieDetailActionInLibrary.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get movieDetailActionInLibrary;

  /// No description provided for @movieDetailLibraryAddSuccess.
  ///
  /// In en, this message translates to:
  /// **'Added to your library.'**
  String get movieDetailLibraryAddSuccess;

  /// No description provided for @movieDetailLibraryEmptyMovie.
  ///
  /// In en, this message translates to:
  /// **'No movie data is available to save.'**
  String get movieDetailLibraryEmptyMovie;

  /// No description provided for @movieDetailActionRate.
  ///
  /// In en, this message translates to:
  /// **'Rate'**
  String get movieDetailActionRate;

  /// No description provided for @movieDetailImdbOpenError.
  ///
  /// In en, this message translates to:
  /// **'Unable to open IMDb.'**
  String get movieDetailImdbOpenError;

  /// No description provided for @movieDetailTmdbOpenError.
  ///
  /// In en, this message translates to:
  /// **'Unable to open TMDb.'**
  String get movieDetailTmdbOpenError;

  /// No description provided for @movieDetailRatingSourceTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose rating site'**
  String get movieDetailRatingSourceTitle;

  /// No description provided for @movieDetailRatingSourceImdbSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Open IMDb ratings'**
  String get movieDetailRatingSourceImdbSubtitle;

  /// No description provided for @movieDetailRatingSourceTmdbSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Open TMDb ratings'**
  String get movieDetailRatingSourceTmdbSubtitle;

  /// No description provided for @movieDetailActionShare.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get movieDetailActionShare;

  /// No description provided for @movieDetailActors.
  ///
  /// In en, this message translates to:
  /// **'Actors'**
  String get movieDetailActors;

  /// No description provided for @movieDetailGenres.
  ///
  /// In en, this message translates to:
  /// **'Genres'**
  String get movieDetailGenres;

  /// No description provided for @movieDetailInformation.
  ///
  /// In en, this message translates to:
  /// **'Information'**
  String get movieDetailInformation;

  /// No description provided for @movieDetailInfoOriginalTitle.
  ///
  /// In en, this message translates to:
  /// **'Original title'**
  String get movieDetailInfoOriginalTitle;

  /// No description provided for @movieDetailInfoStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get movieDetailInfoStatus;

  /// No description provided for @movieDetailInfoYear.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get movieDetailInfoYear;

  /// No description provided for @movieDetailInfoRuntime.
  ///
  /// In en, this message translates to:
  /// **'Runtime'**
  String get movieDetailInfoRuntime;

  /// No description provided for @movieDetailInfoLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get movieDetailInfoLanguage;

  /// No description provided for @movieDetailInfoQuality.
  ///
  /// In en, this message translates to:
  /// **'Quality'**
  String get movieDetailInfoQuality;

  /// No description provided for @movieDetailInfoDirector.
  ///
  /// In en, this message translates to:
  /// **'Director'**
  String get movieDetailInfoDirector;

  /// No description provided for @movieDetailRating.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get movieDetailRating;

  /// No description provided for @movieDetailRateMovie.
  ///
  /// In en, this message translates to:
  /// **'Rate the movie'**
  String get movieDetailRateMovie;

  /// No description provided for @movieDetailRecommended.
  ///
  /// In en, this message translates to:
  /// **'Recommended'**
  String get movieDetailRecommended;

  /// No description provided for @movieDetailReviews.
  ///
  /// In en, this message translates to:
  /// **'{count} reviews'**
  String movieDetailReviews(int count);

  /// No description provided for @watchScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Watch'**
  String get watchScreenTitle;

  /// No description provided for @watchLoadError.
  ///
  /// In en, this message translates to:
  /// **'Unable to load this stream.'**
  String get watchLoadError;

  /// No description provided for @watchServerSection.
  ///
  /// In en, this message translates to:
  /// **'Servers'**
  String get watchServerSection;

  /// No description provided for @watchEpisodeSection.
  ///
  /// In en, this message translates to:
  /// **'Episodes'**
  String get watchEpisodeSection;

  /// No description provided for @watchNoEpisodes.
  ///
  /// In en, this message translates to:
  /// **'This server does not have any episodes yet.'**
  String get watchNoEpisodes;

  /// No description provided for @watchNoPlayableSource.
  ///
  /// In en, this message translates to:
  /// **'No playable m3u8 source is available for the selected episode.'**
  String get watchNoPlayableSource;

  /// No description provided for @watchPlayerError.
  ///
  /// In en, this message translates to:
  /// **'The player could not start this stream.'**
  String get watchPlayerError;

  /// No description provided for @watchPlayerPreview.
  ///
  /// In en, this message translates to:
  /// **'Video preview is replaced with a test placeholder in widget tests.'**
  String get watchPlayerPreview;

  /// No description provided for @watchNoEpisodeSelected.
  ///
  /// In en, this message translates to:
  /// **'No episode selected'**
  String get watchNoEpisodeSelected;

  /// No description provided for @watchEpisodeValue.
  ///
  /// In en, this message translates to:
  /// **'Episode {episode}'**
  String watchEpisodeValue(Object episode);

  /// No description provided for @watchServerValue.
  ///
  /// In en, this message translates to:
  /// **'Server: {server}'**
  String watchServerValue(Object server);

  /// No description provided for @authSignInTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign In 👋🏻'**
  String get authSignInTitle;

  /// No description provided for @authSignUpTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get authSignUpTitle;

  /// No description provided for @authSignInSubtitle.
  ///
  /// In en, this message translates to:
  /// **'By signing in, you agree to iMovie conditions of Use and Privacy Policy'**
  String get authSignInSubtitle;

  /// No description provided for @authSignUpSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Create account in a second, this need to personalize recommendations for you'**
  String get authSignUpSubtitle;

  /// No description provided for @authEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get authEmailLabel;

  /// No description provided for @authEmailHint.
  ///
  /// In en, this message translates to:
  /// **'Your email'**
  String get authEmailHint;

  /// No description provided for @authPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get authPasswordLabel;

  /// No description provided for @authPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get authPasswordHint;

  /// No description provided for @authConfirmPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get authConfirmPasswordLabel;

  /// No description provided for @authConfirmPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Re-enter your password'**
  String get authConfirmPasswordHint;

  /// No description provided for @authRememberMe.
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get authRememberMe;

  /// No description provided for @authForgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get authForgotPassword;

  /// No description provided for @authForgotPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Forgot password'**
  String get authForgotPasswordTitle;

  /// No description provided for @authForgotPasswordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your account email. iMovie will send password reset instructions to that address.'**
  String get authForgotPasswordSubtitle;

  /// No description provided for @authForgotPasswordSubmit.
  ///
  /// In en, this message translates to:
  /// **'Send reset email'**
  String get authForgotPasswordSubmit;

  /// No description provided for @authForgotPasswordSuccess.
  ///
  /// In en, this message translates to:
  /// **'If the email exists, iMovie will send password reset instructions.'**
  String get authForgotPasswordSuccess;

  /// No description provided for @authAcceptTerms.
  ///
  /// In en, this message translates to:
  /// **'I agree to Terms & Conditions and Privacy\nPolicy'**
  String get authAcceptTerms;

  /// No description provided for @authSignInAction.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get authSignInAction;

  /// No description provided for @authSignUpAction.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get authSignUpAction;

  /// No description provided for @authDividerOr.
  ///
  /// In en, this message translates to:
  /// **'OR'**
  String get authDividerOr;

  /// No description provided for @authSignInFooterPrefix.
  ///
  /// In en, this message translates to:
  /// **'Don’t have an account? '**
  String get authSignInFooterPrefix;

  /// No description provided for @authSignUpFooterPrefix.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? '**
  String get authSignUpFooterPrefix;

  /// No description provided for @authInvalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address.'**
  String get authInvalidEmail;

  /// No description provided for @authInvalidPassword.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters.'**
  String get authInvalidPassword;

  /// No description provided for @authPasswordMismatch.
  ///
  /// In en, this message translates to:
  /// **'The confirmation password does not match.'**
  String get authPasswordMismatch;

  /// No description provided for @authAcceptTermsError.
  ///
  /// In en, this message translates to:
  /// **'Accept the terms before creating an account.'**
  String get authAcceptTermsError;

  /// No description provided for @authSignInSuccess.
  ///
  /// In en, this message translates to:
  /// **'Signed in successfully.'**
  String get authSignInSuccess;

  /// No description provided for @authSignUpSuccess.
  ///
  /// In en, this message translates to:
  /// **'Account created successfully.'**
  String get authSignUpSuccess;

  /// No description provided for @browseSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Movies, series, actors'**
  String get browseSearchHint;

  /// No description provided for @browseHeroTitle.
  ///
  /// In en, this message translates to:
  /// **'Find movies that fit your mood'**
  String get browseHeroTitle;

  /// No description provided for @browseHeroSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Filter quickly by genre, country, and release year.'**
  String get browseHeroSubtitle;

  /// No description provided for @browseStatCatalog.
  ///
  /// In en, this message translates to:
  /// **'Catalog'**
  String get browseStatCatalog;

  /// No description provided for @browseStatGenres.
  ///
  /// In en, this message translates to:
  /// **'Genres'**
  String get browseStatGenres;

  /// No description provided for @browseStatPopular.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get browseStatPopular;

  /// No description provided for @browseMovieCount.
  ///
  /// In en, this message translates to:
  /// **'{count} movies'**
  String browseMovieCount(int count);

  /// No description provided for @browseSearchCount.
  ///
  /// In en, this message translates to:
  /// **'{count} results'**
  String browseSearchCount(int count);

  /// No description provided for @browsePopularSection.
  ///
  /// In en, this message translates to:
  /// **'Popular'**
  String get browsePopularSection;

  /// No description provided for @browseNoSearchResults.
  ///
  /// In en, this message translates to:
  /// **'No matching movies found'**
  String get browseNoSearchResults;

  /// No description provided for @browseSearchResults.
  ///
  /// In en, this message translates to:
  /// **'Search results'**
  String get browseSearchResults;

  /// No description provided for @libraryEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Your library is empty'**
  String get libraryEmptyTitle;

  /// No description provided for @libraryEmptySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Add movies from the detail screen to find them here.'**
  String get libraryEmptySubtitle;

  /// No description provided for @libraryCollectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Personal collection'**
  String get libraryCollectionTitle;

  /// No description provided for @libraryCollectionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Movies you saved so you can return to them anytime.'**
  String get libraryCollectionSubtitle;

  /// No description provided for @libraryStatsMovies.
  ///
  /// In en, this message translates to:
  /// **'Saved movies'**
  String get libraryStatsMovies;

  /// No description provided for @libraryStatsPlayable.
  ///
  /// In en, this message translates to:
  /// **'Ready to watch'**
  String get libraryStatsPlayable;

  /// No description provided for @libraryStatsUpdated.
  ///
  /// In en, this message translates to:
  /// **'Recently added'**
  String get libraryStatsUpdated;

  /// No description provided for @librarySavedAt.
  ///
  /// In en, this message translates to:
  /// **'Saved {date}'**
  String librarySavedAt(String date);

  /// No description provided for @librarySwipeHint.
  ///
  /// In en, this message translates to:
  /// **'Swipe left to remove'**
  String get librarySwipeHint;

  /// No description provided for @libraryRemoveConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Remove from library?'**
  String get libraryRemoveConfirmTitle;

  /// No description provided for @libraryRemoveConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'This movie will be removed from your library. You can still add it again from the movie detail screen.'**
  String get libraryRemoveConfirmMessage;

  /// No description provided for @libraryRemoveConfirmCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get libraryRemoveConfirmCancel;

  /// No description provided for @libraryRemoveConfirmAction.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get libraryRemoveConfirmAction;

  /// No description provided for @libraryRemoveAction.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get libraryRemoveAction;

  /// No description provided for @libraryRemoveSuccess.
  ///
  /// In en, this message translates to:
  /// **'Removed from your library.'**
  String get libraryRemoveSuccess;

  /// No description provided for @libraryErrorLoad.
  ///
  /// In en, this message translates to:
  /// **'Unable to load your movie library.'**
  String get libraryErrorLoad;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @profileChangeAvatar.
  ///
  /// In en, this message translates to:
  /// **'Change avatar'**
  String get profileChangeAvatar;

  /// No description provided for @profileChangeCover.
  ///
  /// In en, this message translates to:
  /// **'Change cover'**
  String get profileChangeCover;

  /// No description provided for @profileFullNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get profileFullNameLabel;

  /// No description provided for @profileFullNameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your full name'**
  String get profileFullNameHint;

  /// No description provided for @profilePhoneLabel.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get profilePhoneLabel;

  /// No description provided for @profilePhoneHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number'**
  String get profilePhoneHint;

  /// No description provided for @profileSaveAction.
  ///
  /// In en, this message translates to:
  /// **'Save profile'**
  String get profileSaveAction;

  /// No description provided for @profileSignOutAction.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get profileSignOutAction;

  /// No description provided for @profileSignedOutTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to manage your profile'**
  String get profileSignedOutTitle;

  /// No description provided for @profileSignedOutSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your avatar, name, and phone number are available after signing in.'**
  String get profileSignedOutSubtitle;

  /// No description provided for @profileEmpty.
  ///
  /// In en, this message translates to:
  /// **'No profile data was found for this account.'**
  String get profileEmpty;

  /// No description provided for @profileSaved.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully.'**
  String get profileSaved;

  /// No description provided for @profileAvatarSaved.
  ///
  /// In en, this message translates to:
  /// **'Avatar updated successfully.'**
  String get profileAvatarSaved;

  /// No description provided for @profileInvalidAvatar.
  ///
  /// In en, this message translates to:
  /// **'Choose a valid image file.'**
  String get profileInvalidAvatar;

  /// No description provided for @profileFullNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter your full name.'**
  String get profileFullNameRequired;

  /// No description provided for @profileSignOutError.
  ///
  /// In en, this message translates to:
  /// **'Unable to sign out.'**
  String get profileSignOutError;

  /// No description provided for @profileWatchHistory.
  ///
  /// In en, this message translates to:
  /// **'My watch history'**
  String get profileWatchHistory;

  /// No description provided for @profileMovies.
  ///
  /// In en, this message translates to:
  /// **'Movies'**
  String get profileMovies;

  /// No description provided for @profileShows.
  ///
  /// In en, this message translates to:
  /// **'Shows'**
  String get profileShows;

  /// No description provided for @profileEpisodes.
  ///
  /// In en, this message translates to:
  /// **'Episodes'**
  String get profileEpisodes;

  /// No description provided for @profileStatsPosts.
  ///
  /// In en, this message translates to:
  /// **'Posts'**
  String get profileStatsPosts;

  /// No description provided for @profileStatsFollowers.
  ///
  /// In en, this message translates to:
  /// **'Followers'**
  String get profileStatsFollowers;

  /// No description provided for @profileStatsFollowing.
  ///
  /// In en, this message translates to:
  /// **'Following'**
  String get profileStatsFollowing;

  /// No description provided for @profileMainSettings.
  ///
  /// In en, this message translates to:
  /// **'Main settings'**
  String get profileMainSettings;

  /// No description provided for @profileOtherSettings.
  ///
  /// In en, this message translates to:
  /// **'Others'**
  String get profileOtherSettings;

  /// No description provided for @profileSettingsProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile settings'**
  String get profileSettingsProfile;

  /// No description provided for @profileSettingsCommunity.
  ///
  /// In en, this message translates to:
  /// **'Community'**
  String get profileSettingsCommunity;

  /// No description provided for @profileSettingsMyPosts.
  ///
  /// In en, this message translates to:
  /// **'My profile'**
  String get profileSettingsMyPosts;

  /// No description provided for @profileSettingsNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get profileSettingsNotifications;

  /// No description provided for @profileSettingsAudioSubtitles.
  ///
  /// In en, this message translates to:
  /// **'Audio subtitles'**
  String get profileSettingsAudioSubtitles;

  /// No description provided for @profileSettingsAppearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get profileSettingsAppearance;

  /// No description provided for @profileSettingsDefault.
  ///
  /// In en, this message translates to:
  /// **'Default'**
  String get profileSettingsDefault;

  /// No description provided for @profileSettingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get profileSettingsLanguage;

  /// No description provided for @profileSettingsEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get profileSettingsEnglish;

  /// No description provided for @profileSettingsVietnamese.
  ///
  /// In en, this message translates to:
  /// **'Vietnamese'**
  String get profileSettingsVietnamese;

  /// No description provided for @profileSettingsHelpCenter.
  ///
  /// In en, this message translates to:
  /// **'Help center'**
  String get profileSettingsHelpCenter;

  /// No description provided for @profileSettingsSecurity.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get profileSettingsSecurity;

  /// No description provided for @profileSettingsAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get profileSettingsAbout;

  /// No description provided for @profileContactTitle.
  ///
  /// In en, this message translates to:
  /// **'Contact info'**
  String get profileContactTitle;

  /// No description provided for @profileContactSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Direct channels to contact Nguyen Quoc Trung.'**
  String get profileContactSubtitle;

  /// No description provided for @profileContactOpenAction.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get profileContactOpenAction;

  /// No description provided for @profileContactCopyAction.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get profileContactCopyAction;

  /// No description provided for @profileContactCopied.
  ///
  /// In en, this message translates to:
  /// **'Contact information copied.'**
  String get profileContactCopied;

  /// No description provided for @profileContactOpenError.
  ///
  /// In en, this message translates to:
  /// **'Unable to open this contact channel.'**
  String get profileContactOpenError;

  /// No description provided for @profileContactZaloTitle.
  ///
  /// In en, this message translates to:
  /// **'Zalo'**
  String get profileContactZaloTitle;

  /// No description provided for @profileContactFacebookTitle.
  ///
  /// In en, this message translates to:
  /// **'Facebook'**
  String get profileContactFacebookTitle;

  /// No description provided for @profileContactGmailTitle.
  ///
  /// In en, this message translates to:
  /// **'Gmail'**
  String get profileContactGmailTitle;

  /// No description provided for @profileContactFacebookSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Nguyen Quoc Trung (Shinjitsu Kudo)'**
  String get profileContactFacebookSubtitle;

  /// No description provided for @profileContactGmailSubtitle.
  ///
  /// In en, this message translates to:
  /// **'nqtrungit1999@gmail.com'**
  String get profileContactGmailSubtitle;

  /// No description provided for @profileContactZaloSubtitle.
  ///
  /// In en, this message translates to:
  /// **'+84975182035'**
  String get profileContactZaloSubtitle;

  /// No description provided for @notificationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsTitle;

  /// No description provided for @notificationsEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Nothing new yet'**
  String get notificationsEmptyTitle;

  /// No description provided for @notificationsEmptySubtitle.
  ///
  /// In en, this message translates to:
  /// **'New posts, stories, comments, and reactions will show up here.'**
  String get notificationsEmptySubtitle;

  /// No description provided for @notificationsHeaderSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Stay in sync with your community activity.'**
  String get notificationsHeaderSubtitle;

  /// No description provided for @notificationsReadAll.
  ///
  /// In en, this message translates to:
  /// **'Read all'**
  String get notificationsReadAll;

  /// No description provided for @notificationsLoadError.
  ///
  /// In en, this message translates to:
  /// **'Unable to load notifications.'**
  String get notificationsLoadError;

  /// No description provided for @notificationsHeaderTitle.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0 {All caught up} =1 {1 unread notification} other {{count} unread notifications}}'**
  String notificationsHeaderTitle(int count);

  /// No description provided for @profileAboutTitle.
  ///
  /// In en, this message translates to:
  /// **'Author'**
  String get profileAboutTitle;

  /// No description provided for @profileAboutSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Introduction screen for the creator behind iMovie.'**
  String get profileAboutSubtitle;

  /// No description provided for @profileAboutRole.
  ///
  /// In en, this message translates to:
  /// **'Mobile Developer'**
  String get profileAboutRole;

  /// No description provided for @profileAboutCompany.
  ///
  /// In en, this message translates to:
  /// **'Company'**
  String get profileAboutCompany;

  /// No description provided for @profileAboutHandle.
  ///
  /// In en, this message translates to:
  /// **'Handle'**
  String get profileAboutHandle;

  /// No description provided for @profileAboutFocusTitle.
  ///
  /// In en, this message translates to:
  /// **'Focus'**
  String get profileAboutFocusTitle;

  /// No description provided for @profileAboutFocusSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Flutter, GraphQL, Maps, Firebase, RESTful API, Clean Architecture, and polished mobile product experiences.'**
  String get profileAboutFocusSubtitle;

  /// No description provided for @profileAboutFocusFlutter.
  ///
  /// In en, this message translates to:
  /// **'Flutter'**
  String get profileAboutFocusFlutter;

  /// No description provided for @profileAboutFocusArchitecture.
  ///
  /// In en, this message translates to:
  /// **'Bloc'**
  String get profileAboutFocusArchitecture;

  /// No description provided for @profileAboutFocusBackend.
  ///
  /// In en, this message translates to:
  /// **'Supabase'**
  String get profileAboutFocusBackend;

  /// No description provided for @profileAboutFocusGraphql.
  ///
  /// In en, this message translates to:
  /// **'GraphQL'**
  String get profileAboutFocusGraphql;

  /// No description provided for @profileAboutFocusMaps.
  ///
  /// In en, this message translates to:
  /// **'Maps'**
  String get profileAboutFocusMaps;

  /// No description provided for @profileAboutFocusFirebase.
  ///
  /// In en, this message translates to:
  /// **'Firebase'**
  String get profileAboutFocusFirebase;

  /// No description provided for @profileAboutFocusRestfulApi.
  ///
  /// In en, this message translates to:
  /// **'RESTful API'**
  String get profileAboutFocusRestfulApi;

  /// No description provided for @profileAboutFocusCleanArchitecture.
  ///
  /// In en, this message translates to:
  /// **'Clean Architecture'**
  String get profileAboutFocusCleanArchitecture;

  /// No description provided for @profileAboutFocusProduct.
  ///
  /// In en, this message translates to:
  /// **'Product UI'**
  String get profileAboutFocusProduct;

  /// No description provided for @profileSettingsInviteFriends.
  ///
  /// In en, this message translates to:
  /// **'Invite friends'**
  String get profileSettingsInviteFriends;

  /// No description provided for @profileSettingsRateApp.
  ///
  /// In en, this message translates to:
  /// **'Rate the app'**
  String get profileSettingsRateApp;

  /// No description provided for @languageSelectTitle.
  ///
  /// In en, this message translates to:
  /// **'Select language'**
  String get languageSelectTitle;

  /// No description provided for @languageSelectSubtitle.
  ///
  /// In en, this message translates to:
  /// **'The language is applied immediately across the app.'**
  String get languageSelectSubtitle;

  /// No description provided for @languageEnglishTitle.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglishTitle;

  /// No description provided for @languageEnglishSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Use English for the app interface'**
  String get languageEnglishSubtitle;

  /// No description provided for @languageVietnameseTitle.
  ///
  /// In en, this message translates to:
  /// **'Tiếng Việt'**
  String get languageVietnameseTitle;

  /// No description provided for @languageVietnameseSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Use Vietnamese for the app interface'**
  String get languageVietnameseSubtitle;

  /// No description provided for @languageChangeSuccess.
  ///
  /// In en, this message translates to:
  /// **'Language updated.'**
  String get languageChangeSuccess;

  /// No description provided for @languageChangeError.
  ///
  /// In en, this message translates to:
  /// **'Unable to update language.'**
  String get languageChangeError;

  /// No description provided for @changePasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get changePasswordTitle;

  /// No description provided for @changePasswordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Use your current password to confirm this change, then enter a new password for future sign-ins.'**
  String get changePasswordSubtitle;

  /// No description provided for @changePasswordCurrentLabel.
  ///
  /// In en, this message translates to:
  /// **'Current password'**
  String get changePasswordCurrentLabel;

  /// No description provided for @changePasswordCurrentHint.
  ///
  /// In en, this message translates to:
  /// **'Enter current password'**
  String get changePasswordCurrentHint;

  /// No description provided for @changePasswordNewLabel.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get changePasswordNewLabel;

  /// No description provided for @changePasswordNewHint.
  ///
  /// In en, this message translates to:
  /// **'Enter new password'**
  String get changePasswordNewHint;

  /// No description provided for @changePasswordConfirmLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm new password'**
  String get changePasswordConfirmLabel;

  /// No description provided for @changePasswordConfirmHint.
  ///
  /// In en, this message translates to:
  /// **'Re-enter new password'**
  String get changePasswordConfirmHint;

  /// No description provided for @changePasswordSaveAction.
  ///
  /// In en, this message translates to:
  /// **'Update password'**
  String get changePasswordSaveAction;

  /// No description provided for @changePasswordInvalidCurrent.
  ///
  /// In en, this message translates to:
  /// **'Enter your current password.'**
  String get changePasswordInvalidCurrent;

  /// No description provided for @changePasswordInvalidNew.
  ///
  /// In en, this message translates to:
  /// **'New password must be at least 6 characters.'**
  String get changePasswordInvalidNew;

  /// No description provided for @changePasswordUnchanged.
  ///
  /// In en, this message translates to:
  /// **'New password must be different from the current password.'**
  String get changePasswordUnchanged;

  /// No description provided for @changePasswordSuccess.
  ///
  /// In en, this message translates to:
  /// **'Password updated successfully.'**
  String get changePasswordSuccess;

  /// No description provided for @communityTitle.
  ///
  /// In en, this message translates to:
  /// **'Community'**
  String get communityTitle;

  /// No description provided for @communityProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get communityProfileTitle;

  /// No description provided for @communityUserFallbackName.
  ///
  /// In en, this message translates to:
  /// **'iMovie user'**
  String get communityUserFallbackName;

  /// No description provided for @communityFollowAction.
  ///
  /// In en, this message translates to:
  /// **'Follow'**
  String get communityFollowAction;

  /// No description provided for @communityFollowingAction.
  ///
  /// In en, this message translates to:
  /// **'Following'**
  String get communityFollowingAction;

  /// No description provided for @communityFollowersLabel.
  ///
  /// In en, this message translates to:
  /// **'Followers'**
  String get communityFollowersLabel;

  /// No description provided for @communityFollowingLabel.
  ///
  /// In en, this message translates to:
  /// **'Following'**
  String get communityFollowingLabel;

  /// No description provided for @communityFollowersTitle.
  ///
  /// In en, this message translates to:
  /// **'Followers'**
  String get communityFollowersTitle;

  /// No description provided for @communityFollowingTitle.
  ///
  /// In en, this message translates to:
  /// **'Following'**
  String get communityFollowingTitle;

  /// No description provided for @communityFollowersEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No followers yet'**
  String get communityFollowersEmptyTitle;

  /// No description provided for @communityFollowersEmptySubtitle.
  ///
  /// In en, this message translates to:
  /// **'People who follow you will appear here.'**
  String get communityFollowersEmptySubtitle;

  /// No description provided for @communityFollowingEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Not following anyone yet'**
  String get communityFollowingEmptyTitle;

  /// No description provided for @communityFollowingEmptySubtitle.
  ///
  /// In en, this message translates to:
  /// **'People you follow will appear here.'**
  String get communityFollowingEmptySubtitle;

  /// No description provided for @communityPostsLabel.
  ///
  /// In en, this message translates to:
  /// **'Posts'**
  String get communityPostsLabel;

  /// No description provided for @communityStoriesMetricLabel.
  ///
  /// In en, this message translates to:
  /// **'Stories'**
  String get communityStoriesMetricLabel;

  /// No description provided for @communityFollowSuccess.
  ///
  /// In en, this message translates to:
  /// **'You are now following this user.'**
  String get communityFollowSuccess;

  /// No description provided for @communityUnfollowSuccess.
  ///
  /// In en, this message translates to:
  /// **'You unfollowed this user.'**
  String get communityUnfollowSuccess;

  /// No description provided for @communityProfileEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No posts yet'**
  String get communityProfileEmptyTitle;

  /// No description provided for @communityProfileEmptySubtitle.
  ///
  /// In en, this message translates to:
  /// **'This user\'s shared posts will appear here.'**
  String get communityProfileEmptySubtitle;

  /// No description provided for @communityMyPostsTitle.
  ///
  /// In en, this message translates to:
  /// **'My posts'**
  String get communityMyPostsTitle;

  /// No description provided for @communityComposerPrompt.
  ///
  /// In en, this message translates to:
  /// **'What are you watching today?'**
  String get communityComposerPrompt;

  /// No description provided for @communityPostMovieLabel.
  ///
  /// In en, this message translates to:
  /// **'Tagged movie'**
  String get communityPostMovieLabel;

  /// No description provided for @communityStoriesTitle.
  ///
  /// In en, this message translates to:
  /// **'Stories'**
  String get communityStoriesTitle;

  /// No description provided for @communityCreateStoryAction.
  ///
  /// In en, this message translates to:
  /// **'Create story'**
  String get communityCreateStoryAction;

  /// No description provided for @communityStoryEditorTitle.
  ///
  /// In en, this message translates to:
  /// **'Create story'**
  String get communityStoryEditorTitle;

  /// No description provided for @communityStoryTextHint.
  ///
  /// In en, this message translates to:
  /// **'Write on the image'**
  String get communityStoryTextHint;

  /// No description provided for @communityStoryPickImageAction.
  ///
  /// In en, this message translates to:
  /// **'Choose an image for your story'**
  String get communityStoryPickImageAction;

  /// No description provided for @communityStoryChangeImageAction.
  ///
  /// In en, this message translates to:
  /// **'Change image'**
  String get communityStoryChangeImageAction;

  /// No description provided for @communityStoryDoneEditingAction.
  ///
  /// In en, this message translates to:
  /// **'Hide keyboard'**
  String get communityStoryDoneEditingAction;

  /// No description provided for @communityStoryImageRequired.
  ///
  /// In en, this message translates to:
  /// **'Choose an image to create a story.'**
  String get communityStoryImageRequired;

  /// No description provided for @communityStoryPublishAction.
  ///
  /// In en, this message translates to:
  /// **'Publish story'**
  String get communityStoryPublishAction;

  /// No description provided for @communityCreateStorySuccess.
  ///
  /// In en, this message translates to:
  /// **'Story created.'**
  String get communityCreateStorySuccess;

  /// No description provided for @communityDeleteStorySuccess.
  ///
  /// In en, this message translates to:
  /// **'Story deleted.'**
  String get communityDeleteStorySuccess;

  /// No description provided for @communityCreateTitle.
  ///
  /// In en, this message translates to:
  /// **'Create post'**
  String get communityCreateTitle;

  /// No description provided for @communityEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit post'**
  String get communityEditTitle;

  /// No description provided for @communityEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No community posts yet'**
  String get communityEmptyTitle;

  /// No description provided for @communityMyPostsEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'You have not posted yet'**
  String get communityMyPostsEmptyTitle;

  /// No description provided for @communityEmptySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Share a reaction, a favorite title, or a moment from your watch session.'**
  String get communityEmptySubtitle;

  /// No description provided for @communityLoadError.
  ///
  /// In en, this message translates to:
  /// **'Unable to load community posts.'**
  String get communityLoadError;

  /// No description provided for @communityLikeAction.
  ///
  /// In en, this message translates to:
  /// **'Like'**
  String get communityLikeAction;

  /// No description provided for @communityCommentAction.
  ///
  /// In en, this message translates to:
  /// **'Comment'**
  String get communityCommentAction;

  /// No description provided for @communityEditAction.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get communityEditAction;

  /// No description provided for @communityDeleteAction.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get communityDeleteAction;

  /// No description provided for @communityDeleteSuccess.
  ///
  /// In en, this message translates to:
  /// **'Post deleted.'**
  String get communityDeleteSuccess;

  /// No description provided for @communityCommentsTitle.
  ///
  /// In en, this message translates to:
  /// **'Comments'**
  String get communityCommentsTitle;

  /// No description provided for @communityCommentsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No comments yet.'**
  String get communityCommentsEmpty;

  /// No description provided for @communityCommentHint.
  ///
  /// In en, this message translates to:
  /// **'Write a comment...'**
  String get communityCommentHint;

  /// No description provided for @communityCommentEmptyError.
  ///
  /// In en, this message translates to:
  /// **'Enter a comment first.'**
  String get communityCommentEmptyError;

  /// No description provided for @communityContentHint.
  ///
  /// In en, this message translates to:
  /// **'What do you think about this movie?'**
  String get communityContentHint;

  /// No description provided for @communityMovieHint.
  ///
  /// In en, this message translates to:
  /// **'Tag a movie title'**
  String get communityMovieHint;

  /// No description provided for @communityMovieSearchSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose a movie from search results'**
  String get communityMovieSearchSubtitle;

  /// No description provided for @communityMovieClearAction.
  ///
  /// In en, this message translates to:
  /// **'Clear selected movie'**
  String get communityMovieClearAction;

  /// No description provided for @communityMoviePickerTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose movie'**
  String get communityMoviePickerTitle;

  /// No description provided for @communityMovieSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search movie title'**
  String get communityMovieSearchHint;

  /// No description provided for @communityMovieSearchEmpty.
  ///
  /// In en, this message translates to:
  /// **'Enter at least 2 characters to search movies.'**
  String get communityMovieSearchEmpty;

  /// No description provided for @communityLocationHint.
  ///
  /// In en, this message translates to:
  /// **'Attach current address'**
  String get communityLocationHint;

  /// No description provided for @communityUseCurrentLocation.
  ///
  /// In en, this message translates to:
  /// **'Use current location'**
  String get communityUseCurrentLocation;

  /// No description provided for @communityLocationError.
  ///
  /// In en, this message translates to:
  /// **'Unable to get your current address.'**
  String get communityLocationError;

  /// No description provided for @communityPickImageAction.
  ///
  /// In en, this message translates to:
  /// **'Add image'**
  String get communityPickImageAction;

  /// No description provided for @communityRemoveImageAction.
  ///
  /// In en, this message translates to:
  /// **'Remove image'**
  String get communityRemoveImageAction;

  /// No description provided for @communityPublishAction.
  ///
  /// In en, this message translates to:
  /// **'Publish'**
  String get communityPublishAction;

  /// No description provided for @communityCancelAction.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get communityCancelAction;

  /// No description provided for @communityUpdateAction.
  ///
  /// In en, this message translates to:
  /// **'Update post'**
  String get communityUpdateAction;

  /// No description provided for @communityEmptyContentError.
  ///
  /// In en, this message translates to:
  /// **'Enter content or choose an image.'**
  String get communityEmptyContentError;

  /// No description provided for @communityCreateSuccess.
  ///
  /// In en, this message translates to:
  /// **'Post published.'**
  String get communityCreateSuccess;

  /// No description provided for @communityUpdateSuccess.
  ///
  /// In en, this message translates to:
  /// **'Post updated.'**
  String get communityUpdateSuccess;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'vi':
      return AppLocalizationsVi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
