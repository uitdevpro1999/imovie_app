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
  /// **'iMovie App'**
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

  /// No description provided for @movieDetailActionWatchlist.
  ///
  /// In en, this message translates to:
  /// **'Watchlist'**
  String get movieDetailActionWatchlist;

  /// No description provided for @movieDetailActionRate.
  ///
  /// In en, this message translates to:
  /// **'Rate'**
  String get movieDetailActionRate;

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
  /// **'By signing in, you agree to MovieGo conditions of\nUse and Privacy Policy'**
  String get authSignInSubtitle;

  /// No description provided for @authSignUpSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Create account in a second, this need to personalize\nrecommendations for you'**
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
  /// **'Enter your account email. MovieGo will send password reset instructions to that address.'**
  String get authForgotPasswordSubtitle;

  /// No description provided for @authForgotPasswordSubmit.
  ///
  /// In en, this message translates to:
  /// **'Send reset email'**
  String get authForgotPasswordSubmit;

  /// No description provided for @authForgotPasswordSuccess.
  ///
  /// In en, this message translates to:
  /// **'If the email exists, MovieGo will send password reset instructions.'**
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
