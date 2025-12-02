---
description: Open file or folder in VS Code
allowed-tools: Bash
---

```bash
~/.claude/scripts/code.sh $ARGUMENTS
```

<!--
TEST CASES:
- `/code src/main.py` → runs `code src/main.py`
- `/code` (no args) → runs `code .` to open current directory
-->
