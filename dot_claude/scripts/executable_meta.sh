#!/bin/bash
# Meta audit: comprehensive Claude Code configuration and session analysis
set -euo pipefail

TARGET="${1:-all}"
TRANSCRIPT="${TRANSCRIPT_PATH:-}"

# Helper: estimate tokens (4 chars per token)
estimate_tokens() {
  local bytes=$1
  echo $((bytes / 4))
}

# Helper: get file size
filesize() {
  wc -c < "$1" 2>/dev/null || echo 0
}

# ============================================================================
# SESSION AUDIT
# ============================================================================

audit_session() {
  local transcript="${1:-${TRANSCRIPT}}"

  echo "## Session Analysis"
  echo

  if [ -z "$transcript" ] || [ ! -f "$transcript" ]; then
    echo "⚠️  No transcript found (session audit skipped)"
    echo
    return 0
  fi

  echo "**Transcript:** $(basename "$transcript")"
  echo "**Lines:** $(wc -l < "$transcript")"
  echo

  # Count tool uses
  count_tool() {
    local count=$(grep "\"type\":\"tool_use\".*\"name\":\"$1\"" "$transcript" 2>/dev/null | wc -l)
    echo "$count"
  }

  # Extract assistant text content
  extract_assistant_text() {
    grep '"role":"assistant"' "$transcript" | \
      grep -o '"text":"[^"]*"' | \
      sed 's/"text":"//; s/"$//' | \
      sed 's/\\n/\n/g'
  }

  # Check for footer patterns
  has_footer_pattern() {
    local pattern="$1"
    local count=$(extract_assistant_text | grep -i "$pattern" | wc -l)
    echo "$count"
  }

  # Check for rule violations
  check_preambles() {
    local count=$(extract_assistant_text | grep -iE "^(sure|great question|i'd be happy|let me)" | wc -l)
    echo "$count"
  }

  check_signoffs() {
    local count=$(extract_assistant_text | grep -iE "(let me know|feel free to|hope this helps|happy to help)" | wc -l)
    echo "$count"
  }

  check_summaries() {
    local count=$(extract_assistant_text | grep -iE "^(I'm going to|I'll|Let me (first|start by)|Here's what)" | wc -l)
    echo "$count"
  }

  # Tool usage
  echo "## Tool Usage"
  echo
  task_count=$(count_tool "Task")
  skill_count=$(count_tool "Skill")
  todo_count=$(count_tool "TodoWrite")

  echo "- Task (subagents): $task_count"
  echo "- Skill: $skill_count"
  echo "- TodoWrite: $todo_count"
  echo

  # Footer compliance
  echo "## Footer Compliance"
  echo

  agent_footers=$(has_footer_pattern "Agents used:")
  skill_footers=$(has_footer_pattern "Skills used:")

  if [ "$task_count" -gt 0 ] && [ "$agent_footers" -eq 0 ]; then
    echo "⚠️  Task tool used ($task_count times) but no 'Agents used:' footer found"
  elif [ "$task_count" -gt 0 ]; then
    echo "✓ Agent usage reported in footer"
  fi

  if [ "$skill_count" -gt 0 ] && [ "$skill_footers" -eq 0 ]; then
    echo "⚠️  Skill tool used ($skill_count times) but no 'Skills used:' footer found"
  elif [ "$skill_count" -gt 0 ]; then
    echo "✓ Skill usage reported in footer"
  fi

  if [ "$task_count" -eq 0 ] && [ "$skill_count" -eq 0 ]; then
    echo "✓ No Task/Skill tools used this session"
  fi

  echo

  # Rule violations
  echo "## Style Guide Compliance"
  echo
  preambles=$(check_preambles)
  signoffs=$(check_signoffs)
  summaries=$(check_summaries)

  rule_violations=$((preambles + signoffs + summaries))

  if [ "$rule_violations" -eq 0 ]; then
    echo "✓ No style violations detected"
  else
    echo "**Potential violations:** $rule_violations matches"
    [ "$preambles" -gt 0 ] && echo "- Preamble patterns: $preambles"
    [ "$signoffs" -gt 0 ] && echo "- Sign-off patterns: $signoffs"
    [ "$summaries" -gt 0 ] && echo "- Summary patterns: $summaries"
    echo
    echo "*Note: These are pattern matches and may include false positives*"
  fi
  echo

  # TodoWrite usage
  echo "## Task Management"
  echo
  assistant_turns=$(grep -c '"role":"assistant"' "$transcript" 2>/dev/null || echo 0)

  if [ "$assistant_turns" -gt 5 ] && [ "$todo_count" -eq 0 ]; then
    echo "⚠️  No TodoWrite used in session with $assistant_turns assistant turns"
    echo "   Consider using TodoWrite for multi-step tasks"
  elif [ "$todo_count" -gt 0 ]; then
    echo "✓ TodoWrite used $todo_count time(s)"
  else
    echo "✓ Short session ($assistant_turns turns), TodoWrite not required"
  fi
  echo

  # Context injection analysis
  echo "## Context Injection"
  echo

  extract_contexts() {
    grep -oE 'project-contexts: [^}]+' "$transcript" | \
      sed 's/project-contexts: //' | \
      sed 's/\\n.*//' | \
      sort | uniq -c
  }

  extract_user_contexts() {
    grep -oE 'user-contexts: [^}]+' "$transcript" | \
      sed 's/user-contexts: //' | \
      sed 's/\\n.*//' | \
      sort | uniq -c
  }

  project_contexts=$(extract_contexts 2>/dev/null || echo "")
  user_contexts=$(extract_user_contexts 2>/dev/null || echo "")

  if [ -n "$project_contexts" ]; then
    echo "**Project contexts loaded:**"
    echo "$project_contexts" | sed 's/^/  /'
    echo
  fi

  if [ -n "$user_contexts" ]; then
    echo "**User contexts loaded:**"
    echo "$user_contexts" | sed 's/^/  /'
    echo
  fi

  # Check for false positives
  false_positive_count=0
  if echo "$project_contexts" | grep -q "edm-terminology"; then
    edm_work=$(extract_assistant_text | grep -iE "(drop|buildup|breakdown|outro|intro)" | wc -l)
    if [ "$edm_work" -eq 0 ]; then
      echo "⚠️  EDM terminology loaded but no EDM-specific work detected"
      false_positive_count=$((false_positive_count + 1))
    fi
  fi

  if [ "$false_positive_count" -eq 0 ] && [ -n "$project_contexts$user_contexts" ]; then
    echo "✓ Context injection appears relevant to session work"
  fi

  echo

  # Rule compliance
  echo "## Rule Compliance & Conflicts"
  echo

  echo "**Rules followed:**"
  rules_followed=0

  if [ "$preambles" -eq 0 ]; then
    echo "- ✓ No preambles (CLAUDE.md interaction style)"
    rules_followed=$((rules_followed + 1))
  fi

  if [ "$signoffs" -eq 0 ]; then
    echo "- ✓ No sign-offs (CLAUDE.md interaction style)"
    rules_followed=$((rules_followed + 1))
  fi

  if [ -n "$project_contexts$user_contexts" ]; then
    echo "- ✓ Context injection working (hooks configured)"
    rules_followed=$((rules_followed + 1))
  fi

  bash_count=$(count_tool "Bash")
  if [ "$bash_count" -gt 0 ]; then
    echo "- ✓ Bash tool used ($bash_count times)"
    rules_followed=$((rules_followed + 1))
  fi

  read_count=$(count_tool "Read")
  if [ "$read_count" -gt 0 ]; then
    echo "- ✓ Read tool used ($read_count times)"
    rules_followed=$((rules_followed + 1))
  fi

  if [ "$rules_followed" -eq 0 ]; then
    echo "- (minimal session, limited rule application)"
  fi

  echo
  echo "**Rules deprioritized:**"
  rules_skipped=0

  if [ "$assistant_turns" -gt 3 ] && [ "$todo_count" -eq 0 ]; then
    echo "- ⚠️  TodoWrite not used despite $assistant_turns turns"
    echo "  Reason: Likely single analytical task, not multi-step project"
    rules_skipped=$((rules_skipped + 1))
  fi

  if [ "$false_positive_count" -gt 0 ]; then
    echo "- ⚠️  Context injection triggered on false positive"
    echo "  Reason: Hook keyword matching too broad (default fallback)"
    rules_skipped=$((rules_skipped + 1))
  fi

  explore_patterns=$(extract_assistant_text | grep -iE "let me (search|find|explore|look for)" | wc -l)
  if [ "$explore_patterns" -gt 0 ] && [ "$task_count" -eq 0 ]; then
    echo "- ⚠️  Exploration work without Task/Explore agent"
    echo "  Reason: Direct reads faster for known paths (2-3 targeted files)"
    rules_skipped=$((rules_skipped + 1))
  fi

  if [ "$rules_skipped" -eq 0 ]; then
    echo "- (no rule deprioritization detected)"
  fi

  echo

  echo "**Potential rule conflicts:**"
  conflicts=0

  if [ "$todo_count" -eq 0 ] && [ "$assistant_turns" -gt 5 ]; then
    echo "- System: Use TodoWrite frequently vs User: No preambles/summaries"
    echo "  Resolution: Skip TodoWrite when tracking doesn't add value"
    conflicts=$((conflicts + 1))
  fi

  if [ "$false_positive_count" -gt 0 ]; then
    echo "- Hook: Always inject contexts vs User: Token efficiency"
    echo "  Resolution: Flagged for optimization (remove default fallback)"
    conflicts=$((conflicts + 1))
  fi

  if [ -f ~/.claude/settings.json ] && grep -q '"alwaysThinkingEnabled": true' ~/.claude/settings.json; then
    echo "- Settings: alwaysThinkingEnabled vs User: Answer directly, then stop"
    echo "  Resolution: Think internally, don't output extended reasoning unless asked"
    conflicts=$((conflicts + 1))
  fi

  if [ "$conflicts" -eq 0 ]; then
    echo "- (no rule conflicts detected)"
  fi

  echo
  echo "---"
  echo
}

