---
description: Restart Claude session
allowed-tools: Bash
---

Restart claude session. If using `c` wrapper, signals restart. Otherwise just kills session.

To always get restart behavior, start claude via `c` instead of `claude` directly.

```bash
touch /tmp/.claude-restart && kill $PPID
```

<!--
TEST CASES:
- `/new` → creates restart signal file and kills session
- `/new` with `c` wrapper → restarts session cleanly
-->
