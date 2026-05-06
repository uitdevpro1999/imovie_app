# Agent Activity Notification Skill

## Purpose

Make agent activity visible to the user during multi-agent or long-running work.

## Rules

- Announce the active agent and reason before a major phase starts.
- Announce handoff between agents.
- Keep updates short and factual.
- Record current activity in `context/shared/agent_activity_status.md` when the project uses shared context.

## Status Format

- Active agent
- Current phase
- Inputs being used
- Expected output
- Last update time
