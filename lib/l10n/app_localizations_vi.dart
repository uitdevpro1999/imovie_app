// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get appTitle => 'iMovie';

  @override
  String get retry => 'Thử lại';

  @override
  String get homeFilterAll => 'Tất cả';

  @override
  String get homeFilterUpdated => 'Mới cập nhật';

  @override
  String get homeFilterSeries => 'Phim bộ';

  @override
  String get homeFilterAnimation => 'Hoạt hình';

  @override
  String get homeFilterYear => 'Năm 2026';

  @override
  String get homeBadgeAdFree => 'Không quảng cáo';

  @override
  String get homeSectionFreshUpdates => 'Mới cập nhật';

  @override
  String get homeSectionHighestRated => 'Điểm cao nhất';

  @override
  String get homeSectionSeriesSpotlight => 'Phim bộ nổi bật';

  @override
  String get homeSectionAnimationPicks => 'Hoạt hình đáng chú ý';

  @override
  String get homeSectionTvShows => 'TV Shows';

  @override
  String get homeSectionUpcoming => 'Sắp chiếu';

  @override
  String get homeSectionTopThisWeek => 'Nổi bật tuần này';

  @override
  String get homeSectionViewMore => 'Xem thêm';

  @override
  String get homeBottomNavHome => 'Trang chủ';

  @override
  String get homeBottomNavBrowse => 'Khám phá';

  @override
  String get homeBottomNavCommunity => 'Cộng đồng';

  @override
  String get homeBottomNavLibrary => 'Tủ phim';

  @override
  String get homeBottomNavProfile => 'Tài khoản';

  @override
  String get homeHeroDefaultSubtitle =>
      'Những tựa phim mới cập nhật từ feed hôm nay';

  @override
  String get homeErrorLoadFeed => 'Không thể tải dữ liệu trang chủ.';

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
  String get movieDetailErrorLoad => 'Không thể tải chi tiết phim.';

  @override
  String get movieDetailPlay => 'Phát';

  @override
  String get movieDetailActionTrailer => 'Trailer';

  @override
  String get movieTrailerUnavailable => 'Không tìm thấy trailer cho phim này.';

  @override
  String get movieDetailActionWatchlist => 'Danh sách';

  @override
  String get movieDetailActionInLibrary => 'Đã lưu';

  @override
  String get movieDetailLibraryAddSuccess => 'Đã thêm vào tủ phim.';

  @override
  String get movieDetailLibraryEmptyMovie => 'Không có dữ liệu phim để lưu.';

  @override
  String get movieDetailActionRate => 'Đánh giá';

  @override
  String get movieDetailImdbOpenError => 'Không thể mở trang IMDb.';

  @override
  String get movieDetailTmdbOpenError => 'Không thể mở trang TMDb.';

  @override
  String get movieDetailRatingSourceTitle => 'Chọn trang đánh giá';

  @override
  String get movieDetailRatingSourceImdbSubtitle => 'Mở trang đánh giá IMDb';

  @override
  String get movieDetailRatingSourceTmdbSubtitle => 'Mở trang đánh giá TMDb';

  @override
  String get movieDetailActionShare => 'Chia sẻ';

  @override
  String get movieDetailActors => 'Diễn viên';

  @override
  String get movieDetailGenres => 'Thể loại';

  @override
  String get movieDetailInformation => 'Thông tin';

  @override
  String get movieDetailInfoOriginalTitle => 'Tên gốc';

  @override
  String get movieDetailInfoStatus => 'Trạng thái';

  @override
  String get movieDetailInfoYear => 'Năm';

  @override
  String get movieDetailInfoRuntime => 'Thời lượng';

  @override
  String get movieDetailInfoLanguage => 'Ngôn ngữ';

  @override
  String get movieDetailInfoQuality => 'Chất lượng';

  @override
  String get movieDetailInfoDirector => 'Đạo diễn';

  @override
  String get movieDetailRating => 'Đánh giá';

  @override
  String get movieDetailRateMovie => 'Đánh giá phim';

  @override
  String get movieDetailRecommended => 'Đề xuất';

  @override
  String movieDetailReviews(int count) {
    return '$count lượt đánh giá';
  }

  @override
  String get watchScreenTitle => 'Xem phim';

  @override
  String get watchLoadError => 'Không thể tải luồng phát này.';

  @override
  String get watchServerSection => 'Server';

  @override
  String get watchEpisodeSection => 'Tập';

  @override
  String get watchNoEpisodes => 'Server này chưa có danh sách tập.';

  @override
  String get watchNoPlayableSource =>
      'Không có nguồn phát khả dụng cho tập đã chọn.';

  @override
  String get watchPlayerError => 'Trình phát không thể khởi chạy luồng này.';

  @override
  String get watchPlayerPreview =>
      'Trong widget test, player được thay bằng placeholder xem trước.';

  @override
  String get watchNoEpisodeSelected => 'Chưa chọn tập';

  @override
  String get watchPlaybackSourceEmbed => 'Embed';

  @override
  String get watchPlaybackSourceM3u8 => 'M3U8';

  @override
  String get watchSwitchToEmbed => 'Đổi sang Embed';

  @override
  String get watchSwitchToM3u8 => 'Đổi sang M3U8';

  @override
  String watchEpisodeValue(Object episode) {
    return 'Tập $episode';
  }

  @override
  String watchServerValue(Object server) {
    return 'Server: $server';
  }

  @override
  String get authSignInTitle => 'Đăng nhập 👋🏻';

  @override
  String get authSignUpTitle => 'Đăng ký';

  @override
  String get authSignInSubtitle =>
      'Khi đăng nhập, bạn đồng ý với điều khoản sử dụng và chính sách quyền riêng tư của iMovie';

  @override
  String get authSignUpSubtitle =>
      'Tạo tài khoản để cá nhân hóa gợi ý phim dành riêng cho bạn';

  @override
  String get authEmailLabel => 'Email';

  @override
  String get authEmailHint => 'Email của bạn';

  @override
  String get authPasswordLabel => 'Mật khẩu';

  @override
  String get authPasswordHint => 'Mật khẩu';

  @override
  String get authConfirmPasswordLabel => 'Nhập lại mật khẩu';

  @override
  String get authConfirmPasswordHint => 'Nhập lại mật khẩu của bạn';

  @override
  String get authRememberMe => 'Ghi nhớ đăng nhập';

  @override
  String get authForgotPassword => 'Quên mật khẩu?';

  @override
  String get authForgotPasswordTitle => 'Quên mật khẩu';

  @override
  String get authForgotPasswordSubtitle =>
      'Nhập email tài khoản của bạn. iMovie sẽ gửi email hướng dẫn đặt lại mật khẩu.';

  @override
  String get authForgotPasswordSubmit => 'Gửi email đặt lại';

  @override
  String get authForgotPasswordSuccess =>
      'Nếu email tồn tại, iMovie sẽ gửi hướng dẫn đặt lại mật khẩu.';

  @override
  String get authAcceptTerms =>
      'Tôi đồng ý với Điều khoản sử dụng và Chính sách\nquyền riêng tư';

  @override
  String get authSignInAction => 'Đăng nhập';

  @override
  String get authSignUpAction => 'Đăng ký';

  @override
  String get authDividerOr => 'HOẶC';

  @override
  String get authSignInFooterPrefix => 'Chưa có tài khoản? ';

  @override
  String get authSignUpFooterPrefix => 'Đã có tài khoản? ';

  @override
  String get authInvalidEmail => 'Nhập địa chỉ email hợp lệ.';

  @override
  String get authInvalidPassword => 'Mật khẩu phải có ít nhất 6 ký tự.';

  @override
  String get authPasswordMismatch => 'Mật khẩu nhập lại không khớp.';

  @override
  String get authAcceptTermsError =>
      'Vui lòng đồng ý điều khoản trước khi tạo tài khoản.';

  @override
  String get authSignInSuccess => 'Đăng nhập thành công.';

  @override
  String get authSignUpSuccess => 'Tạo tài khoản thành công.';

  @override
  String get browseSearchHint => 'Phim, series, diễn viên';

  @override
  String get browseHeroTitle => 'Tìm phim hợp gu của bạn';

  @override
  String get browseHeroSubtitle =>
      'Lọc nhanh theo thể loại, quốc gia và năm phát hành.';

  @override
  String get browseStatCatalog => 'Danh mục';

  @override
  String get browseStatGenres => 'Thể loại';

  @override
  String get browseStatPopular => 'Đang có';

  @override
  String browseMovieCount(int count) {
    return '$count phim';
  }

  @override
  String browseSearchCount(int count) {
    return '$count kết quả';
  }

  @override
  String get browsePopularSection => 'Phổ biến';

  @override
  String get browseNoSearchResults => 'Không tìm thấy phim phù hợp';

  @override
  String get browseSearchResults => 'Kết quả tìm kiếm';

  @override
  String get libraryEmptyTitle => 'Tủ phim đang trống';

  @override
  String get libraryEmptySubtitle =>
      'Thêm phim từ màn chi tiết để xem lại nhanh hơn.';

  @override
  String get libraryCollectionTitle => 'Bộ sưu tập cá nhân';

  @override
  String get libraryCollectionSubtitle =>
      'Những bộ phim bạn đã lưu để quay lại bất cứ lúc nào.';

  @override
  String get libraryStatsMovies => 'Phim đã lưu';

  @override
  String get libraryStatsPlayable => 'Có thể xem';

  @override
  String get libraryStatsUpdated => 'Mới cập nhật';

  @override
  String librarySavedAt(String date) {
    return 'Đã lưu $date';
  }

  @override
  String get librarySwipeHint => 'Vuốt sang trái để xóa';

  @override
  String get libraryRemoveConfirmTitle => 'Xóa khỏi tủ phim?';

  @override
  String get libraryRemoveConfirmMessage =>
      'Phim này sẽ bị xóa khỏi tủ phim của bạn. Bạn vẫn có thể thêm lại từ màn chi tiết phim.';

  @override
  String get libraryRemoveConfirmCancel => 'Hủy';

  @override
  String get libraryRemoveConfirmAction => 'Xóa';

  @override
  String get libraryRemoveAction => 'Xóa';

  @override
  String get libraryRemoveSuccess => 'Đã xóa khỏi tủ phim.';

  @override
  String get libraryErrorLoad => 'Không thể tải tủ phim.';

  @override
  String get profileTitle => 'Hồ sơ';

  @override
  String get profileChangeAvatar => 'Đổi ảnh đại diện';

  @override
  String get profileChangeCover => 'Đổi ảnh bìa';

  @override
  String get profileFullNameLabel => 'Họ và tên';

  @override
  String get profileFullNameHint => 'Nhập họ và tên';

  @override
  String get profilePhoneLabel => 'Số điện thoại';

  @override
  String get profilePhoneHint => 'Nhập số điện thoại';

  @override
  String get profileSaveAction => 'Lưu hồ sơ';

  @override
  String get profileSignOutAction => 'Đăng xuất';

  @override
  String get profileSignedOutTitle => 'Đăng nhập để quản lý hồ sơ';

  @override
  String get profileSignedOutSubtitle =>
      'Ảnh đại diện, tên và số điện thoại sẽ hiển thị sau khi đăng nhập.';

  @override
  String get profileEmpty => 'Không tìm thấy hồ sơ cho tài khoản này.';

  @override
  String get profileSaved => 'Đã cập nhật hồ sơ.';

  @override
  String get profileAvatarSaved => 'Đã cập nhật ảnh đại diện.';

  @override
  String get profileInvalidAvatar => 'Vui lòng chọn một file ảnh hợp lệ.';

  @override
  String get profileFullNameRequired => 'Vui lòng nhập họ và tên.';

  @override
  String get profileSignOutError => 'Không thể đăng xuất.';

  @override
  String get profileWatchHistory => 'Lịch sử xem của tôi';

  @override
  String get profileMovies => 'Phim';

  @override
  String get profileShows => 'Series';

  @override
  String get profileEpisodes => 'Tập';

  @override
  String get profileStatsPosts => 'Bài viết';

  @override
  String get profileStatsFollowers => 'Follower';

  @override
  String get profileStatsFollowing => 'Đã follow';

  @override
  String get profileMainSettings => 'Cài đặt chính';

  @override
  String get profileOtherSettings => 'Khác';

  @override
  String get profileSettingsProfile => 'Cài đặt hồ sơ';

  @override
  String get profileSettingsCommunity => 'Cộng đồng';

  @override
  String get profileSettingsMyPosts => 'Hồ sơ của tôi';

  @override
  String get profileSettingsNotifications => 'Thông báo';

  @override
  String get profileSettingsAudioSubtitles => 'Âm thanh phụ đề';

  @override
  String get profileSettingsAppearance => 'Giao diện';

  @override
  String get profileSettingsDefault => 'Mặc định';

  @override
  String get profileSettingsLanguage => 'Ngôn ngữ';

  @override
  String get profileSettingsEnglish => 'Tiếng Anh';

  @override
  String get profileSettingsVietnamese => 'Tiếng Việt';

  @override
  String get profileSettingsHelpCenter => 'Trung tâm trợ giúp';

  @override
  String get profileSettingsSecurity => 'Bảo mật';

  @override
  String get profileSettingsAbout => 'Giới thiệu';

  @override
  String get profileContactTitle => 'Thông tin liên hệ';

  @override
  String get profileContactSubtitle =>
      'Các kênh liên hệ trực tiếp với Nguyễn Quốc Trung.';

  @override
  String get profileContactOpenAction => 'Mở';

  @override
  String get profileContactCopyAction => 'Sao chép';

  @override
  String get profileContactCopied => 'Đã sao chép thông tin liên hệ.';

  @override
  String get profileContactOpenError => 'Không thể mở kênh liên hệ này.';

  @override
  String get profileContactZaloTitle => 'Zalo';

  @override
  String get profileContactFacebookTitle => 'Facebook';

  @override
  String get profileContactGmailTitle => 'Gmail';

  @override
  String get profileContactFacebookSubtitle =>
      'Nguyễn Quốc Trung (Shinjitsu Kudo)';

  @override
  String get profileContactGmailSubtitle => 'nqtrungit1999@gmail.com';

  @override
  String get profileContactZaloSubtitle => '+84975182035';

  @override
  String get notificationsTitle => 'Thông báo';

  @override
  String get notificationsEmptyTitle => 'Chưa có thông báo mới';

  @override
  String get notificationsEmptySubtitle =>
      'Bài viết, tin, bình luận và cảm xúc mới sẽ hiện ở đây.';

  @override
  String get notificationsHeaderSubtitle =>
      'Theo dõi mọi tương tác cộng đồng của bạn.';

  @override
  String get notificationsReadAll => 'Đọc tất cả';

  @override
  String get notificationsLoadError => 'Không thể tải thông báo.';

  @override
  String notificationsHeaderTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count thông báo chưa đọc',
      one: '1 thông báo chưa đọc',
      zero: 'Bạn đã xem hết',
    );
    return '$_temp0';
  }

  @override
  String get profileAboutTitle => 'Tác giả';

  @override
  String get profileAboutSubtitle =>
      'Màn hình giới thiệu người xây dựng iMovie.';

  @override
  String get profileAboutRole => 'Mobile Developer';

  @override
  String get profileAboutCompany => 'Công ty';

  @override
  String get profileAboutHandle => 'Tài khoản';

  @override
  String get profileAboutFocusTitle => 'Chuyên môn';

  @override
  String get profileAboutFocusSubtitle =>
      'Flutter, GraphQL, Maps, Firebase, RESTful API, Clean Architecture và trải nghiệm sản phẩm mobile.';

  @override
  String get profileAboutFocusFlutter => 'Flutter';

  @override
  String get profileAboutFocusArchitecture => 'Bloc';

  @override
  String get profileAboutFocusBackend => 'Supabase';

  @override
  String get profileAboutFocusGraphql => 'GraphQL';

  @override
  String get profileAboutFocusMaps => 'Maps';

  @override
  String get profileAboutFocusFirebase => 'Firebase';

  @override
  String get profileAboutFocusRestfulApi => 'RESTful API';

  @override
  String get profileAboutFocusCleanArchitecture => 'Clean Architecture';

  @override
  String get profileAboutFocusProduct => 'Product UI';

  @override
  String get profileSettingsInviteFriends => 'Mời bạn bè';

  @override
  String get profileSettingsRateApp => 'Đánh giá ứng dụng';

  @override
  String get languageSelectTitle => 'Chọn ngôn ngữ';

  @override
  String get languageSelectSubtitle =>
      'Ngôn ngữ được áp dụng ngay cho toàn bộ ứng dụng.';

  @override
  String get languageEnglishTitle => 'English';

  @override
  String get languageEnglishSubtitle => 'Use English for app interface';

  @override
  String get languageVietnameseTitle => 'Tiếng Việt';

  @override
  String get languageVietnameseSubtitle =>
      'Sử dụng tiếng Việt cho giao diện ứng dụng';

  @override
  String get languageChangeSuccess => 'Đã cập nhật ngôn ngữ.';

  @override
  String get languageChangeError => 'Không thể cập nhật ngôn ngữ.';

  @override
  String get changePasswordTitle => 'Đổi mật khẩu';

  @override
  String get changePasswordSubtitle =>
      'Nhập mật khẩu hiện tại để xác nhận thay đổi, sau đó dùng mật khẩu mới cho các lần đăng nhập tiếp theo.';

  @override
  String get changePasswordCurrentLabel => 'Mật khẩu hiện tại';

  @override
  String get changePasswordCurrentHint => 'Nhập mật khẩu hiện tại';

  @override
  String get changePasswordNewLabel => 'Mật khẩu mới';

  @override
  String get changePasswordNewHint => 'Nhập mật khẩu mới';

  @override
  String get changePasswordConfirmLabel => 'Xác nhận mật khẩu mới';

  @override
  String get changePasswordConfirmHint => 'Nhập lại mật khẩu mới';

  @override
  String get changePasswordSaveAction => 'Cập nhật mật khẩu';

  @override
  String get changePasswordInvalidCurrent => 'Vui lòng nhập mật khẩu hiện tại.';

  @override
  String get changePasswordInvalidNew =>
      'Mật khẩu mới phải có ít nhất 6 ký tự.';

  @override
  String get changePasswordUnchanged =>
      'Mật khẩu mới phải khác mật khẩu hiện tại.';

  @override
  String get changePasswordSuccess => 'Đã cập nhật mật khẩu.';

  @override
  String get communityTitle => 'Cộng đồng';

  @override
  String get communityProfileTitle => 'Hồ sơ';

  @override
  String get communityUserFallbackName => 'Người dùng iMovie';

  @override
  String get communityFollowAction => 'Theo dõi';

  @override
  String get communityFollowingAction => 'Đã follow';

  @override
  String get communityFollowersLabel => 'Follower';

  @override
  String get communityFollowingLabel => 'Đã follow';

  @override
  String get communityFollowersTitle => 'Follower';

  @override
  String get communityFollowingTitle => 'Đã follow';

  @override
  String get communityFollowersEmptyTitle => 'Chưa có Follower';

  @override
  String get communityFollowersEmptySubtitle =>
      'Follower của bạn sẽ xuất hiện ở đây.';

  @override
  String get communityFollowingEmptyTitle => 'Chưa follow ai';

  @override
  String get communityFollowingEmptySubtitle =>
      'Những người bạn đã follow sẽ xuất hiện ở đây.';

  @override
  String get communityPostsLabel => 'Bài viết';

  @override
  String get communityStoriesMetricLabel => 'Tin';

  @override
  String get communityFollowSuccess => 'Đã follow người dùng này.';

  @override
  String get communityUnfollowSuccess => 'Đã bỏ follow người dùng này.';

  @override
  String get communityProfileEmptyTitle => 'Chưa có bài viết';

  @override
  String get communityProfileEmptySubtitle =>
      'Các bài viết được chia sẻ của người dùng này sẽ hiển thị tại đây.';

  @override
  String get communityMyPostsTitle => 'Bài viết của tôi';

  @override
  String get communityComposerPrompt => 'Bạn đang nghĩ gì về bộ phim hôm nay?';

  @override
  String get communityPostMovieLabel => 'Phim được gắn';

  @override
  String get communityStoriesTitle => 'Tin';

  @override
  String get communityCreateStoryAction => 'Tạo tin';

  @override
  String get communityStoryEditorTitle => 'Tạo tin';

  @override
  String get communityStoryTextHint => 'Viết chữ lên ảnh';

  @override
  String get communityStoryPickImageAction => 'Chọn ảnh để tạo tin';

  @override
  String get communityStoryChangeImageAction => 'Đổi ảnh';

  @override
  String get communityStoryDoneEditingAction => 'Ẩn bàn phím';

  @override
  String get communityStoryImageRequired => 'Vui lòng chọn ảnh để tạo tin.';

  @override
  String get communityStoryPublishAction => 'Đăng tin';

  @override
  String get communityCreateStorySuccess => 'Đã tạo tin.';

  @override
  String get communityDeleteStorySuccess => 'Đã xóa tin.';

  @override
  String get communityCreateTitle => 'Tạo bài viết';

  @override
  String get communityEditTitle => 'Sửa bài viết';

  @override
  String get communityEmptyTitle => 'Chưa có bài viết cộng đồng';

  @override
  String get communityMyPostsEmptyTitle => 'Bạn chưa đăng bài viết nào';

  @override
  String get communityEmptySubtitle =>
      'Chia sẻ cảm nhận, tựa phim yêu thích hoặc khoảnh khắc xem phim của bạn.';

  @override
  String get communityLoadError => 'Không thể tải bài viết cộng đồng.';

  @override
  String get communityLikeAction => 'Thích';

  @override
  String get communityCommentAction => 'Bình luận';

  @override
  String get communityEditAction => 'Sửa';

  @override
  String get communityDeleteAction => 'Xóa';

  @override
  String get communityDeleteSuccess => 'Đã xóa bài viết.';

  @override
  String get communityCommentsTitle => 'Bình luận';

  @override
  String get communityCommentsEmpty => 'Chưa có bình luận nào.';

  @override
  String get communityCommentHint => 'Viết bình luận...';

  @override
  String get communityCommentEmptyError => 'Vui lòng nhập nội dung bình luận.';

  @override
  String get communityContentHint => 'Bạn đang nghĩ gì về bộ phim này?';

  @override
  String get communityMovieHint => 'Gắn tên tựa phim';

  @override
  String get communityMovieSearchSubtitle => 'Chọn phim từ dữ liệu tìm kiếm';

  @override
  String get communityMovieClearAction => 'Bỏ phim đã chọn';

  @override
  String get communityMoviePickerTitle => 'Chọn phim';

  @override
  String get communityMovieSearchHint => 'Tìm tên phim';

  @override
  String get communityMovieSearchEmpty => 'Nhập ít nhất 2 ký tự để tìm phim.';

  @override
  String get communityLocationHint => 'Gắn địa chỉ hiện tại';

  @override
  String get communityUseCurrentLocation => 'Dùng vị trí hiện tại';

  @override
  String get communityLocationError => 'Không thể lấy địa chỉ hiện tại.';

  @override
  String get communityPickImageAction => 'Thêm ảnh';

  @override
  String get communityRemoveImageAction => 'Bỏ ảnh';

  @override
  String get communityPublishAction => 'Đăng bài';

  @override
  String get communityCancelAction => 'Hủy';

  @override
  String get communityUpdateAction => 'Cập nhật bài viết';

  @override
  String get communityEmptyContentError =>
      'Vui lòng nhập nội dung hoặc chọn ảnh.';

  @override
  String get communityCreateSuccess => 'Đã đăng bài viết.';

  @override
  String get communityUpdateSuccess => 'Đã cập nhật bài viết.';
}
