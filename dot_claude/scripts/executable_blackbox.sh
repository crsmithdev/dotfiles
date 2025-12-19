#!/bin/bash
set -e

BLACK_BOX_FILE="$HOME/.claude/black-box.txt"

if [[ "$*" == *"!"* ]]; then
  # Resume mode: read and delete the file
  if [ -f "$BLACK_BOX_FILE" ]; then
    echo "=== RESUMING FROM BLACK BOX ==="
    cat "$BLACK_BOX_FILE"
    echo "=== END BLACK BOX ==="
    rm "$BLACK_BOX_FILE"
  else
    echo "No black box file found."
  fi
else
  # Save mode: save user message, prompt for context
  echo "USER MESSAGE:" > "$BLACK_BOX_FILE"
  echo "$*" >> "$BLACK_BOX_FILE"
  echo "" >> "$BLACK_BOX_FILE"
  echo "✓ Saved to black box: $BLACK_BOX_FILE"
  echo ""
  echo "Append a brief context summary to $BLACK_BOX_FILE with key files, decisions, and current state."
fi
