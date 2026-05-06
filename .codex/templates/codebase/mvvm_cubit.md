# Flutter MVVM-Cubit Codebase Template

## Source Basis

Derived from a production Flutter app using `View + Cubit-as-ViewModel + State + Repository`, centralized `core/` infrastructure, generated routing, DI, GraphQL/REST services, response wrappers, and feature-oriented UI folders.

## Architecture Intent

This is a pragmatic MVVM variant:

- View: `Page` and widgets.
- ViewModel: `Cubit` or equivalent state holder.
- ViewState: immutable `State` object.
- Model: API/local models and domain-ish response/request objects.
- Repository: feature data contract and implementation boundary.

It is not strict Clean Architecture because it may keep repositories and models under `core/` and may not require separate use cases for every operation.

## When To Choose

- The team wants fast feature delivery with enough separation for maintainability.
- Business logic is mostly screen/flow orchestration, filtering, pagination, forms, and API calls.
- The project benefits from reusable base page/state/error/loading infrastructure.
- A strict domain layer would add ceremony without clear value.
- Existing app already groups features under `ui/<feature>` and shared services under `core/`.

## When Not To Choose

- Business rules must be independently testable outside UI flow.
- The project has multiple platforms/modules sharing the same domain.
- The feature requires complex domain orchestration across many repositories.
- The target project already has a consistent Clean Architecture or other established pattern.

## Folder Blueprint

```text
lib/
  app/
    app.dart
    app_cubit.dart
    app_state.dart
  core/
    common/
      bases/
        bloc/
        entities/
        enum/
        model/
      styles/
    constants/
    debug/
    extensions/
    global/
    internet/
    local_storage/
    localizations/
    logger/
    managers/
    models/
      request/
      response/
    repositories/
      <feature>/
    router/
    services/
      graphql/
      rest_or_api/
    utils/
  generated/
  ui/
    <feature>/
      <feature>_page.dart
      <feature>_cubit.dart
      <feature>_state.dart
      widgets/
```

## Feature Slice Blueprint

```text
ui/<feature>/<feature>_page.dart
ui/<feature>/<feature>_cubit.dart
ui/<feature>/<feature>_state.dart
ui/<feature>/widgets/<feature>_section.dart
core/repositories/<feature>/<feature>_repository.dart
core/models/request/<feature>/<action>_request.dart
core/models/response/<feature>/<feature>_response.dart
core/services/graphql/documents/<feature>_document.dart
```

## Data Flow

```text
View -> Cubit/ViewModel -> Repository -> GraphQL/REST service -> API
API -> Response model/wrapper -> Repository -> Cubit State -> View
```

## View Rules

- Page extends the project base page if available.
- Page creates and owns view-only controllers such as tab, refresh, scroll, animation, and text controllers unless the value is business state.
- Page uses `BlocBuilder`, `BlocSelector`, `context.select`, or project equivalent to rebuild only needed sections.
- Widgets receive explicit values and callbacks; avoid passing the whole state unless project convention does it.

## Cubit / ViewModel Rules

- Own screen events, async orchestration, request construction, pagination counters, filters, selected tabs, and command methods.
- Use immutable state for UI-observed values.
- Keep private mutable fields only for internal flow control such as page number, debounce timer, active filter object, or tab status.
- Clean up timers, subscriptions, controllers, and externally created cubits.
- Keep API response parsing in repository/service, not in the page.

## State Rules

- Include base lifecycle fields: page status, processing, error model.
- Include feature fields: items, selected filter, enable load more, loading flags, form values, server validation flags.
- Keep calculated getters in state when reused across widgets or validation.
- Use separate flags for page loading and list/background processing when the UI needs both.

## Repository Rules

- Repository interface and implementation can live in the same file when the project favors speed and the file remains readable.
- Repository methods should be feature-intent operations, not raw HTTP calls in UI terms.
- Repository owns GraphQL root field or REST endpoint selection, variables/body mapping, and response wrapper parsing.
- Use generated JSON models for request/response when codegen is already in the project.

## Base Infrastructure

- Base page wraps provider creation, init lifecycle, global keyboard dismiss, loading overlay, page status rendering, and error display.
- Base cubit wraps async launch, loading/processing changes, and error normalization.
- Base state standardizes `pageStatus`, `processing`, and `errorEntity`.
- Global event/message manager handles app-level notifications or refresh signals.

## Codegen Policy

- Do not hand-edit generated files.
- Run generator after changing routes, DI registrations, serialized models, immutable states, generated assets, or localization.
- Keep generated outputs out of template decisions unless the target project explicitly commits them.

## Required Tech Lead Decisions

- Whether Cubit is the ViewModel abstraction or another state holder is used.
- Whether repositories are in `core/repositories` or feature-local folders.
- Whether use cases are skipped, optional, or introduced only for complex flows.
- Whether base page/cubit/state are created now or after the first repeated pattern.
- Network stack: GraphQL, REST, or mixed.
- Generated model and route strategy.

## First Vertical Slice

1. App bootstrap with DI and routing.
2. One page with Cubit/ViewModel and immutable state.
3. One repository method.
4. One response wrapper/model.
5. Loading, error, empty, and success UI.
6. Refresh or retry path if the feature is list/data-heavy.

## Review Checklist

- View does not directly call network services.
- Cubit/ViewModel does not parse raw transport response details beyond repository return values.
- Private mutable fields are internal only and cannot desync from state-observed values.
- Pagination flags and counters are reset correctly on refresh/filter/tab changes.
- Controllers/timers/listeners are disposed.
- Generated files are untouched.
- Verification covers state transitions, request construction, and one UI smoke path.
