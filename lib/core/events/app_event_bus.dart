import 'dart:async';

import 'package:imovie_app/core/events/app_auth_event.dart';
import 'package:imovie_app/core/events/app_community_event.dart';
import 'package:imovie_app/core/events/app_profile_event.dart';
import 'package:imovie_app/core/events/app_library_event.dart';
import 'package:imovie_app/core/events/app_toast_event.dart';

final appEventBus = AppEventBus();

class AppEventBus {
  AppEventBus();

  final StreamController<AppToastEvent> _toastController =
      StreamController<AppToastEvent>.broadcast();
  final StreamController<AppAuthEvent> _authController =
      StreamController<AppAuthEvent>.broadcast();
  final StreamController<AppProfileEvent> _profileController =
      StreamController<AppProfileEvent>.broadcast();
  final StreamController<AppLibraryEvent> _libraryController =
      StreamController<AppLibraryEvent>.broadcast();
  final StreamController<AppCommunityEvent> _communityController =
      StreamController<AppCommunityEvent>.broadcast();

  Stream<AppToastEvent> get toastStream => _toastController.stream;
  Stream<AppAuthEvent> get authStream => _authController.stream;
  Stream<AppProfileEvent> get profileStream => _profileController.stream;
  Stream<AppLibraryEvent> get libraryStream => _libraryController.stream;
  Stream<AppCommunityEvent> get communityStream => _communityController.stream;

  void emitToast(AppToastEvent event) {
    if (event.message.trim().isEmpty) {
      return;
    }

    _toastController.add(event);
  }

  void emitAuth(AppAuthEvent event) {
    _authController.add(event);
  }

  void emitProfile(AppProfileEvent event) {
    _profileController.add(event);
  }

  void emitLibrary(AppLibraryEvent event) {
    _libraryController.add(event);
  }

  void emitCommunity(AppCommunityEvent event) {
    _communityController.add(event);
  }
}
