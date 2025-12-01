#!/bin/bash
set -e

# Python Project Scaffolding Script
# Usage: scaffold-python.sh <project-name> <project-description>
# Example: scaffold-python.sh logparse "Parse system logs with patterns"

if [ $# -lt 2 ]; then
    echo "Usage: scaffold-python.sh <project-name> <project-description>"
    echo "Example: scaffold-python.sh logparse \"Parse system logs with patterns\""
    exit 1
fi

PROJECT_NAME=$1
PROJECT_DESC=$2
DEST=$PWD/$PROJECT_NAME
EXAMPLES_DIR="$HOME/dotfiles/examples/python"

# Verify examples directory exists
if [ ! -d "$EXAMPLES_DIR" ]; then
    echo "Error: Examples directory not found at $EXAMPLES_DIR"
    exit 1
fi

# Check if project directory already exists
if [ -d "$DEST" ]; then
    echo "Error: Directory $PROJECT_NAME already exists"
    exit 1
fi

# Create project directory
mkdir -p "$DEST"

# Step 1: Copy static files (7 files)
echo "Copying static files..."
cp "$EXAMPLES_DIR/.python-version" "$DEST/.python-version"
cp "$EXAMPLES_DIR/.gitignore" "$DEST/.gitignore"
cp "$EXAMPLES_DIR/.pre-commit-config.yaml" "$DEST/.pre-commit-config.yaml"
cp "$EXAMPLES_DIR/.env.example" "$DEST/.env.example"
cp "$EXAMPLES_DIR/justfile" "$DEST/justfile"
cp "$EXAMPLES_DIR/CLAUDE.md" "$DEST/CLAUDE.md"
mkdir -p "$DEST/openspec"
cp "$EXAMPLES_DIR/openspec/project.md" "$DEST/openspec/project.md"

# Step 2: Create directories
echo "Creating directories..."
mkdir -p "$DEST/src/$PROJECT_NAME"
mkdir -p "$DEST/tests"

# Step 3: Generate template files with substitution
echo "Generating templates..."

# pyproject.toml
cat > "$DEST/pyproject.toml" <<'EOF'
[build-system]
requires = ["hatchling"]
build-backend = "hatchling.build"

[project]
name = "PROJECT_NAME"
version = "0.1.0"
description = "PROJECT_DESC"
requires-python = ">=3.12"
authors = [
    {name = "Developer"}
]

dependencies = []

[project.optional-dependencies]
dev = [
    "pytest>=7.4.0",
    "pytest-cov>=4.1.0",
    "ruff>=0.1.0",
    "mypy>=1.5.0",
    "pre-commit>=3.0.0",
]

[tool.ruff]
line-length = 100
target-version = "py312"

[tool.ruff.lint]
select = ["E", "F", "I", "N", "W"]
ignore = ["E501"]

[tool.mypy]
python_version = "3.12"
warn_return_any = true
warn_unused_configs = true
disallow_untyped_defs = false

[tool.pytest.ini_options]
testpaths = ["tests"]
python_files = ["test_*.py"]
python_classes = ["Test*"]
python_functions = ["test_*"]
addopts = "-v --cov=src --cov-report=term-missing"
EOF

sed -i "s/PROJECT_NAME/$PROJECT_NAME/g" "$DEST/pyproject.toml"
sed -i "s/PROJECT_DESC/$PROJECT_DESC/g" "$DEST/pyproject.toml"

# README.md
cat > "$DEST/README.md" <<'EOF'
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
EOF

sed -i "s/PROJECT_NAME/$PROJECT_NAME/g" "$DEST/README.md"
sed -i "s/PROJECT_DESC/$PROJECT_DESC/g" "$DEST/README.md"

# src/PROJECT_NAME/__init__.py
cat > "$DEST/src/$PROJECT_NAME/__init__.py" <<'EOF'
"""PROJECT_DESC"""

__version__ = "0.1.0"
EOF

sed -i "s/PROJECT_DESC/$PROJECT_DESC/g" "$DEST/src/$PROJECT_NAME/__init__.py"

# Step 4: Copy example code
echo "Copying example code..."
cp "$EXAMPLES_DIR/src/example/util.py" "$DEST/src/$PROJECT_NAME/util.py"
cp "$EXAMPLES_DIR/tests/conftest.py" "$DEST/tests/conftest.py"

# tests/test_util.py
cat > "$DEST/tests/test_util.py" <<'EOF'
"""Tests for util module."""

import pytest

from PROJECT_NAME.util import double, format_message


def test_double() -> None:
    """Test double function."""
    assert double(0) == 0
    assert double(5) == 10
    assert double(-3) == -6


def test_double_with_pytest_param() -> None:
    """Test double with multiple inputs."""
    test_cases = [
        (0, 0),
        (5, 10),
        (-3, -6),
        (100, 200),
    ]
    for input_val, expected in test_cases:
        assert double(input_val) == expected


def test_format_message() -> None:
    """Test format_message function."""
    assert format_message("Alice", 3) == "Alice has 3 items"
    assert format_message("Bob", 0) == "Bob has 0 items"


def test_format_message_with_pytest_param() -> None:
    """Test format_message with multiple inputs."""
    test_cases = [
        ("Alice", 3, "Alice has 3 items"),
        ("Bob", 0, "Bob has 0 items"),
        ("Charlie", 42, "Charlie has 42 items"),
    ]
    for name, count, expected in test_cases:
        assert format_message(name, count) == expected
EOF

sed -i "s/PROJECT_NAME/$PROJECT_NAME/g" "$DEST/tests/test_util.py"

echo "✓ Project created: $PROJECT_NAME/"
echo ""
echo "Next steps:"
echo "  cd $PROJECT_NAME"
echo "  uv sync"
echo "  pre-commit install"
echo "  just test"
