---
description: Comprehensive codebase audit with parallel agents (read-only)
---

Run a comprehensive codebase audit using parallel specialized agents. This spawns multiple agents to analyze architecture, code quality, documentation, and user experience simultaneously.

**This is a READ-ONLY audit. Enter plan mode first, then spawn agents.**

## Instructions

First, use EnterPlanMode to ensure no changes are made during the audit.

Then spawn the following agents IN PARALLEL using the Task tool. Each agent should return a structured report with findings - no fixes applied.

### Agent 1: Architecture Review (architect-review)
Analyze the overall architecture:
- Module structure and dependencies
- Separation of concerns
- Design patterns used (and misused)
- Coupling and cohesion analysis
- Scalability considerations
- Identify architectural debt

### Agent 2: Code Quality Review (code-reviewer)
Deep code quality analysis:
- Code smells and anti-patterns
- Error handling consistency
- Type safety and type hint coverage
- Test coverage gaps
- Dead code detection
- Security vulnerabilities (OWASP top 10)
- Performance bottlenecks

### Agent 3: Documentation Audit (docs-architect)
Review all documentation:
- README accuracy vs actual behavior
- Docstring completeness and accuracy
- API documentation gaps
- Code comments that are stale or misleading
- Missing documentation for public interfaces
- CLAUDE.md effectiveness for AI interactions

### Agent 4: CLI/UX Testing (debugger)
Exercise the application from a user perspective:
- Run `edm --help` and all subcommands
- Test with various file types and edge cases
- Verify error messages are helpful
- Check exit codes are correct
- Test parallel processing options
- Identify UX pain points

### Agent 5: Dependency & Maintenance Review (legacy-modernizer)
Analyze project health:
- Dependency versions and security
- pyproject.toml configuration
- Pre-commit hooks coverage
- Development workflow friction points

### Agent 6: CI/CD Health Check (deployment-engineer)
Analyze CI/CD pipeline health using `gh` CLI:
- Run `gh run list --limit 20` to see recent workflow runs
- Run `gh run view <id>` on any failed runs to get details
- Identify recurring failures and their root causes
- Check workflow definitions in `.github/workflows/`
- Analyze build times and optimization opportunities
- Review branch protection and deployment practices
- Check for flaky tests or intermittent failures
- Suggest CI/CD improvements (caching, parallelization, etc.)

## Output Format

After all agents complete, synthesize their findings into:

### 1. CRITICAL ISSUES (fix immediately)
Issues that could cause data loss, security vulnerabilities, or crashes.

### 2. HIGH-IMPACT IMPROVEMENTS (address soon)
Changes that would significantly improve maintainability, performance, or user experience.

### 3. MINOR IMPROVEMENTS (nice to have)
Smaller refactors, style improvements, or optimizations.

### 4. FEATURE-READY ASSESSMENT
Clear yes/no: Is this codebase ready for continued feature development, or are there blockers?

### 5. CLAUDE.md & WORKFLOW OPTIMIZATION
Specific suggestions for improving AI-assisted development:
- CLAUDE.md improvements
- Slash command suggestions
- Memory/context optimizations
- Workflow patterns to adopt
