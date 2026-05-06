# Clean Architecture Skill

## Purpose

Apply dependency direction and separation of concerns when the project uses or chooses a layered architecture.

## Rules

- Presentation depends on state/use cases/services, not concrete network or database code.
- Domain holds business concepts and repository contracts when the project uses a domain layer.
- Data holds DTOs, API clients, persistence, mappers, and repository implementations.
- Mapping belongs at boundaries, not scattered through widgets.
- Avoid adding layers to a small project unless the architecture decision requires them.

## Adaptation

- If the project uses feature-first folders, keep layers inside the feature.
- If the project uses layer-first folders, place files in the matching global layer.
- If the project uses a simpler service-oriented style, preserve it unless risk justifies a refactor.
