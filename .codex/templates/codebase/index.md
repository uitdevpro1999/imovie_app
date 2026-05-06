# Codebase Template Index

## Purpose

These templates are reference blueprints for Tech Lead decisions when creating or reshaping Flutter projects.

## Available Templates

- `clean_architecture.md`: use when the project needs strict presentation/domain/data separation, use cases, repository contracts, DTO/entity mapping, and long-term feature isolation.
- `mvvm_cubit.md`: use when the project needs pragmatic feature delivery with View + Cubit-as-ViewModel + State + Repository, while keeping infrastructure centralized.

## Selection Rule

Tech Lead must choose a template only after reading current project constraints. The chosen template is a baseline, not a forced rule. If the target project already has stronger local conventions, local conventions win.

## Handoff Contract

When Tech Lead chooses a template, the decision must include:

- Selected template
- Why it fits
- What parts are adopted
- What parts are intentionally skipped
- First vertical slice
- Required packages/codegen
- Verification ladder
- Migration or rollback note
