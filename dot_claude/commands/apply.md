---
description: Implement an approved OpenSpec change and keep tasks in sync.
model: sonnet
---

First, check if `openspec/` directory exists. If not, respond: "This project doesn't have OpenSpec set up."

If OpenSpec is present:

**Steps**
1. Read `changes/<id>/proposal.md`, `design.md`, and `tasks.md`
2. Work through tasks sequentially, minimal edits
3. Mark tasks `- [x]` as completed
4. Use `openspec show <id>` for context as needed

**Guardrails**
- Minimal implementations first
- Keep changes tightly scoped
- Confirm completion before updating statuses

<!--
TEST CASES:
- `/apply <id>` in project with openspec/ → implements the change
- `/apply` in project without openspec/ → politely explains OpenSpec not set up
-->
