---
description: Run multiple commands in single aggregated execution
model: haiku
allowed-tools: Bash
---

Aggregate independent commands into a single execution to reduce tool call roundtrips.

**Syntax:**
```
bash ~/.claude/scripts/batch.sh <cmd1> <cmd2> <cmd3> ... [--parallel] [--json]
```

**Available commands:**
- `status` - Git status
- `log` - Git log (last 10 commits)
- `branch` - Git branch info
- `ci` - GitHub CI runs (requires gh CLI)
- `openspec` - OpenSpec proposals (requires openspec CLI)
- `check` - Run all quality checks
- `test` - Run pytest suite
- `lint` - Run ruff linter
- `fmt` - Run ruff formatter

**Examples:**

Fast git status check (parallel, 1 roundtrip):
```
bash ~/.claude/scripts/batch.sh status branch --parallel
```

Pre-commit review:
```
bash ~/.claude/scripts/batch.sh status lint fmt types --parallel
```

Full project check (sequential, fails fast):
```
bash ~/.claude/scripts/batch.sh status lint fmt types test
```

Structured output for integration:
```
bash ~/.claude/scripts/batch.sh status log branch --parallel --json
```

**Speed improvements:**
- `--parallel`: Run independent commands concurrently
- Aggregation: N commands = 1 roundtrip instead of N roundtrips
- Combined: 3 commands in parallel = ~1/3 execution time vs sequential

**Token cost:**
- JSON output: ~50% less processing than human-readable
- Batch aggregation: ~40% fewer tool calls
- Total: ~60-70% token reduction for multi-command workflows
