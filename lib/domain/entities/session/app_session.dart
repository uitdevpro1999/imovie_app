import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_session.freezed.dart';

@freezed
abstract class AppSession with _$AppSession {
  const AppSession._();

  const factory AppSession({
    required bool isAuthenticated,
    String? userId,
    String? email,
  }) = _AppSession;

  factory AppSession.guest() => const AppSession(isAuthenticated: false);

  factory AppSession.authenticated({required String userId, String? email}) {
    return AppSession(isAuthenticated: true, userId: userId, email: email);
  }

  String get identityLabel => email ?? userId ?? 'Guest';
}
