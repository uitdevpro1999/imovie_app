# REST API Pattern Skill

## Purpose

Implement REST API integrations using the target project's networking standard, including Dio, package:http, generated clients, or custom wrappers.

## Template Binding

Before implementing REST API work or REST error handling, read `templates/api/index.md` and follow `templates/api/rest_error_handling.md`.

## Procedure

1. Detect current network stack and boundary: client, interceptor, repository, service, datasource, or direct call.
2. Read the API contract: method, path, path params, query params, headers, body, response, status codes, errors, auth, pagination.
3. Keep HTTP calls out of widgets and state holders unless the project is intentionally simple and already does this.
4. Model request/response types using existing serializer conventions.
5. Map network errors to the project's error model.
6. Add cancellation, timeout, retry, or refresh behavior only if the current stack already supports it or the task requires it.

## Dio Guidance

- Prefer one configured client instance.
- Use interceptors for auth, logging, headers, and error normalization when the project already centralizes them.
- Do not create ad hoc `Dio()` instances in feature code.

## http Guidance

- Wrap `package:http` in a small client/service layer for headers, parsing, timeouts, and errors.
- Avoid duplicating JSON parsing and status-code checks in UI code.

## Output

- Endpoint contract
- Model and mapper impact
- Repository/service impact
- Error handling
- Verification path
