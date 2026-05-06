import 'dart:async';

import 'package:imovie_app/core/bloc/base_cubit.dart';
import 'package:imovie_app/core/error/app_failure.dart';
import 'package:imovie_app/presentation/app/app_cubit.dart';
import 'package:imovie_app/presentation/app/app_state.dart';
import 'package:imovie_app/presentation/ui/profile/language/language_state.dart';

class LanguageCubit extends BaseCubit<LanguageState> {
  LanguageCubit({required AppCubit appCubit})
    : _appCubit = appCubit,
      super(LanguageState(selectedLanguageCode: appCubit.state.localeCode)) {
    _appSubscription = appCubit.stream.listen(_handleAppState);
  }

  final AppCubit _appCubit;
  late final StreamSubscription<AppState> _appSubscription;

  Future<void> selectLanguage({
    required String languageCode,
    required LanguageMessages messages,
  }) async {
    if (languageCode == state.selectedLanguageCode) {
      return;
    }

    emit(state.copyWith(processing: true, failure: null));
    try {
      await _appCubit.updateLocale(languageCode);
      emit(
        state.copyWith(
          processing: false,
          selectedLanguageCode: _appCubit.state.localeCode,
          failure: null,
        ),
      );
      showSuccessToast(messages.success);
    } catch (error) {
      final failure = AppFailure.unknown(
        messages.error,
        details: error.toString(),
      );
      emit(state.copyWith(processing: false, failure: failure));
      showFailureToast(failure);
    }
  }

  void _handleAppState(AppState appState) {
    if (appState.localeCode == state.selectedLanguageCode) {
      return;
    }

    emit(state.copyWith(selectedLanguageCode: appState.localeCode));
  }

  @override
  Future<void> close() async {
    await _appSubscription.cancel();
    return super.close();
  }
}

class LanguageMessages {
  const LanguageMessages({required this.success, required this.error});

  final String success;
  final String error;
}
