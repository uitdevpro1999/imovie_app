# Feature Business Analysis Skill

## Purpose

Analyze a feature from product documents, tickets, API specs, Figma, and code to produce a shared feature brief.

## Supported Inputs

- PRD, user story, HLD, LLD, ticket, meeting note, acceptance criteria
- Figma URL, screenshot, prototype, design token note
- REST, GraphQL, WebSocket, or event contract
- Existing implementation

## Procedure

1. Create a source registry with title, date/version if available, owner if available, and reliability.
2. Extract business scope, actors, scenarios, acceptance criteria, data rules, edge cases, and exclusions.
3. Map source to design and code impact.
4. Detect conflicts between sources and mark unresolved items.
5. Do not invent missing business rules.

## Feature Brief Sections

- Scenario
- Business summary
- Traceability: product source -> design -> API/data -> code
- In-scope and out-of-scope
- API/data/event impact
- UI/state impact
- Risks
- Assumptions
- Open questions
- Candidate files/layers to modify
