# Project Context: Dotfiles

## Purpose

Shared configuration and tooling for AI-native development across personal projects. Provides:
- Standards and best practices documentation
- Example projects demonstrating standards
- Reusable slash commands for Claude Code
- AI-agnostic configuration patterns
- Support for multiple AI tools (Claude Code, Cursor, Aider, etc.)

**Current Status:** Core infrastructure with evolving standards.

## Tech Stack

### Core Tools
- **UV** - Python package management
- **Ruff** - Linting and formatting
- **Mypy** - Type checking
- **Pytest** - Testing framework
- **Pre-commit** - Developer-side CI hooks
- **Just** - Task runner

### AI Tools
- **Claude Code** - Primary development assistant
- **Cursor** - Secondary IDE with Claude integration
- **Aider** - Terminal-based pair programming
- Future tools: Windsurf, others

### Development
- **Python 3.12+** - Primary language
- **Git** - Version control
- **OpenSpec** - Spec-driven development
- **Markdown** - Documentation and configuration

## Project Conventions

### Code Standards

**Python Projects:**
- src/ layout (not flat): `src/<package_name>/`
- Type hints throughout with strict mypy checking
- Ruff for linting/formatting: line-length = 100
- Pre-commit hooks: ruff, mypy, general checks
- Pytest with coverage: minimum 80%
- Docstrings: NumPy or Google style

**Configuration:**
- pyproject.toml for all tool configuration
- [dependency-groups] dev for development dependencies
- Environment variables for sensitive data
- Git-tracked configuration for team/AI consistency

**AI Development:**
- CLAUDE.md for Claude Code instructions
- AI_INSTRUCTIONS.md for tool-agnostic rules
- .cursorrules for Cursor-specific patterns
- .aider/ for Aider configuration
- Slash commands stored in `.claude/commands/`

### Naming Conventions

**Files and Directories:**
- kebab-case for directories and files
- _private.py for internal modules
- test_*.py for test files
- conftest.py for shared test fixtures

**Git Commits:**
- Lowercase, imperative mood: "add feature" not "added feature"
- 50 characters max for subject
- Reference issues/proposals: "add feature (fixes #123)"

**Projects and Commands:**
- verb-led short codes: [AINT], [CODE], [SYNK]
- Kebab-case change IDs: add-, update-, remove-, refactor-
- Snake_case for Python module names

### OpenSpec Standards

**Change Proposals:**
- Write proposal.md explaining why, what, impact
- Create spec deltas with ADDED/MODIFIED/REMOVED requirements
- Include tasks.md with implementation checklist
- Create design.md if: multi-service, external deps, security, migration complexity
- Validate: `openspec validate [change-id] --strict`

**Spec Requirements:**
- Use SHALL/MUST for normative (avoid should/may)
- Every requirement must have at least one #### Scenario:
- Scenarios use WHEN/THEN format with bullet points
- Delta operations: ADDED, MODIFIED, REMOVED, RENAMED
- MODIFIED must include full requirement (not partial updates)

## Architecture Patterns

### Python Project Structure

Standard structure for all Python projects:

```
<project>/
├── src/
│   └── <package>/
│       ├── __init__.py
│       ├── core.py
│       └── cli.py (if CLI)
├── tests/
│   ├── conftest.py
│   ├── test_core.py
│   └── test_cli.py
├── openspec/
│   ├── project.md
│   ├── spec.md (if using OpenSpec)
│   └── changes/
├── .python-version
├── .gitignore
├── .pre-commit-config.yaml
├── pyproject.toml
├── justfile
├── CLAUDE.md
├── AI_INSTRUCTIONS.md
└── README.md
```

### Configuration Patterns

**Shared vs Project-Specific:**
- Shared: Tool configs (ruff, mypy), pre-commit hooks, justfile templates
- Project-specific: Dependencies, package name, CLI structure, domain logic

**AI Configuration Hierarchy:**
1. Global: `~/.claude/CLAUDE.md` - Global rules for all projects
2. Project shared: `AI_INSTRUCTIONS.md` - Tool-agnostic rules
3. Tool-specific: `CLAUDE.md`, `.cursorrules`, `.aider/` - Tool customizations

### Update Propagation

**Strategy Selection:**
- **Manual Sync**: Personal projects, diverged significantly
- **Git Subtree**: Integrated history, selective updates
- **AI-Assisted**: Semantic migration with human approval
- **Monorepo**: Tight coupling, team coordination

See `examples/python-base/` for reference implementation.

## Important Constraints

**Performance:**
- Commands should complete in <30 seconds
- No heavy processing in CI checks
- Slash commands should be self-documenting

**Compatibility:**
- Support Python 3.12+ (test on 3.12, 3.13)
- Tool-agnostic patterns (not Claude-specific)
- Git-based workflows (no platform-specific tools)

**AI Development:**
- Instructions must be clear and actionable
- Examples are living documentation
- Intent over implementation

## External Dependencies

**Key References:**
- Modern Python 2025 standards
- AI coding tools ecosystem
- Git-based development practices
- OpenSpec specification system

**Future Integrations:**
- Multiple Python versions (3.13, 3.14)
- Additional languages (TypeScript, Rust, Go)
- Team collaboration patterns
- Advanced AI workflows

## Glossary

- **Exemplar**: Working reference project demonstrating standards (e.g., python-base)
- **Change**: Proposed modification to specifications under openspec/changes/
- **Spec**: Current requirements and behavior documented in openspec/specs/
- **Slash command**: AI assistant command stored in .claude/commands/*.md
- **SHORTNAME**: Single-word code prefixing proposal references (e.g., [AINT])
