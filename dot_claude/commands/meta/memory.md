---
description: Analyze memory and context files with optimization recommendations
model: haiku
allowed-tools: Bash, Read, Glob, Grep
---

Analyze memory systems and provide optimization recommendations.

**Analysis scope:**

1. **Memory files**:
   - CLAUDE.md files (global ~/.claude/CLAUDE.md and project-local)
   - Context files in .claude/contexts/
   - Memory graph structure and relationships
   - Cipher/encoding patterns

2. **Statistics to report**:
   - Total memory footprint (character count, token estimate)
   - File count and sizes
   - Redundancy detection (duplicate content across files)
   - Unused or stale memory entries
   - Memory injection frequency (how often each is loaded)

3. **Optimization recommendations**:
   - Consolidation opportunities (merge similar context)
   - Removal candidates (outdated or unused memory)
   - Restructuring suggestions (better organization)
   - Token efficiency improvements
   - Memory hierarchy optimization

4. **Output format**:
   ```
   ## Memory Analytics

   **Statistics:**
   - Total files: X
   - Total size: Y chars (~Z tokens)
   - Redundancy: N% duplicate content
   - Average file size: A chars

   **Files breakdown:**
   - ~/.claude/CLAUDE.md: X chars
   - project/CLAUDE.md: Y chars
   - .claude/contexts/: Z files, A chars

   **Optimization Recommendations:**

   [HIGH] Remove stale context file X (last used: never, 500 tokens)
   [MED] Consolidate duplicated git instructions in CLAUDE.md
   [LOW] Simplify verbose instruction in context Y (save ~100 tokens)

   **Estimated savings:** ~X tokens (Y% reduction)
   ```

<!--
TEST CASES:
- `/memory` → analyzes all memory files, provides statistics and recommendations
- `/memory` with no memory files → reports empty state, suggests initial setup
-->
