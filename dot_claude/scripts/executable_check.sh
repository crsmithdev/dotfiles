#!/bin/bash
set -e

# Check if just is available
if ! command -v just &> /dev/null; then
  echo "Error: 'just' command not found"
  echo "Check your repo's build system (justfile, Makefile, package.json scripts, etc.)"
  exit 1
fi

# Check if justfile exists
if [ ! -f "justfile" ]; then
  echo "Error: No justfile found in current directory"
  exit 1
fi

echo "Running quality checks..."
echo ""

# Run checks - adjust targets based on what's available in justfile
FAILED=0

echo "=== Format Check ==="
if just fmt 2>&1; then
  echo "✓ Format check passed"
else
  echo "✗ Format check failed"
  FAILED=1
fi
echo ""

echo "=== Lint Check ==="
if just lint 2>&1; then
  echo "✓ Lint check passed"
else
  echo "✗ Lint check failed"
  FAILED=1
fi
echo ""

echo "=== Type Check ==="
if just types 2>&1; then
  echo "✓ Type check passed"
else
  echo "✗ Type check failed"
  FAILED=1
fi
echo ""

echo "=== Test Suite ==="
if just test 2>&1; then
  echo "✓ Tests passed"
else
  echo "✗ Tests failed"
  FAILED=1
fi
echo ""

if [ $FAILED -eq 0 ]; then
  echo "✓ All checks passed"
  exit 0
else
  echo "✗ Some checks failed"
  exit 1
fi
