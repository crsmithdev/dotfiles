---
description: Run command with Sonnet
model: sonnet
---

If no arguments provided, respond: "This command needs a request. Try `/s your question here`"

Otherwise execute the request below:

$ARGUMENTS

<!--
TEST CASES:
- `/s` (no args) → asks user to provide a request
- `/s what is 2+2` → answers "4" using sonnet model
-->
