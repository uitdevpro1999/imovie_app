import 'dart:developer' as developer;

abstract final class AppLogger {
  static void info(String message, {String name = 'iMovieApp'}) {
    developer.log(message, name: name, level: 800);
  }

  static void warning(
    String message, {
    String name = 'iMovieApp',
    Object? error,
    StackTrace? stackTrace,
  }) {
    developer.log(
      message,
      name: name,
      level: 900,
      error: error,
      stackTrace: stackTrace,
    );
  }

  static void error(
    String message, {
    String name = 'iMovieApp',
    Object? error,
    StackTrace? stackTrace,
  }) {
    developer.log(
      message,
      name: name,
      level: 1000,
      error: error,
      stackTrace: stackTrace,
    );
  }

  static String maskEmail(String email) {
    final normalized = email.trim();
    final atIndex = normalized.indexOf('@');
    if (atIndex <= 1) {
      return normalized.isEmpty ? '<empty>' : '***';
    }

    final name = normalized.substring(0, atIndex);
    final domain = normalized.substring(atIndex);
    return '${name[0]}***$domain';
  }

  static String shortId(String id) {
    final normalized = id.trim();
    if (normalized.length <= 8) {
      return normalized.isEmpty ? '<empty>' : normalized;
    }

    return '${normalized.substring(0, 8)}...';
  }
}
