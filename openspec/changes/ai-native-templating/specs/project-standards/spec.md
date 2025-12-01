# Specification: Project Standards & Conventions

## ADDED Requirements

### Requirement: Project Conventions Documentation
The system SHALL provide comprehensive project conventions in `openspec/project.md` documenting coding standards, naming conventions, architecture patterns, and OpenSpec requirements.

#### Scenario: Reference current standards
- **WHEN** developer reads `openspec/project.md`
- **THEN** finds documentation of Python standards, naming conventions, and patterns

#### Scenario: Onboard new team members
- **WHEN** new developer joins project
- **THEN** can read `openspec/project.md` to understand project conventions

#### Scenario: Consistent standards across projects
- **WHEN** developer works on multiple projects
- **THEN** all projects reference same conventions for consistency

---

### Requirement: AI Development Instructions
The system SHALL provide clear instructions for AI coding assistants across all tools (Claude Code, Cursor, Aider).

#### Scenario: Claude Code instructions
- **WHEN** Claude Code is used in project
- **THEN** CLAUDE.md and AI_INSTRUCTIONS.md guide AI behavior

#### Scenario: Tool-agnostic rules
- **WHEN** different AI tool is used
- **THEN** tool's configuration file references shared AI_INSTRUCTIONS.md

#### Scenario: Consistent AI behavior
- **WHEN** same project is worked on with different AI tools
- **THEN** both tools follow same standards due to shared instructions

---

### Requirement: Code Style Standards
The system SHALL enforce consistent code style via:
- Ruff for linting and formatting (line-length = 100)
- Mypy for type checking with strict settings
- Black or Ruff format for consistent formatting
- Pre-commit hooks to enforce before commit

#### Scenario: Consistent formatting
- **WHEN** code is written in project
- **THEN** `just fmt` command formats all code consistently

#### Scenario: Type safety
- **WHEN** code is written
- **THEN** `just types` command checks type annotations

#### Scenario: Linting enforcement
- **WHEN** code is committed
- **THEN** pre-commit hooks run ruff to enforce linting rules

---

### Requirement: Testing Standards
The system SHALL require:
- Pytest for testing framework
- Test files in tests/ directory matching test_*.py pattern
- conftest.py for shared fixtures
- Minimum 80% code coverage
- Coverage reports generated on each test run

#### Scenario: Run tests
- **WHEN** developer runs `just test`
- **THEN** pytest executes all tests with coverage report

#### Scenario: Coverage tracking
- **WHEN** tests complete
- **THEN** coverage report shows percentage and missing lines

#### Scenario: CI integration
- **WHEN** code is pushed
- **THEN** CI runs tests and reports failures

---

### Requirement: Documentation Standards
The system SHALL require:
- README.md at project root with setup instructions
- Architecture documentation in docs/ directory
- Docstrings for public functions (NumPy or Google style)
- Examples and usage patterns

#### Scenario: New developer setup
- **WHEN** new developer clones project
- **THEN** README.md explains how to install and run

#### Scenario: Architecture understanding
- **WHEN** developer needs to understand project structure
- **THEN** finds docs/architecture.md with overview

#### Scenario: Function documentation
- **WHEN** developer reads source code
- **THEN** sees docstrings explaining function purpose and arguments

---

### Requirement: Dependency Management
The system SHALL use:
- UV for package management
- pyproject.toml for configuration
- [dependency-groups] dev for development dependencies
- uv.lock for reproducible builds
- No loose version pins (use uv.lock instead)

#### Scenario: Install dependencies
- **WHEN** developer runs `uv sync`
- **THEN** all dependencies installed with exact versions from uv.lock

#### Scenario: Add dependency
- **WHEN** developer needs new dependency
- **THEN** adds to pyproject.toml, runs `uv sync`, uv.lock updates

#### Scenario: Reproducible across machines
- **WHEN** project is cloned on different machine
- **THEN** `uv sync` produces identical environment

---

### Requirement: Project Structure
The system SHALL enforce src/ layout for all Python projects:
- `src/<package_name>/` for source code
- `tests/` for test code
- `docs/` for documentation
- `openspec/` for specifications and changes
- Configuration at project root

#### Scenario: Import packages
- **WHEN** code imports from package
- **THEN** imports work consistently with src/ layout

#### Scenario: Test discovery
- **WHEN** pytest runs
- **THEN** finds all tests in tests/ directory

