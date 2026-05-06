import 'dart:async';

import 'package:imovie_app/core/events/app_toast_event.dart';

final appEventBus = AppEventBus();

class AppEventBus {
  AppEventBus();

  final StreamController<AppToastEvent> _toastController =
      StreamController<AppToastEvent>.broadcast();

  Stream<AppToastEvent> get toastStream => _toastController.stream;

  void emitToast(AppToastEvent event) {
    if (event.message.trim().isEmpty) {
      return;
    }

    _toastController.add(event);
  }
}
