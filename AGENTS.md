# AGENTS.md

This file tells Codex how to use the local `.codex` agent system in this project.

## Primary Agent System

Use the `.codex/` folder as the primary local agent system for this project.

There is no `.codex/README.md` in this repository. Start from the most relevant entry point for the current task.

Important paths:

- Agents: `.codex/agents/`
- Skills: `.codex/skills/`
- Commands: `.codex/commands/`
- Workflows: `.codex/workflows/`
- Codebase templates: `.codex/templates/codebase/`
- API templates: `.codex/templates/api/`
- Project instruction templates: `.codex/templates/project-instructions/`
- Shared context: `.codex/context/shared/`
- History logs: `.codex/context/history/`

## Startup Rules

Before significant work:

1. Read the relevant entry point in `.codex/commands/`, `.codex/workflows/`, or `.codex/agents/` for the current task.
2. Read relevant files in `.codex/context/shared/` if they exist.
3. Detect the current Flutter architecture before applying any template.
4. Select the matching agent from `.codex/agents/`.
5. Load only the skills needed for the task.
6. Prefer existing project conventions over the generic kit when they conflict.
7. State assumptions, validation path, and residual risks before finishing.

## Command Mapping

If the user uses one of these prefixes, treat it as the matching command template:

- `/auto`: `.codex/commands/auto.md`
- `/orchestrate`: `.codex/commands/orchestrate.md`
- `/analyze`: `.codex/commands/analyze.md`
- `/business`: `.codex/commands/business.md`
- `/figma`: `.codex/commands/figma.md`
- `/tech-lead`: `.codex/commands/tech-lead.md`
- `/implement`: `.codex/commands/implement.md`
- `/review`: `.codex/commands/review.md`
- `/test`: `.codex/commands/test.md`
- `/validate`: `.codex/commands/validate.md`
- `/improve`: `.codex/commands/improve.md`

## Architecture Decisions

When proposing a new codebase, large module, or architecture direction:

1. Use `.codex/agents/tech-lead.md`.
2. Read `.codex/templates/codebase/index.md`.
3. If choosing Clean Architecture, follow `.codex/templates/codebase/clean_architecture.md`.
4. If choosing MVVM-Cubit, follow `.codex/templates/codebase/mvvm_cubit.md`.
5. If choosing another architecture, document why no existing template fits.

## API Work

When the task touches API integration or API errors:

1. Read `.codex/templates/api/index.md`.
2. For GraphQL operations, use `.codex/templates/api/graphql_implementation.md`.
3. For GraphQL errors, use `.codex/templates/api/graphql_error_handling.md`.
4. For REST/Dio/http/Retrofit errors, use `.codex/templates/api/rest_error_handling.md`.

## Quality Rules

- Do not manually edit generated files.
- Do not introduce a new architecture or package without a Tech Lead decision.
- Do not invent business rules not present in docs, code, API contract, or user instruction.
- Do not claim checks passed unless they were actually run.
- For UI work, verify loading, empty, error, disabled, success, and overflow states when relevant.
- For state work, avoid duplicate sources of truth.
- For controller, stream, subscription, timer, animation, or async callback changes, verify lifecycle ownership.

## Logging

When modifying `.codex/`, agent instructions, skills, workflows, templates, or shared context:

1. Write a log in `.codex/context/history/`.
2. Include reason, changed files, behavior change, validation, and residual risk.
3. If a defect was caused by an agent, update lessons or improvement memory; do not close as no-op.

## Project-Specific Rules

Add local rules below. These rules override the generic kit when they are more specific.

- Current project structure is still close to the default Flutter starter layout, with app code centered in `lib/main.dart`; treat it as an unstructured starter unless a documented Tech Lead decision says otherwise.
- Prefer `flutter analyze` and `flutter test` for baseline validation when code changes affect behavior.
- For every screen, keep the `*_page.dart` file focused on route setup, page shell, lifecycle, and high-level composition only. Extract all reusable or non-trivial UI widgets into separate files under that screen's `widgets/` folder; do not define screen widgets in the page file.
- TODO: Add generated file policy.
- TODO: Add state management convention.
- TODO: Add API client and error handling convention.
- TODO: Add localization convention.
- TODO: Add project-specific risks or invariants.
