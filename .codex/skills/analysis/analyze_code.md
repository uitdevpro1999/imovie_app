# Analyze Code Skill

## Purpose

Read Flutter/Dart code safely, identify behavior, and trace impact without guessing.

## Procedure

1. Find entry points: `pubspec.yaml`, app bootstrap, routes, feature folders, state holders, repositories, API clients, and tests.
2. Identify architecture shape: layer-first, feature-first, package-first, modular, monolithic, or mixed.
3. Trace the behavior from UI to state to domain/service to data/API/local storage and back.
4. Record actual naming, error handling, async, cancellation, lifecycle, and generated-file conventions.
5. Check nearby implementations before creating new patterns.

## Master Trace Protocol

- Trace both the happy path and at least one failure path.
- Identify where data changes shape: DTO, entity, state, view model, form value, or UI text.
- Identify ownership of mutable objects and async work.
- Identify cross-feature coupling before editing shared files.
- Record which files are evidence and which files are only candidates.

## Evidence Rules

- Quote or reference file paths and symbols for every important conclusion.
- Mark missing information as an assumption or open question.
- Do not infer business behavior from UI labels alone when docs or API contracts disagree.

## Output

- Code path summary
- Detected architecture
- Reusable patterns
- Change impact candidates
- Risks and unknowns
- Confidence level
