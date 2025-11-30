---
allowed-tools: Bash
---

Kill current session and restart claude. Requires starting claude via the `c` wrapper script.

```bash
touch /tmp/.claude-restart && kill $PPID
```
