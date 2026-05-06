# REST API Error Handling Template

## When To Use

- Integrating REST endpoints through Dio, package:http, Retrofit, generated clients, uploads, downloads, or multipart requests.
- Designing shared REST error normalization.
- Debugging status-code, timeout, cancellation, bad response, or server validation errors.

## Error Categories

- No network before request.
- Connection timeout.
- Send timeout.
- Receive timeout.
- Request cancelled.
- DNS/socket/TLS/proxy connection error.
- Bad response status code.
- Server error payload with message/code/key/errors.
- Parser/nullability mismatch.
- Upload/download file error.
- Auth expired or permission denied.

## Normalization Boundary

```text
HTTP client/interceptor/service catches transport errors
Client/service normalizes to AppError/ServerError
Repository maps success response and throws normalized error
ViewModel/Cubit maps error to state
View displays localized message/action
```

Do not let widgets or state holders inspect raw `Response`, `DioException`, or `http.Response` unless the whole app intentionally has no data layer.

## Dio Template

1. Use one configured Dio instance or generated client factory.
2. Set base URL, headers, auth, timeout, logging, and interceptors centrally.
3. Convert `DioException` by type:
   - cancel -> cancelled request message
   - connectionTimeout -> connection timeout
   - sendTimeout -> send timeout
   - receiveTimeout -> receive timeout
   - connectionError -> network message
   - badResponse -> parse server payload
   - unknown -> fallback message
4. For `badResponse`, read status code and server payload.
5. Map server fields such as `message`, `code`, `key`, `errors`, or field errors into the normalized error model.
6. Trigger auth refresh/retry only if the existing stack supports it and the task requires it.

## package:http Template

1. Wrap `http.Client` in a project service.
2. Add timeout handling around requests.
3. Decode JSON only after checking status code and content type.
4. Convert non-2xx response into normalized error.
5. Avoid repeating status-code and JSON parsing logic in each repository method.

## Status Code Guidance

- 400: invalid request or server validation.
- 401: unauthorized/session expired; refresh or logout based on app policy.
- 403: permission denied.
- 404: not found.
- 409: conflict or state mismatch.
- 422: validation error when backend uses it.
- 429: rate limit.
- 500+: server unavailable or unexpected server failure.

Status-code meaning can vary by backend. Prefer the API contract when available.

## Field Validation Mapping

- If payload includes field errors, map them to field-specific state.
- Keep sync validators separate from server validators.
- Clear server field error when the user changes the corresponding field.
- Do not show all server validation only as a generic toast if the UI has field-level errors.

## Upload/Download Rules

- Use multipart only at client/service boundary.
- Sanitize binary/file values in logs.
- Handle cancellation and progress through a scoped controller/token when needed.
- Do not store large binary response in state unless required.

## Verification

- 2xx success parses into expected response model.
- 400/422 server validation maps correctly.
- 401 follows auth policy.
- Timeout and connection error show safe network message.
- Unknown payload shape falls back safely.
- Upload/download path handles cancel/failure.
- UI does not inspect raw HTTP errors.

## Common Failure Modes

- Creating ad hoc `Dio()` inside feature code.
- Parsing server message without checking payload type.
- Assuming every error payload has `message`.
- Throwing raw `DioException` into UI.
- Treating HTTP 200 with business failure as success without checking wrapper.
- Duplicating error handling across repositories.
