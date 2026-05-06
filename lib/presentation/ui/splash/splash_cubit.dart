import 'package:imovie_app/core/bloc/base_cubit.dart';
import 'package:imovie_app/core/events/app_auth_event.dart';
import 'package:imovie_app/core/events/app_event_bus.dart';
import 'package:imovie_app/core/usecase/use_case.dart';
import 'package:imovie_app/domain/usecases/get_current_session_use_case.dart';
import 'package:imovie_app/presentation/ui/splash/splash_state.dart';

class SplashCubit extends BaseCubit<SplashState> {
  SplashCubit({required GetCurrentSessionUseCase getCurrentSessionUseCase})
    : _getCurrentSessionUseCase = getCurrentSessionUseCase,
      super(const SplashState());

  static const splashDuration = Duration(seconds: 3);

  final GetCurrentSessionUseCase _getCurrentSessionUseCase;

  @override
  Future<void> initData() async {
    await Future<void>.delayed(splashDuration);

    final result = await _getCurrentSessionUseCase(const NoParams());
    final isAuthenticated = result.map(
      success: (session) => session.isAuthenticated,
      failure: (_) => false,
    );

    appEventBus.emitAuth(
      isAuthenticated
          ? AppAuthEvent.authenticated()
          : AppAuthEvent.unauthenticated(),
    );
  }
}
