# Design: [AINT] AI-Native Intent-Based Scaffolding

## Context

### Problem Statement
Traditional templating systems (cookiecutter, copier) use jinja2 variable substitution and require separate template maintenance. This is inefficient for AI-assisted development where:
1. Most files are identical across projects
2. AI can understand semantic intent and adapt to context
3. Standards evolve with real project changes, not maintained templates

### Domain: Python Project Scaffolding
Focus on Python 3.12+ projects using modern standards (UV, Ruff, Mypy, Pytest, Pre-commit). Extensible to other languages and domains.

### Stakeholders
- Individual developers creating new projects
- Teams standardizing practices
- AI assistants (Claude Code) providing scaffold assistance
- Maintenance burden: currently zero template maintenance, stays zero

## Goals

### Primary Goals
1. **No Templating Overhead**: Use literal working code as exemplars, not jinja2 templates
2. **Semantic Generation**: AI understands intent and adapts to context (not string substitution)
3. **Flexible Propagation**: Support loose to tight coupling based on project evolution needs
4. **Natural Evolution**: When exemplar improves, standards improve automatically

### Secondary Goals
1. **Developer Speed**: Scaffold new Python project in <5 minutes
2. **Validation**: Catch structural invariants without preventing contextual variation
3. **Documentation**: Examples are production code, self-documenting
4. **Maintainability**: Zero template maintenance, use real projects as documentation

### Non-Goals
1. **Template engine replacement**: Not building cookiecutter alternative
2. **Automatic migrations**: Changing existing projects requires human approval
3. **Monorepo enforcement**: Tight coupling is one option, not requirement
4. **Framework-specific scaffolding**: Stay framework-agnostic, let domain-specific exemplars exist

## Decisions

### Decision 1: Three-Tier Architecture

**Decision:** Use three-tier system rather than single template engine.

**What:**
1. **Tier 1 - Reference**: `examples/python/` is working reference project, not template
2. **Tier 2 - Generation**: Slash commands + AI understand patterns from exemplar
3. **Tier 3 - Validation**: Both AI semantic checks and programmatic validation

**Why:**
- Exemplars are self-documenting (real code beats documentation)
- AI can understand patterns and adapt, templates cannot
- Semantic validation catches intent violations, syntactic validation catches structure
- Three tiers separate concerns: exemplar (reference), generation (understanding), validation (quality)

**Alternatives Considered:**
- Single generator (cookiecutter): Limited to variable substitution, high maintenance
- Monorepo with shared config: Tight coupling, all projects must evolve together
- Prompt-only (no exemplar): Drifts over time, inconsistent standards
- Programmatic-only (no AI): Mechanical, cannot adapt to context

**Trade-offs:**
- +: Natural evolution, semantic understanding, zero template maintenance
- -: Requires AI access for generation, some variation between generated projects
- Mitigated by: Validation tier ensures structural invariants

