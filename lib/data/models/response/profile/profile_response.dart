import 'package:imovie_app/domain/entities/profile/app_profile.dart';

class ProfileResponse {
  const ProfileResponse({
    required this.id,
    required this.email,
    required this.fullName,
    required this.phone,
    required this.avatarUrl,
    required this.coverUrl,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return ProfileResponse(
      id: json['id']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      fullName: json['full_name']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      avatarUrl: json['avatar_url']?.toString() ?? '',
      coverUrl: json['cover_url']?.toString() ?? '',
    );
  }

  final String id;
  final String email;
  final String fullName;
  final String phone;
  final String avatarUrl;
  final String coverUrl;

  AppProfile toEntity() {
    return AppProfile(
      id: id,
      email: email,
      fullName: fullName,
      phone: phone,
      avatarUrl: avatarUrl,
      coverUrl: coverUrl,
    );
  }
}
