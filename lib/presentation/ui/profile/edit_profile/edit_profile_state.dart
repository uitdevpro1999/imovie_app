import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:imovie_app/core/bloc/base_state.dart';
import 'package:imovie_app/core/error/app_failure.dart';
import 'package:imovie_app/domain/entities/profile/app_profile.dart';

part 'edit_profile_state.freezed.dart';

@freezed
abstract class EditProfileState with _$EditProfileState implements BaseState {
  const EditProfileState._();

  const factory EditProfileState({
    @Default(PageStatus.initial) PageStatus pageStatus,
    @Default(false) bool processing,
    AppFailure? failure,
    AppProfile? profile,
    @Default(false) bool isAuthenticated,
    Uint8List? pendingAvatarBytes,
    @Default('') String pendingAvatarFileName,
    @Default('') String pendingAvatarContentType,
    Uint8List? pendingCoverBytes,
    @Default('') String pendingCoverFileName,
    @Default('') String pendingCoverContentType,
    String? actionMessage,
  }) = _EditProfileState;

  bool get hasPendingAvatar => pendingAvatarBytes != null;
  bool get hasPendingCover => pendingCoverBytes != null;

  @override
  EditProfileState copyWithBase({
    PageStatus? pageStatus,
    bool? processing,
    AppFailure? failure,
    bool clearFailure = false,
  }) {
    return copyWith(
      pageStatus: pageStatus ?? this.pageStatus,
      processing: processing ?? this.processing,
      failure: clearFailure ? null : failure ?? this.failure,
    );
  }
}
