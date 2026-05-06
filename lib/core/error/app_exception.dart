import 'package:imovie_app/core/error/app_failure.dart';

class AppException implements Exception {
  const AppException(this.failure);

  final AppFailure failure;
}
