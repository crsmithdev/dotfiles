# Claude Workflow Guidelines

## OpenSpec for Structured Changes

OpenSpec provides structured change management for projects. Always refer to the project's `openspec/AGENTS.md` when:
- Mentioning planning or proposals (words like proposal, spec, change, plan)
- Introducing new capabilities, breaking changes, architecture shifts, or big performance/security work
- The request sounds ambiguous and authoritative specs are needed before coding

Use OpenSpec workflows to:
- Create and apply change proposals
- Follow spec format and conventions
- Manage project structure and guidelines

## Development Workflow

### Before Committing Code
- [ ] Run project checks (tests, types, linting, formatting)
- [ ] Updated relevant documentation if architecture/CLI changed
- [ ] No commented-out code remains

### Before Creating Change Proposals
- [ ] Read existing proposals/specs
- [ ] Read project conventions documentation
- [ ] Validate with strict mode if available

### Git Workflow
- Use provided slash commands (`/ship`, `/propose`, `/apply`, `/archive`)
- Commit one logical change per commit
- Follow project commit message conventions

## Quality Standards

### Code Quality
- No backward compatibility shims - replace old interfaces directly
- No commented-out code
- No premature abstractions
- Type-safe code with full type hints
- Comprehensive error handling with specific exception types

### Documentation
- Update docs when architecture/CLI changes
- Use project-specific documentation style guides
- Keep documentation in sync with code

## Task Management

Use OpenSpec for:
- New features
- Breaking changes
- Architecture changes
- Performance/security work

Use standard workflow for:
- Bug fixes
- Minor enhancements
- Documentation updates
