import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imovie_app/core/bloc/base_state.dart';
import 'package:imovie_app/core/error/app_failure.dart';
import 'package:imovie_app/core/events/app_event_bus.dart';
import 'package:imovie_app/core/events/app_toast_event.dart';

abstract class BaseCubit<S extends BaseState> extends Cubit<S> {
  BaseCubit(super.initialState);

  Future<T> launch<T>(
    Future<T> Function() future, {
    bool isShowLoading = true,
    FutureOr<T> Function(Object error, StackTrace stackTrace)? onError,
  }) async {
    final isPageLoading = state.pageStatus != PageStatus.loaded;

    if (isShowLoading) {
      emit(
        state.copyWithBase(
              pageStatus: isPageLoading ? PageStatus.loading : null,
              processing: isPageLoading ? false : true,
              clearFailure: true,
            )
            as S,
      );
    }

    try {
      final value = await future();

      if (isShowLoading) {
        emit(
          state.copyWithBase(
                pageStatus: isPageLoading ? PageStatus.loaded : null,
                processing: false,
              )
              as S,
        );
      }

      return value;
    } catch (error, stackTrace) {
      if (isShowLoading) {
        final failure = _mapFailure(error);
        emit(
          state.copyWithBase(
                pageStatus: isPageLoading ? PageStatus.error : null,
                processing: false,
                failure: failure,
              )
              as S,
        );
        showFailureToast(failure);
      }

      if (onError != null) {
        return await onError(error, stackTrace);
      }

      rethrow;
    }
  }

  AppFailure _mapFailure(Object error) {
    return switch (error) {
      AppFailure() => error,
      DioException() => AppFailure.network(
        error.message ?? 'Network request failed.',
        details: error.toString(),
      ),
      _ => AppFailure.unknown(
        'Unexpected error occurred.',
        details: error.toString(),
      ),
    };
  }

  Future<void> initData() async {}

  Future<void> retry() async {
    await initData();
  }

  void showSuccessToast(String message) {
    appEventBus.emitToast(AppToastEvent.success(message));
  }

  void showFailureToast(AppFailure failure) {
    appEventBus.emitToast(AppToastEvent.error(failure.message));
  }

  void showErrorToast(String message) {
    appEventBus.emitToast(AppToastEvent.error(message));
  }
}
