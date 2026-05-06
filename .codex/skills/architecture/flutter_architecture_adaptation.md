# Flutter Architecture Adaptation Skill

## Purpose

Prevent forcing one architecture onto every Flutter project.

## Detection Checklist

- Folder style: feature-first, layer-first, package-first, modular, or mixed.
- State management: setState, ValueNotifier, ChangeNotifier, Provider, Riverpod, BLoC/Cubit, GetX, Redux-like, custom, or none.
- Data access: REST, GraphQL, local DB, platform channel, mock/static, or mixed.
- DI: manual constructors, service locator, annotations/codegen, provider graph, or none.
- Routing: Navigator, declarative router, generated router, custom shell, or none.
- Codegen: build_runner, localization generator, asset generator, API generator, or none.

## Rules

- Existing project convention wins unless it is unsafe or broken.
- New architecture decisions require a written tradeoff.
- Do not introduce global state, service locators, codegen, or router packages without a concrete reason.
- Keep changes compatible with current testing and build setup.

## Expert Adaptation Questions

- Is the project small enough that extra layers would create more cost than value?
- Is the current pattern consistent, or is the touched area already an exception?
- Does the task require a local fix, a vertical slice, or a foundation decision?
- Will the proposed pattern still work when the feature adds loading, error, retry, cancellation, and tests?
- Can the decision be reversed without rewriting multiple features?
