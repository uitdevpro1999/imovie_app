enum AppProfileChangeType { profile, avatar, cover, media }

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

  factory AppProfileEvent.coverUpdated() {
    return const AppProfileEvent._(
      changeType: AppProfileChangeType.cover,
      reloadRemote: false,
    );
  }

  factory AppProfileEvent.mediaUpdated() {
    return const AppProfileEvent._(
      changeType: AppProfileChangeType.media,
      reloadRemote: false,
    );
  }

  final AppProfileChangeType changeType;
  final bool reloadRemote;
}
