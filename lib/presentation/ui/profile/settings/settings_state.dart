import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:imovie_app/core/bloc/base_state.dart';
import 'package:imovie_app/core/error/app_failure.dart';
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
    @Default(false) bool isAuthenticated,
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
