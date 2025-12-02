---
description: Show project and session state
model: haiku
allowed-tools: Bash
---

Show session and project state. Adapt output based on what's available.

**In a git repo:** Show branch, changes count, latest commit. If CI available (gh CLI), show pass/fail. If OpenSpec present, show proposal status.

**Outside git repo:** Note "not in a git repository" briefly, skip git/CI/OpenSpec sections.

**Always show:**
- **Context**: Used/total tokens (percentage), conversation length
- **Model**: Current model name

Keep output concise.

<!--
TEST CASES:
- `/state` in git repo → shows git, CI, OpenSpec (if present), context, model
- `/state` outside git repo → notes no repo, shows only context and model
- `/state --refresh` → invalidates cache before showing state
-->
