# Tasks: [AINT] AI-Native Intent-Based Scaffolding

## 1. Reference Implementation (python)
- [ ] 1.1 Create `examples/python/` directory structure
- [ ] 1.2 Create `examples/python/pyproject.toml` with complete tooling config (uv, ruff, mypy, pytest)
- [ ] 1.3 Create `examples/python/src/example/` with typed example code
- [ ] 1.4 Create `examples/python/tests/` with conftest.py and example tests
- [ ] 1.5 Create `examples/python/justfile` with standard tasks (check, test, fmt, lint, types, clean)
- [ ] 1.6 Create `examples/python/.pre-commit-config.yaml` with ruff, mypy, general hooks
- [ ] 1.7 Create `examples/python/.python-version` (3.12)
- [ ] 1.8 Create `examples/python/.gitignore` with Python patterns
- [ ] 1.9 Create `examples/python/CLAUDE.md` with Claude Code instructions
- [ ] 1.10 Create `examples/python/AI_INSTRUCTIONS.md` with tool-agnostic rules
- [ ] 1.11 Create `examples/python/README.md` with setup instructions
- [ ] 1.12 Create `examples/python/openspec/` directory structure
- [ ] 1.13 Create `examples/python/docs/` with architecture documentation
- [ ] 1.14 Verify reference project: `uv sync && uv run pytest && just check`
- [ ] 1.15 Document usage patterns in `examples/python/USAGE.md`

## 2. Slash Commands & Generation Instructions
- [ ] 2.1 Create `~/.claude/commands/scaffold-python.md` for creating new projects
- [ ] 2.2 Create `~/.claude/commands/check-standards.md` for validation
- [ ] 2.3 Create `~/.claude/commands/sync-standards.md` for updating existing projects
- [ ] 2.4 Test `/scaffold-python` by creating a test project
- [ ] 2.5 Test `/check-standards` on reference implementation
- [ ] 2.6 Test `/check-standards` on edm project
- [ ] 2.7 Test `/check-standards` on skinnerbox project

## 3. Programmatic Validation
- [ ] 3.1 Create `bin/check-python-standards` script
- [ ] 3.2 Implement directory structure checks
- [ ] 3.3 Implement pyproject.toml validation
- [ ] 3.4 Implement tool configuration validation
- [ ] 3.5 Test script on reference implementation
- [ ] 3.6 Test script on edm project
- [ ] 3.7 Test script on skinnerbox project
- [ ] 3.8 Document script usage in README.md

## 4. Documentation & Standards
- [ ] 4.1 Create `docs/PROPAGATION.md` with four strategies and decision matrix
- [ ] 4.2 Create `docs/SCAFFOLDING.md` with detailed how-to guide
- [ ] 4.3 Create `docs/AI_TOOLS.md` with multi-tool support patterns
- [ ] 4.4 Document update strategies with Git subtree examples
- [ ] 4.5 Update main `README.md` with scaffolding overview
- [ ] 4.6 Create `docs/MIGRATION.md` for updating existing projects to standards

## 5. OpenSpec Integration
- [ ] 5.1 Verify `openspec/project.md` is complete
- [ ] 5.2 Create spec deltas in `openspec/changes/ai-native-templating/specs/`
- [ ] 5.3 Create `python-scaffolding` spec with requirements
- [ ] 5.4 Create `project-standards` spec with requirements
- [ ] 5.5 Validate with `openspec validate ai-native-templating --strict`
- [ ] 5.6 Fix any validation errors
- [ ] 5.7 Confirm proposal is complete and ready for review

## 6. Real-World Testing
- [ ] 6.1 Create test project using `/scaffold-python`
- [ ] 6.2 Verify test project passes all checks
- [ ] 6.3 Update edm to match standards (sync patterns, configs)
- [ ] 6.4 Update skinnerbox to match standards
- [ ] 6.5 Verify both projects pass `/check-standards`
- [ ] 6.6 Document learnings and iterate

## 7. AI-Agnostic Extensions (Phase 5)
- [ ] 7.1 Test with Cursor: Create `.cursorrules` referencing AI_INSTRUCTIONS.md
- [ ] 7.2 Test with Aider: Create `.aider/prompts.yaml` referencing AI_INSTRUCTIONS.md
- [ ] 7.3 Document multi-tool workflow
- [ ] 7.4 Create guide for adding new AI tools
- [ ] 7.5 Update README.md with multi-tool support
- [ ] 7.6 Test scaffold generation with each tool

## 8. Final Review & Commit
- [ ] 8.1 Review all created files for consistency
- [ ] 8.2 Ensure all examples are runnable
- [ ] 8.3 Update CHANGELOG.md (if exists)
- [ ] 8.4 Create commit with all changes
- [ ] 8.5 Prepare for PR/merge
- [ ] 8.6 Archive completed change in openspec/

## Notes

### Prerequisites Before Starting
- Read `~/.claude/plans/ai-native-templating-complete.md` for design context
- Review `openspec/project.md` for project conventions
- Understand the three-tier system: Exemplar + Generation + Validation

### Quality Gates
- All new files must pass respective tool checks
- Reference implementation must pass: `uv sync && uv run pytest && just check`
- All slash commands must be tested manually
- OpenSpec validation must pass with `--strict` flag
- Documentation must include examples

### Testing Approach
- Each phase is testable independently
- Real-world projects (edm, skinnerbox) used for validation
- Multi-tool support tested with actual usage

### Dependencies Between Tasks
- Phase 1 (reference impl) is prerequisite for Phase 2-4
- Phase 2-3 (slash commands + validation) can be done in parallel
- Phase 4 (documentation) depends on 1-3
- Phase 5 (AI-agnostic) can start after Phase 2
- Phase 6 (testing) validates all previous work
- Phase 7-8 are final polish and deployment
