# 2026-04-25 - AGENTS Codex Path Alignment

## Reason

The root `AGENTS.md` still pointed to `flutter-agent-kit/...`, but this repository uses `.codex/...` as the local agent system.

## Changed Files

- `AGENTS.md`
- `.codex/context/history/2026-04-25-agents-codex-path-alignment.md`

## Behavior Change

Project-level Codex instructions now point to the actual `.codex` folder structure in this repository. Startup guidance no longer references a missing `README.md` and instead tells agents to begin from the relevant command, workflow, or agent entry point that exists in `.codex`.

## Validation

- Verified `.codex/` contains `agents`, `commands`, `context`, `skills`, `templates`, and `workflows`.
- Verified `.codex/README.md` does not exist, so the startup rule was updated accordingly.
- Verified command, template, context, and logging paths in `AGENTS.md` now target `.codex/...`.

## Residual Risk

Project-specific rules are still only partially filled in. Future work should document generated-file policy, state management, API conventions, localization, and project invariants once those decisions exist.
