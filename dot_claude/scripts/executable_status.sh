#!/bin/bash
set -e

echo "=== Project Status ==="
git status --short
echo ""

echo "=== Recent Commits ==="
git log --oneline -5
echo ""

echo "=== OpenSpec Proposals ==="
if command -v openspec &> /dev/null; then
  openspec list 2>/dev/null || echo "No OpenSpec proposals found"
else
  echo "openspec command not available"
fi
