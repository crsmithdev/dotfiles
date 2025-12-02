# /scaffold-python

Create a new Python project with all standards pre-configured.

## Usage

```
/scaffold-python <project-name> <project-description>
```

## Parameters

- `project-name` (required): Name of the project (e.g., `logparse`)
- `project-description` (required): One-line description of what the project does (e.g., `Parse system logs with patterns`)

## What It Does

This command scaffolds a complete Python 3.12+ project in under a second with:

✓ **7 static files** copied unchanged:
  - `.python-version` (Python 3.12)
  - `.gitignore` (Python patterns)
  - `.pre-commit-config.yaml` (Ruff, mypy, general hooks)
  - `.env.example` (Empty template)
  - `justfile` (Standard development tasks)
  - `CLAUDE.md` (Development instructions for Claude)
  - `openspec/project.md` (Project conventions)

✓ **3 template files** generated with project name/description:
  - `pyproject.toml` (Project metadata and tool configs)
  - `README.md` (Setup and development instructions)
  - `src/{PROJECT_NAME}/__init__.py` (Package initialization)

✓ **2 minimal example files** with imports updated:
  - `src/{PROJECT_NAME}/util.py` (Two simple functions showing patterns)
  - `tests/test_util.py` (Test examples with full coverage)

✓ **2 directories** created:
  - `src/{PROJECT_NAME}/` (Source code location)
  - `tests/` (Test code location)

## Example

```bash
/scaffold-python logparse "Parse system logs with patterns"
```

Creates:
```
logparse/
├── .python-version           # Static file
├── .gitignore                # Static file
├── .pre-commit-config.yaml   # Static file
├── .env.example              # Static file
├── justfile                  # Static file
├── CLAUDE.md                 # Static file
├── pyproject.toml            # Generated template
├── README.md                 # Generated template
├── src/
│   └── logparse/
│       ├── __init__.py       # Generated template
│       └── util.py           # Example code (copyable)
├── tests/
│   ├── conftest.py           # Static file
│   └── test_util.py          # Example tests
└── openspec/
    └── project.md            # Static file
```

## Next Steps

After scaffolding:

```bash
cd logparse
uv sync                 # Install dependencies
pre-commit install      # Setup git hooks
just test              # Verify tooling works
```

Then:
1. Delete `src/logparse/util.py` (example code)
2. Delete `tests/test_util.py` (example tests)
3. Start writing your own modules and tests

## Features

- **No AI code generation**: Pure shell script, 100% deterministic
- **Fully tested**: Example code has complete test coverage
- **Standards included**: Type hints, docstrings, testing, all tools pre-configured
- **Ready to use**: Runs `just test` immediately after scaffolding (all tests pass)
- **Clear examples**: Developers see patterns to copy from in util.py and test_util.py

## Related Commands

- `/check-standards` - Validate project structure and run quality checks
- `/sync-standards` - Update existing projects to current standards
