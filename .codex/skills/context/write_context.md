# Write Context Skill

## Purpose

Create shared context files that other agents can reuse.

## Context Types

- Feature brief
- UI brief
- Source registry
- Traceability matrix
- Task board
- Architecture decision
- Validation report
- Lesson learned
- Improvement backlog

## Rules

- Store reusable facts in `context/shared/`.
- Store task-specific history in `context/history/`.
- Include date, source inputs, assumptions, and open questions.
- Keep context factual and update it when new evidence invalidates old notes.
