---
description: Run all quality checks (format, lint, type check, tests) in parallel
model: haiku
---

Run all quality checks in parallel. Assumes `just` is available with targets for formatting, linting, type checking, and testing. Check the repo's justfile or CLAUDE.md for specific target names.

Run: `just fmt && just lint && just types && just test` (or parallel equivalent if available)

Report results concisely: pass/fail for each check, details only on failures.

<!--
TEST CASES:
- `/check` in repo with justfile → runs fmt, lint, types, test targets
- `/check` in repo without justfile → reports just not found, suggests checking repo setup
-->
