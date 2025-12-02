---
description: Archive a deployed OpenSpec change and update specs.
model: sonnet
allowed-tools: Bash
---

First, check if `openspec/` directory exists. If not, respond: "This project doesn't have OpenSpec set up."

If OpenSpec is present:

**Steps**
1. Determine change ID (from args, conversation, or ask user)
2. Validate with `openspec list` or `openspec show <id>`
3. Run `openspec archive <id> --yes`
4. Confirm specs updated and change moved to `changes/archive/`

<!--
TEST CASES:
- `/archive <id>` in project with openspec/ → archives the change
- `/archive` in project without openspec/ → politely explains OpenSpec not set up
-->
