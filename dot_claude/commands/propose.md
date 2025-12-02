---
description: Scaffold a new OpenSpec change and validate strictly.
model: sonnet
allowed-tools: Read, Write, Bash
---

First, check if `openspec/` directory exists. If not, respond: "This project doesn't have OpenSpec set up. Create an `openspec/` directory with `project.md` first, or use a different workflow."

If OpenSpec is present:

**Guardrails**
- Minimal implementations first; add complexity only when required
- Keep changes tightly scoped
- No code during proposal stage—only design docs
- Ask clarifying questions before editing files

**Steps**
1. Review `openspec/project.md`, run `openspec list`, inspect related code
2. Choose unique verb-led `change-id`, scaffold under `openspec/changes/<id>/`
3. Create `proposal.md`, `tasks.md`, `design.md` (if needed)
4. Draft spec deltas in `changes/<id>/specs/<capability>/spec.md`
5. Validate with `openspec validate <id> --strict`

<!--
TEST CASES:
- `/propose` in project with openspec/ → scaffolds proposal structure
- `/propose` in project without openspec/ → politely explains OpenSpec not set up
-->
