#!/bin/bash
# Git cache system for read-only operations
# Caches: status, log, branch info with configurable TTL
# Usage: source git-cache.sh; git_cache_status; git_cache_log; etc.

CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/claude-git"
CACHE_TTL=${GIT_CACHE_TTL:-60}  # 60 seconds default

mkdir -p "$CACHE_DIR"

# Generate cache key for current repo
git_cache_key() {
    local repo_root=$(git rev-parse --show-toplevel 2>/dev/null)
    echo "${repo_root//\//_}"
}

# Check if cache is valid (within TTL)
git_cache_valid() {
    local cache_file="$1"
    if [[ ! -f "$cache_file" ]]; then
        return 1
    fi
    local age=$(($(date +%s) - $(stat -f%m "$cache_file" 2>/dev/null || stat -c%Y "$cache_file")))
    [[ $age -lt $CACHE_TTL ]]
}

# Get or compute git status
git_cache_status() {
    local key=$(git_cache_key)
    local cache_file="$CACHE_DIR/status_${key}"

    if git_cache_valid "$cache_file"; then
        cat "$cache_file"
    else
        git status --porcelain | tee "$cache_file"
    fi
}

# Get or compute git log (last 5 commits)
git_cache_log() {
    local key=$(git_cache_key)
    local cache_file="$CACHE_DIR/log_${key}"

    if git_cache_valid "$cache_file"; then
        cat "$cache_file"
    else
        git log --oneline -5 | tee "$cache_file"
    fi
}

# Get or compute git branch info
git_cache_branch() {
    local key=$(git_cache_key)
    local cache_file="$CACHE_DIR/branch_${key}"

    if git_cache_valid "$cache_file"; then
        cat "$cache_file"
    else
        git branch -vv | tee "$cache_file"
    fi
}

# Get or compute current branch
git_cache_current_branch() {
    local key=$(git_cache_key)
    local cache_file="$CACHE_DIR/current_branch_${key}"

    if git_cache_valid "$cache_file"; then
        cat "$cache_file"
    else
        git rev-parse --abbrev-ref HEAD | tee "$cache_file"
    fi
}

# Invalidate all caches for current repo
git_cache_invalidate() {
    local key=$(git_cache_key)
    rm -f "$CACHE_DIR"/*_${key}
}

# Run git operation in background, return immediately with cached value
git_cache_async() {
    local operation="$1"
    local cache_file="$2"

    # Return cached value immediately
    if [[ -f "$cache_file" ]]; then
        cat "$cache_file"
    else
        echo "[cache miss, updating in background]"
    fi

    # Update cache asynchronously
    (
        case "$operation" in
            status) git status --porcelain > "$cache_file" 2>/dev/null ;;
            log) git log --oneline -5 > "$cache_file" 2>/dev/null ;;
            branch) git branch -vv > "$cache_file" 2>/dev/null ;;
        esac
    ) &
}
