# API Template Index

## Purpose

Use these templates when Tech Lead or Coder designs API integration, response parsing, and error handling for Flutter projects.

## Available Templates

- `graphql_implementation.md`: baseline for GraphQL documents, client boundary, variables, response wrappers, repository integration, and verification.
- `graphql_error_handling.md`: baseline for GraphQL transport errors, GraphQL error payloads, auth refresh/retry, logout, and UI error mapping.
- `rest_error_handling.md`: baseline for REST/Dio/http errors, status codes, server error payloads, network errors, timeout/cancel behavior, and UI error mapping.

## Selection Rule

- GraphQL operation or schema task: read `graphql_implementation.md`.
- GraphQL exception, auth, retry, `ErrorResponse`, or root field issue: read `graphql_error_handling.md`.
- REST endpoint, Dio, http, Retrofit, upload/download, or status-code issue: read `rest_error_handling.md`.

## Tech Lead Output

When API templates are used, include:

- Selected API template
- Existing stack detected
- Error contract assumptions
- Response wrapper decision
- Auth/retry/logout decision
- Verification ladder
