---
description: Black box - save context for next session
---

**Black box - save context across sessions**

This command saves or resumes context between Claude sessions.

File: `/tmp/claude-black-box.txt`

Modes:
- **Save mode**: `/bb <message>` - write specific message to file for next session
- **Context mode**: `/bb ^` - save recent conversation context (see below)
- **Resume mode**: `/bb !` - read file and continue, delete file after reading
- **Auto-cleanup**: File auto-deletes on next startup if never resumed

To implement:
1. If args contain `!` → Read the file, delete it, then continue based on content
2. If args contain `^` → Summarize recent context to file:
   - What task/problem was being worked on
   - Key files modified or discussed
   - Important decisions made
   - Current progress state
   - What needs to happen next
   - Include enough Q/A pairs to capture the full context (not just the last one)
3. Otherwise → Save the literal message to file

$ARGUMENTS
