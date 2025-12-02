---
description: Switch to Haiku or run with Haiku without switching
model: haiku
allowed-tools: Bash
---

If there are arguments below, execute that request. Otherwise run `/model haiku` to switch.

$ARGUMENTS

<!--
TEST CASES:
- `/h` (no args) → runs `/model haiku` to switch default model
- `/h what is 2+2` → answers "4" without switching model
-->
