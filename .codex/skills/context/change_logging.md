# Change Logging Skill

## Purpose

Log every change to agents, skills, commands, workflows, and shared context.

## Rules

- Create a dated log in `context/history/`.
- Include changed files, reason, scope, validation, and residual risk.
- If the change is mirrored to another tool folder, log both sides.
- Do not hide failed or blocked validation.

## Log Template

```md
# YYYY-MM-DD - Change Title

## Reason

## Changed Files

## Behavior Change

## Validation

## Residual Risk
```
