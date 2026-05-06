import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_failure.freezed.dart';

enum FailureType {
  configuration,
  unauthorized,
  network,
  notFound,
  server,
  unknown,
}

@freezed
abstract class AppFailure with _$AppFailure {
  const AppFailure._();

  const factory AppFailure({
    required FailureType type,
    required String message,
    String? details,
  }) = _AppFailure;

  factory AppFailure.configuration(String message, {String? details}) {
    return AppFailure(
      type: FailureType.configuration,
      message: message,
      details: details,
    );
  }

  factory AppFailure.unauthorized(String message, {String? details}) {
    return AppFailure(
      type: FailureType.unauthorized,
      message: message,
      details: details,
    );
  }

  factory AppFailure.network(String message, {String? details}) {
    return AppFailure(
      type: FailureType.network,
      message: message,
      details: details,
    );
  }

  factory AppFailure.notFound(String message, {String? details}) {
    return AppFailure(
      type: FailureType.notFound,
      message: message,
      details: details,
    );
  }

  factory AppFailure.server(String message, {String? details}) {
    return AppFailure(
      type: FailureType.server,
      message: message,
      details: details,
    );
  }

  factory AppFailure.unknown(String message, {String? details}) {
    return AppFailure(
      type: FailureType.unknown,
      message: message,
      details: details,
    );
  }
}
