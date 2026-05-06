# Figma Analysis Skill

## Purpose

Read Figma as a design source and translate it into implementable Flutter requirements.

## Procedure

1. Capture node URL, file key, node id, and screen name.
2. Extract visible states, components, typography, color, spacing, icons, assets, and interactions.
3. Compare design state with product docs and existing UI.
4. Identify reusable widgets and design system equivalents in the current project.
5. Record assumptions when Figma omits behavior, validation, loading, error, or empty states.

## Implementation Notes

- Use Figma for visual and interaction evidence.
- Use product/API docs for business rules.
- Do not create business behavior solely because a visual control exists.
- For Flutter, translate layout into existing project primitives before adding new abstractions.

## Output

- UI brief
- Design-to-code mapping
- Visual states
- Asset requirements
- Open design questions
