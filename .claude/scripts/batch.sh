#!/bin/bash
# Batch runner: aggregates multiple commands into single execution
# Reduces tool call roundtrips by running dependent/independent commands together
# Usage: batch cmd1 cmd2 cmd3 ... [--parallel] [--json]

set -e

# Map of command aliases to actual commands
declare -A CMD_MAP=(
    [status]="git status"
    [log]="git log --oneline -10"
    [branch]="git branch -vv"
    [ci]="gh run list --limit 3"
    [openspec]="openspec list"
    [check]="just check"
    [test]="just test"
    [lint]="just lint"
    [fmt]="just fmt"
)

if [[ $# -eq 0 ]]; then
    echo "Usage: batch <cmd1> <cmd2> ... [--parallel] [--json]"
    echo ""
    echo "Available commands:"
    for cmd in "${!CMD_MAP[@]}"; do
        echo "  $cmd"
    done
    exit 1
fi

PARALLEL=false
JSON_OUTPUT=false
COMMANDS=()

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --parallel) PARALLEL=true ;;
        --json) JSON_OUTPUT=true ;;
        *)
            if [[ -n "${CMD_MAP[$1]}" ]]; then
                COMMANDS+=("$1")
            else
                echo "Unknown command: $1" >&2
                exit 1
            fi
            ;;
    esac
    shift
done

# Execute and collect results
if $PARALLEL; then
    # Parallel execution with background jobs
    declare -a PIDS
    declare -A RESULTS
    TMPDIR=$(mktemp -d)
    trap "rm -rf $TMPDIR" EXIT

    for cmd in "${COMMANDS[@]}"; do
        (
            {
                eval "${CMD_MAP[$cmd]}"
            } > "$TMPDIR/$cmd" 2>&1
        ) &
        PIDS+=($!)
    done

    # Wait for all background jobs
    for pid in "${PIDS[@]}"; do
        wait "$pid"
    done

    # Read cached results
    for cmd in "${COMMANDS[@]}"; do
        RESULTS[$cmd]=$(cat "$TMPDIR/$cmd" 2>/dev/null || echo "")
    done
else
    # Sequential execution
    declare -A RESULTS
    for cmd in "${COMMANDS[@]}"; do
        RESULTS[$cmd]=$(eval "${CMD_MAP[$cmd]}" 2>&1)
    done
fi

# Output results
if $JSON_OUTPUT; then
    echo "{"
    first=true
    for cmd in "${COMMANDS[@]}"; do
        if [ "$first" = true ]; then
            first=false
        else
            echo ","
        fi
        echo -n "  \"$cmd\": $(printf '%s\n' "${RESULTS[$cmd]}" | jq -Rs .)"
    done
    echo ""
    echo "}"
else
    for cmd in "${COMMANDS[@]}"; do
        echo "=== $cmd ==="
        echo "${RESULTS[$cmd]}"
        echo ""
    done
fi
