---
description: >-
    Learn how to use Umbraco.AI services in your code for chat, embeddings, and more.
---

# Using the API

Umbraco.AI provides a service layer that wraps Microsoft.Extensions.AI types with Umbraco-specific features like profiles and connections. This section covers how to use these services in your code.

## Primary Services

| Service               | Purpose                                |
| --------------------- | -------------------------------------- |
| `IAIChatService`      | Chat completions and conversational AI |
| `IAIEmbeddingService` | Generate vector embeddings for text    |

## Dependency Injection (DI)

All services are registered automatically and can be injected into your controllers, services, and components:

{% code title="ServiceInjection.cs" %}

```csharp
public class MyController : UmbracoApiController
{
    private readonly IAIChatService _chatService;
    private readonly IAIEmbeddingService _embeddingService;

    public MyController(
        IAIChatService chatService,
        IAIEmbeddingService embeddingService)
    {
        _chatService = chatService;
        _embeddingService = embeddingService;
    }
}
```

{% endcode %}

## Using M.E.AI Types

Umbraco.AI uses standard Microsoft.Extensions.AI (M.E.AI) types:

| Type                 | Namespace                 | Purpose                                  |
| -------------------- | ------------------------- | ---------------------------------------- |
| `ChatMessage`        | `Microsoft.Extensions.AI` | A message in a conversation              |
| `ChatRole`           | `Microsoft.Extensions.AI` | User, Assistant, System, Tool            |
| `ChatResponse`       | `Microsoft.Extensions.AI` | Complete response from chat              |
| `ChatResponseUpdate` | `Microsoft.Extensions.AI` | Streaming response chunk                 |
| `ChatOptions`        | `Microsoft.Extensions.AI` | Request options (temperature, and so on) |

{% code title="ChatMessageTypes.cs" %}

```csharp
using Microsoft.Extensions.AI;

var messages = new List<ChatMessage>
{
    new(ChatRole.System, "You are a helpful assistant."),
    new(ChatRole.User, "Hello!")
};
```

{% endcode %}

## Quick Examples

### Chat Completion

{% code title="ChatExample.cs" %}

```csharp
var messages = new List<ChatMessage>
{
    new(ChatRole.User, "What is Umbraco CMS?")
};

var response = await _chatService.GetChatResponseAsync(
    chat => chat.WithAlias("content-chat"),
    messages);
var answer = response.Message.Text;
```

{% endcode %}

### Streaming Chat

{% code title="StreamingExample.cs" %}

```csharp
var messages = new List<ChatMessage>
{
    new(ChatRole.User, "Write a short poem about coding.")
};

await foreach (var update in _chatService.StreamChatResponseAsync(
    chat => chat.WithAlias("poem-writer"),
    messages))
{
    Console.Write(update.Text);
}
```

{% endcode %}

### Generate Embedding

{% code title="EmbeddingExample.cs" %}

```csharp
var embedding = await _embeddingService.GenerateEmbeddingAsync(
    "Umbraco is a content management system");

float[] vector = embedding.Vector.ToArray();
```

{% endcode %}

## In This Section

{% content-ref url="chat/README.md" %}
[Chat](chat/README.md)
{% endcontent-ref %}

{% content-ref url="embeddings/README.md" %}
[Embeddings](embeddings/README.md)
{% endcontent-ref %}

{% content-ref url="tools/README.md" %}
[Tools](tools/README.md)
{% endcontent-ref %}
