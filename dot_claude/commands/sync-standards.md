# /sync-standards

Update an existing Python project to current standards.

## Usage

```
/sync-standards [project-dir]
```

## Parameters

- `project-dir` (optional): Path to project directory. Defaults to current directory.

## What It Does

Examines an existing project and recommends safe updates to align with current standards. This is an interactive process that requires human approval for each change.

### Process

1. **Analyze**: Read project's current state and examine exemplar patterns
2. **Compare**: Identify differences in:
   - File structure (missing directories, unexpected layouts)
   - Tool configurations (outdated settings, missing tools)
   - Dependency versions (new dev tools, version bumps)
   - Code patterns (diverged from exemplar style)
3. **Recommend**: Suggest specific updates with explanations
4. **Confirm**: Wait for user approval before making changes
5. **Apply**: Update files and run validation to ensure nothing broke

### What Can Be Updated

**Safe Updates** (applied automatically after approval):
- `pyproject.toml`: Update tool versions, add missing configs
- `.pre-commit-config.yaml`: Update hook versions, add new hooks
- `.python-version`: Update Python version
- `justfile`: Add new tasks, update task definitions
- `CLAUDE.md`: Refresh development instructions
- `README.md`: Update setup instructions if changed

**Review-Required Updates** (shown but require explicit approval):
- New tool additions that change development workflow
- Removal of tools or configurations
- Significant restructuring of project layout

**Not Updated** (project-specific):
- `src/{PROJECT_NAME}/` and `tests/` contents (your code stays as-is)
- Domain-specific dependencies
- Custom configurations and overrides

## Example Workflow

```
$ /sync-standards myproject

Analyzing myproject/ vs exemplar...

Found 3 updates available:

1. Update Python version: 3.11 → 3.12
   - Changes: .python-version
   - This aligns with current standards
   ☐ Apply this update

2. Add missing ruff formatting config
   - Changes: pyproject.toml [tool.ruff.format]
   - Tools are preconfigured for optimal settings
   ☐ Apply this update

3. Update pre-commit hook versions
   - Changes: .pre-commit-config.yaml (3 hooks updated)
   - Brings security patches and new features
   ☐ Apply this update

Apply selected updates? [y/n]
```

## Update Strategies

You can use different strategies based on project needs:

### Strategy 1: Loose Coupling (Manual Sync)
- Run `/sync-standards` when you choose
- Review and approve each update
- Suitable for: Side projects, experimental code, diverging projects

### Strategy 2: Scheduled Sync
- Run `/sync-standards` quarterly or with release cycles
- Batch multiple updates together
- Suitable for: Team projects, stable codebases

### Strategy 3: Git Subtree (Medium Coupling)
- Keep exemplar in git subtree
- Update exemplar subtree when needed
- Use `/sync-standards` to pull changes into project
- Suitable for: Projects that evolve slowly but stay in sync

### Strategy 4: Monorepo (Tight Coupling)
- All projects in single repository
- Changes to exemplar apply to all projects
- Atomic updates across entire codebase
- Suitable for: Teams with coordinated standards

## Related Commands

- `/scaffold-python` - Create a new project from scratch
- `/check-standards` - Validate project structure and quality
