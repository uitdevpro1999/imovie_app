import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:imovie_app/config/flavors/app_environment.dart';
import 'package:imovie_app/core/error/app_failure.dart';

part 'app_bootstrap.freezed.dart';

@freezed
abstract class AppBootstrap with _$AppBootstrap {
  const AppBootstrap._();

  const factory AppBootstrap({
    required AppEnvironment environment,
    AppFailure? initializationFailure,
  }) = _AppBootstrap;

  bool get isSupabaseReady {
    return environment.isSupabaseConfigured && initializationFailure == null;
  }
}
