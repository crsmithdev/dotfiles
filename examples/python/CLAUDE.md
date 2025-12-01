# Development Instructions for Claude Code

This document provides guidance for AI-assisted development in this project.

## Code Style & Standards

### Type Hints
All functions must have type hints:

```python
def greet(name: str) -> str:
    """Greet someone."""
    return f"Hello, {name}!"
```

### Docstrings
All functions must have docstrings:

```python
def calculate(x: int, y: int) -> int:
    """Calculate sum of two numbers.

    Args:
        x: First number
        y: Second number

    Returns:
        Sum of x and y
    """
    return x + y
```

### Testing
Write tests in `tests/test_*.py`:

```python
def test_calculate() -> None:
    """Test calculate function."""
    assert calculate(2, 3) == 5
```

## Project Structure

```
src/PROJECT_NAME/     - Source code (package)
tests/                - Test code
```

## Development Workflow

1. **Setup**: `uv sync` then `pre-commit install`
2. **Develop**: Make changes in `src/`
3. **Test**: `just test` to run tests
4. **Check**: `just check` to run all checks (fmt, lint, types, test)
5. **Commit**: Clear, focused commits with descriptive messages

## Tools

- **ruff**: Formatting and linting (run via `just fmt` and `just lint`)
- **mypy**: Type checking (run via `just types`)
- **pytest**: Testing (run via `just test`)
- **pre-commit**: Git hooks (run automatically on commit)

## Validation

Before committing, ensure:
- All tests pass: `just test`
- Type hints are correct: `just types`
- Code is formatted: `just fmt`
- No lint issues: `just lint`
- Or run all at once: `just check`
