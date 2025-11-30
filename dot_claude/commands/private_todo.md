---
name: Quick Design Proposal
description: Create an OpenSpec proposal for design ideas and requirements (without tasks/specs)
category: OpenSpec
tags: [openspec, design]
---

Create an OpenSpec design proposal for ideas and requirements without implementation tasks or specs. I'll scaffold the change directory, create proposal.md and design.md capturing your ideas, and you can expand it to a full proposal later using /o:propose.

**What I'll do:**
1. Choose a unique `change-id` based on your description
2. Create `openspec/changes/<id>/` with:
   - `proposal.md`: Feature overview, user value, and scope
   - `design.md`: Design ideas, architecture, trade-offs, and requirements
3. Leave it ready for you to expand with specs and tasks later

**Then later:** Use `/o:propose` to develop it into a full proposal with spec deltas and task lists.
