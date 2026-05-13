import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:imovie_app/core/logger/app_logger.dart';

abstract interface class CallProximityService {
  Future<void> enable();

  Future<void> disable();
}

class NativeCallProximityService implements CallProximityService {
  const NativeCallProximityService();

  static const _channel = MethodChannel('imovie_app/call_proximity');
  static const _logName = 'CallProximity';

  @override
  Future<void> enable() => _invoke('enable');

  @override
  Future<void> disable() => _invoke('disable');

  Future<void> _invoke(String method) async {
    if (kIsWeb) {
      return;
    }
    try {
      await _channel.invokeMethod<void>(method);
    } catch (error, stackTrace) {
      AppLogger.warning(
        'Call proximity $method failed.',
        name: _logName,
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
}

class NoOpCallProximityService implements CallProximityService {
  const NoOpCallProximityService();

  @override
  Future<void> enable() async {}

  @override
  Future<void> disable() async {}
}
