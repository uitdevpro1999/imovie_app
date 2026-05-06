# 2026-04-22 - Project Instruction Templates

## Reason

Add copyable project-level templates for `AGENTS.md` and `CLAUDE.md` so new Flutter projects can activate the portable agent kit without writing bootstrap instructions from scratch.

## Changed Files

- `flutter-agent-kit/README.md`
- `flutter-agent-kit/templates/project-instructions/AGENTS.md`
- `flutter-agent-kit/templates/project-instructions/CLAUDE.md`
- `flutter-agent-kit/context/history/2026-04-22-project-instruction-templates.md`
- `.codex/context/history/2026-04-22-project-instruction-templates.md`
- `.claude/context/history/2026-04-22-project-instruction-templates.md`

## Behavior Change

The kit now includes ready-to-copy root instruction templates for Codex and Claude Code. The templates point agents to the portable kit, command mappings, codebase templates, API templates, safety rules, and logging rules.

## Validation

- Project instruction template inventory verified: 2 files.
- README references verified for `templates/project-instructions/AGENTS.md` and `templates/project-instructions/CLAUDE.md`.
- Portability grep passed for README, project instruction templates, and this kit log: no product names, source project paths, or source-project-specific class names were found.

## Residual Risk

Target projects must still fill in project-specific rules after the first architecture analysis.
