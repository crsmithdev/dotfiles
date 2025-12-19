---
description: Run command with Haiku
model: haiku
---

If no arguments provided, respond: "This command needs a request. Try `/h your question here`"

Otherwise execute the request below:

$ARGUMENTS

<!--
TEST CASES:
- `/h` (no args) → asks user to provide a request
- `/h what is 2+2` → answers "4" using haiku model
-->
