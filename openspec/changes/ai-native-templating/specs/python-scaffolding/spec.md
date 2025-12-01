# Specification: Python Project Scaffolding

## ADDED Requirements

### Requirement: Reference Implementation
The system SHALL provide a reference Python project in `~/dotfiles/examples/python/` that demonstrates all standards and can be cloned or adapted for new projects.

#### Scenario: Reference project structure
- **WHEN** developer examines `examples/python/`
- **THEN** project contains src/, tests/, docs/, openspec/ directories with working code and configuration

#### Scenario: Reference project runs
- **WHEN** developer runs `cd examples/python && uv sync && uv run pytest && just check`
- **THEN** all commands complete successfully with no errors

#### Scenario: Reference project is production-quality
- **WHEN** developer examines `examples/python/`
- **THEN** code includes type hints, docstrings, tests, and is suitable as documentation by example

---

### Requirement: Project Scaffolding Slash Command
The system SHALL provide `/scaffold-python` slash command in Claude Code to generate new Python projects based on user intent and the reference exemplar.

#### Scenario: Generate new project
- **WHEN** user runs `/scaffold-python` with project name, type, and description
- **THEN** new project is created with complete structure (src/, tests/, configs, etc.)

#### Scenario: Adapt to context
- **WHEN** user specifies project needs (e.g., "async data pipeline with click CLI")
- **THEN** generated project includes appropriate patterns (asyncio, click, structlog, etc.)

#### Scenario: Command references exemplar
- **WHEN** developer examines `/scaffold-python` command definition
- **THEN** command explicitly references `~/dotfiles/examples/python/` as exemplar

---

### Requirement: Standards Validation Slash Command
The system SHALL provide `/check-standards` slash command to validate that a project follows structural invariants and conventions.

#### Scenario: Validate project structure
- **WHEN** user runs `/check-standards` in a project directory
- **THEN** validation checks for required files (src/, tests/conftest.py, pyproject.toml, .pre-commit-config.yaml)

#### Scenario: Validate tool configuration
- **WHEN** user runs `/check-standards`
- **THEN** validation checks tool configurations (ruff line-length, mypy settings, pytest configuration)

#### Scenario: Provide actionable feedback
- **WHEN** validation fails
- **THEN** user sees specific feedback (missing files, incorrect config) with suggestions to fix

#### Scenario: Semantic validation
- **WHEN** user runs `/check-standards`
- **THEN** AI explains differences from standards, whether they're safe variations or concerning divergences

---

### Requirement: Update Standards Slash Command
The system SHALL provide `/sync-standards` slash command to help update existing projects to current standards.

#### Scenario: Compare with exemplar
- **WHEN** user runs `/sync-standards`
- **THEN** AI examines current project and exemplar, identifies differences

#### Scenario: Recommend safe updates
- **WHEN** `/sync-standards` completes analysis
- **THEN** user sees list of recommended updates with explanation of impact

#### Scenario: Human approval for changes
- **WHEN** user sees recommendations
- **THEN** user can approve, modify, or reject each suggestion before applying

---

### Requirement: Tool Configuration Invariants
The system SHALL enforce structural invariants that all Python projects MUST have:
- src/ layout (not flat layout)
- tests/conftest.py exists
- pyproject.toml with [project], [build-system], [tool.ruff], [tool.mypy], [tool.pytest.ini_options]
- [dependency-groups] dev with pytest, ruff, mypy, pre-commit
- .pre-commit-config.yaml with ruff, mypy, and general hooks
- README.md with setup instructions
- .gitignore includes Python patterns

#### Scenario: Structure enforcement
- **WHEN** developer generates project with `/scaffold-python`
- **THEN** all invariants are present in generated code

#### Scenario: Structure validation
- **WHEN** user runs `/check-standards`
- **THEN** validation confirms all invariants are present

---

### Requirement: Programmatic Validation Script
The system SHALL provide `~/dotfiles/bin/check-python-standards` executable script for automated validation in CI/scripts.

#### Scenario: Check structure programmatically
- **WHEN** script is run in project directory
- **THEN** script checks file structure, pyproject.toml, .pre-commit-config.yaml

#### Scenario: Output checklist format
- **WHEN** script completes
- **THEN** output shows checkmarks/errors for each check with clear format

#### Scenario: Return exit code
- **WHEN** script completes
- **THEN** exit code is 0 if all checks pass, 1 if any fail

#### Scenario: Useful for CI/automation
- **WHEN** script is used in CI pipelines or automation
- **THEN** it provides clear pass/fail signal and specific failure reasons

---

### Requirement: AI-Agnostic Configuration
The system SHALL support multiple AI tools (Claude Code, Cursor, Aider) with shared rules and tool-specific customizations.

#### Scenario: Shared instructions
- **WHEN** developer examines project configuration
- **THEN** `AI_INSTRUCTIONS.md` exists with tool-agnostic rules

#### Scenario: Tool-specific configuration
- **WHEN** developer uses different AI tool
- **THEN** tool-specific config (CLAUDE.md, .cursorrules, .aider/) references shared instructions

#### Scenario: Add new AI tool
- **WHEN** new AI tool becomes available
- **THEN** can create tool-specific config that references shared instructions without duplication

---

### Requirement: Update Propagation Documentation
The system SHALL document four strategies for propagating standards updates to existing projects:
1. Manual Sync - Copy files when desired (loose coupling)
2. Git Subtree - Selective pulls with history (medium coupling)
3. AI-Assisted Migration - Semantic updates with human approval (flexible coupling)
4. Monorepo Living at HEAD - Atomic updates across projects (tight coupling)

#### Scenario: Understand propagation options
- **WHEN** developer reads `docs/PROPAGATION.md`
- **THEN** documentation explains each strategy with pros/cons and decision matrix

#### Scenario: Choose strategy per project
- **WHEN** developer has multiple projects
- **THEN** can use different strategies (loose for side projects, tight for team codebases)

#### Scenario: Implement Git Subtree
- **WHEN** developer chooses Git Subtree strategy
- **THEN** documentation includes step-by-step commands and examples

---

### Requirement: Structural Invariants vs Contextual Variation
The system SHALL distinguish between:
- **Invariants** (MUST match): src/ layout, test structure, tool presence
- **Conventions** (SHOULD match): tool versions, domain models, CLI framework
- **Specifics** (project-unique): package names, business logic, domain

#### Scenario: Understand variation categories
- **WHEN** developer reads standards documentation
- **THEN** each requirement is clearly marked as invariant, convention, or specific

#### Scenario: Allow appropriate variation
- **WHEN** developer creates project
- **THEN** invariants are enforced, conventions documented, specifics are free to vary

#### Scenario: Validation respects categories
- **WHEN** user runs `/check-standards`
- **THEN** validation enforces invariants, suggests conventions, ignores specifics
