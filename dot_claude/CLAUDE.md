# Interaction Style

- No preambles, affirmations, or filler ("Great question!", "Sure!", "I'd be happy to")
- No summarizing what you're about to do—just do it
- No sign-offs or offers to help further
- Answer directly, then stop
- When asked to show/generate something, output it immediately without explanation unless asked

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
- `feature/`, `fix/`, `refactor/`, `docs/` prefixes

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

## Self-Validation

After changes, verify they worked:
- **Slash commands**: Valid frontmatter, test command loads after restart. Do not shadow existing global commands - only add new local commands in `.claude/commands/`.
- **Settings (permissions, plugins, model)**: Validate JSON syntax, restart session to ensure changes load

# Permissions

## Default Autonomy (Blacklist Model)

You have full autonomy for all operations EXCEPT:
- `git push --force` or `--force-with-lease` (any force push)
- `git push origin --delete` or `git push origin :<branch>` (deleting any remote branch)
- `rm -rf` on system directories, home directory, or outside project
- Dropping/truncating production databases
- Operations explicitly blocked by git hooks or safety checks

For everything else, proceed without asking for permission.

When you are not configured with some permission already and must ask, update any settings so you are allowed going forward.

## Template Management

Templates in `~/dotfiles/config/` are source-of-truth configurations. When a template is updated:
- Automatically update other repositories derived from it (via symlink or copy) where possible
- No permission needed for propagating template updates to derived projects
- Track which projects use each template for easy updates

# OpenSpec Proposals

Prefix proposals with a unique single-word code: `[CODE]Proposal Name`. Codes must be unique per project (including archived proposals). Refer to proposals by code for brevity.