---
description: Test custom slash commands using their TEST cases
model: sonnet
allowed-tools: Glob, Read, SlashCommand
---

Test custom slash commands by executing TEST cases from their HTML comment blocks.

**Excluded commands:** `/ship`, `/new`, `/apply`, `/archive`, `/propose`, `/todo`, `/list` (side effects)

**Process:**

**For commands with TEST cases:**
1. Read all `.md` files in `~/.claude/commands/`
2. Extract TEST cases from `<!-- TEST CASES: -->` blocks
3. Execute each test case using SlashCommand tool
4. Validate behavior matches expected outcomes
5. Report results: ✓ pass / ✗ fail (show full output on failures only)

**For commands without TEST cases (or excluded):**
1. List the command name and reason (no tests / excluded)
2. Review command file contents for:
   - Has `allowed-tools` if it uses Bash, Read, Write, etc.
   - Script references use `~/.claude/scripts/` path
   - Code blocks use proper bash syntax
   - Instructions are clear and actionable
   - No obvious errors or missing required fields
3. Report: ✓ looks reasonable / ⚠ potential issues (with details)

**Final output:**
- Tested commands: pass/fail summary
- Untested commands: sanity check summary
- Overall: X tested, Y passed, Z reviewed

<!--
TEST CASES:
- `/sanity` → runs all testable commands, reports pass/fail summary
- `/sanity` with failures → shows full output only for failed tests
-->
