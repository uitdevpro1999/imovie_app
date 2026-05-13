import 'package:get_it/get_it.dart';
import 'package:imovie_app/config/flavors/app_bootstrap.dart';
import 'package:imovie_app/core/di/service_locator.config.dart';
import 'package:injectable/injectable.dart';

final GetIt sl = GetIt.instance;

@InjectableInit(ignoreUnregisteredTypes: [AppBootstrap])
Future<void> configureDependencies({required AppBootstrap bootstrap}) async {
  await sl.reset();
  sl.registerSingleton<AppBootstrap>(bootstrap);
  await sl.init();
}
