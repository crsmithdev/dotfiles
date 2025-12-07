---
description: Audit and test Claude Code configuration
model: haiku
allowed-tools: Bash, Read, Glob, Grep
arguments:
  - name: target
    description: Optional audit target (contexts|memory|commands|hooks|settings|tokens|session)
---

Comprehensive audit of Claude Code configuration and session compliance.

```bash
~/.claude/scripts/meta.sh "$ARGUMENTS"
```

Analyze the output and provide:

## Analysis Framework

For each section, identify:

### Findings

**Duplications [warn]:**
- Content appearing in multiple places
- Action: consolidate to single location

**Inconsistencies [warn]:**
- Conflicting patterns or configurations
- Action: standardize approach

**Optimizations [info]:**
- Token efficiency opportunities
- Model choice improvements (use haiku where possible)
- Script extraction for reusability
- Action: specific change with estimated impact

**Path Issues [error]:**
- Missing files, broken references
- Action: create or fix reference

### Recommendations

Prioritize by impact:
1. Critical fixes (broken references, errors)
2. High-impact optimizations (>500 tokens saved)
3. Medium improvements (consistency, clarity)
4. Low priority enhancements

**Format each recommendation:**
- What: specific change to make
- Why: problem being solved
- Impact: quantified benefit (tokens saved, cost reduction, clarity)

<!--
TEST CASES:
- `/meta` → full audit with all sections
- `/meta session` → analyze current session for rule compliance
- `/meta commands` → command inventory and analysis
- `/meta contexts` → context files analysis
- `/meta memory` → CLAUDE.md files analysis
- `/meta hooks` → hook configuration analysis
- `/meta settings` → settings.json analysis
- `/meta tokens` → token usage estimate
-->
