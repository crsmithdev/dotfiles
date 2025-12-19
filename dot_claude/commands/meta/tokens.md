---
description: Analyze token usage, hooks, and context injection
model: haiku
allowed-tools: Bash, Read, Glob, Grep
---

Analyze token usage and context injection patterns with optimization recommendations.

**Analysis scope:**

1. **Current session**:
   - Token usage (input/output/total)
   - Context window utilization percentage
   - Message count and average message size
   - Tool call frequency and cost

2. **Hook analysis**:
   - All configured hooks (startup, prompt-submit, etc.)
   - Hook execution frequency
   - Token cost per hook execution
   - Total token overhead from hooks
   - Failed/blocked hook executions

3. **Context injection**:
   - What gets injected on each message
   - CLAUDE.md injection cost
   - Context file injection cost
   - System reminder frequency and cost
   - Tool description overhead

4. **Statistics to report**:
   - Total tokens used this session
   - Tokens from hooks vs user messages vs tool calls
   - Average tokens per exchange
   - Context injection overhead per message
   - Projected tokens to context limit

5. **Optimization recommendations**:
   - Hooks to optimize or disable
   - Context to move from injection to on-demand
   - Redundant system reminders to suppress
   - Model switching opportunities (haiku for simple tasks)
   - Tool allowlist tightening

6. **Output format**:
   ```
   ## Token Analytics

   **Current Session:**
   - Total tokens: X (Y% of limit)
   - Messages: N (avg M tokens/message)
   - Tool calls: P (avg Q tokens/call)

   **Hook Overhead:**
   - Startup hooks: X tokens
   - Prompt-submit hooks: Y tokens/message
   - Total hook cost: Z tokens (A% of session)

   **Context Injection:**
   - CLAUDE.md: X tokens/message
   - Contexts: Y tokens/message
   - System reminders: Z tokens/message
   - Tool descriptions: A tokens/message

   **Optimization Recommendations:**

   [HIGH] Startup hook X runs every message (500 tokens) - move to on-demand
   [MED] CLAUDE.md contains 2000 tokens - consider splitting
   [LOW] System reminders repeat 5x - suppress after first

   **Estimated savings:** ~X tokens/message (Y% reduction)
   ```

<!--
TEST CASES:
- `/tokens` → analyzes current session token usage, hook overhead, provides recommendations
- `/tokens` early in session → shows minimal usage, projects future costs
-->