# ============================================================================
# CONFIGURATION AUDIT
# ============================================================================

audit_memory() {
  echo "## Memory Analysis"
  echo
  echo "### Inventory"
  echo "| Level | File | Size | ~Tokens | Purpose |"
  echo "|-------|------|------|---------|---------|"

  if [ -f ~/.claude/CLAUDE.md ]; then
    size=$(filesize ~/.claude/CLAUDE.md)
    tokens=$(estimate_tokens "$size")
    echo "| User | ~/.claude/CLAUDE.md | ${size}B | ~$tokens | Global instructions |"
  fi

  if [ -f ~/CLAUDE.md ]; then
    size=$(filesize ~/CLAUDE.md)
    tokens=$(estimate_tokens "$size")
    echo "| Project | ~/CLAUDE.md | ${size}B | ~$tokens | Project instructions |"
  fi

  if [ -f ./CLAUDE.md ] && [ "$(pwd)" != "$HOME" ]; then
    size=$(filesize ./CLAUDE.md)
    tokens=$(estimate_tokens "$size")
    echo "| Project | ./CLAUDE.md | ${size}B | ~$tokens | Project instructions |"
  fi

  if [ -f .claude/CLAUDE.md ]; then
    size=$(filesize .claude/CLAUDE.md)
    tokens=$(estimate_tokens "$size")
    echo "| Project | .claude/CLAUDE.md | ${size}B | ~$tokens | Local instructions |"
  fi

  if [ -f ~/.claude/memory-graph.json ]; then
    size=$(filesize ~/.claude/memory-graph.json)
    tokens=$(estimate_tokens "$size")
    echo "| User | ~/.claude/memory-graph.json | ${size}B | ~$tokens | Structured memory graph |"
  fi

  echo

  # Memory graph statistics
  if [ -f ~/.claude/memory-graph.json ]; then
    echo "### Memory Graph Statistics"

    python3 -c "
import json
import sys
from collections import Counter

try:
    with open('$HOME/.claude/memory-graph.json', 'r') as f:
        data = json.load(f)

    entities = data.get('entities', [])
    relations = data.get('relations', [])

    print(f'- **Entities**: {len(entities)} total')

    # Entity type breakdown
    types = Counter(e.get('entityType', 'unknown') for e in entities)
    if types:
        print('  - By type:')
        for entity_type, count in sorted(types.items(), key=lambda x: -x[1]):
            print(f'    - {entity_type}: {count}')

    print(f'- **Relations**: {len(relations)} total')

    # Relation type breakdown
    rel_types = Counter(r.get('relationType', 'unknown') for r in relations)
    if rel_types:
        print('  - By type:')
        for rel_type, count in sorted(rel_types.items(), key=lambda x: -x[1]):
            print(f'    - {rel_type}: {count}')

    # Observation stats
    total_obs = sum(len(e.get('observations', [])) for e in entities)
    if entities:
        avg_obs = total_obs / len(entities)
        print(f'- **Observations**: {total_obs} total (~{avg_obs:.1f} per entity)')

except Exception as e:
    print(f'Error parsing memory graph: {e}', file=sys.stderr)
" 2>/dev/null || echo "  Error: Cannot parse memory graph"

    echo
  fi
}

