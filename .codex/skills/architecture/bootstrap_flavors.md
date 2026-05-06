# Bootstrap Flavors Skill

## Purpose

Design or adapt Flutter build environments without leaking secrets or forcing a fixed flavor model.

## Procedure

1. Detect existing environment strategy: Dart defines, flavors, build schemes, config files, CI variables, remote config, or none.
2. Identify app id, app name, endpoint, feature flags, analytics, signing, and platform-specific config boundaries.
3. Avoid changing production endpoints, signing, or secrets unless explicitly requested.
4. For new projects, start with the minimum number of environments needed by the brief.
5. Document run/build commands and verification for each environment.

## Output

- Environment inventory
- Proposed flavor/config model
- Secret handling rules
- Run/build command impact
- Risks and verification
