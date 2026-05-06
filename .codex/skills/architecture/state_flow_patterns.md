# State Flow Patterns Skill

## Purpose

Keep Flutter UI state predictable and aligned with the project's chosen state management.

## Rules

- Keep one source of truth for each value.
- Store derived calculations in state only when they must be reused, tested, or shared across widgets.
- Keep transient controller lifecycle inside the widget that owns the controller.
- Dispose controllers only when no widget can still reference them.
- Avoid triggering async work from build methods.
- Represent loading, empty, error, and success states explicitly when the feature needs them.

## Adaptation

- For BLoC/Cubit, emit immutable state transitions.
- For Riverpod/Provider, keep providers focused and avoid cyclic dependencies.
- For ChangeNotifier, notify only after consistent state changes.
- For setState, keep the state local and small.
- For custom state patterns, follow existing lifecycle and equality rules.
