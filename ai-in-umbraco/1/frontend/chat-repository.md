---
description: >-
    Access AI chat functionality from TypeScript using the chat repository pattern.
---

# Chat Repository

The chat repository provides a data layer for AI chat operations in the backoffice frontend, abstracting the Management API calls behind a consistent interface.

## UaiChatRepository

The `UaiChatRepository` handles server communication for chat operations. Use `UaiChatController` for higher-level chat interactions instead of calling the repository directly.

{% code title="Example" %}

```typescript
import { UaiChatRepository } from "@umbraco-ai/backoffice";

const repository = new UaiChatRepository(host);
```

{% endcode %}

## When to Use

| Scenario | Use |
| --- | --- |
| Chat UI with streaming and cancellation | `UaiChatController` |
| Direct API calls for chat data | `UaiChatRepository` |
| Custom chat implementations | `UaiChatRepository` |

For most use cases, prefer `UaiChatController` which wraps the repository with streaming support, cancellation, and state management.

## Related

- [Chat Controller](chat-controller.md) - Higher-level chat interface
- [Types](types.md) - TypeScript type definitions
