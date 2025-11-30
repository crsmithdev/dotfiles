#!/bin/bash
# Persistent Claude Code session manager
# Maintains context across multiple commands without roundtrip overhead
# Usage: session start [project] | session cmd <command> | session stop

SESSION_DIR="${XDG_RUNTIME_DIR:-/tmp}/claude-sessions"
SESSION_FILE="${SESSION_DIR}/active.session"

mkdir -p "$SESSION_DIR"

case "${1:-help}" in
    start)
        # Start a persistent session
        local project="${2:-.}"
        local session_id="$(date +%s)-$$"

        mkdir -p "$SESSION_DIR/$session_id"

        cat > "$SESSION_FILE" <<EOF
SESSION_ID=$session_id
PROJECT=$project
START_TIME=$(date +%s)
LAST_ACTIVITY=$(date +%s)
EOF

        # Initialize session context
        cat > "$SESSION_DIR/$session_id/context.sh" <<EOF
#!/bin/bash
# Session context: $project
cd "$project" 2>/dev/null || true

# Load git cache
source ~/.claude/scripts/git-cache.sh

# Initialize common variables
export PROJECT_ROOT="\$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
export SESSION_ID=$session_id

# Quick utilities
alias st='git status'
alias log='git log --oneline -5'
alias br='git branch -vv'
alias test='just test'
alias check='just check'
alias cached_status='git_cache_status'
alias cached_log='git_cache_log'
alias cached_branch='git_cache_branch'

echo "Session started: $session_id in $project"
EOF

        chmod +x "$SESSION_DIR/$session_id/context.sh"
        echo "Session $session_id started"
        echo "Source context: source ~/.claude/scripts/session.sh load"
        ;;

    load)
        # Load active session in current shell
        if [[ -f "$SESSION_FILE" ]]; then
            source "$SESSION_FILE"
            source "$SESSION_DIR/$SESSION_ID/context.sh"
        else
            echo "No active session" >&2
            exit 1
        fi
        ;;

    cmd)
        # Run command in active session context
        if [[ ! -f "$SESSION_FILE" ]]; then
            echo "No active session" >&2
            exit 1
        fi

        source "$SESSION_FILE"
        shift  # Remove 'cmd'

        # Execute command in session context
        (
            source "$SESSION_DIR/$SESSION_ID/context.sh" > /dev/null 2>&1
            eval "$@"
        )
        ;;

    run)
        # Run a script in session context
        local script="$2"

        if [[ ! -f "$SESSION_FILE" ]]; then
            echo "No active session" >&2
            exit 1
        fi

        if [[ ! -f "$script" ]]; then
            echo "Script not found: $script" >&2
            exit 1
        fi

        source "$SESSION_FILE"
        (
            source "$SESSION_DIR/$SESSION_ID/context.sh" > /dev/null 2>&1
            source "$script"
        )
        ;;

    stop)
        # Stop active session
        if [[ -f "$SESSION_FILE" ]]; then
            source "$SESSION_FILE"
            rm -rf "$SESSION_DIR/$SESSION_ID"
            rm -f "$SESSION_FILE"
            echo "Session stopped"
        else
            echo "No active session" >&2
        fi
        ;;

    status)
        # Show active session info
        if [[ -f "$SESSION_FILE" ]]; then
            source "$SESSION_FILE"
            echo "Active session: $SESSION_ID"
            echo "Project: $PROJECT"
            echo "Started: $(date -d @$START_TIME)"
            echo "Context script: $SESSION_DIR/$SESSION_ID/context.sh"
        else
            echo "No active session"
        fi
        ;;

    help|*)
        cat <<EOF
Persistent Claude Code Session Manager

Usage:
  session start [project]    Start new session (defaults to current dir)
  session load               Load active session in current shell
  session cmd <command>      Run command in session context
  session run <script>       Run script in session context
  session stop               Stop active session
  session status             Show active session info
  session help               Show this help

Examples:
  session start ~/myproject
  session cmd 'git status'
  session cmd 'sitrep-fast --json'
  session run ~/.claude/scripts/sitrep-fast.sh

Notes:
  - Session context includes cached git operations
  - Commands execute with no roundtrip overhead
  - Session persists across multiple invocations
  - Use 'source session.sh load' to load context in current shell
EOF
        ;;
esac
