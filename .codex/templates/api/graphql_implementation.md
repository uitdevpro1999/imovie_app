# GraphQL Implementation Template

## When To Use

- Adding a GraphQL query, mutation, subscription, upload, or generated operation.
- Mapping GraphQL docs, schema screenshots, playground snippets, or operation links into Flutter code.
- Refactoring a feature to use the existing GraphQL client boundary.

## Required Inputs

- Operation type: query, mutation, subscription, or upload.
- Operation name.
- Variables and required arguments.
- Root response field.
- Selected fields and nullability.
- Response wrapper shape.
- Error shape.
- Auth requirement.
- Pagination shape if present.

## Recommended Boundaries

```text
GraphQL document -> Client/service -> Datasource or Repository -> DTO/Response wrapper -> Entity/State -> UI
```

If the project uses strict Clean Architecture:

```text
UI -> ViewModel/Cubit -> UseCase -> Repository interface -> Repository impl -> Datasource -> GraphQL client
```

If the project uses MVVM-Cubit:

```text
View -> Cubit/ViewModel -> Repository -> GraphQL client -> Response model
```

## Implementation Steps

1. Locate existing GraphQL client, operation documents, response wrappers, and error normalization.
2. Add the operation document in the project's existing document location.
3. Use the exact root field expected by the response.
4. Pass variables in the same shape as the API contract.
5. Parse only the root payload into the project wrapper/model.
6. Map DTO/response models to entity/state at the current project's boundary.
7. Keep raw GraphQL `QueryResult`, `OperationException`, and transport-specific details out of UI code.
8. Add upload context/headers only when the operation requires multipart handling.
9. Run codegen if the project generates operation, model, DI, or route files.

## Response Wrapper Pattern

Common wrappers:

- Single object: `{ success, code, message, data }`
- List: `{ success, code, message, data: [...] }`
- Paging: `{ success, code, message, data: { content, pageInfo } }`
- Union/error: root field may be a success payload or error payload with typename/code/status/message.

Do not assume one wrapper globally. Detect the wrapper used by nearby operations.

## Root Field Rules

- Root field is part of the contract, not a local naming preference.
- Mismatched root field usually causes null data or malformed data errors.
- Keep root field constants centralized when the project already does that.
- For old operations, preserve root field names unless the API contract changed.

## Pagination Rules

- Track page, size, hasNext/totalPages according to server response.
- Reset page and list state on refresh, filter, search, or tab change.
- Append only on successful load-more.
- Avoid client-side paging if server-side paging exists.

## Verification

- Static analyzer.
- Contract fixture or parser test for the response wrapper.
- State transition test or manual scenario for loading, success, empty, error.
- Auth/retry check if the operation requires authentication.
- Upload/download smoke test if binary transport is involved.

## Common Failure Modes

- Wrong root field.
- Variables nested under the wrong key.
- UI parses raw GraphQL result.
- Nullability hidden by defaults.
- Paging flags not reset.
- Upload request missing multipart context/header.
- Existing operation overwritten instead of adding a new one.
