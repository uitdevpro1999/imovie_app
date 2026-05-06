enum AppToastType { success, error, info, warning }

class AppToastEvent {
  const AppToastEvent({required this.type, required this.message});

  factory AppToastEvent.success(String message) {
    return AppToastEvent(type: AppToastType.success, message: message);
  }

  factory AppToastEvent.error(String message) {
    return AppToastEvent(type: AppToastType.error, message: message);
  }

  factory AppToastEvent.info(String message) {
    return AppToastEvent(type: AppToastType.info, message: message);
  }

  factory AppToastEvent.warning(String message) {
    return AppToastEvent(type: AppToastType.warning, message: message);
  }

  final AppToastType type;
  final String message;
}
