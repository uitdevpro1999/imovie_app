# Codebase Bootstrap Skill

## Purpose

Create a reusable Flutter project foundation or module foundation after the architecture decision is clear.

## Template Binding

Before producing a bootstrap package, read `templates/codebase/index.md`.

- For Clean Architecture, follow `templates/codebase/clean_architecture.md`.
- For MVVM-Cubit, follow `templates/codebase/mvvm_cubit.md`.
- For another architecture, write an explicit reason and produce a custom blueprint.
- Templates are baselines. Target project constraints override template defaults.

## Bootstrap Package

- Architecture choice and folder strategy
- Selected template and adopted/skipped parts
- Dependency list and rationale
- Networking strategy
- State management strategy
- Routing strategy
- Localization strategy
- Asset strategy
- Code generation strategy
- Error and logging strategy
- Test strategy
- First vertical slice plan

## Rules

- Start with a runnable app before adding optional infrastructure.
- Add packages only when the project needs them.
- Keep generated artifacts out of manual edits.
- Separate app secrets from committed source.
- Provide setup and verify commands.
