import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:imovie_app/config/flavors/app_bootstrap.dart';
import 'package:imovie_app/config/flavors/app_environment.dart';
import 'package:imovie_app/core/error/app_failure.dart';
import 'package:imovie_app/core/di/service_locator.dart';
import 'package:imovie_app/core/logger/app_logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  WidgetsFlutterBinding.ensureInitialized();

  final environment = AppEnvironment.fromDefines();
  AppFailure? initializationFailure;

  if (environment.isSupabaseConfigured) {
    try {
      AppLogger.info(
        'Initializing Supabase for ${environment.supabaseHost}.',
        name: 'Supabase',
      );
      await Supabase.initialize(
        url: environment.supabaseUrl,
        anonKey: environment.supabaseAnonKey,
      );
      AppLogger.info('Supabase initialized.', name: 'Supabase');
    } catch (error) {
      AppLogger.error(
        'Supabase initialization failed.',
        name: 'Supabase',
        error: error,
      );
      initializationFailure = AppFailure.configuration(
        'Unable to initialize Supabase.',
        details: error.toString(),
      );
    }
  } else {
    AppLogger.warning('Supabase config is missing.', name: 'Supabase');
  }

  final appBootstrap = AppBootstrap(
    environment: environment,
    initializationFailure: initializationFailure,
  );

  await configureDependencies(bootstrap: appBootstrap);
  runApp(await builder());
}
