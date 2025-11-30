---
description: Fast project status with structured output
---

Run `~/.claude/scripts/sitrep-fast.sh --json` to get structured project status.

**Interpret the JSON output:**
- `git.branch`: Current branch
- `git.status`: Number of uncommitted changes
- `git.recent_commits`: Latest commit hash and message
- `ci.last_run`: Most recent CI run timestamp
- `openspec.proposals`: Count of complete proposals

**If OpenSpec data is needed:**
- Run `openspec list` for detailed proposal breakdown
- Categorize proposals:
  - Complete (not archived): 100% tasks done (marked with ✓)
  - In progress: >0% and <100% tasks done
  - Not started: 0% tasks done

**For full status (slower):**
- Run `~/.claude/scripts/sitrep.sh` for verbose output with all checks
