# 2026-04-25 - Clean Architecture Supabase Bootstrap

## Reason

Bootstrap the starter Flutter project into a lean Clean Architecture codebase with Supabase as the primary backend service, following the local `.codex` tech-lead guidance.

## Changed Files

- `pubspec.yaml`
- `pubspec.lock`
- `lib/main.dart`
- `lib/bootstrap.dart`
- `lib/config/flavors/app_environment.dart`
- `lib/config/flavors/app_bootstrap.dart`
- `lib/config/navigation/app_router.dart`
- `lib/core/di/service_locator.dart`
- `lib/core/error/app_failure.dart`
- `lib/core/result/result.dart`
- `lib/core/usecase/use_case.dart`
- `lib/data/datasources/session/session_remote_data_source.dart`
- `lib/data/repositories/session/session_repository_impl.dart`
- `lib/domain/entities/session/app_session.dart`
- `lib/domain/repositories/session_repository.dart`
- `lib/domain/usecases/get_current_session_use_case.dart`
- `lib/presentation/app/app.dart`
- `lib/presentation/ui/home/home_cubit.dart`
- `lib/presentation/ui/home/home_state.dart`
- `lib/presentation/ui/home/home_page.dart`
- `test/widget_test.dart`
- `android/app/src/main/AndroidManifest.xml`
- `macos/Runner/DebugProfile.entitlements`
- `macos/Runner/Release.entitlements`
- `.codex/context/history/2026-04-25-clean-architecture-supabase-bootstrap.md`

## Behavior Change

The app no longer uses the default Flutter counter sample. It now boots through a dedicated bootstrap layer, initializes Supabase from `SUPABASE_URL` and `SUPABASE_ANON_KEY` dart defines when present, registers dependencies through GetIt, routes through GoRouter, and renders a first Clean Architecture vertical slice that reads the current Supabase session state through Presentation -> Domain -> Data boundaries.

## Validation

- Added and resolved dependencies: `supabase_flutter`, `flutter_bloc`, `get_it`, `go_router`, `equatable`.
- Formatted `lib/` and `test/` with Dart formatter.
- `flutter analyze` passed with no issues.
- `flutter test` passed.
- Added Android internet permission and macOS network client entitlements required for backend connectivity.

## Residual Risk

- Only the bootstrap slice is implemented; feature modules such as movies, auth flows, profile, storage, and realtime still need explicit domain and schema decisions.
- Supabase database table structure, RLS policies, redirect URLs, and auth providers are not inferred here and must be defined before live feature development.
- The current slice validates session status only; it does not yet prove a production database query path.
