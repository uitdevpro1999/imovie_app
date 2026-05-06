# Auto Agent Execution Workflow

## Purpose

Automatically convert user input and project sources into agent tasks and execute them in dependency order.

## Flow

1. Analyst creates source registry and task map.
2. Tech Lead handles architecture, dependency, or starter decisions when needed.
3. Coder implements the smallest closed slice.
4. Test Writer adds or recommends targeted tests.
5. Reviewer checks for regressions and gaps.
6. Validator confirms verify path.
7. Self-Learning captures lessons or patches the kit when needed.

## Master Gates

- Gate 1: Source reliability and conflicts are known before planning.
- Gate 2: Architecture invariants are known before implementation.
- Gate 3: Dependency or architecture decisions are approved by Tech Lead before Coder acts on them.
- Gate 4: Coder owns a bounded write scope and does not overlap another agent.
- Gate 5: Verification is selected by risk, not by habit.
- Gate 6: Reviewer findings must be resolved, accepted with risk, or escalated.
- Gate 7: Defects and repeated corrections trigger Self-Learning.

## Handoff Packet

- Objective
- Inputs
- Constraints
- Files/layers owned
- Expected output
- Verification
- Risks and open questions
- Confidence level

## Rules

- Do not assign the same write scope to multiple agents at the same time.
- Stop for user input only when a safe assumption would change business behavior or architecture materially.
- Prefer sequential gates for high-risk work; parallelize only independent read-only analysis or disjoint write scopes.
