# Review Checklist Skill

## Purpose

Review Flutter changes for behavior, maintainability, and regression risk.

## Checklist

- Requirement and acceptance criteria are satisfied.
- Data parsing and mapping match the contract.
- State transitions are predictable and lifecycle-safe.
- Async callbacks cannot update disposed state.
- Mutable controllers and focus nodes have clear ownership.
- Controllers, streams, subscriptions, timers, and animations are disposed correctly.
- UI handles loading, empty, error, disabled, and success states when required.
- User-facing text follows localization rules.
- No generated file was manually edited.
- New dependency or architecture choice is justified.
- Tests or verification match the risk.
- Existing screens/features are not accidentally changed.

## Master Review Heuristics

- Look for the bug that would still pass a simple happy-path manual test.
- Check whether the implementation duplicates state, validation, parsing, or API logic.
- Check whether a partial failure leaves UI or data inconsistent.
- Check whether nullability and default values hide backend contract changes.
- Check whether the code can be safely removed or rolled back.

## Finding Format

- Severity
- Evidence
- Expected behavior
- Suggested fix
- Residual risk if not fixed
