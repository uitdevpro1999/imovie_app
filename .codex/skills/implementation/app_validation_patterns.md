# App Validation Patterns Skill

## Purpose

Implement form, field, and business validation without scattering rules across UI code.

## Procedure

1. Identify source of validation truth: docs, API contract, existing validator, design hint, or user prompt.
2. Separate input formatting, field validation, cross-field validation, and server validation.
3. Place reusable validation in the same layer/pattern used by the project.
4. Keep UI responsible for display, not rule ownership.
5. Preserve localization for user-facing validation messages.

## Checklist

- Required/optional behavior
- Min/max length or value
- Format rules
- Cross-field dependencies
- Async/server validation
- Error display timing
- Accessibility and focus behavior
- Tests or manual verify path
