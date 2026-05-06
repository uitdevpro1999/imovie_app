import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:imovie_app/core/bloc/base_state.dart';
import 'package:imovie_app/core/error/app_failure.dart';
import 'package:imovie_app/domain/entities/profile/app_profile.dart';

part 'profile_state.freezed.dart';

@freezed
abstract class ProfileState with _$ProfileState implements BaseState {
  const ProfileState._();

  const factory ProfileState({
    @Default(PageStatus.initial) PageStatus pageStatus,
    @Default(false) bool processing,
    AppFailure? failure,
    AppProfile? profile,
    @Default(false) bool isAuthenticated,
    String? actionMessage,
  }) = _ProfileState;

  @override
  ProfileState copyWithBase({
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
