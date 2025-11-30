#!/bin/bash
# Quick project status overview

echo "=== GIT STATUS ==="
git status &
pid1=$!

echo -e "\n=== RECENT COMMITS ==="
git log --oneline -5 &
pid2=$!

echo -e "\n=== BRANCH INFO ==="
git branch -vv &
pid3=$!

echo -e "\n=== CI RUNS ==="
gh run list --limit 3 &
pid4=$!

echo -e "\n=== OPENSPEC PROPOSALS ==="
openspec list &
pid5=$!

wait $pid1 $pid2 $pid3 $pid4 $pid5
