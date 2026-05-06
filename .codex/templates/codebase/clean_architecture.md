# Flutter Clean Architecture Codebase Template

## Source Basis

Derived from a production Flutter app using layered `presentation -> domain -> data`, Cubit state, repository contracts, datasource separation, DTO/entity mapping, GraphQL/REST boundaries, DI, routing, localization, and code generation.

## When To Choose

- Business rules are non-trivial and must be isolated from UI and network details.
- The app has multiple feature domains or is expected to grow.
- API contracts and local storage need stable mapping boundaries.
- Teams need clear test seams around use cases, repositories, and mappers.
- A feature may have multiple data sources: remote, local, cache, file, platform service, or event stream.

## When Not To Choose

- The app is a small prototype with very few screens.
- The team needs a minimal UI shell faster than architecture separation.
- There is no meaningful domain logic beyond pass-through CRUD.
- Existing project architecture is already consistent and different.

## Folder Blueprint

```text
lib/
  config/
    navigation/
    styles/
    flavors/
  core/
    bloc/
    error/
    events/
    extensions/
    localizations/
    logger/
    mapper/
    models/
    services/
    storage/
    usecase/
    utils/
  data/
    datasources/
      <feature>/
    documents_or_endpoints/
    models/
      request/
      response/
    repositories/
      <feature>/
  domain/
    entities/
      request/
      response/
    repositories/
    usecases/
      <feature>/
  generated/
  presentation/
    common/
    ui/
      <feature>/
    widgets/
```

## Layer Responsibilities

- `presentation`: pages, widgets, Cubit/ViewModel, immutable state, UI-only formatting, navigation triggers, user interaction.
- `domain`: entities, repository interfaces, use cases, business-level request/response objects.
- `data`: remote/local datasources, DTO request/response models, repository implementations, mappers, API documents/endpoints.
- `core`: reusable infrastructure that is not feature-specific.
- `config`: app-level navigation, theme, flavor/environment, and platform config.

## Feature Slice Blueprint

```text
domain/entities/request/<feature>/<action>_request_entity.dart
domain/entities/response/<feature>/<feature>_entity.dart
domain/repositories/<feature>_repository.dart
domain/usecases/<feature>/<action>_use_case.dart
data/models/request/<feature>/<action>_request.dart
data/models/response/<feature>/<feature>_response.dart
data/datasources/<feature>/<feature>_remote_data_source.dart
data/repositories/<feature>/<feature>_repository_impl.dart
presentation/ui/<feature>/<feature>_page.dart
presentation/ui/<feature>/<feature>_cubit.dart
presentation/ui/<feature>/<feature>_state.dart
```

## Data Flow

```text
View -> Cubit/ViewModel -> UseCase -> Repository interface -> Repository impl -> Datasource -> API/local
API/local -> DTO -> Entity -> UseCase result -> Cubit State -> View
```

## State Pattern

- Page owns UI composition.
- Cubit/ViewModel owns events, async orchestration, pagination, filters, and state transitions.
- State is immutable and contains `pageStatus`, foreground/background processing flags, error model, and feature data.
- Use a base launcher or equivalent wrapper for loading/error handling if the project has one.
- Store derived values in state only when reused by multiple widgets, validation, tests, or navigation.

## Repository Pattern

- Domain repository is an interface.
- Data repository implements the interface and maps entity/request objects to DTOs.
- Datasource owns the network/local call and parses the response wrapper.
- UI/state layer never parses raw API response shapes.
- Use case exposes the intent-oriented operation consumed by Cubit/ViewModel.

## API Pattern

- Keep GraphQL documents or REST endpoints outside widgets and state holders.
- Every API call must identify operation name, variables/body, root/response field, parser, error behavior, auth behavior, and pagination if any.
- Response wrappers should be centralized: single object, list object, paging object, and page info.
- Nullability must be modeled intentionally.

## Codegen Policy

- Source files own annotations and declarations.
- Generated files are not edited by hand.
- Run codegen after changes to route, DI, DTO serialization, immutable state, assets, or localization.
- Document the exact command in the Tech Lead decision and Coder output.

## Required Tech Lead Decisions

- State management package and base lifecycle abstraction.
- DI strategy.
- Routing strategy.
- API client strategy: REST, GraphQL, generated client, or mixed.
- Model mapping strategy: manual, generated, or hybrid.
- Error model and response wrapper.
- Localization strategy.
- First vertical slice and verify ladder.

## First Vertical Slice

1. App bootstrap and DI.
2. One route.
3. One read-only feature using remote or fake datasource.
4. Entity/DTO mapping.
5. Cubit/ViewModel state with loading/error/success.
6. Analyzer and one targeted unit/widget test if the project has a test harness.

## Review Checklist

- Dependency direction is not violated.
- UI does not know DTO/network details.
- Data layer does not depend on presentation.
- Use cases are intent-oriented, not just API method names when business logic exists.
- Mapping and nullability are explicit.
- Generated files are not manually edited.
- Verification covers mapper, state transition, and API parsing risk.
