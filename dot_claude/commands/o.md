---
description: Switch to Opus or run with Opus without switching
model: opus
allowed-tools: Bash
---

If there are arguments below, execute that request. Otherwise run `/model opus` to switch.

$ARGUMENTS

<!--
TEST CASES:
- `/o` (no args) → runs `/model opus` to switch default model
- `/o what is 2+2` → answers "4" without switching model
-->
