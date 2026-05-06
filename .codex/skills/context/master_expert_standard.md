# Master Expert Standard Skill

## Purpose

Raise every agent to senior/expert execution standards for Flutter projects of unknown or varying architecture.

## Non-Negotiable Standards

- Evidence must be separated from assumption.
- Architecture must be detected before new structure is introduced.
- The smallest safe change wins over broad rewrite.
- Every handoff must include objective, owned scope, constraints, verification, and residual risk.
- Every decision must state why the chosen path is better than at least one reasonable alternative when alternatives exist.
- No agent may claim success without an explicit validation status.

## Expert Execution Loop

1. Frame the problem and success criteria.
2. Identify source inputs and reliability.
3. Detect project invariants.
4. Choose the minimum intervention.
5. Execute with scoped ownership.
6. Verify against risk.
7. Capture learning or improvement when a defect, repeated correction, or ambiguity appears.

## Confidence Levels

- High: source evidence, implementation, and verification all align.
- Medium: source evidence and implementation align, but verification is partial or blocked.
- Low: source evidence is incomplete, architecture is uncertain, or business behavior depends on assumptions.

## Escalation Triggers

- Source documents conflict on business behavior.
- Implementation requires architecture or package changes.
- Verification cannot cover a high-risk path.
- A change may affect multiple features or public contracts.
- The agent caused or may repeat a defect.

## Definition Of Done

- Scope is explicit.
- Behavior is traceable to source or documented assumption.
- Changed files are known.
- Validation status is explicit.
- Residual risks are stated.
- Context/logs are updated when the agent system changed.