#### Scenario: Avoid naming conflicts
- **WHEN** multiple projects exist
- **THEN** src/ layout prevents package name conflicts

---

### Requirement: Git Workflow
The system SHALL follow conventions for commits, branches, and messages:
- Branch names: `feature/`, `fix/`, `refactor/`, `docs/` prefixes
- Commit messages: lowercase, imperative mood, max 50 characters
- One logical change per commit
- Reference issues in commits (when applicable)

#### Scenario: Create feature branch
- **WHEN** developer starts new feature
- **THEN** creates branch named `feature/descriptive-name`

#### Scenario: Clear commit history
- **WHEN** reviewing git log
- **THEN** sees clear imperative messages describing changes

#### Scenario: Small focused commits
- **WHEN** making changes
- **THEN** groups related changes in single commits, unrelated changes separate

---

### Requirement: Task Runner (Justfile)
The system SHALL provide justfile with standard tasks:
- `just install` - install dependencies (uv sync)
- `just check` - run all quality checks (fmt, lint, types, test)
- `just fmt` - format code (ruff format)
- `just lint` - lint code (ruff check --fix)
- `just types` - type check (mypy)
- `just test` - run tests (pytest)
- `just clean` - remove build artifacts and caches

#### Scenario: Run all checks
- **WHEN** developer runs `just check` before committing
- **THEN** all quality checks run (formatting, linting, types, tests)

#### Scenario: One command for CI
- **WHEN** CI pipeline runs
- **THEN** uses `just check` to validate all quality gates

#### Scenario: Clean build
- **WHEN** developer runs `just clean`
- **THEN** all caches and build artifacts removed

---

### Requirement: Pre-commit Hooks
The system SHALL configure pre-commit hooks to run:
- Ruff linter and formatter
- Mypy type checker
- Standard hooks (trailing-whitespace, end-of-file-fixer, check-yaml, detect-private-key)

#### Scenario: Install hooks
- **WHEN** developer clones project
- **THEN** runs `pre-commit install` to enable hooks

#### Scenario: Validate before commit
- **WHEN** developer attempts commit
- **THEN** pre-commit hooks run and must pass before commit completes

#### Scenario: Auto-fix where possible
- **WHEN** pre-commit hooks run
- **THEN** ruff and formatting issues are auto-fixed, others must be manually addressed

---

### Requirement: OpenSpec Integration
The system SHALL use OpenSpec for spec-driven development:
- `openspec/` directory with project.md, specs/, and changes/
- `openspec/project.md` documents project conventions
- Proposals in `openspec/changes/[change-id]/`
- Completed changes archived in `openspec/changes/archive/`

#### Scenario: Create proposal
- **WHEN** new feature is planned
- **THEN** creates proposal.md, tasks.md, and spec deltas in openspec/changes/

#### Scenario: Review specifications
- **WHEN** developer needs to understand current spec
- **THEN** examines openspec/specs/ for requirements

#### Scenario: Validate changes
- **WHEN** proposal is created
- **THEN** runs `openspec validate [change-id] --strict` to ensure correct format

---

### Requirement: Environment Configuration
The system SHALL manage environment via:
- `.python-version` file pinning Python version (3.12+)
- `.env` file for local environment variables (not committed)
- Environment variable documentation in README.md
- No hardcoded secrets or configuration

#### Scenario: Consistent Python version
- **WHEN** project is cloned
- **THEN** pyenv reads `.python-version` and activates correct Python

#### Scenario: Local configuration
- **WHEN** developer needs API keys or custom config
- **THEN** sets in `.env` file (excluded from git)

#### Scenario: Production deployment
- **WHEN** project is deployed
- **THEN** production environment variables set appropriately (not from .env)

---

### Requirement: Extensibility for Other Languages
The system SHALL support extension to other languages (TypeScript, Rust, Go, etc.) by:
- Maintaining same three-tier architecture (exemplar, generation, validation)
- Creating language-specific exemplars in `examples/`
- Documenting language-specific standards in openspec/

#### Scenario: Add TypeScript support
- **WHEN** TypeScript projects are needed
- **THEN** can create `examples/typescript-base/` and `/scaffold-typescript`

#### Scenario: Consistent patterns
- **WHEN** switching between languages
- **THEN** same scaffolding, validation, propagation patterns apply

#### Scenario: Team standardization
- **WHEN** team works with multiple languages
- **THEN** each language has exemplar following same conventions
