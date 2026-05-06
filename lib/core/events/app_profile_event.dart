enum AppProfileChangeType { profile, avatar }

class AppProfileEvent {
  const AppProfileEvent._({
    required this.changeType,
    required this.reloadRemote,
  });

  factory AppProfileEvent.profileUpdated() {
    return const AppProfileEvent._(
      changeType: AppProfileChangeType.profile,
      reloadRemote: true,
    );
  }

  factory AppProfileEvent.avatarUpdated() {
    return const AppProfileEvent._(
      changeType: AppProfileChangeType.avatar,
      reloadRemote: false,
    );
  }

  final AppProfileChangeType changeType;
  final bool reloadRemote;
}
