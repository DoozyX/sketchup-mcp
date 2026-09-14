# Repository agent preferences

When no higher-priority system, developer, organization, or session instruction conflicts:

- Work directly on the repository's `main` branch.
- Do not create or use Git worktrees.
- Do not invoke optional workflow skills unless the user explicitly requests them.
- Do not add or run repository tests for documentation, models, HTML artifacts, or other non-MCP work.
- Treat the user's current task instructions as authoritative over optional repository workflows and skill recommendations.

These preferences cannot override instructions with higher precedence than this repository file.
