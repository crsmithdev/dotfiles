# Change: [AINT] AI-Native Intent-Based Scaffolding

## Why

Currently using copier for project templating, but it was never fully implemented. Traditional templating (cookiecutter, copier) uses jinja2 templates and variables, which adds overhead when most files are identical across projects. AI-native development requires a better approach that enables:
- **No templating overhead**: Clone working reference projects directly
- **Semantic generation**: Let AI understand intent and adapt to context
- **Flexible propagation**: Support multiple update strategies based on project coupling
- **Natural evolution**: Standards improve when exemplar projects improve

## What Changes

### New Capabilities
- **Python Project Scaffolding**: One-command project setup with all standards pre-configured
- **Static Scaffolding Files**: Copy-ready files for immediate project setup (pyproject.toml, justfile, .gitignore, .pre-commit-config.yaml, CLAUDE.md, etc.)
- **Template Generation**: Simple string substitution for project name and description in configuration
- **Minimal Example Code**: Single tested module demonstrating type hints, docstrings, and patterns
- **Standards Validation**: Semantic and programmatic checks ensuring structural invariants
- **Update Propagation**: Multiple strategies from loose to tight coupling

### Modified Capabilities
- **CLAUDE.md**: Now includes development instructions
- **Project Structure**: Examples directory with reference implementations

### New Files/Directories
- `examples/python/` - Reference project (static files + minimal example)
- `bin/scaffold-python.sh` - Shell script for project scaffolding
- `bin/check-python-standards` - Programmatic validator
- `.claude/commands/scaffold-python.md` - Documentation of scaffold process
- `.claude/commands/check-standards.md` - Validate structure
- `.claude/commands/sync-standards.md` - Update projects
- `openspec/project.md` - Project conventions and patterns
- `docs/PROPAGATION.md` - Update strategies documentation
- `docs/STATIC_VS_DYNAMIC.md` - Scaffolding architecture explanation

## Impact

- **Affected specs**: python-scaffolding (new), project-standards (new)
- **Affected code**: No breaking changes to existing code
- **Affected workflow**: Creates new scaffolding workflow using slash commands
- **Team impact**: Standardizes Python project setup across organization
- **Maintenance**: Reduces template maintenance, uses real projects as exemplars

## Benefits

**Technical:**
- Semantic understanding: AI adapts patterns to context, not just variable substitution
- Natural evolution: Improve exemplar → standard automatically updates
- Zero template maintenance: Use real working projects as documentation
- Structural validation: Ensure invariants without preventing variation

**Developer Experience:**
- One command: `bin/scaffold-python.sh myproject "Description"` creates working project
- Verify immediately: `just test` verifies all tooling works
- Clear example: Includes minimal tested code to copy patterns from
- Flexible coupling: Choose update strategy per project
- No AI needed: Pure shell script, reproducible and fast

**Quality:**
- Consistent standards across projects
- Validation catches missing patterns
- Examples are production code, not documentation
- AI-assisted code generation with intent understanding

## Research & Sources

**Industry Convergence (2024-2025):**
- Pattern: Exemplars + prompt templates + AI understanding
- Examples: [ai-coding-project-boilerplate](https://github.com/shinpr/ai-coding-project-boilerplate), GoCodeo BUILD, RapidNative
- Foundation: [MIT Sloan prompt templates](https://mitsloan.mit.edu/ideas-made-to-matter/prompt-engineering-so-2024-try-these-prompt-templates-instead)

**Modern Python Standards:**
- UV for package management, Ruff for linting/formatting
- Strict type checking with mypy, pytest with coverage
- pyproject.toml centralization, pre-commit automation


See `~/.claude/plans/ai-native-templating-complete.md` for complete research, comparisons, and detailed design.
