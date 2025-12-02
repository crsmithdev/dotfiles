#!/bin/bash

BB_FILE="/tmp/claude-black-box.txt"

# Check if file exists from previous session
if [ -f "$BB_FILE" ] && [ -s "$BB_FILE" ]; then
  echo "📦 Black box context found from previous session:"
  echo "---"
  cat "$BB_FILE"
  echo "---"
  echo ""
  echo "Use '/bb !' to continue with this context, or start fresh."

  # Mark that we notified about this file
  echo "NOTIFIED" > "${BB_FILE}.notified"
else
  # Clean up if it was never resumed
  rm -f "$BB_FILE" "${BB_FILE}.notified"
fi
