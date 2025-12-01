---
description: Show project and session state
model: haiku
---

Show git status, CI/OpenSpec info, and context usage.

Execute in parallel:
1. `~/.claude/scripts/sitrep-fast.sh --json {{ --refresh if user passed --refresh flag }}`
2. Get context usage from system messages

Present concise summary:
- **Git**: Branch, changes count, latest commit
- **CI**: Last run status (cache age: Xs ago)
- **OpenSpec**: Proposal count (cache age: Xs ago)
- **Context**: Used/total tokens (%)
- **Model**: Current model

Note: Cache TTL is 5min for CI/OpenSpec, 60s for git. Use --refresh to invalidate.
