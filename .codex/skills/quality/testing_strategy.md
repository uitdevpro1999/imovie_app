# Testing Strategy Skill

## Purpose

Choose the right verification level for Flutter work.

## Test Types

- Unit tests: mappers, validators, use cases, reducers, state transitions.
- Widget tests: rendering, user interaction, form behavior, accessibility states.
- Integration tests: navigation, platform services, multi-screen flows.
- Golden tests: stable design-system components when the project supports them.
- Contract tests: API parsing and error mapping.
- Manual smoke: runtime paths that cannot be automated quickly.

## Rules

- Test behavior, not implementation details.
- Prefer deterministic input/output tests for business logic.
- Avoid fragile timing and pixel assertions unless the harness is designed for them.
- Document blocked tests with exact reason and manual fallback.
