# Feature Source Workflows

## Docs + Figma

- Analyst creates feature brief from docs and maps it to Figma.
- Coder follows docs for business rules and Figma for UI.
- Reviewer checks source-to-code and design-to-code traceability.
- Test Writer derives tests from acceptance criteria and UI states.
- Master gate: conflicts between docs and Figma must be listed before implementation.

## Docs Only

- Analyst creates feature brief and lists UI assumptions.
- Coder follows docs and reuses existing UI patterns.
- Reviewer checks business consistency and codebase fit.
- Test Writer focuses on rules, validation, branching, and side effects.
- Master gate: UI assumptions must not become hidden business rules.

## Figma Only

- Analyst creates UI brief, not business brief.
- Coder implements only visual and interaction states shown or inferable from existing code.
- Reviewer checks visual parity and assumptions.
- Test Writer focuses widget state, input behavior, and manual verification.
- Master gate: missing business rules stay open questions.

## API Only

- Analyst creates API contract brief.
- Tech Lead decides integration boundary when unclear.
- Coder implements models, data access, mapping, and minimal UI/state integration required.
- Reviewer checks parsing, nullability, errors, pagination, and auth assumptions.
- Master gate: response nullability, error shape, and pagination must be verified or marked blocked.
