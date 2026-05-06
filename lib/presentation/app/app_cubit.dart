import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imovie_app/core/usecase/use_case.dart';
import 'package:imovie_app/domain/usecases/get_current_session_use_case.dart';
import 'package:imovie_app/presentation/app/app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit({required GetCurrentSessionUseCase getCurrentSessionUseCase})
    : _getCurrentSessionUseCase = getCurrentSessionUseCase,
      super(const AppState());

  final GetCurrentSessionUseCase _getCurrentSessionUseCase;

  Future<void> checkAuthentication() async {
    emit(const AppState(authStatus: AppAuthStatus.checking));

    final result = await _getCurrentSessionUseCase(const NoParams());
    emit(
      result.map(
        success: (session) => AppState(
          authStatus: session.isAuthenticated
              ? AppAuthStatus.authenticated
              : AppAuthStatus.unauthenticated,
        ),
        failure: (failure) => AppState(
          authStatus: AppAuthStatus.unauthenticated,
          failure: failure,
        ),
      ),
    );
  }

  void markAuthenticated() {
    emit(const AppState(authStatus: AppAuthStatus.authenticated));
  }

  void markUnauthenticated() {
    emit(const AppState(authStatus: AppAuthStatus.unauthenticated));
  }
}
