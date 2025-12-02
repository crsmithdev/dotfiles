---
description: Show project and session state with draft proposals
---

# Show project state including draft proposals

Show the current project state and session status, including both completed proposals and draft proposals (those missing implementation details).

```bash
echo "=== Project Status ===" && \
git status --short && echo && \
echo "=== Recent Commits ===" && \
git log --oneline -5 && echo && \
echo "=== OpenSpec Proposals ===" && \
openspec list
```
