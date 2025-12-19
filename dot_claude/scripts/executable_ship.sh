#!/bin/bash
# Show git status for commit preparation

echo "=== GIT STATUS ==="
git status

echo -e "\n=== GIT DIFF ==="
git diff

echo -e "\n=== RECENT COMMITS ==="
git log -3 --oneline

echo -e "\n=== Ready to commit ==="
echo "Review the changes above and provide a commit message."
