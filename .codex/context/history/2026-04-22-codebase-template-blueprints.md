# 2026-04-22 - Codebase Template Blueprints

## Reason

User requested reusable codebase templates so Tech Lead can bind Clean Architecture and MVVM-Cubit architecture decisions to concrete Flutter blueprints.

## Changed Files

- `flutter-agent-kit/README.md`
- `flutter-agent-kit/agents/tech-lead.md`
- `flutter-agent-kit/skills/architecture/codebase_bootstrap.md`
- `flutter-agent-kit/skills/architecture/tech_lead_decision.md`
- `flutter-agent-kit/templates/codebase/index.md`
- `flutter-agent-kit/templates/codebase/clean_architecture.md`
- `flutter-agent-kit/templates/codebase/mvvm_cubit.md`
- `flutter-agent-kit/context/history/2026-04-22-codebase-template-blueprints.md`
- `.codex/context/history/2026-04-22-codebase-template-blueprints.md`
- `.claude/context/history/2026-04-22-codebase-template-blueprints.md`

## Behavior Change

Tech Lead now has a template binding step before proposing codebase architecture. Clean Architecture decisions must use the Clean Architecture template. MVVM-Cubit decisions must use the MVVM-Cubit template. Other architecture choices require an explicit reason.

## Validation

- Template inventory verified: 3 files under `flutter-agent-kit/templates/codebase/`.
- Template references verified in README, Tech Lead agent, codebase bootstrap skill, and Tech Lead decision skill.
- Portability grep passed for portable kit docs/templates/agents/skills/workflows/commands: no product names, project paths, or source-project-specific class names were found.

## Residual Risk

Templates are generic blueprints extracted from existing Flutter projects. Target projects still need local adjustment for team skill, SDK version, packages, CI, and product constraints.
