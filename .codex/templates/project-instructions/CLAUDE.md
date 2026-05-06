# CLAUDE.md

This file tells Claude Code how to use the local Flutter agent kit in this project.

## Primary Agent System

Use `flutter-agent-kit/README.md` as the primary local agent system for Flutter tasks.

Important paths:

- Agents: `flutter-agent-kit/agents/`
- Skills: `flutter-agent-kit/skills/`
- Commands: `flutter-agent-kit/commands/`
- Workflows: `flutter-agent-kit/workflows/`
- Codebase templates: `flutter-agent-kit/templates/codebase/`
- API templates: `flutter-agent-kit/templates/api/`
- Shared context: `flutter-agent-kit/context/shared/`
- History logs: `flutter-agent-kit/context/history/`

## Required Operating Model

For significant analysis, implementation, review, or architecture work:

1. Read `flutter-agent-kit/README.md`.
2. Follow `flutter-agent-kit/skills/context/master_expert_standard.md`.
3. Follow `flutter-agent-kit/skills/context/expert_operating_model.md`.
4. Detect the project's current architecture before applying generic rules.
5. Use only the agent and skills needed for the current task.
6. Preserve project-specific conventions unless they conflict with safety or explicit user instructions.
7. Finish with validation status and residual risks.

## Agent Selection

- Analysis, tracing, feature brief: `flutter-agent-kit/agents/analyst.md`
- Architecture, package, build, codebase decision: `flutter-agent-kit/agents/tech-lead.md`
- Implementation and bug fix: `flutter-agent-kit/agents/coder.md`
- Review and regression detection: `flutter-agent-kit/agents/reviewer.md`
- Test design or test implementation: `flutter-agent-kit/agents/test-writer.md`
- Lessons, defect prevention, kit improvement: `flutter-agent-kit/agents/self-learning.md`

## Command Mapping

Treat these user prefixes as command templates:

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

## Codebase Template Binding

Before proposing a new project structure or major architecture direction:

1. Read `flutter-agent-kit/templates/codebase/index.md`.
2. Use `flutter-agent-kit/templates/codebase/clean_architecture.md` for Clean Architecture.
3. Use `flutter-agent-kit/templates/codebase/mvvm_cubit.md` for MVVM-Cubit.
4. If no template fits, write a custom decision record with rejected options.

## API Template Binding

Before implementing or reviewing API integration:

1. Read `flutter-agent-kit/templates/api/index.md`.
2. Use `flutter-agent-kit/templates/api/graphql_implementation.md` for GraphQL operation implementation.
3. Use `flutter-agent-kit/templates/api/graphql_error_handling.md` for GraphQL error, auth refresh, retry, logout, and malformed-data handling.
4. Use `flutter-agent-kit/templates/api/rest_error_handling.md` for REST/Dio/http/Retrofit error handling.

## Safety Rules

- Do not manually edit generated files.
- Do not add packages without a documented reason.
- Do not add business rules without source evidence.
- Do not make broad refactors when a small closed change satisfies the task.
- Do not report validation as passed unless the command or check was run.
- If validation is blocked, state the blocker and the fallback path.

## Logging

When modifying the agent kit or instruction system:

1. Write a dated log in `flutter-agent-kit/context/history/`.
2. Include changed files, behavior change, validation, and residual risk.
3. If the change fixes an agent-caused defect, capture the prevention rule.

## Project-Specific Rules

Add project-specific Claude Code rules below. These override generic kit guidance when they are more precise.

- TODO: Add project overview.
- TODO: Add setup/build/test commands.
- TODO: Add architecture summary.
- TODO: Add generated file policy.
- TODO: Add API, auth, and error handling policy.
- TODO: Add localization and design system rules.
