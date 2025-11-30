---
description: Commit and push changes to GitHub
---

**Optimized workflow:**

1. Get git status in one batch call:
   ```
   bash ~/.claude/scripts/batch.sh status branch --parallel
   ```

2. Review the status and staged changes:
   - Check `git diff --staged` for what will be committed
   - Check `git status` for what needs staging

3. Draft a terse commit message following repo style:
   - Subject line only (50 chars max, lowercase, imperative)
   - Body only if changes require explanation (>100 chars total)
   - Include standard footer if repo requires it

4. Stage and commit in one operation:
   ```
   git add <files> && git commit -m "message"
   ```

5. Push to origin:
   ```
   git push
   ```

6. Report the commit hash and push status

**For full review before commit:**
```
~/.claude/scripts/ship.sh
```

**Token cost optimization:**
- Use batch command to aggregate git status/branch checks
- Avoid redundant status operations
- Push immediately after commit (single git operation)
- Use structured output if integrating with other tools
