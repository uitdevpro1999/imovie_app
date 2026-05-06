# Validator Skill

## Purpose

Select and execute the right validation path before closing a task.

## Verify Ladder

1. Static checks: format, analyze, lint.
2. Code generation check when source annotations or generated inputs changed.
3. Unit/widget tests for changed logic.
4. Build or smoke run for platform or integration risk.
5. Manual scenario verification for UI, design, or backend-dependent paths.

## Risk-Based Selection

- Data contract change: parser tests, nullability checks, error mapping checks, and contract fixture.
- GraphQL change: verify root field, variables, response wrapper, business error payload, malformed-data behavior, and auth retry/logout if applicable.
- REST change: verify status-code mapping, timeout/network mapping, server validation payload, parser failure, and auth behavior if applicable.
- State/lifecycle change: state transition tests or targeted widget smoke with disposal/navigation.
- UI/design change: widget/manual visual path for default, empty, error, disabled, and overflow states.
- Architecture/dependency change: dependency resolution, build, analyzer, and rollback note.
- Localization change: key generation or lookup check across supported locales.
- Generated-input change: run the generator or mark blocked with exact command.

## Validation Summary

- Passed
- Failed
- Blocked
- Not run and why
- Residual risks
- Recommended next check
- Confidence level

## Rules

- Choose checks based on touched files and risk.
- Do not claim verification that was not run.
- If a check is blocked, record the blocker and fallback.
