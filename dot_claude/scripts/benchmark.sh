#!/bin/bash
# Benchmark: Optimized vs unoptimized command execution
# Compares tool call overhead, roundtrip latency, and token generation

set -e

ITERATIONS=${1:-3}
RESULTS_DIR=$(mktemp -d)
trap "rm -rf $RESULTS_DIR" EXIT

echo "=== Benchmarking Command Execution ==="
echo "Iterations: $ITERATIONS"
echo ""

# Test 1: Status checks - unoptimized (3 separate calls)
echo "Test 1: Git status checks (unoptimized - 3 separate calls)"
time_unopt=0
for ((i=1; i<=ITERATIONS; i++)); do
    start=$(date +%s%N)
    {
        git status > /dev/null 2>&1
        git log --oneline -10 > /dev/null 2>&1
        git branch -vv > /dev/null 2>&1
    }
    end=$(date +%s%N)
    duration=$(( (end - start) / 1000000 ))  # Convert to milliseconds
    time_unopt=$(( time_unopt + duration ))
done
avg_unopt=$(( time_unopt / ITERATIONS ))
echo "  Total: ${time_unopt}ms for $ITERATIONS iterations"
echo "  Average: ${avg_unopt}ms per run"
echo ""

# Test 2: Status checks - optimized (batch, parallel)
echo "Test 2: Git status checks (optimized - batch + parallel)"
time_opt=0
for ((i=1; i<=ITERATIONS; i++)); do
    start=$(date +%s%N)
    bash ~/.claude/scripts/batch.sh status log branch --parallel > /dev/null 2>&1
    end=$(date +%s%N)
    duration=$(( (end - start) / 1000000 ))
    time_opt=$(( time_opt + duration ))
done
avg_opt=$(( time_opt / ITERATIONS ))
echo "  Total: ${time_opt}ms for $ITERATIONS iterations"
echo "  Average: ${avg_opt}ms per run"
echo ""

# Calculate improvement
if [[ $avg_unopt -gt 0 ]]; then
    improvement=$(( (avg_unopt - avg_opt) * 100 / avg_unopt ))
    speedup=$(echo "scale=2; $avg_unopt / $avg_opt" | bc)
    echo "Performance Improvement:"
    echo "  Faster by: ${improvement}% (${avg_unopt}ms → ${avg_opt}ms)"
    echo "  Speedup: ${speedup}x faster"
fi
echo ""

# Test 3: Sitrep - unoptimized (verbose with summarization)
echo "Test 3: Project status (unoptimized - verbose sitrep.sh)"
time_verbose=0
for ((i=1; i<=ITERATIONS; i++)); do
    start=$(date +%s%N)
    bash ~/.claude/scripts/sitrep.sh > /dev/null 2>&1
    end=$(date +%s%N)
    duration=$(( (end - start) / 1000000 ))
    time_verbose=$(( time_verbose + duration ))
done
avg_verbose=$(( time_verbose / ITERATIONS ))
echo "  Total: ${time_verbose}ms for $ITERATIONS iterations"
echo "  Average: ${avg_verbose}ms per run"
echo ""

# Test 4: Sitrep - optimized (fast + structured)
echo "Test 4: Project status (optimized - sitrep-fast.sh --json)"
time_fast=0
for ((i=1; i<=ITERATIONS; i++)); do
    start=$(date +%s%N)
    bash ~/.claude/scripts/sitrep-fast.sh --json > /dev/null 2>&1
    end=$(date +%s%N)
    duration=$(( (end - start) / 1000000 ))
    time_fast=$(( time_fast + duration ))
done
avg_fast=$(( time_fast / ITERATIONS ))
echo "  Total: ${time_fast}ms for $ITERATIONS iterations"
echo "  Average: ${avg_fast}ms per run"
echo ""

if [[ $avg_verbose -gt 0 ]]; then
    improvement=$(( (avg_verbose - avg_fast) * 100 / avg_verbose ))
    speedup=$(echo "scale=2; $avg_verbose / $avg_fast" | bc)
    echo "Performance Improvement:"
    echo "  Faster by: ${improvement}% (${avg_verbose}ms → ${avg_fast}ms)"
    echo "  Speedup: ${speedup}x faster"
fi
echo ""

# Test 5: Quick status - ultra-fast
echo "Test 5: Project status (ultra-fast - sitrep-fast.sh --no-ci --no-openspec)"
time_quick=0
for ((i=1; i<=ITERATIONS; i++)); do
    start=$(date +%s%N)
    bash ~/.claude/scripts/sitrep-fast.sh --no-ci --no-openspec > /dev/null 2>&1
    end=$(date +%s%N)
    duration=$(( (end - start) / 1000000 ))
    time_quick=$(( time_quick + duration ))
done
avg_quick=$(( time_quick / ITERATIONS ))
echo "  Total: ${time_quick}ms for $ITERATIONS iterations"
echo "  Average: ${avg_quick}ms per run"
echo ""

if [[ $avg_verbose -gt 0 ]]; then
    improvement=$(( (avg_verbose - avg_quick) * 100 / avg_verbose ))
    speedup=$(echo "scale=2; $avg_verbose / $avg_quick" | bc)
    echo "Performance Improvement vs verbose:"
    echo "  Faster by: ${improvement}% (${avg_verbose}ms → ${avg_quick}ms)"
    echo "  Speedup: ${speedup}x faster"
fi
echo ""

# Summary table
echo "=== Summary ==="
printf "%-45s %8s %12s\n" "Operation" "Time (ms)" "Speedup"
printf "%-45s %8s %12s\n" "---" "---" "---"
printf "%-45s %8d %11.2fx\n" "Git checks (unoptimized, 3 calls)" "$avg_unopt" "1.0"
printf "%-45s %8d %11.2fx\n" "Git checks (optimized, batch)" "$avg_opt" "$(echo "scale=2; $avg_unopt / $avg_opt" | bc)"
printf "%-45s %8d %11.2fx\n" "Sitrep (unoptimized, verbose)" "$avg_verbose" "1.0"
printf "%-45s %8d %11.2fx\n" "Sitrep (optimized, JSON)" "$avg_fast" "$(echo "scale=2; $avg_verbose / $avg_fast" | bc)"
printf "%-45s %8d %11.2fx\n" "Sitrep (ultra-fast, no CI/specs)" "$avg_quick" "$(echo "scale=2; $avg_verbose / $avg_quick" | bc)"