**Rationale:**
Aligns with industry convergence: [ai-coding-project-boilerplate](https://github.com/shinpr/ai-coding-project-boilerplate), GoCodeo BUILD, RapidNative all use exemplars + AI understanding rather than traditional templates.

---

### Decision 2: Update Propagation via Multiple Strategies

**Decision:** Support four propagation strategies, user chooses based on coupling.

**What:**
1. **Manual Sync**: Copy files when desired (loose coupling)
2. **Git Subtree**: `git subtree pull` for selective updates (medium coupling)
3. **AI-Assisted**: `/sync-standards` examines exemplar, recommends updates (flexible coupling)
4. **Monorepo Living at HEAD**: All projects in one repo, atomic updates (tight coupling)

**Why:**
- One-size-fits-all doesn't work: side projects need loose coupling, team codebases need tight
- User chooses strategy based on project evolution velocity and team size
- Minimal, focused exemplar + flexible propagation beats heavyweight monorepo
- AI-assisted migration requires human understanding of context

**Alternatives Considered:**
- Only Git Subtree: Too rigid for casual projects, too coupled for diverging projects
- Only Monorepo: Forces all projects into same release cycle
- No propagation (manual only): Standards diverge quickly
- Automatic updates: Risk breaking projects, require extensive testing

**Trade-offs:**
- +: Flexibility, no forced coupling, user chooses coupling level
- -: More documentation, users must choose strategy
- Mitigated by: Decision matrix in docs/PROPAGATION.md, sensible defaults

**Rationale:**
Projects naturally diverge from templates. Rather than fighting this, provide strategies that acknowledge it and minimize friction.

---

### Decision 3: Claude Code Development Instructions

**Decision:** Provide clear, comprehensive CLAUDE.md instructions for development.

**What:**
- CLAUDE.md with development instructions and patterns
- Clear guidance for AI-assisted code generation
- References to exemplar projects and standards
- Git-tracked configuration for team consistency

**Why:**
- Single source of truth for development patterns
- Clear instructions improve AI code generation quality
- Git-tracked ensures consistency across team
- Self-contained (no external tool dependencies)

**Alternatives Considered:**
- Multiple tool configs: Adds complexity, harder to maintain
- Generic Markdown only: Less actionable for AI assistants
- Global `~/.claude/CLAUDE.md` only: Can't customize per project
- No explicit instructions: Drifts over time

**Trade-offs:**
- +: Simple, clear, focused on Claude Code
- -: Claude Code only (not portable to other tools)
- Mitigation: Focus on what matters now, extensible if needed later

**Rationale:**
Simplicity and clarity. Keep instructions focused, actionable, and easy to maintain. Avoid over-engineering for hypothetical multi-tool support.

---

### Decision 4: Structural Invariants vs Contextual Variation

**Decision:** Define strict invariants (must match), conventions (should match), and specifics (project-specific).

**What:**

**Invariants** (enforce via validation, structure is mandatory):
- src/ layout (not flat)
- tests/conftest.py exists
- pyproject.toml with [project], [build-system], [dependency-groups] dev, [tool.*]
- .pre-commit-config.yaml with ruff, mypy, general checks
- README.md with setup instructions

**Conventions** (validate semantically, can vary):
- Tool versions can differ (3.12, 3.13, 3.14)
- Domain models vary (pydantic, dataclasses, plain classes)
- CLI structure varies (click vs typer, single vs group commands)
- Async vs sync patterns per project need

**Specifics** (project-unique):
- Package names, descriptions
- Domain logic and business rules
- Specific dependencies beyond core tooling
- Test fixtures and patterns

**Why:**
- Invariants provide guardrails: wrong structure breaks imports, testing, CI
- Conventions allow learning and evolution: let projects find their pattern
- Specifics are unique: no one-size-fits-all here
- Semantic validation (AI understanding) can distinguish these categories

**Alternatives Considered:**
- All strict: Prevents evolution, templates become cargo-cult
- All flexible: Divergence gets out of hand, hard to maintain consistency
- Programmatic only: Can't understand semantic intent

**Trade-offs:**
- +: Guidance without dogmatism, flexibility with structure
- -: Requires communication about which bucket each rule falls into
- Mitigated by: Clear documentation, examples showing variation

**Rationale:**
Good scaffolding is guardrails + freedom. Tell developers what they MUST have (invariants), what they SHOULD follow (conventions), and let them decide everything else (specifics).

---

### Decision 4: Exemplar in dotfiles vs Standalone Package

**Decision:** Keep exemplar (`examples/python/`) in dotfiles, not separate package.

**What:**
- `~/dotfiles/examples/python/` is reference project
- Can be cloned directly for new projects or used as AI context
- Lives in dotfiles repo, evolves with other projects (edm, skinnerbox)

**Why:**
- Dotfiles is central place for shared standards and configuration
- Reference project benefits from improvements to edm, skinnerbox
- Team can see real projects improving standards (not abstract template)
- Easier to coordinate updates (all in one repo)

**Alternatives Considered:**
- Separate `python-base` package/repo: Decoupled but harder to evolve together
- PyPI package: Over-engineering for internal tools
- GitHub template repo: GitHub-specific, less convenient locally
- No exemplar: Just instructions, projects drift over time

**Trade-offs:**
- +: Central, co-evolved with standards, easy to discover
- -: Dotfiles becomes larger, depends on dotfiles setup
- Mitigated by: Submodular structure, optional examples directory

**Rationale:**
Exemplars are most powerful when they're real projects that evolve. Keeping them in dotfiles (alongside CLAUDE.md, pre-commit configs, other standards) makes them discoverable and contextually clear.

---

### Decision 5: Validation: AI Slash Commands + Programmatic Script

**Decision:** Two-tier validation: AI semantic + programmatic structural checks.

**What:**
1. **AI Semantic** (`/check-standards` slash command):
   - Reads exemplar and project
   - Identifies patterns that differ
   - Explains trade-offs
   - Recommends improvements

2. **Programmatic** (`bin/check-python-standards` script):
   - Checks file structure exists
   - Validates tool configurations
   - Runs actual tools (ruff, mypy, pytest)
   - Outputs checkmarks/errors

**Why:**
- Semantic validation catches "this doesn't match the pattern" (AI understanding)
- Programmatic validation catches "this is broken" (tool feedback)
- Together they're more powerful than either alone
- Programmatic can be run in CI, semantic is for humans/improvement

**Alternatives Considered:**
- AI only: Can't catch actual tool failures, may miss structural issues
- Programmatic only: Doesn't understand context or intent
- Linter rules (ruff, mypy): Already built-in, don't need duplication

**Trade-offs:**
- +: Covers both "wrong pattern" and "broken implementation"
- -: Requires maintaining both
- Mitigated by: Keep programmatic script simple, let tools do heavy lifting

**Rationale:**
Different problems need different solutions. Structure problems need semantic understanding. Actual failures need tool feedback.

---

## Architecture

### One-Phase Scaffolding System

**Phase 1: Static Copy + Template** (Shell script, <1 second)
- Copy identical files from examples/python/
- Simple string substitution for project name/description
- Copy minimal example code (util.py + test)
- Create empty directories
- Done - fully working, tested project ready to use

### Directory Structure

```
~/dotfiles/
├── examples/
│   └── python/                         # Reference implementation
│       ├── .python-version             # STATIC FILES (7 total)
│       ├── .gitignore                  # Copy unchanged to every project
│       ├── .pre-commit-config.yaml     # Ruff, mypy, general hooks
│       ├── .env.example
│       ├── justfile
│       ├── CLAUDE.md
│       ├── openspec/project.md
│       │
│       ├── pyproject.toml              # TEMPLATE FILES (3 total)
│       ├── README.md                   # Name & description substituted
│       ├── src/example/__init__.py     # Package docstring substituted
│       │
│       ├── src/example/util.py         # MINIMAL EXAMPLE (tested, copyable)
│       └── tests/test_util.py          # Example tests
│
├── bin/
│   ├── scaffold-python.sh              # Scaffolding script (1 phase)
│   └── check-python-standards          # Validation
│
├── .claude/
│   ├── commands/
│   │   ├── scaffold-python.md          # Documentation of scaffold
│   │   ├── check-standards.md          # Validation
│   │   └── sync-standards.md           # Update propagation
│   └── settings.json
│
├── openspec/
│   ├── project.md
│   ├── specs/
│   └── changes/ai-native-templating/
│
└── docs/
    ├── MINIMAL_SCAFFOLDING.md          # Explains this architecture
    ├── PROPAGATION.md                  # Update strategies
    └── SCAFFOLDING.md                  # How-to guide
```

### Phase 1: Automated Copy + Template

```bash
$ bin/scaffold-python.sh logparse "Parse system logs"

Step 1: Copy static files (7 files, unchanged)
  .python-version → logparse/.python-version
  .gitignore → logparse/.gitignore
  .pre-commit-config.yaml → logparse/.pre-commit-config.yaml
  .env.example → logparse/.env.example
  justfile → logparse/justfile
  CLAUDE.md → logparse/CLAUDE.md
  openspec/project.md → logparse/openspec/project.md

Step 2: Create directories
  mkdir -p src/logparse tests openspec/changes

Step 3: Generate templates (3 files, simple string substitution)
  pyproject.toml: name="logparse", description="Parse system logs"
  README.md: # LogParse\n\nParse system logs.
  src/logparse/__init__.py: """Parse system logs."""

Step 4: Copy example code (minimal, tested, non-project-specific)
  src/logparse/util.py        ← From examples/python/src/example/util.py
  tests/test_util.py          ← From examples/python/tests/test_util.py

Output: Complete working project
  ✓ 7 static files copied
  ✓ 3 templates generated
  ✓ 2 directories created
  ✓ 2 example files copied + project name updated
  ✓ Fully working, tested, ready to use

$ cd logparse
$ uv sync
$ just test
tests/test_util.py::test_double PASSED
tests/test_util.py::test_format_message PASSED
✓ Tooling verified
```

### Data Flow

```
Developer Request
    ↓
Slash Command (/scaffold-python)
    ↓
AI Reads exemplar + instructions
    ↓
AI Generates project structure
    ↓
Developer runs /check-standards
    ↓
Semantic validation (AI) + Programmatic validation (script)
    ↓
Feedback: What's good, what needs fixing
    ↓
Developer updates project
    ↓
Standards established
```

## Risks & Mitigations

### Risk 1: Standards Drift Without Enforcement
**Impact**: Projects diverge from standards over time
**Mitigation**:
- Validation via `/check-standards` catches drift
- Documentation (exemplar + docs/) explains standards
- Regular review of real projects (edm, skinnerbox) catches trends
- AI can suggest improvements via `/sync-standards`

### Risk 2: Exemplar Becomes Stale
**Impact**: Reference project doesn't reflect current best practices
**Mitigation**:
- Exemplar is real project (not template), actively maintained
- When edm/skinnerbox improves, exemplar improves
- Documentation (docs/PROPAGATION.md) explains how standards evolve
- Version via Git tags if needed

### Risk 3: Multiple AI Tools Create Inconsistency
**Impact**: Cursor generates differently than Claude Code
**Mitigation**:
- Shared `AI_INSTRUCTIONS.md` ensures same understanding
- Tool-specific configs are thin wrappers, not policy
- Validation catches actual differences
- Cross-tool testing during Phase 5

### Risk 4: Tight Coupling in Monorepo Breaks Other Projects
**Impact**: Updating python-base breaks dependent projects
**Mitigation**:
- Monorepo is optional strategy, not requirement
- Default is loose coupling (manual sync)
- AI-assisted migration requires human approval
- Documentation explains decision matrix

### Risk 5: Slash Commands Become Outdated
**Impact**: Generation instructions diverge from exemplar
**Mitigation**:
- Commands reference exemplar directly: "See ~/dotfiles/examples/python/"
- When exemplar changes, commands still work (they examine exemplar)
- Validation catches inconsistencies
- Regular testing with Phase 6 (real-world projects)

## Migration Plan

### For New Projects
1. Request: "Create Python project for X"
2. Claude/user runs `/scaffold-python`
3. Project is generated with current standards
4. Validation confirms structural invariants

### For Existing Projects
1. Developer: "Update this project to standards"
2. User runs `/sync-standards`
3. AI examines project vs exemplar
4. Recommends safe updates for developer approval
5. Developer approves and applies changes

### For Team Adoption
1. Share exemplar and documentation
2. Run `/scaffold-python` for new projects
3. Gradually improve existing projects via `/sync-standards`
4. Use `/check-standards` in code review

## Open Questions

1. **Version pinning**: How strictly should exemplar pin tool versions?
   - Answer: Use uv.lock for reproducibility, but allow some flexibility

2. **Breaking changes to exemplar**: How do we communicate when exemplar changes fundamentally?
   - Answer: Changelog in examples/python/docs/, migration guides in docs/MIGRATION.md

3. **Divergence tolerance**: When is it OK for projects to differ significantly from standards?
   - Answer: Define via invariants (must), conventions (should), specifics (vary)

4. **Multi-language extension**: How to support TypeScript, Rust, etc.?
   - Answer: Same three-tier pattern, create exemplars for each language

5. **Team vs individual**: How does this scale to larger teams?
   - Answer: Monorepo strategy for tight teams, propagation strategies for distributed

## Success Criteria

- **Phase 1-3**: Reference implementation and slash commands working, tests passing
- **Phase 4**: Can scaffold new Python project in <5 minutes
- **Phase 5**: Works with Claude Code, Cursor, Aider (tested)
- **Phase 6**: Real projects (edm, skinnerbox) updated successfully
- **Phase 7-8**: Documentation complete, ready for team adoption
- **Long-term**: Standards naturally improve as exemplar improves

## Next Steps

1. Build reference implementation (Phase 1)
2. Create slash commands (Phase 2)
3. Create validation (Phase 3)
4. Document and test (Phases 4-6)
5. Multi-tool support (Phase 5)
6. Archive and deploy (Phase 7-8)
