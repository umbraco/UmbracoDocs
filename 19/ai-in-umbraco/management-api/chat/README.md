---
description: >-
    Chat completion endpoints for conversational AI via the Management API.
---

# Chat Endpoints

The chat endpoints provide access to AI chat completions through the Management API.

## Available Endpoints

| Method | Endpoint                                                            | Description                                     |
| ------ | ------------------------------------------------------------------- | ----------------------------------------------- |
| POST   | `/umbraco/ai/management/api/v1/chat/complete`                       | Get a chat completion using the default profile |
| POST   | `/umbraco/ai/management/api/v1/chat/{profileIdOrAlias}/complete`    | Get a chat completion using a specific profile  |

## Request Format

All chat endpoints accept the same request body:

{% code title="Request Body" %}

```json
{
    "messages": [
        {
            "role": "system",
            "content": "You are a helpful assistant."
        },
        {
            "role": "user",
            "content": "Hello, how are you?"
        }
    ]
}
```

{% endcode %}

### Message Roles

| Role        | Description                             |
| ----------- | --------------------------------------- |
| `system`    | Instructions for the AI (sets behavior) |
| `user`      | Messages from the user                  |
| `assistant` | Previous responses from the AI          |

## Response Format

{% code title="Response" %}

```json
{
    "message": {
        "role": "assistant",
        "content": "Hello! I'm doing well, thank you for asking. How can I help you today?"
    },
    "finishReason": "stop",
    "usage": {
        "inputTokens": 25,
        "outputTokens": 18,
        "totalTokens": 43
    }
}
```

{% endcode %}

## In This Section

{% content-ref url="complete.md" %}
[Complete](complete.md)
{% endcontent-ref %}
