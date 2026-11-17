---
description: >-
    Get a complete chat response from the AI model.
---

# Complete Chat

Get a complete (non-streaming) chat response from an AI model.

## Endpoints

| Method | Endpoint                                                              | Description              |
| ------ | --------------------------------------------------------------------- | ------------------------ |
| POST   | `/umbraco/ai/management/api/v1/chat/complete`                         | Use default chat profile |
| POST   | `/umbraco/ai/management/api/v1/chat/{profileIdOrAlias}/complete`      | Use specific profile     |

## Request

### Headers

| Header       | Value              |
| ------------ | ------------------ |
| Content-Type | `application/json` |

### Body

{% code title="Request Body" %}

```json
{
    "messages": [
        {
            "role": "user",
            "content": "What is Umbraco CMS?"
        }
    ]
}
```

{% endcode %}

### With Conversation History

{% code title="Multi-turn Request" %}

```json
{
    "messages": [
        {
            "role": "system",
            "content": "You are a helpful assistant that explains technical concepts simply."
        },
        {
            "role": "user",
            "content": "What is a CMS?"
        },
        {
            "role": "assistant",
            "content": "A CMS (Content Management System) is software that helps you create, manage, and modify content on a website without needing to write code directly."
        },
        {
            "role": "user",
            "content": "Can you give me an example?"
        }
    ]
}
```

{% endcode %}

## Response

### Success (200 OK)

{% code title="Response" %}

```json
{
    "message": {
        "role": "assistant",
        "content": "Umbraco is an open-source content management system (CMS) built on Microsoft .NET. It's known for its flexibility, allowing developers to build custom solutions while providing content editors with an intuitive interface for managing website content."
    },
    "finishReason": "stop",
    "usage": {
        "inputTokens": 12,
        "outputTokens": 48,
        "totalTokens": 60
    }
}
```

{% endcode %}

### Response Properties

| Property             | Type   | Description                                      |
| -------------------- | ------ | ------------------------------------------------ |
| `message.role`       | string | Always "assistant"                               |
| `message.content`    | string | The AI's response text                           |
| `finishReason`       | string | Why the response ended (stop, length, and so on) |
| `usage.inputTokens`  | int    | Tokens in the request                            |
| `usage.outputTokens` | int    | Tokens in the response                           |
| `usage.totalTokens`  | int    | Total tokens used                                |

### Finish Reasons

| Reason          | Description          |
| --------------- | -------------------- |
| `stop`          | Natural completion   |
| `length`        | Max tokens reached   |
| `contentFilter` | Content was filtered |

## Errors

### 400 Bad Request

Invalid request format:

{% code title="Response" %}

```json
{
    "type": "https://tools.ietf.org/html/rfc7231#section-6.5.1",
    "title": "Bad Request",
    "status": 400,
    "detail": "Messages cannot be empty"
}
```

{% endcode %}

### 404 Not Found

Profile not found:

{% code title="Response" %}

```json
{
    "type": "https://tools.ietf.org/html/rfc7231#section-6.5.4",
    "title": "Not Found",
    "status": 404,
    "detail": "Profile 'non-existent' not found"
}
```

{% endcode %}

## Examples

### cURL - Default Profile

{% code title="cURL" %}

```bash
curl -X POST "https://your-site.com/umbraco/ai/management/api/v1/chat/complete" \
  -H "Content-Type: application/json" \
  -d '{
    "messages": [
      {"role": "user", "content": "Hello!"}
    ]
  }'
```

{% endcode %}

### cURL - Specific Profile

{% code title="cURL with Profile" %}

```bash
curl -X POST "https://your-site.com/umbraco/ai/management/api/v1/chat/content-assistant/complete" \
  -H "Content-Type: application/json" \
  -d '{
    "messages": [
      {"role": "user", "content": "Write a tagline for a coffee shop."}
    ]
  }'
```

{% endcode %}

### JavaScript (Fetch)

{% code title="JavaScript" %}

```javascript
const response = await fetch("/umbraco/ai/management/api/v1/chat/complete", {
    method: "POST",
    headers: {
        "Content-Type": "application/json",
    },
    credentials: "include",
    body: JSON.stringify({
        messages: [{ role: "user", content: "What is Umbraco?" }],
    }),
});

const data = await response.json();
console.log(data.message.content);
```

{% endcode %}

### C# (HttpClient)

{% code title="C#" %}

```csharp
var request = new
{
    messages = new[]
    {
        new { role = "user", content = "What is Umbraco?" }
    }
};

var response = await httpClient.PostAsJsonAsync(
    "/umbraco/ai/management/api/v1/chat/complete",
    request);

var result = await response.Content.ReadFromJsonAsync<ChatResponse>();
Console.WriteLine(result.Message.Content);
```

{% endcode %}
