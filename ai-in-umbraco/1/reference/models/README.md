---
description: >-
    Domain model classes for AI operations.
---

# Models

Core domain models used throughout Umbraco.AI.

## Available Models

| Model                            | Description                      |
| -------------------------------- | -------------------------------- |
| [AIProfile](ai-profile.md)       | Configuration for AI model usage |
| [AIConnection](ai-connection.md) | Connection to an AI provider     |
| [AICapability](ai-capability.md) | Type of AI capability            |
| [AIModelRef](ai-model-ref.md)    | Reference to a specific model    |

## Model Relationships

```
AIConnection (credentials)
      │
      └─► AIProfile (settings)
              │
              ├── AICapability (what it does)
              └── AIModelRef (which model)
```

A profile references:

- One **connection** for authentication
- One **model reference** specifying provider and model ID
- One **capability** type (Chat, Embedding, and so on)

## In This Section

{% content-ref url="ai-profile.md" %}
[AIProfile](ai-profile.md)
{% endcontent-ref %}

{% content-ref url="ai-connection.md" %}
[AIConnection](ai-connection.md)
{% endcontent-ref %}

{% content-ref url="ai-capability.md" %}
[AICapability](ai-capability.md)
{% endcontent-ref %}

{% content-ref url="ai-model-ref.md" %}
[AIModelRef](ai-model-ref.md)
{% endcontent-ref %}
