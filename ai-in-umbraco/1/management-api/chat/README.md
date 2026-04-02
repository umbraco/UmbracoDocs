---
description: >-
    Chat completion endpoints for conversational AI via the Management API.
---

# Chat Endpoints

The chat endpoints provide access to AI chat completions through the Management API.

## Available Endpoints

| Method | Endpoint                            | Description                                        |
| ------ | ----------------------------------- | -------------------------------------------------- |
| POST   | `/chat/complete`                    | Get a chat completion using the default profile    |
| POST   | `/chat/{profileIdOrAlias}/complete` | Get a chat completion using a specific profile     |
| POST   | `/chat/stream`                      | Stream a chat completion using the default profile |
| POST   | `/chat/{profileIdOrAlias}/stream`   | Stream a chat completion using a specific profile  |

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

### Non-Streaming Response

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

### Streaming Response

Streaming endpoints return Server-Sent Events (SSE):

```
data: {"content":"Hello"}

data: {"content":"!"}

data: {"content":" I'm"}

data: {"content":" doing"}

data: {"finishReason":"stop"}

data: [DONE]
```

## In This Section

{% content-ref url="complete.md" %}
[Complete](complete.md)
{% endcontent-ref %}

{% content-ref url="stream.md" %}
[Stream](stream.md)
{% endcontent-ref %}
