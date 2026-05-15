# Supabase Pattern Skill

## Purpose

Design, implement, review, or test Supabase integrations in any codebase without leaking SDK details into feature/UI layers.

Use this skill for Supabase client setup, auth/session work, PostgREST table access, RPC, Edge Functions, Storage, Realtime, RLS-related behavior, and Supabase error handling.

## Architecture Adaptation

- Detect the current codebase style first: clean/layered, MVC, MVVM, service-oriented, backend-only, script, or starter.
- Keep the local naming convention. The shared Supabase boundary may be called service, adapter, gateway, datasource, repository helper, or client wrapper.
- Do not introduce a new architecture just to use Supabase. In small codebases, a single centralized Supabase module can be enough.
- Keep UI/controllers/state holders away from raw Supabase response parsing unless the project is intentionally a tiny script.
- For client apps, use only anon/publishable keys. Never expose service-role keys. Server code and Edge Functions may use service-role keys only inside trusted runtime boundaries.

## Base Service Boundary

Prefer one shared Supabase boundary around the SDK before feature-specific data code.

It should own:

- Client initialization and readiness checks.
- Auth/session lookup and a `requireCurrentUser`-style guard.
- Reusable database helpers: list, single, maybe-single, insert, upsert, update, delete, count, RPC.
- Edge Function invocation with normalized success/error parsing.
- Storage upload, public/signed URL generation, and deletion helpers.
- Realtime table/broadcast subscription helpers with unsubscribe cleanup.
- Safe logging that masks user identifiers, emails, tokens, and secrets.
- Response-shape validation before returning data to feature mappers.

Add configured and unconfigured/no-op variants when the app can boot without Supabase config. The unconfigured path must fail deterministically with the project error model instead of crashing later in feature code.

## Feature Implementation Flow

1. Locate existing Supabase initialization, DI, environment, and error/result conventions.
2. Add missing base-service capability first when multiple features need the same Supabase primitive.
3. Define feature data contracts explicitly: table, columns, bucket, function, RPC, filters, order, range, auth requirement, and expected nullability.
4. Put feature-specific Supabase calls in the data/service layer that already owns remote IO.
5. Map raw rows/payloads to DTOs or typed objects at the data boundary, then map to domain/entity types in the existing repository/application layer.
6. Keep business rules server-side when they protect data integrity or security; use RLS, constraints, triggers, RPC, or Edge Functions instead of trusting client checks.
7. Return the project-standard result/failure type from repositories/use cases. Do not throw raw Supabase exceptions into UI/state layers.

## Auth And Readiness

- Check readiness before network work when config or initialization can be absent.
- Use a single auth source of truth for current user/session.
- Require auth close to the data operation that needs it, with feature-specific unauthorized messages.
- Refresh or sync auth tokens for Realtime/private channels when the SDK requires it.
- Treat sign-out, expired sessions, missing profiles, and email confirmation states as distinct cases if the product needs distinct UX.

## Database Access

- Prefer explicit selected columns over broad `*` once the contract stabilizes.
- Keep filters, ordering, ranges, and pagination server-side.
- Use maybe-single only when "not found" is valid; use single when absence is an error.
- Normalize empty, malformed, and unexpected response shapes before mapper code.
- For mutations that need the updated row, use insert/update/upsert with select-returning behavior if supported by the SDK.
- Use RPC for cohesive database operations that must be atomic or policy-safe.

## Storage

- Decide public URL vs signed URL from the bucket privacy model.
- Use deterministic paths when replacing user/resource assets; use unique paths when history or cache-busting matters.
- Set content type, cache control, and upsert behavior explicitly.
- Validate file size/type before upload at the appropriate layer.
- Delete stale objects when replacing or deleting records if the product requires cleanup.

## Edge Functions

- Route function calls through the base Supabase boundary.
- Treat function name, action, body, response shape, status codes, and error payload as an API contract.
- Parse structured function error details before falling back to generic messages.
- Keep service-role operations inside functions or other trusted server code.
- Temporary fallback function names are acceptable only when migrating; log them and remove once stable.

## Realtime

- Subscribe through a wrapper that owns channel creation and removal.
- Filter subscriptions as narrowly as possible by schema/table/event/column/user/resource.
- Normalize table-change and broadcast payloads into one typed change model before feature code consumes them.
- Handle deletes using old-record data when new-record data is empty.
- Remove channels on stream/controller disposal, component unmount, or subscription cancel.
- Add duplicate suppression only when the transport or feature can emit repeated events.

## Error Mapping

Map Supabase errors at the repository/service boundary into the project's error model:

- Auth/session failures -> unauthorized or auth-specific failure.
- Missing configuration or failed initialization -> configuration failure.
- PostgREST/database/policy/network errors -> network/server/data failure according to local conventions.
- Storage errors -> upload/download/storage or network failure.
- Edge Function errors -> server/API failure with parsed details.
- Malformed rows/payloads -> data/unknown failure with enough detail for logs.

Log technical details for debugging, but return user-safe messages to UI.

## Security Checklist

- RLS policies exist for every client-accessed table.
- Client filters do not replace RLS.
- Service-role key never ships to browser/mobile/desktop clients.
- Storage bucket privacy matches URL strategy.
- User IDs in writes are derived from the authenticated session or server-side auth context, not trusted request body fields.
- Secrets live in environment/config management and are excluded from source control.

## Validation

Choose checks based on the changed surface:

- Initialization/readiness: missing config, bad config, successful config.
- Auth: signed-in, signed-out, expired session, unauthorized write.
- Database: success, empty/not-found, malformed row, RLS-denied, pagination/filter/order.
- Mapper: nullability, enum/scalar conversion, date/time handling.
- Storage: valid upload, invalid file, public/signed URL, replacement cleanup.
- Edge Functions/RPC: success payload, business error payload, transport failure, malformed response.
- Realtime: subscribe, event mapping, delete payload, unsubscribe/dispose cleanup, duplicate behavior.
- Architecture: raw Supabase SDK does not leak past the intended boundary.

Run the project's normal static checks, tests, codegen, and migration/policy verification path when available.

## Output

- Detected codebase style and Supabase boundary.
- Base service changes or reason none were needed.
- Feature contracts: tables, buckets, functions, filters, auth, payload shapes.
- Error mapping and readiness behavior.
- Security/RLS assumptions.
- Validation run, blocked checks, and residual risks.
