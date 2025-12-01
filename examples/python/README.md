# PROJECT_NAME

PROJECT_DESC

## Setup

Install dependencies:
```bash
uv sync
```

Install pre-commit hooks:
```bash
pre-commit install
```

## Development

Run all quality checks:
```bash
just check
```

Individual commands:
- `just fmt` - Format code
- `just lint` - Lint code
- `just types` - Type check
- `just test` - Run tests
- `just install` - Install dependencies
- `just clean` - Remove caches

## Project Structure

```
src/PROJECT_NAME/     - Source code (package)
tests/                - Test code
```

## Type Hints

All code must have type hints. Example:

```python
def greet(name: str) -> str:
    """Greet someone."""
    return f"Hello, {name}!"
```

## Testing

Write tests in `tests/test_*.py`:

```python
def test_greet() -> None:
    """Test greet function."""
    assert greet("World") == "Hello, World!"
```

Run with `just test`.

## Next Steps

1. Create your first module in `src/PROJECT_NAME/`
2. Add tests in `tests/`
3. Run `just check` to verify
4. Commit with clear messages
