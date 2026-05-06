// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'iMovie';

  @override
  String get retry => 'Retry';

  @override
  String get homeFilterAll => 'All';

  @override
  String get homeFilterUpdated => 'Updated';

  @override
  String get homeFilterSeries => 'Series';

  @override
  String get homeFilterAnimation => 'Animation';

  @override
  String get homeFilterYear => '2026';

  @override
  String get homeBadgeAdFree => 'No ADS';

  @override
  String get homeSectionFreshUpdates => 'Fresh updates';

  @override
  String get homeSectionHighestRated => 'Highest rated';

  @override
  String get homeSectionSeriesSpotlight => 'Series spotlight';

  @override
  String get homeSectionAnimationPicks => 'Animation picks';

  @override
  String get homeSectionTvShows => 'TV Shows';

  @override
  String get homeSectionUpcoming => 'Coming soon';

  @override
  String get homeSectionTopThisWeek => 'Top this week';

  @override
  String get homeSectionViewMore => 'View more';

  @override
  String get homeBottomNavHome => 'Home';

  @override
  String get homeBottomNavBrowse => 'Browse';

  @override
  String get homeBottomNavCommunity => 'Community';

  @override
  String get homeBottomNavLibrary => 'Library';

  @override
  String get homeBottomNavProfile => 'Profile';

  @override
  String get homeHeroDefaultSubtitle =>
      'Recently updated titles from the latest feed';

  @override
  String get homeErrorLoadFeed => 'Unable to load the home feed.';

  @override
  String homeMetaEpisode(Object episode, Object duration) {
    return '$episode • $duration';
  }

  @override
  String homeMetaLanguage(Object language, Object quality) {
    return '$language • $quality';
  }

  @override
  String homeMetaYear(Object year) {
    return '$year';
  }

  @override
  String get movieDetailErrorLoad => 'Unable to load the movie details.';

  @override
  String get movieDetailPlay => 'Play';

  @override
  String get movieDetailActionTrailer => 'Trailer';

  @override
  String get movieTrailerUnavailable =>
      'No trailer is available for this movie.';

  @override
  String get movieDetailActionWatchlist => 'Watchlist';

  @override
  String get movieDetailActionInLibrary => 'Saved';

  @override
  String get movieDetailLibraryAddSuccess => 'Added to your library.';

  @override
  String get movieDetailLibraryEmptyMovie =>
      'No movie data is available to save.';

  @override
  String get movieDetailActionRate => 'Rate';

  @override
  String get movieDetailImdbOpenError => 'Unable to open IMDb.';

  @override
  String get movieDetailTmdbOpenError => 'Unable to open TMDb.';

  @override
  String get movieDetailRatingSourceTitle => 'Choose rating site';

  @override
  String get movieDetailRatingSourceImdbSubtitle => 'Open IMDb ratings';

  @override
  String get movieDetailRatingSourceTmdbSubtitle => 'Open TMDb ratings';

  @override
  String get movieDetailActionShare => 'Share';

  @override
  String get movieDetailActors => 'Actors';

  @override
  String get movieDetailGenres => 'Genres';

  @override
  String get movieDetailInformation => 'Information';

  @override
  String get movieDetailInfoOriginalTitle => 'Original title';

  @override
  String get movieDetailInfoStatus => 'Status';

  @override
  String get movieDetailInfoYear => 'Year';

  @override
  String get movieDetailInfoRuntime => 'Runtime';

  @override
  String get movieDetailInfoLanguage => 'Language';

  @override
  String get movieDetailInfoQuality => 'Quality';

  @override
  String get movieDetailInfoDirector => 'Director';

  @override
  String get movieDetailRating => 'Rating';

  @override
  String get movieDetailRateMovie => 'Rate the movie';

  @override
  String get movieDetailRecommended => 'Recommended';

  @override
  String movieDetailReviews(int count) {
    return '$count reviews';
  }

  @override
  String get watchScreenTitle => 'Watch';

  @override
  String get watchLoadError => 'Unable to load this stream.';

  @override
  String get watchServerSection => 'Servers';

  @override
  String get watchEpisodeSection => 'Episodes';

  @override
  String get watchNoEpisodes => 'This server does not have any episodes yet.';

  @override
  String get watchNoPlayableSource =>
      'No playable m3u8 source is available for the selected episode.';

  @override
  String get watchPlayerError => 'The player could not start this stream.';

  @override
  String get watchPlayerPreview =>
      'Video preview is replaced with a test placeholder in widget tests.';

  @override
  String get watchNoEpisodeSelected => 'No episode selected';

  @override
  String watchEpisodeValue(Object episode) {
    return 'Episode $episode';
  }

  @override
  String watchServerValue(Object server) {
    return 'Server: $server';
  }

  @override
  String get authSignInTitle => 'Sign In 👋🏻';

  @override
  String get authSignUpTitle => 'Sign Up';

  @override
  String get authSignInSubtitle =>
      'By signing in, you agree to iMovie conditions of\nUse and Privacy Policy';

  @override
  String get authSignUpSubtitle =>
      'Create account in a second, this need to personalize\nrecommendations for you';

  @override
  String get authEmailLabel => 'Email';

  @override
  String get authEmailHint => 'Your email';

  @override
  String get authPasswordLabel => 'Password';

  @override
  String get authPasswordHint => 'Password';

  @override
  String get authConfirmPasswordLabel => 'Confirm password';

  @override
  String get authConfirmPasswordHint => 'Re-enter your password';

  @override
  String get authRememberMe => 'Remember me';

  @override
  String get authForgotPassword => 'Forgot Password?';

  @override
  String get authForgotPasswordTitle => 'Forgot password';

  @override
  String get authForgotPasswordSubtitle =>
      'Enter your account email. iMovie will send password reset instructions to that address.';

  @override
  String get authForgotPasswordSubmit => 'Send reset email';

  @override
  String get authForgotPasswordSuccess =>
      'If the email exists, iMovie will send password reset instructions.';

  @override
  String get authAcceptTerms =>
      'I agree to Terms & Conditions and Privacy\nPolicy';

  @override
  String get authSignInAction => 'Sign In';

  @override
  String get authSignUpAction => 'Sign Up';

  @override
  String get authDividerOr => 'OR';

  @override
  String get authSignInFooterPrefix => 'Don’t have an account? ';

  @override
  String get authSignUpFooterPrefix => 'Already have an account? ';

  @override
  String get authInvalidEmail => 'Enter a valid email address.';

  @override
  String get authInvalidPassword => 'Password must be at least 6 characters.';

  @override
  String get authPasswordMismatch =>
      'The confirmation password does not match.';

  @override
  String get authAcceptTermsError =>
      'Accept the terms before creating an account.';

  @override
  String get authSignInSuccess => 'Signed in successfully.';

  @override
  String get authSignUpSuccess => 'Account created successfully.';

  @override
  String get browseSearchHint => 'Movies, series, actors';

  @override
  String get browsePopularSection => 'Popular';

  @override
  String get browseNoSearchResults => 'No matching movies found';

  @override
  String get browseSearchResults => 'Search results';

  @override
  String get libraryEmptyTitle => 'Your library is empty';

  @override
  String get libraryEmptySubtitle =>
      'Add movies from the detail screen to find them here.';

  @override
  String get libraryRemoveAction => 'Remove';

  @override
  String get libraryRemoveSuccess => 'Removed from your library.';

  @override
  String get libraryErrorLoad => 'Unable to load your movie library.';

  @override
  String get profileTitle => 'Profile';

  @override
  String get profileChangeAvatar => 'Change avatar';

  @override
  String get profileFullNameLabel => 'Full name';

  @override
  String get profileFullNameHint => 'Enter your full name';

  @override
  String get profilePhoneLabel => 'Phone number';

  @override
  String get profilePhoneHint => 'Enter your phone number';

  @override
  String get profileSaveAction => 'Save profile';

  @override
  String get profileSignOutAction => 'Sign out';

  @override
  String get profileSignedOutTitle => 'Sign in to manage your profile';

  @override
  String get profileSignedOutSubtitle =>
      'Your avatar, name, and phone number are available after signing in.';

  @override
  String get profileEmpty => 'No profile data was found for this account.';

  @override
  String get profileSaved => 'Profile updated successfully.';

  @override
  String get profileAvatarSaved => 'Avatar updated successfully.';

  @override
  String get profileInvalidAvatar => 'Choose a valid image file.';

  @override
  String get profileFullNameRequired => 'Enter your full name.';

  @override
  String get profileSignOutError => 'Unable to sign out.';

  @override
  String get profileWatchHistory => 'My watch history';

  @override
  String get profileMovies => 'Movies';

  @override
  String get profileShows => 'Shows';

  @override
  String get profileEpisodes => 'Episodes';

  @override
  String get profileMainSettings => 'Main settings';

  @override
  String get profileOtherSettings => 'Others';

  @override
  String get profileSettingsProfile => 'Profile settings';

  @override
  String get profileSettingsCommunity => 'Community';

  @override
  String get profileSettingsMyPosts => 'My posts';

  @override
  String get profileSettingsNotifications => 'Notifications';

  @override
  String get profileSettingsAudioSubtitles => 'Audio subtitles';

  @override
  String get profileSettingsAppearance => 'Appearance';

  @override
  String get profileSettingsDefault => 'Default';

  @override
  String get profileSettingsLanguage => 'Language';

  @override
  String get profileSettingsEnglish => 'English';

  @override
  String get profileSettingsVietnamese => 'Vietnamese';

  @override
  String get profileSettingsHelpCenter => 'Help center';

  @override
  String get profileSettingsSecurity => 'Security';

  @override
  String get profileSettingsAbout => 'About';

  @override
  String get profileSettingsInviteFriends => 'Invite friends';

  @override
  String get profileSettingsRateApp => 'Rate the app';

  @override
  String get languageSelectTitle => 'Select language';

  @override
  String get languageSelectSubtitle =>
      'The language is applied immediately across the app.';

  @override
  String get languageEnglishTitle => 'English';

  @override
  String get languageEnglishSubtitle => 'Use English for the app interface';

  @override
  String get languageVietnameseTitle => 'Tiếng Việt';

  @override
  String get languageVietnameseSubtitle =>
      'Use Vietnamese for the app interface';

  @override
  String get languageChangeSuccess => 'Language updated.';

  @override
  String get languageChangeError => 'Unable to update language.';

  @override
  String get changePasswordTitle => 'Change password';

  @override
  String get changePasswordSubtitle =>
      'Use your current password to confirm this change, then enter a new password for future sign-ins.';

  @override
  String get changePasswordCurrentLabel => 'Current password';

  @override
  String get changePasswordCurrentHint => 'Enter current password';

  @override
  String get changePasswordNewLabel => 'New password';

  @override
  String get changePasswordNewHint => 'Enter new password';

  @override
  String get changePasswordConfirmLabel => 'Confirm new password';

  @override
  String get changePasswordConfirmHint => 'Re-enter new password';

  @override
  String get changePasswordSaveAction => 'Update password';

  @override
  String get changePasswordInvalidCurrent => 'Enter your current password.';

  @override
  String get changePasswordInvalidNew =>
      'New password must be at least 6 characters.';

  @override
  String get changePasswordUnchanged =>
      'New password must be different from the current password.';

  @override
  String get changePasswordSuccess => 'Password updated successfully.';

  @override
  String get communityTitle => 'Community';

  @override
  String get communityMyPostsTitle => 'My posts';

  @override
  String get communityComposerPrompt => 'What are you watching today?';

  @override
  String get communityPostMovieLabel => 'Tagged movie';

  @override
  String get communityStoriesTitle => 'Stories';

  @override
  String get communityCreateStoryAction => 'Create story';

  @override
  String get communityStoryEditorTitle => 'Create story';

  @override
  String get communityStoryTextHint => 'Write on the image';

  @override
  String get communityStoryPickImageAction => 'Choose an image for your story';

  @override
  String get communityStoryChangeImageAction => 'Change image';

  @override
  String get communityStoryImageRequired =>
      'Choose an image to create a story.';

  @override
  String get communityStoryPublishAction => 'Publish story';

  @override
  String get communityCreateStorySuccess => 'Story created.';

  @override
  String get communityDeleteStorySuccess => 'Story deleted.';

  @override
  String get communityCreateTitle => 'Create post';

  @override
  String get communityEditTitle => 'Edit post';

  @override
  String get communityEmptyTitle => 'No community posts yet';

  @override
  String get communityMyPostsEmptyTitle => 'You have not posted yet';

  @override
  String get communityEmptySubtitle =>
      'Share a reaction, a favorite title, or a moment from your watch session.';

  @override
  String get communityLoadError => 'Unable to load community posts.';

  @override
  String get communityLikeAction => 'Like';

  @override
  String get communityCommentAction => 'Comment';

  @override
  String get communityEditAction => 'Edit';

  @override
  String get communityDeleteAction => 'Delete';

  @override
  String get communityDeleteSuccess => 'Post deleted.';

  @override
  String get communityCommentsTitle => 'Comments';

  @override
  String get communityCommentsEmpty => 'No comments yet.';

  @override
  String get communityCommentHint => 'Write a comment...';

  @override
  String get communityCommentEmptyError => 'Enter a comment first.';

  @override
  String get communityContentHint => 'What do you think about this movie?';

  @override
  String get communityMovieHint => 'Tag a movie title';

  @override
  String get communityMovieSearchSubtitle =>
      'Choose a movie from search results';

  @override
  String get communityMovieClearAction => 'Clear selected movie';

  @override
  String get communityMoviePickerTitle => 'Choose movie';

  @override
  String get communityMovieSearchHint => 'Search movie title';

  @override
  String get communityMovieSearchEmpty =>
      'Enter at least 2 characters to search movies.';

  @override
  String get communityLocationHint => 'Attach current address';

  @override
  String get communityUseCurrentLocation => 'Use current location';

  @override
  String get communityLocationError => 'Unable to get your current address.';

  @override
  String get communityPickImageAction => 'Add image';

  @override
  String get communityRemoveImageAction => 'Remove image';

  @override
  String get communityPublishAction => 'Publish';

  @override
  String get communityUpdateAction => 'Update post';

  @override
  String get communityEmptyContentError => 'Enter content or choose an image.';

  @override
  String get communityCreateSuccess => 'Post published.';

  @override
  String get communityUpdateSuccess => 'Post updated.';
}
