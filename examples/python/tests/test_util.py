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
