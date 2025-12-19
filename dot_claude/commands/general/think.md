---
description: Deep research and exploration of topics
model: opus
allowed-tools: Task, WebSearch, WebFetch, Read, Glob, Grep
---

**Use extended thinking (ultrathink) for this entire response.**

**Topic determination:**
- `/think <topic>` → Research the specified topic
- `/think` → Research the current or most recently discussed topic in the conversation

Conduct comprehensive research and exploration:

**Research Process:**

1. **Spawn research agents** (in parallel):
   - Explore agent: Search codebase for relevant context
   - Web research: Search for authoritative sources, recent developments, best practices
   - Technical deep-dive: Analyze specific implementations, patterns, trade-offs

2. **Gather information**:
   - Search web for current thinking, documentation, research papers
   - Search GitHub for relevant repositories, issues, discussions, and code examples (if technical topic)
   - Fetch and analyze relevant articles, specs, guides
   - Review local codebase if relevant to question
   - Cross-reference multiple sources

3. **Deep analysis**:
   - Synthesize findings from all research streams
   - Identify patterns, principles, and underlying systems
   - Explore edge cases and failure modes
   - Consider cross-domain insights and analogies
   - Map out trade-offs and alternatives

4. **Deliver comprehensive answer**:
   - Structured exploration of the topic
   - Multiple perspectives and approaches
   - Concrete examples and evidence
   - Practical recommendations
   - Sources and references

**Question/Topic:** $ARGUMENTS

<!--
TEST CASES:
- `/think` (no args) → researches the current or most recently discussed topic
- `/think what is the best way to structure a plugin system` → spawns agents, searches web, provides detailed analysis with sources
- `/think explain the CAP theorem with examples` → researches, provides comprehensive explanation with real-world examples
-->
