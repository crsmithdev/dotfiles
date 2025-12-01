# Project Conventions

This file documents the development standards and conventions for this project.

## Python Standards

- **Version**: Python 3.12+
- **Package Manager**: UV
- **Type Checking**: mypy (strict mode)
- **Formatting**: ruff
- **Linting**: ruff
- **Testing**: pytest with coverage
- **Pre-commit Hooks**: Enabled

## Code Requirements

### Type Hints
- All functions must have argument and return type hints
- Use `-> None` for functions without return values
- Complex types should use type aliases

### Docstrings
- All functions must have docstrings
- Use Google-style format with Args, Returns, Raises sections
- Include examples where helpful

### Testing
- Write tests for all public functions
- Aim for 80%+ code coverage
- Use pytest fixtures for common setup
- Test both success and edge cases

## File Structure

```
src/PROJECT_NAME/     - Source code
  __init__.py         - Package initialization
  *.py                - Module files
tests/                - Test code
  test_*.py           - Test modules
  conftest.py         - Pytest configuration
```

## Git Conventions

- Branch names: `feature/`, `fix/`, `docs/` prefixes
- Commit messages: Lowercase, imperative mood, no period
- One logical change per commit

## Quality Gates

Projects must pass:
- Type checking: `mypy src/ tests/`
- Linting: `ruff check .`
- Formatting: `ruff format .`
- Tests: `pytest`
- Coverage: Minimum 80%

## Dependencies

### Core
- UV for package management
- Python 3.12+

### Dev
- pytest (testing)
- pytest-cov (coverage)
- ruff (formatting and linting)
- mypy (type checking)
- pre-commit (git hooks)

Add domain-specific dependencies as needed in `pyproject.toml`.
