#!/bin/bash
# Fast sitrep: optimized for token cost and speed
# Uses git cache, parallel operations, structured output
# Usage: sitrep-fast [--json] [--no-ci] [--no-openspec]

set -e

source ~/.claude/scripts/git-cache.sh

OUTPUT_FORMAT="text"  # text or json
INCLUDE_CI=true
INCLUDE_OPENSPEC=true

# Parse flags
while [[ $# -gt 0 ]]; do
    case $1 in
        --json) OUTPUT_FORMAT="json" ;;
        --no-ci) INCLUDE_CI=false ;;
        --no-openspec) INCLUDE_OPENSPEC=false ;;
        --fast) ;; # Default behavior
        *) echo "Unknown flag: $1" >&2; exit 1 ;;
    esac
    shift
done

# Collect data in parallel
declare -A data

# Git operations (cached)
data[status]=$(git_cache_status)
data[log]=$(git_cache_log)
data[branch]=$(git_cache_branch)
data[current_branch]=$(git_cache_current_branch)

# CI operations (only if requested, in background)
if $INCLUDE_CI; then
    gh run list --limit 3 > /tmp/ci_runs 2>/dev/null &
    ci_pid=$!
fi

# OpenSpec operations (only if requested, in background)
if $INCLUDE_OPENSPEC; then
    openspec list > /tmp/openspec_list 2>/dev/null &
    openspec_pid=$!
fi

# Output in chosen format
case $OUTPUT_FORMAT in
    json)
        # Structured output for programmatic consumption
        {
            echo "{"
            echo "  \"git\": {"
            echo "    \"branch\": \"$(echo "${data[current_branch]}" | tr -d '\n')\","
            echo "    \"status\": \"$(echo "${data[status]}" | wc -l) changes\","
            echo "    \"recent_commits\": \"$(echo "${data[log]}" | head -1 | tr -d '"')\""
            echo "  },"

            if $INCLUDE_CI; then
                wait $ci_pid 2>/dev/null || true
                echo "  \"ci\": {"
                echo "    \"last_run\": \"$(head -2 /tmp/ci_runs 2>/dev/null | tail -1 | awk '{print $NF}' || echo 'unknown')\""
                echo "  },"
            fi

            if $INCLUDE_OPENSPEC; then
                wait $openspec_pid 2>/dev/null || true
                proposal_count=$(grep -c "^[A-Z]" /tmp/openspec_list 2>/dev/null || echo 0)
                echo "  \"openspec\": {"
                echo "    \"proposals\": $proposal_count"
                echo "  }"
            fi

            echo "}"
        }
        ;;
    *)
        # Human-readable compact format
        echo "Branch: ${data[current_branch]}"
        echo "Status: $(echo "${data[status]}" | wc -l) changes"
        echo "Latest: $(echo "${data[log]}" | head -1)"

        if $INCLUDE_CI; then
            wait $ci_pid 2>/dev/null || true
            echo "CI: $(head -2 /tmp/ci_runs 2>/dev/null | tail -1 || echo 'unknown')"
        fi

        if $INCLUDE_OPENSPEC; then
            wait $openspec_pid 2>/dev/null || true
            complete=$(grep "✓" /tmp/openspec_list 2>/dev/null | wc -l)
            echo "OpenSpec: $complete complete"
        fi
        ;;
esac

# Cleanup
rm -f /tmp/ci_runs /tmp/openspec_list
