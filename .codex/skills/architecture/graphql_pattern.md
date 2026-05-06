# GraphQL Pattern Skill

## Purpose

Implement GraphQL work consistently with the target project's client, document, model, and repository conventions.

## Template Binding

Before implementing GraphQL work, read `templates/api/index.md`.

- For query/mutation/subscription/upload implementation, follow `templates/api/graphql_implementation.md`.
- For transport errors, business error payloads, auth refresh, retry, logout, malformed data, or root-field failures, follow `templates/api/graphql_error_handling.md`.

## Procedure

1. Locate the GraphQL client and existing operation documents.
2. Check how variables, response wrappers, errors, auth, retries, and pagination are handled.
3. Add or update operation documents without breaking existing operations.
4. Create request/response DTOs and mappers according to current code style.
5. Keep UI/state layers away from raw GraphQL response parsing.
6. Run codegen if the project uses generated GraphQL types.

## Contract Checklist

- Operation name
- Variables and required arguments
- Selected fields
- Nullability
- Enum/scalar mapping
- Pagination and sorting
- Error shape
- Auth requirements

## Output

- Selected GraphQL template
- Operation contract
- Client/repository boundary
- Error handling path
- Codegen impact
- Verification path
