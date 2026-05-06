# Post Prompt Improvement Workflow

## Purpose

Make the agent kit learn from each significant prompt.

## Flow

1. Classify outcome: no-op, backlog, lesson, or patch.
2. If a defect was caused by the agent, capture root cause and prevention rule.
3. Patch the smallest relevant agent/skill/workflow when the issue is systemic.
4. Log every change.

## Rules

- Do not overfit generic kit files to one project.
- Put project-specific facts in that project's context, not in this portable kit.
- Prefer concise prevention rules that future agents can follow.
