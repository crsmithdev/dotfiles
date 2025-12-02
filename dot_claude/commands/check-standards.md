# /check-standards

Validate that a Python project meets structural invariants and quality standards.

## Usage

```
/check-standards [project-dir]
```

## Parameters

- `project-dir` (optional): Path to project directory. Defaults to current directory.

## What It Does

Runs both semantic and programmatic validation:

### Structural Invariants (Required)

Checks that the project has the required file structure:
- ✓ `pyproject.toml` exists
- ✓ `README.md` exists
- ✓ `.gitignore` exists
- ✓ `.pre-commit-config.yaml` exists
- ✓ `CLAUDE.md` exists (development instructions)
- ✓ `src/` directory exists
- ✓ `tests/` directory exists
- ✓ `tests/conftest.py` exists

### Tool Configurations (Required)

Checks that required tools are configured:
- ✓ `[tool.ruff]` section in `pyproject.toml`
- ✓ `[tool.mypy]` section in `pyproject.toml`
- ✓ `[tool.pytest.ini_options]` section in `pyproject.toml`

### Quality Checks (Runtime)

Runs actual tools to verify code quality:
- ✓ Type checking with `mypy` (strict mode)
- ✓ Linting with `ruff`
- ✓ Tests with `pytest`

## Example Output

```
Checking Python project standards...

Structural Invariants:
✓ pyproject.toml exists
✓ README.md exists
✓ .gitignore exists
✓ .pre-commit-config.yaml exists
✓ CLAUDE.md exists (development instructions)
✓ src/ directory exists
✓ tests/ directory exists
✓ tests/conftest.py exists

Tool Configurations:
✓ Ruff configured in pyproject.toml
✓ Mypy configured in pyproject.toml
✓ Pytest configured in pyproject.toml

Quality Checks:
Running quality tools...
✓ Type checking (mypy) passes
✓ Linting (ruff) passes
✓ Tests (pytest) pass

─────────────────────────────
Passed: 20
Failed: 0
✓ All checks passed
```

## Exit Codes

- `0`: All checks passed
- `1`: One or more checks failed

## Semantic Validation (AI Understanding)

In addition to programmatic checks, `/check-standards` can provide semantic feedback about patterns:

- Are domain models following project conventions?
- Are async patterns consistent with project style?
- Are testing strategies aligned with examples?
- Do API designs match established patterns?

This requires reading project code and comparing against exemplar patterns.

## Related Commands

- `/scaffold-python` - Create a new project from scratch
- `/sync-standards` - Update existing project to current standards
