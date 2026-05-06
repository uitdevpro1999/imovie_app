# GraphQL Error Handling Template

## When To Use

- Handling `OperationException`, `LinkException`, server exception, GraphQL error payload, auth refresh, retry, logout, permission error, or malformed data.
- Debugging GraphQL calls that return HTTP success but business error payload.
- Building a shared error model for GraphQL clients.

## Error Categories

- Network unavailable before request.
- Transport error: timeout, socket, TLS, proxy, server unavailable.
- HTTP error wrapped by GraphQL link/client.
- GraphQL execution errors in `errors`.
- Business error payload in the root field.
- Auth expired or unauthorized.
- Permission denied.
- Empty or malformed data.
- Parser or nullability mismatch.

## Normalization Boundary

```text
GraphQL client/service catches transport + GraphQL errors
Client/service normalizes to AppError/ServerError
Repository returns typed success or throws normalized error
ViewModel/Cubit maps error to state
View displays localized message/action
```

Do not duplicate GraphQL error parsing in each feature.

## Handling Algorithm

1. Check network state if the project has a network checker.
2. Execute operation through the centralized GraphQL client/service.
3. If the result has exception, extract transport response, parsed response, code, status, message, and root field payload if available.
4. If unauthorized and refresh is supported, run a single-flight refresh so parallel requests wait for one refresh operation.
5. If refresh succeeds, reset/rebuild the client and retry the original operation once.
6. If refresh fails or retry already happened, trigger logout/session-expired flow.
7. If root payload has an error typename or business error shape, map code/status/message to normalized error.
8. If data or root field is missing and the operation does not explicitly allow null, throw malformed data error.
9. Convert unknown errors to a safe fallback error.

## Auth Refresh Rules

- Retry at most once per operation.
- Use a shared refresh future or lock to avoid multiple refresh calls.
- Reset client headers/cache after saving new tokens.
- Do not retry if refresh token is missing.
- Logout/session-expired flow should be centralized.
- Never log raw tokens in production logs.

## Error Model Fields

Recommended normalized fields:

- message
- title
- code
- statusCode
- key
- type/category
- isShow or display policy
- original error for debug-only logging

## UI Mapping

- Page-level loading error: show retry page.
- Background action error: show toast/snackbar/dialog based on project convention.
- Field/server validation: map to field-specific state when the API identifies the field.
- Auth/session error: trigger app-level logout/session flow.
- Permission error: refresh permission state or block action with message.

## Verification

- Unauthorized response triggers refresh and retries once.
- Refresh failure triggers logout/session flow.
- Business error payload maps to localized user message.
- Malformed root field fails loudly instead of silently returning empty state.
- Unknown exception maps to safe fallback.
- No feature-specific duplicate error parser was added.

## Common Failure Modes

- Treating GraphQL business error as success.
- Retrying endlessly on unauthorized.
- Multiple refresh requests racing.
- Resetting token storage but not client headers.
- Logging tokens or sensitive variables.
- Throwing raw `OperationException` to UI.
- Swallowing null root field and rendering incorrect empty UI.
