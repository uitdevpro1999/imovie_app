import 'package:imovie_app/core/error/app_failure.dart';

enum PageStatus { initial, loading, loaded, error }

abstract class BaseState {
  PageStatus get pageStatus;
  bool get processing;
  AppFailure? get failure;

  BaseState copyWithBase({
    PageStatus? pageStatus,
    bool? processing,
    AppFailure? failure,
    bool clearFailure = false,
  });
}
