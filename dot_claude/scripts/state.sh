#!/bin/bash
# Fast sitrep: optimized for token cost and speed
# Uses git cache, parallel operations, structured output
# Usage: sitrep-fast [--json] [--no-ci] [--no-openspec] [--refresh]

set -e

source ~/.claude/scripts/git-cache.sh
source ~/.claude/scripts/ci-cache.sh

OUTPUT_FORMAT="text"  # text or json
INCLUDE_CI=true
INCLUDE_OPENSPEC=true
REFRESH_CACHE=false

# Parse flags
while [[ $# -gt 0 ]]; do
    case $1 in
        --json) OUTPUT_FORMAT="json" ;;
        --no-ci) INCLUDE_CI=false ;;
        --no-openspec) INCLUDE_OPENSPEC=false ;;
        --refresh) REFRESH_CACHE=true ;;
        --fast) ;; # Default behavior
        *) echo "Unknown flag: $1" >&2; exit 1 ;;
    esac
    shift
done

# Invalidate caches if refresh requested
if $REFRESH_CACHE; then
    git_cache_invalidate
    ci_cache_invalidate
fi

# Collect data in parallel
declare -A data

# Git operations (cached)
data[status]=$(git_cache_status)
data[log]=$(git_cache_log)
data[branch]=$(git_cache_branch)
data[current_branch]=$(git_cache_current_branch)

# CI operations (cached)
if $INCLUDE_CI; then
    data[ci_runs]=$(ci_cache_runs)
    data[ci_age]=$(ci_cache_runs_age)
fi

# OpenSpec operations (cached)
if $INCLUDE_OPENSPEC; then
    data[openspec_list]=$(openspec_cache_list)
    data[openspec_age]=$(openspec_cache_list_age)
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
                ci_line=$(echo "${data[ci_runs]}" | head -1)
                ci_status=$(echo "$ci_line" | awk '{print $2}')
                ci_workflow=$(echo "$ci_line" | awk '{print $4}')
                ci_time=$(echo "$ci_line" | awk '{print $NF}')
                echo "  \"ci\": {"
                echo "    \"status\": \"$ci_status\","
                echo "    \"workflow\": \"$ci_workflow\","
                echo "    \"last_run\": \"$ci_time\","
                echo "    \"cache_age\": \"${data[ci_age]}\""
                echo "  },"
            fi

            if $INCLUDE_OPENSPEC; then
                echo "  \"openspec\": {"
                echo "    \"cache_age\": \"${data[openspec_age]}\","
                echo "    \"proposals\": ["
                first=true
                echo "${data[openspec_list]}" | grep -E "^  [A-Z]" | while read -r line; do
                    name=$(echo "$line" | awk '{print $1}')
                    tasks=$(echo "$line" | grep -oE "[0-9]+/[0-9]+ tasks|✓ Complete|No tasks" || echo "unknown")
                    if [[ "$first" == "true" ]]; then
                        first=false
                    else
                        echo ","
                    fi
                    printf '      {"name": "%s", "tasks": "%s"}' "$name" "$tasks"
                done
                echo ""
                echo "    ]"
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
            echo "CI: $(echo "${data[ci_runs]}" | head -2 | tail -1 || echo 'unknown') (cached ${data[ci_age]})"
        fi

        if $INCLUDE_OPENSPEC; then
            complete=$(echo "${data[openspec_list]}" | grep "✓" 2>/dev/null | wc -l)
            echo "OpenSpec: $complete complete (cached ${data[openspec_age]})"
        fi
        ;;
esac
