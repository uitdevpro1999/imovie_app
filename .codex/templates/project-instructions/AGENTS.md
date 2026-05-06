# AGENTS.md

This file tells Codex how to use the local Flutter agent kit in this project.

## Primary Agent System

Use `flutter-agent-kit/README.md` as the primary local agent system.

Important paths:

- Agents: `flutter-agent-kit/agents/`
- Skills: `flutter-agent-kit/skills/`
- Commands: `flutter-agent-kit/commands/`
- Workflows: `flutter-agent-kit/workflows/`
- Codebase templates: `flutter-agent-kit/templates/codebase/`
- API templates: `flutter-agent-kit/templates/api/`
- Shared context: `flutter-agent-kit/context/shared/`
- History logs: `flutter-agent-kit/context/history/`

## Startup Rules

Before significant work:

1. Read `flutter-agent-kit/README.md`.
2. Read relevant files in `flutter-agent-kit/context/shared/` if they exist.
3. Detect the current Flutter architecture before applying any template.
4. Select the matching agent from `flutter-agent-kit/agents/`.
5. Load only the skills needed for the task.
6. Prefer existing project conventions over the generic kit when they conflict.
7. State assumptions, validation path, and residual risks before finishing.

## Command Mapping

If the user uses one of these prefixes, treat it as the matching command template:

- `/auto`: `flutter-agent-kit/commands/auto.md`
- `/orchestrate`: `flutter-agent-kit/commands/orchestrate.md`
- `/analyze`: `flutter-agent-kit/commands/analyze.md`
- `/business`: `flutter-agent-kit/commands/business.md`
- `/figma`: `flutter-agent-kit/commands/figma.md`
- `/tech-lead`: `flutter-agent-kit/commands/tech-lead.md`
- `/implement`: `flutter-agent-kit/commands/implement.md`
- `/review`: `flutter-agent-kit/commands/review.md`
- `/test`: `flutter-agent-kit/commands/test.md`
- `/validate`: `flutter-agent-kit/commands/validate.md`
- `/improve`: `flutter-agent-kit/commands/improve.md`

## Architecture Decisions

When proposing a new codebase, large module, or architecture direction:

1. Use `flutter-agent-kit/agents/tech-lead.md`.
2. Read `flutter-agent-kit/templates/codebase/index.md`.
3. If choosing Clean Architecture, follow `flutter-agent-kit/templates/codebase/clean_architecture.md`.
4. If choosing MVVM-Cubit, follow `flutter-agent-kit/templates/codebase/mvvm_cubit.md`.
5. If choosing another architecture, document why no existing template fits.

## API Work

When the task touches API integration or API errors:

1. Read `flutter-agent-kit/templates/api/index.md`.
2. For GraphQL operations, use `flutter-agent-kit/templates/api/graphql_implementation.md`.
3. For GraphQL errors, use `flutter-agent-kit/templates/api/graphql_error_handling.md`.
4. For REST/Dio/http/Retrofit errors, use `flutter-agent-kit/templates/api/rest_error_handling.md`.

## Quality Rules

- Do not manually edit generated files.
- Do not introduce a new architecture or package without a Tech Lead decision.
- Do not invent business rules not present in docs, code, API contract, or user instruction.
- Do not claim checks passed unless they were actually run.
- For UI work, verify loading, empty, error, disabled, success, and overflow states when relevant.
- For state work, avoid duplicate sources of truth.
- For controller, stream, subscription, timer, animation, or async callback changes, verify lifecycle ownership.

## Logging

When modifying `flutter-agent-kit/`, agent instructions, skills, workflows, templates, or shared context:

1. Write a log in `flutter-agent-kit/context/history/`.
2. Include reason, changed files, behavior change, validation, and residual risk.
3. If a defect was caused by an agent, update lessons or improvement memory; do not close as no-op.

## Project-Specific Rules

Add local rules below. These rules override the generic kit when they are more specific.

- TODO: Add generated file policy.
- TODO: Add build and test commands.
- TODO: Add state management convention.
- TODO: Add API client and error handling convention.
- TODO: Add localization convention.
- TODO: Add project-specific risks or invariants.
