enum AppAuthEventStatus { authenticated, unauthenticated }

class AppAuthEvent {
  const AppAuthEvent._(this.status);

  factory AppAuthEvent.authenticated() {
    return const AppAuthEvent._(AppAuthEventStatus.authenticated);
  }

  factory AppAuthEvent.unauthenticated() {
    return const AppAuthEvent._(AppAuthEventStatus.unauthenticated);
  }

  final AppAuthEventStatus status;
}
