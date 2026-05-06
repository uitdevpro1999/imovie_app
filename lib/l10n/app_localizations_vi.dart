// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get appTitle => 'iMovie App';

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
  String get homeSectionTopThisWeek => 'Nổi bật tuần này';

  @override
  String get homeSectionViewMore => 'Xem thêm';

  @override
  String get homeBottomNavHome => 'Trang chủ';

  @override
  String get homeBottomNavBrowse => 'Khám phá';

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
  String get movieDetailActionWatchlist => 'Danh sách';

  @override
  String get movieDetailActionRate => 'Đánh giá';

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
      'Không có nguồn m3u8 khả dụng cho tập đã chọn.';

  @override
  String get watchPlayerError => 'Trình phát không thể khởi chạy luồng này.';

  @override
  String get watchPlayerPreview =>
      'Trong widget test, player được thay bằng placeholder xem trước.';

  @override
  String get watchNoEpisodeSelected => 'Chưa chọn tập';

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
      'Khi đăng nhập, bạn đồng ý với điều khoản sử dụng\nvà chính sách quyền riêng tư của MovieGo';

  @override
  String get authSignUpSubtitle =>
      'Tạo tài khoản để cá nhân hóa gợi ý phim\ndành riêng cho bạn';

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
      'Nhập email tài khoản của bạn. MovieGo sẽ gửi email hướng dẫn đặt lại mật khẩu.';

  @override
  String get authForgotPasswordSubmit => 'Gửi email đặt lại';

  @override
  String get authForgotPasswordSuccess =>
      'Nếu email tồn tại, MovieGo sẽ gửi hướng dẫn đặt lại mật khẩu.';

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
  String get browsePopularSection => 'Phổ biến';

  @override
  String get browseNoSearchResults => 'Không tìm thấy phim phù hợp';

  @override
  String get browseSearchResults => 'Kết quả tìm kiếm';

  @override
  String get profileTitle => 'Hồ sơ';

  @override
  String get profileChangeAvatar => 'Đổi ảnh đại diện';

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
  String get profileMainSettings => 'Cài đặt chính';

  @override
  String get profileOtherSettings => 'Khác';

  @override
  String get profileSettingsProfile => 'Cài đặt hồ sơ';

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
  String get profileSettingsHelpCenter => 'Trung tâm trợ giúp';

  @override
  String get profileSettingsSecurity => 'Bảo mật';

  @override
  String get profileSettingsAbout => 'Giới thiệu';

  @override
  String get profileSettingsInviteFriends => 'Mời bạn bè';

  @override
  String get profileSettingsRateApp => 'Đánh giá ứng dụng';
}
