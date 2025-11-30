# Interaction Style

- No preambles, affirmations, or filler ("Great question!", "Sure!", "I'd be happy to")
- No summarizing what you're about to do—just do it
- No sign-offs or offers to help further
- Answer directly, then stop
- When asked to show/generate something, output it immediately without explanation unless asked
- Use natural language instructions as the preferred option for slash commands and shortcuts

# Task Execution

- Default to parallelizing work via subagents when tasks are independent
- Spawn subagents for: research, file exploration, testing, implementation of separate components
- Use Task tool for any operation that can run concurrently with other work
- Before starting multi-part work, identify parallelizable branches and spawn subagents for each
- Subagent selection:
  - **Haiku**: Exploration, grep/file searches, running tests, simple refactoring, documentation updates
  - **Sonnet**: Feature implementation, bug fixes requiring logic changes, code reviews, architecture decisions (default choice)
  - **Opus**: Complex architectural changes affecting multiple systems, difficult debugging after Sonnet fails (ONLY when explicitly requested or Sonnet insufficient)
- Don't wait for one subagent to finish before spawning others if tasks are independent

# Agent Workflow Patterns

## Code Review → Implementation
1. Spawn code-reviewer agent for analysis
2. Capture review findings
3. Spawn implementation agent with review context
4. Track both in TodoWrite

## Analysis → Proposal → Implementation
1. Spawn explore agent for analysis
2. Return findings and ask for approval
3. Create proposal if approved
4. Implementation only after proposal approval

## Parallel Work
- Spawn parallel agents for each independent module
- Example: Agent 1 for new API, Agent 2 for evaluation framework

# Git

## Commits
- Subject line only, no body
- 50 characters max
- Lowercase, no period
- Imperative mood: "add feature" not "added feature"

## Branch Naming
- `feature/<short-name>` - New features
- `fix/<short-name>` - Bug fixes
- `refactor/<short-name>` - Code refactoring
- `docs/<short-name>` - Documentation only

## Commit Granularity
- One commit per logical change
- Tests can be separate commit or included with implementation
- Documentation updates separate from code changes
- Prefer multiple focused commits over single large commits

## When to Push
- After each completed task
- After fixing CI failures
- Before requesting review
- DO NOT push broken tests or failing lints

# Tools

- `code <path>` opens files/folders in VS Code