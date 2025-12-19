---
description: Commit and push changes to GitHub
model: sonnet
allowed-tools: Bash, Read, Glob
---

**Workflow:**

1. **Run checks**: Execute linting, formatting, type checks, tests (if configured via justfile, package.json scripts, etc.)
   - Stop if checks fail with errors
   - Show warnings but continue

2. **Review changes**:
   - Run `git status` and `git diff` to see all changes
   - Identify untracked files

3. **Stage files intelligently**:
   - Add untracked files that should be tracked based on:
     - Project structure (source files, configs, docs)
     - Language conventions (e.g., .py, .ts, .md, .yaml)
     - Existing .gitignore rules
   - **Skip**: build artifacts, dependencies, temp files, secrets, IDE configs
   - **List skipped files** explicitly so user knows what was excluded

4. **Draft commit message**:
   - Subject line only (50 chars max, lowercase, imperative mood)
   - Follow repo style from recent commits
   - Include standard footer:
     ```
     🤖 Generated with [Claude Code](https://claude.com/claude-code)

     Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>
     ```

5. **Commit and push**:
   ```
   git add <files> && git commit -m "$(cat <<'EOF'
   message here

   🤖 Generated with [Claude Code](https://claude.com/claude-code)

   Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>
   EOF
   )" && git push
   ```

6. **Report**: Show commit hash and push status

<!--
TEST CASES:
- `/ship` with passing checks → stages files, commits, pushes
- `/ship` with failing checks → stops, reports errors
- `/ship` with untracked files → stages relevant ones, lists skipped ones
- `/ship` with no changes → reports "nothing to commit"
-->
