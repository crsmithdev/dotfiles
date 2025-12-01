"""Utility functions - example of type hints and docstrings."""


def double(value: int) -> int:
    """Double the input value.

    Args:
        value: Integer to double

    Returns:
        Double the input value

    Example:
        >>> double(5)
        10
    """
    return value * 2


def format_message(name: str, count: int) -> str:
    """Format a message with name and count.

    Args:
        name: Person's name
        count: Number of items

    Returns:
        Formatted message

    Example:
        >>> format_message("Alice", 3)
        'Alice has 3 items'
    """
    return f"{name} has {count} items"
