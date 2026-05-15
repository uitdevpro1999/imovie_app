# 2026-05-15 - Supabase Pattern Skill

## Reason

The user requested a reusable Supabase skill for agents based on project learnings, from base service design through feature implementation, while remaining applicable to all codebase styles.

## Changed Files

- `.codex/skills/architecture/supabase_pattern.md`
- `.codex/agents/coder.md`
- `.codex/agents/tech-lead.md`
- `.codex/agents/reviewer.md`
- `.codex/agents/test-writer.md`
- `.codex/context/history/2026-05-15-supabase-pattern-skill.md`

## Behavior Change

Agents now have an explicit Supabase architecture skill to load for setup, auth/session, PostgREST, RPC, Edge Functions, Storage, Realtime, RLS, and Supabase error handling.

The skill captures reusable project lessons:

- Centralize Supabase SDK access behind a base service/adapter/gateway.
- Keep configured and unconfigured/no-op paths deterministic when config is missing.
- Keep raw Supabase payload parsing out of UI/state layers.
- Normalize data, storage, function, and realtime behavior before feature code consumes it.
- Map Supabase errors into the local error model at the repository/service boundary.
- Verify RLS/security and subscription lifecycle explicitly.

## Validation

- Reviewed existing Supabase bootstrap, auth service, data service, DI, remote datasource, repository, realtime/storage/function patterns.
- Checked the new skill and agent references by reading the changed files.
- No app code changed; Flutter build/test was not required for this documentation-only agent-system change.

## Residual Risk

The skill is framework-neutral by design, so future agents must still adapt naming, error types, DI style, and validation commands to the specific target codebase before implementing Supabase work.
