#!/bin/bash
# Validate slash commands on session start

errors=0

# Check global commands for valid frontmatter
for cmd in ~/.claude/commands/*.md; do
  [ -f "$cmd" ] || continue
  name=$(basename "$cmd" .md)

  # Check has description
  if ! grep -q "^description:" "$cmd" 2>/dev/null; then
    echo "❌ $name: missing description in frontmatter"
    ((errors++))
  fi
done

# Check for shadowed global commands
if [ -d ".claude/commands" ]; then
  for local_cmd in .claude/commands/*.md; do
    [ -f "$local_cmd" ] || continue
    name=$(basename "$local_cmd" .md)

    if [ -f "$HOME/.claude/commands/$name.md" ]; then
      echo "⚠️  $name: local command shadows global (may be intentional if extending)"
    fi
  done
fi

if [ $errors -eq 0 ]; then
  echo "✓ Slash commands validated"
fi

exit 0
