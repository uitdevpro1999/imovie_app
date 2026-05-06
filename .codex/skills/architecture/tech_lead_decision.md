# Tech Lead Decision Skill

## Purpose

Make high-impact technical decisions with clear constraints, alternatives, and verification.

## Decision Record

- Problem
- Context and constraints
- Options considered
- Decision
- Selected codebase template or reason no template applies
- Why this option wins
- Rejected options and why
- Impacted files/layers
- Rollback strategy
- Verify ladder
- Decision confidence
- Follow-up trigger that would reopen the decision

## Rules

- Prefer the simplest option that satisfies requirements and future risk.
- Do not add libraries for isolated convenience if standard Flutter/Dart is enough.
- Make architecture changes incrementally.
- Document assumptions that must be validated before coding.
- For codebase/bootstrap decisions, read `templates/codebase/index.md` and bind Clean Architecture or MVVM-Cubit decisions to the matching template.
- For API integration or error-handling decisions, read `templates/api/index.md` and bind GraphQL/REST decisions to the matching template.

## Architecture Fitness Matrix

- Fit to current project structure
- Fit to team skill and maintenance cost
- Fit to platform targets
- Fit to testability
- Fit to release risk
- Fit to performance and accessibility needs
