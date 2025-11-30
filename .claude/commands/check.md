---
description: Run all quality checks (format, lint, type check, tests) in parallel
---

Run quality checks in parallel batch mode to reduce execution time.

**Fast mode (recommended):**
```
bash ~/.claude/scripts/batch.sh lint fmt types test --parallel
```

**With JSON output for programmatic use:**
```
bash ~/.claude/scripts/batch.sh lint fmt types test --parallel --json
```

**Individual checks:**
- `just lint` - Ruff linting with auto-fix
- `just fmt` - Ruff formatting
- `just types` - Mypy type checking
- `just test` - Pytest suite

**Sequential execution (safer for debugging):**
```
bash ~/.claude/scripts/batch.sh lint fmt types test
```

**Skip specific checks:**
```
bash ~/.claude/scripts/batch.sh fmt types test --parallel
```

**Expected output:** All checks complete or first failure blocks subsequent checks.
