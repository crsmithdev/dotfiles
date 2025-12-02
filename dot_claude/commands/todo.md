---
description: Create an OpenSpec proposal for design ideas and requirements (without tasks/specs)
model: sonnet
---

First, check if `openspec/` directory exists. If not, respond: "This project doesn't have OpenSpec set up."

If OpenSpec is present, create a lightweight design proposal:

1. Choose unique `change-id` from description
2. Create `openspec/changes/<id>/` with:
   - `proposal.md`: Feature overview, user value, scope
   - `design.md`: Design ideas, architecture, trade-offs
3. Skip specs and tasks (expand later with `/propose`)

<!--
TEST CASES:
- `/todo some feature idea` with openspec/ → creates lightweight proposal
- `/todo` in project without openspec/ → politely explains OpenSpec not set up
-->
