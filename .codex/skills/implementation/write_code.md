# Write Code Skill

## Purpose

Implement code changes safely and consistently.

## Procedure

1. Read nearby code before editing.
2. Identify generated files and avoid manual edits.
3. Change the smallest set of files needed for a closed behavior.
4. Preserve existing public APIs unless the brief requires a breaking change.
5. Add tests when the project has a clear harness and the risk justifies it.
6. Run formatter/analyzer/tests relevant to touched code.

## Master Implementation Gate

- The change has one clear owner per file or layer.
- Data mapping is explicit at boundaries.
- State changes are deterministic and inspectable.
- Error handling follows existing project semantics.
- UI code does not own business rules unless the project intentionally does that.
- Shared abstractions are extracted only after a real duplication or complexity signal.

## Code Quality Rules

- Prefer explicit names over clever abstractions.
- Keep async lifecycle safe.
- Handle nullability intentionally.
- Map data at boundaries.
- Keep UI declarative.
- Do not hide business rules in visual widgets.
- Leave the project easier to verify than before.
