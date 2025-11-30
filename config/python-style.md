# Python Style Guide

## Code Style

### Formatter and Linter

Use Ruff for both formatting and linting:

```bash
uv run ruff format .        # Format code
uv run ruff check --fix .   # Lint with auto-fix
```

Run both together:

```bash
uv run ruff check --fix . && ruff format .
```

### Line Length

100 characters (configure in pyproject.toml)

### Quotes

Double quotes preferred for strings:

**Good:**
```python
name = "example"
message = "Process complete"
```

**Bad:**
```python
name = 'example'
message = 'Process complete'
```

### Import Organization

stdlib → third-party → local, sorted alphabetically within groups:

**Good:**
```python
import os
from pathlib import Path

import httpx
import numpy as np
from pydantic import BaseModel

from myapp.analysis import core
from myapp.config import settings
```

**Bad:**
```python
from myapp.config import settings
import httpx
import os
from myapp.analysis import core
from pydantic import BaseModel
import numpy as np
from pathlib import Path
```

## Type Hints

Always use type hints for function signatures. Use modern Python 3.12+ syntax:

**Good:**
```python
from collections.abc import Sequence
from typing import TypeAlias

def process_files(paths: list[str], count: int | None = None) -> dict[str, int]:
    """Process files and return counts."""
    results = {}
    for path in paths:
        results[path] = count or 0
    return results

# Complex types with TypeAlias
Data: TypeAlias = tuple[bytes, int]

def load_data(path: str) -> Data:
    """Load data file and return content with size."""
    content = Path(path).read_bytes()
    return content, len(content)
```

**Bad:**
```python
from typing import List, Optional, Dict, Tuple

def process_files(paths: List[str], count: Optional[int] = None) -> Dict[str, int]:
    results = {}
    for path in paths:
        results[path] = count or 0
    return results

def load_data(path: str) -> Tuple[bytes, int]:
    content = Path(path).read_bytes()
    return content, len(content)
```

### Type Checking

Run mypy in strict mode:

```bash
uv run mypy --strict src/
```

## Error Handling

Create a base exception and derive specific exceptions from it:

**Good:**
```python
class ApplicationError(Exception):
    """Base exception for application."""
    pass

class DataLoadError(ApplicationError):
    """Failed to load data."""
    pass

class ProcessingError(ApplicationError):
    """Processing operation failed."""
    pass

# Usage
try:
    data = load_file(path)
except FileNotFoundError as e:
    raise DataLoadError(f"Failed to load {path}") from e
```

**Bad:**
```python
# No base exception
class DataLoadError(Exception):
    pass

# Bare except
try:
    data = load_file(path)
except:
    raise DataLoadError(f"Failed to load {path}")

# Not preserving exception chain
try:
    data = load_file(path)
except Exception as e:
    raise DataLoadError(f"Failed to load {path}")
```

Always be specific in except clauses and use `raise ... from e` to preserve exception chains.

## Async Patterns

### HTTP Requests

Prefer `httpx` over `requests` for HTTP (supports async):

**Good:**
```python
import httpx

async def fetch_data(url: str) -> dict:
    async with httpx.AsyncClient() as client:
        response = await client.get(url)
        response.raise_for_status()
        return response.json()
```

**Bad:**
```python
import requests

def fetch_data(url: str) -> dict:
    response = requests.get(url)
    response.raise_for_status()
    return response.json()
```

### Concurrent Tasks

Use `asyncio.TaskGroup` (Python 3.11+) for concurrent tasks:

**Good:**
```python
import asyncio

async def process_multiple(paths: list[str]) -> list[float]:
    async with asyncio.TaskGroup() as tg:
        tasks = [tg.create_task(analyze_file(path)) for path in paths]
    return [task.result() for task in tasks]
```

**Bad:**
```python
import asyncio

async def process_multiple(paths: list[str]) -> list[float]:
    # asyncio.gather doesn't cancel on failure
    return await asyncio.gather(*[analyze_file(path) for path in paths])
```

Avoid mixing sync and async code paths - choose one approach per module.

## Data Validation

Use Pydantic v2 for data models and validation:

**Good:**
```python
from pydantic import BaseModel, Field, model_validator

class Result(BaseModel):
    """Processing result."""
    value: float = Field(gt=0, description="Result value")
    confidence: float = Field(ge=0, le=1, description="Confidence score")
    source: str

    @model_validator(mode="after")
    def validate_confidence(self) -> "Result":
        if self.confidence < 0.5 and self.value > 100:
            raise ValueError("High value requires high confidence")
        return self
```

**Bad:**
```python
from pydantic import BaseModel, validator

class Result(BaseModel):
    value: float
    confidence: float
    source: str

    @validator("confidence")  # Deprecated in v2
    def validate_confidence(cls, v, values):
        if v < 0.5 and values.get("value", 0) > 100:
            raise ValueError("High value requires high confidence")
        return v
```

Key points:
- Prefer `model_validator` over deprecated `root_validator`/`validator`
- Use `Field()` for constraints and documentation
- Pydantic v2 has better performance and type checking

## Logging

Use `logging` stdlib, configure once at entry point:

**Good:**
```python
import logging

logger = logging.getLogger(__name__)

def process(path: str) -> float:
    logger.info(f"Starting processing for {path}")
    try:
        result = _process_file(path)
        logger.info(f"Processing complete: {result:.1f}")
        return result
    except Exception as e:
        logger.error(f"Processing failed: {e}")
        raise
```

**Bad:**
```python
import logging

def process(path: str) -> float:
    # No module-level logger
    logging.info("start_processing")  # Not natural language
    try:
        result = _process_file(path)
        logging.info(f"process_complete {result}")  # Inconsistent
        return result
    except Exception as e:
        logging.error("error")  # Not descriptive
        raise
```

Key points:
- Use `logger = logging.getLogger(__name__)` per module
- Log in natural language: "Starting processing" not "start_processing"
- Use appropriate capitalization and punctuation
- Prefer f-strings in log calls or use lazy `%` formatting

## Documentation

Use Google-style docstrings on public functions and classes:

**Good:**
```python
def process(input_path: str, method: str = "default") -> float:
    """Process input file.

    Args:
        input_path: Path to input file
        method: Processing method to use

    Returns:
        Processing result value

    Raises:
        LoadError: If input file cannot be loaded
        ProcessingError: If processing fails
    """
    pass
```

**Bad:**
```python
def process(input_path: str, method: str = "default") -> float:
    """
    Process input file

    :param input_path: str - Path to input file
    :param method: str - Processing method to use
    :return: float - Processing result value
    :raises: LoadError if input file cannot be loaded
    :raises: ProcessingError if processing fails
    """
    pass
```

Key points:
- Google style, not Sphinx/reST
- Keep docstrings to one line when possible
- Type hints replace type info in docstrings
- Only document public APIs
