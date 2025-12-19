---
description: Analyze slash commands and MCP servers with optimization recommendations
model: haiku
allowed-tools: Bash, Read, Glob, Grep
---

Analyze slash commands and MCP servers with optimization recommendations.

**Analysis scope:**

1. **Slash commands**:
   - Total command count (global + local)
   - Command complexity (frontmatter, prompt length, allowed-tools)
   - Token cost per command (prompt template size)
   - Usage frequency (if trackable)
   - Command shadowing (local overriding global)
   - Broken references (missing scripts, invalid tool names)

2. **MCP servers**:
   - Configured servers and their status
   - Tools provided by each server
   - Server startup cost
   - Unused MCP servers (configured but never used)
   - Tool overlap between servers

3. **Statistics to report**:
   - Total slash commands: X global, Y local
   - Average command size: Z tokens
   - Total command overhead: A tokens
   - MCP servers: N active, M configured
   - MCP tools available: P total

4. **Optimization recommendations**:
   - Remove unused commands
   - Simplify verbose command prompts
   - Consolidate duplicate functionality
   - Fix broken references
   - Disable unused MCP servers
   - Merge overlapping tools

5. **Output format**:
   ```
   ## Tools Analytics

   **Slash Commands:**
   - Global: X commands (~Y tokens)
   - Local: Z commands (~A tokens)
   - Total overhead: B tokens
   - Broken: C commands (list them)

   **Command breakdown:**
   - /ship: 500 tokens, uses Bash/Read/Glob
   - /think: 800 tokens, uses Task/WebSearch/WebFetch
   - ...

   **MCP Servers:**
   - Active: N servers
   - Tools: P total tools available
   - Unused: M servers configured but never called

   **Optimization Recommendations:**

   [HIGH] Remove broken command /foo (references missing script)
   [HIGH] Disable unused MCP server "bar" (never called, startup cost)
   [MED] Simplify /ship prompt (currently 500 tokens, can reduce to 300)
   [LOW] Local /apply shadows global - intentional?

   **Estimated savings:** ~X tokens at startup, Y tokens per command use
   ```

<!--
TEST CASES:
- `/tools` → analyzes all commands and MCP servers, provides recommendations
- `/tools` with broken commands → identifies broken references
-->
