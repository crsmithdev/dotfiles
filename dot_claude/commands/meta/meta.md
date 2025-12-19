---
description: Analyze Claude Code internals and configuration
model: haiku
allowed-tools: SlashCommand
argument-hint: memory | tokens | tools | config
---

Run meta-analysis on Claude Code components.

**Usage:**
- `/meta memory` - Analyze memory files, contexts, cipher patterns
- `/meta tokens` - Analyze token usage, hooks, context injection
- `/meta tools` - Analyze slash commands and MCP servers
- `/meta config` - Analyze configuration and settings
- `/meta` - Run all four diagnostics

**Routing logic:**

If argument matches a known subcommand, invoke the corresponding command:
- `memory` → `/meta:memory`
- `tokens` → `/meta:tokens`
- `tools` → `/meta:tools`
- `config` → `/meta:config`

If no argument or unrecognized argument, invoke all four commands sequentially:
1. `/meta:memory`
2. `/meta:tokens`
3. `/meta:tools`
4. `/meta:config`

Present a summary of all findings at the end, highlighting HIGH priority recommendations.

**Arguments provided:** $ARGUMENTS

<!--
TEST CASES:
- `/meta memory` → invokes /meta:memory
- `/meta tokens` → invokes /meta:tokens
- `/meta tools` → invokes /meta:tools
- `/meta config` → invokes /meta:config
- `/meta` → runs all four commands sequentially, summarizes findings
-->
