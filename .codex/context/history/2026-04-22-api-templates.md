# 2026-04-22 - API Templates

## Reason

Add reusable templates for GraphQL implementation, GraphQL error handling, and REST error handling.

## Changed Files

- `flutter-agent-kit/README.md`
- `flutter-agent-kit/agents/coder.md`
- `flutter-agent-kit/agents/tech-lead.md`
- `flutter-agent-kit/skills/architecture/graphql_pattern.md`
- `flutter-agent-kit/skills/architecture/rest_api_pattern.md`
- `flutter-agent-kit/skills/architecture/tech_lead_decision.md`
- `flutter-agent-kit/skills/quality/validator.md`
- `flutter-agent-kit/templates/api/index.md`
- `flutter-agent-kit/templates/api/graphql_implementation.md`
- `flutter-agent-kit/templates/api/graphql_error_handling.md`
- `flutter-agent-kit/templates/api/rest_error_handling.md`
- `flutter-agent-kit/context/history/2026-04-22-api-templates.md`
- `.codex/context/history/2026-04-22-api-templates.md`
- `.claude/context/history/2026-04-22-api-templates.md`

## Behavior Change

Coder and Tech Lead now have explicit API templates for GraphQL operations, GraphQL error normalization, and REST error normalization. GraphQL and REST skills now bind to these templates before implementation.

## Validation

- API template inventory verified: 4 files under `flutter-agent-kit/templates/api/`.
- API template references verified in README, Coder agent, Tech Lead agent, GraphQL skill, REST skill, Tech Lead decision skill.
- Portable kit grep passed for README, agents, skills, workflows, commands, templates, and this kit log: no product names, source project paths, or source-project-specific class names were found.

## Residual Risk

Templates are generic baselines. Target projects still need their exact API contract, error schema, auth policy, and localization behavior.
