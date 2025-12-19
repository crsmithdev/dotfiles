---
description: Analyze Claude Code configuration with optimization recommendations
model: haiku
allowed-tools: Bash, Read, Glob
---

Analyze Claude Code configuration and settings with optimization recommendations.

**Analysis scope:**

1. **Settings.json**:
   - Configured permissions
   - Model preferences
   - Hooks configuration
   - Plugin settings
   - Feature flags
   - Custom tool allowlists

2. **Project structure**:
   - .claude/ directory organization
   - Scripts in .claude/scripts/
   - Contexts in .claude/contexts/
   - Commands in .claude/commands/
   - Orphaned or unused files

3. **Statistics to report**:
   - Total configuration size
   - Permission grants count
   - Hook count and types
   - Plugin count
   - Script count (used vs unused)
   - Configuration complexity score

4. **Optimization recommendations**:
   - Simplify overly permissive grants
   - Remove redundant permissions
   - Optimize hook execution
   - Clean up unused scripts
   - Reorganize project structure
   - Update deprecated settings

5. **Output format**:
   ```
   ## Configuration Analytics

   **Settings:**
   - Permissions: X grants (Y overly broad)
   - Hooks: Z configured (A active)
   - Plugins: N installed
   - Model: default-model-name

   **Project Structure:**
   - Scripts: X total (Y unused)
   - Commands: A total
   - Contexts: B files
   - Total .claude/ size: C MB

   **Configuration Health:**
   - Complexity: [Low/Medium/High]
   - Security: [Tight/Moderate/Permissive]
   - Organization: [Clean/Cluttered]

   **Optimization Recommendations:**

   [HIGH] Permission "Bash" is too broad - scope to specific commands
   [MED] Remove unused scripts: check.sh, status.sh
   [MED] Hook "validate-commands.sh" runs on every startup (slow)
   [LOW] Consider organizing scripts into subdirectories

   **Security Recommendations:**

   [HIGH] Bash permission allows any command - add more specific grants
   [MED] No .gitignore in .claude/ - may commit sensitive data

   **Estimated improvements:** Faster startup, tighter security, cleaner structure
   ```

<!--
TEST CASES:
- `/config` → analyzes settings.json and project structure, provides recommendations
- `/config` with security issues → highlights overly permissive settings
-->
