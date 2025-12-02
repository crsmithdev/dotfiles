---
description: Black box - save context for next session
allowed-tools: Bash, Read, Write
---

```bash
~/.claude/scripts/bb.sh $ARGUMENTS
```

<!--
TEST CASES:
- `/bb save this for later` → writes user message + prompts Claude for context summary
- `/bb !` → reads file, deletes it, continues from saved context
-->
