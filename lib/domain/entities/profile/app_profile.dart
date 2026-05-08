class AppProfile {
  const AppProfile({
    required this.id,
    required this.email,
    required this.fullName,
    required this.phone,
    required this.avatarUrl,
    required this.coverUrl,
  });

  final String id;
  final String email;
  final String fullName;
  final String phone;
  final String avatarUrl;
  final String coverUrl;

  AppProfile copyWith({
    String? id,
    String? email,
    String? fullName,
    String? phone,
    String? avatarUrl,
    String? coverUrl,
  }) {
    return AppProfile(
      id: id ?? this.id,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      coverUrl: coverUrl ?? this.coverUrl,
    );
  }
}
