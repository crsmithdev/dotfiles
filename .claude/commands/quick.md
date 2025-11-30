---
description: Ultra-fast project status (local operations only, no CI/OpenSpec)
---

Get instant project status using cached git operations (no external API calls).

```
bash ~/.claude/scripts/sitrep-fast.sh --no-ci --no-openspec
```

**Output (one-liner format):**
```
Branch: <branch-name> | Status: <N> changes | Latest: <commit-hash> <message>
```

**For JSON (programmatic use):**
```
bash ~/.claude/scripts/sitrep-fast.sh --no-ci --no-openspec --json
```

**Speed characteristics:**
- Instant on cache hits (< 10ms)
- Single subprocess overhead
- No network requests
- No OpenSpec validation

**Use for:**
- Quick sanity checks during development
- Embedding in scripts where speed is critical
- Reducing token overhead in frequent checks

**When you need more details:**
- Use `/sitrep` for full status with CI and OpenSpec
- Use `git status` for detailed file changes
- Use `openspec list` for proposal breakdown