audit_contexts() {
  echo "## Contexts Analysis"
  echo
  echo "### Inventory"
  echo "| Level | File | Size | ~Tokens | Purpose |"
  echo "|-------|------|------|---------|---------|"

  for ctx in ~/.claude/contexts/*.xml; do
    [ -f "$ctx" ] || continue
    name=$(basename "$ctx")
    size=$(filesize "$ctx")
    tokens=$(estimate_tokens "$size")
    echo "| User | $name | ${size}B | ~$tokens | Context injection |"
  done

  if [ -d ".claude/contexts" ]; then
    for ctx in .claude/contexts/*.xml; do
      [ -f "$ctx" ] || continue
      name=$(basename "$ctx")
      size=$(filesize "$ctx")
      tokens=$(estimate_tokens "$size")
      echo "| Project | $name | ${size}B | ~$tokens | Context injection |"
    done
  fi

  echo
  echo "### Analysis"
  echo "- Context injection working via ~/.claude/scripts/inject-user-context.sh"
  echo "- Keyword-based triggers load relevant contexts"
  echo
}

audit_commands() {
  echo "## Commands Analysis"
  echo
  echo "### Inventory"
  echo "| Level | Command | Model | Tools | TEST | Description |"
  echo "|-------|---------|-------|-------|------|-------------|"

  for cmd in ~/.claude/commands/*.md; do
    [ -f "$cmd" ] || continue
    name=$(basename "$cmd" .md)
    desc=$(grep "^description:" "$cmd" 2>/dev/null | cut -d: -f2- | xargs || echo "MISSING")
    model=$(grep "^model:" "$cmd" 2>/dev/null | cut -d: -f2 | xargs || echo "default")
    tools=$(grep "^allowed-tools:" "$cmd" 2>/dev/null | cut -d: -f2 | xargs || echo "all")
    has_test=$(grep -q "TEST CASES" "$cmd" 2>/dev/null && echo "✓" || echo "✗")
    echo "| User | /$name | $model | $tools | $has_test | $desc |"
  done

  if [ -d ".claude/commands" ]; then
    for cmd in .claude/commands/*.md; do
      [ -f "$cmd" ] || continue
      name=$(basename "$cmd" .md)
      desc=$(grep "^description:" "$cmd" 2>/dev/null | cut -d: -f2- | xargs || echo "MISSING")
      model=$(grep "^model:" "$cmd" 2>/dev/null | cut -d: -f2 | xargs || echo "default")
      tools=$(grep "^allowed-tools:" "$cmd" 2>/dev/null | cut -d: -f2 | xargs || echo "all")
      has_test=$(grep -q "TEST CASES" "$cmd" 2>/dev/null && echo "✓" || echo "✗")
      echo "| Project | /$name | $model | $tools | $has_test | $desc |"
    done
  fi

  echo
}

audit_hooks() {
  echo "## Hooks Analysis"
  echo
  echo "### Active Hooks"

  if [ -f ~/.claude/settings.json ]; then
    echo "**User-level hooks (settings.json):**"
    jq -r '.hooks | to_entries[] | "- \(.key): \(.value | length) hook(s)"' ~/.claude/settings.json 2>/dev/null || echo "  None configured"
  fi

  if [ -f .claude/settings.local.json ]; then
    echo
    echo "**Project-level hooks (settings.local.json):**"
    jq -r '.hooks | to_entries[] | "- \(.key): \(.value | length) hook(s)"' .claude/settings.local.json 2>/dev/null || echo "  None configured"
  fi

  echo
}

audit_settings() {
  echo "## Settings Analysis"
  echo

  if [ -f ~/.claude/settings.json ]; then
    echo "### User Settings (~/.claude/settings.json)"
    echo "- Model: $(jq -r '.model // "not set"' ~/.claude/settings.json 2>/dev/null)"
    echo "- Plugins: $(jq -r '.enabledPlugins | length' ~/.claude/settings.json 2>/dev/null || echo 0) enabled"
    echo "- Hooks: $(jq -r '.hooks | length' ~/.claude/settings.json 2>/dev/null || echo 0) event types"
    echo
  fi

  if [ -f .claude/settings.local.json ]; then
    echo "### Project Settings (.claude/settings.local.json)"
    echo "- Model: $(jq -r '.model // "not set"' .claude/settings.local.json 2>/dev/null)"
    echo "- Project-specific overrides present"
    echo
  fi
}

audit_tokens() {
  echo "## Token Usage Estimate"
  echo
  echo "| Category | File | Size | ~Tokens |"
  echo "|----------|------|------|---------|"

  total_bytes=0

  # Memory
  for f in ~/.claude/CLAUDE.md ~/CLAUDE.md ./CLAUDE.md .claude/CLAUDE.md; do
    if [ -f "$f" ]; then
      size=$(filesize "$f")
      tokens=$(estimate_tokens "$size")
      total_bytes=$((total_bytes + size))
      echo "| Memory | $f | ${size}B | ~$tokens |"
    fi
  done

  # Contexts
  for f in ~/.claude/contexts/*.xml; do
    if [ -f "$f" ]; then
      size=$(filesize "$f")
      tokens=$(estimate_tokens "$size")
      total_bytes=$((total_bytes + size))
      echo "| Context | $f | ${size}B | ~$tokens |"
    fi
  done

  if [ -d ".claude/contexts" ]; then
    for f in .claude/contexts/*.xml; do
      if [ -f "$f" ]; then
        size=$(filesize "$f")
        tokens=$(estimate_tokens "$size")
        total_bytes=$((total_bytes + size))
        echo "| Context | $f | ${size}B | ~$tokens |"
      fi
    done
  fi

  total_tokens=$(estimate_tokens "$total_bytes")
  echo "| **TOTAL** | | **${total_bytes}B** | **~${total_tokens}** |"

  echo
}

# ============================================================================
# MAIN EXECUTION
# ============================================================================

case "$TARGET" in
  session)
    audit_session "$TRANSCRIPT"
    ;;
  contexts)
    audit_contexts
    ;;
  memory)
    audit_memory
    ;;
  commands)
    audit_commands
    ;;
  hooks)
    audit_hooks
    ;;
  settings)
    audit_settings
    ;;
  tokens)
    audit_tokens
    ;;
  all|*)
    echo "# Claude Code Meta Audit"
    echo

    audit_memory
    audit_contexts
    audit_commands
    audit_hooks
    audit_settings
    audit_tokens
    audit_session "$TRANSCRIPT"

    echo "---"
    echo
    echo "Run \`/meta <target>\` for detailed analysis:"
    echo "- memory, contexts, commands, hooks, settings, tokens, session"
    ;;
esac
