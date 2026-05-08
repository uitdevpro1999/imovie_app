import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:imovie_app/core/bloc/base_state.dart';
import 'package:imovie_app/core/error/app_failure.dart';
import 'package:imovie_app/domain/entities/community/community_profile.dart';
import 'package:imovie_app/domain/entities/profile/app_profile.dart';

part 'settings_state.freezed.dart';

@freezed
abstract class SettingsState with _$SettingsState implements BaseState {
  const SettingsState._();

  const factory SettingsState({
    @Default(PageStatus.initial) PageStatus pageStatus,
    @Default(false) bool processing,
    AppFailure? failure,
    AppProfile? profile,
    CommunityProfile? communityProfile,
    @Default(false) bool isAuthenticated,
    @Default(false) bool communityStatsLoading,
  }) = _SettingsState;

  @override
  SettingsState copyWithBase({
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
