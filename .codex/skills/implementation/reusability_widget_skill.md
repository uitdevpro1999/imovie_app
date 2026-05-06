# Reusability Widget Skill

## Purpose

Create reusable Flutter widgets only when reuse reduces duplication, risk, or complexity.

## When To Extract

- Same layout/behavior appears in multiple places.
- A section has complex layout that hides page intent.
- A component has state, validation, or accessibility behavior worth isolating.
- Tests become easier with extraction.

## When Not To Extract

- One-off layout with no likely reuse.
- Premature abstraction would hide simple code.
- Project has an existing design system component that should be reused instead.

## Rules

- Keep widget APIs small and explicit.
- Pass data and callbacks, not whole state objects, unless the project pattern does that.
- Avoid hidden side effects in reusable widgets.
- Keep styling aligned with existing theme/design tokens.
