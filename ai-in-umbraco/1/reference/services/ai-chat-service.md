---
description: >-
    Service for AI chat completions.
---

# IAIChatService

The primary service for performing chat completions. Acts as a thin layer over Microsoft.Extensions.AI, adding Umbraco-specific features like profiles and middleware.

## Namespace

{% code title="Namespace" %}

```csharp
using Umbraco.AI.Core.Chat;
using Microsoft.Extensions.AI;
```

{% endcode %}

## Interface

{% code title="IAIChatService" %}

```csharp
public interface IAIChatService
{
    Task<ChatResponse> GetChatResponseAsync(
        IEnumerable<ChatMessage> messages,
        ChatOptions? options = null,
        CancellationToken cancellationToken = default);

    Task<ChatResponse> GetChatResponseAsync(
        Guid profileId,
        IEnumerable<ChatMessage> messages,
        ChatOptions? options = null,
        CancellationToken cancellationToken = default);

    IAsyncEnumerable<ChatResponseUpdate> GetStreamingChatResponseAsync(
        IEnumerable<ChatMessage> messages,
        ChatOptions? options = null,
        CancellationToken cancellationToken = default);

    IAsyncEnumerable<ChatResponseUpdate> GetStreamingChatResponseAsync(
        Guid profileId,
        IEnumerable<ChatMessage> messages,
        ChatOptions? options = null,
        CancellationToken cancellationToken = default);

    Task<IChatClient> GetChatClientAsync(
        Guid? profileId = null,
        CancellationToken cancellationToken = default);
}
```

{% endcode %}

## Methods

### GetChatResponseAsync

Performs a chat completion and returns the full response.

{% code title="Signature" %}

```csharp
Task<ChatResponse> GetChatResponseAsync(
    IEnumerable<ChatMessage> messages,
    ChatOptions? options = null,
    CancellationToken cancellationToken = default);

Task<ChatResponse> GetChatResponseAsync(
    Guid profileId,
    IEnumerable<ChatMessage> messages,
    ChatOptions? options = null,
    CancellationToken cancellationToken = default);
```

{% endcode %}

| Parameter           | Type                       | Description                                     |
| ------------------- | -------------------------- | ----------------------------------------------- |
| `profileId`         | `Guid`                     | (Optional) Profile ID. Uses default if omitted. |
| `messages`          | `IEnumerable<ChatMessage>` | The conversation messages                       |
| `options`           | `ChatOptions?`             | Options to override profile defaults            |
| `cancellationToken` | `CancellationToken`        | Cancellation token                              |

**Returns**: `ChatResponse` with the assistant's message, usage stats, and finish reason.

{% code title="Example" %}

```csharp
var messages = new[]
{
    new ChatMessage(ChatRole.System, "You are a helpful assistant."),
    new ChatMessage(ChatRole.User, "What is Umbraco?")
};

var response = await _chatService.GetChatResponseAsync(messages);

Console.WriteLine(response.Message.Text);
Console.WriteLine($"Tokens: {response.Usage?.TotalTokenCount}");
```

{% endcode %}

### GetStreamingChatResponseAsync

Performs a streaming chat completion, yielding updates as they arrive.

{% code title="Signature" %}

```csharp
IAsyncEnumerable<ChatResponseUpdate> GetStreamingChatResponseAsync(
    IEnumerable<ChatMessage> messages,
    ChatOptions? options = null,
    CancellationToken cancellationToken = default);

IAsyncEnumerable<ChatResponseUpdate> GetStreamingChatResponseAsync(
    Guid profileId,
    IEnumerable<ChatMessage> messages,
    ChatOptions? options = null,
    CancellationToken cancellationToken = default);
```

{% endcode %}

| Parameter           | Type                       | Description                                     |
| ------------------- | -------------------------- | ----------------------------------------------- |
| `profileId`         | `Guid`                     | (Optional) Profile ID. Uses default if omitted. |
| `messages`          | `IEnumerable<ChatMessage>` | The conversation messages                       |
| `options`           | `ChatOptions?`             | Options to override profile defaults            |
| `cancellationToken` | `CancellationToken`        | Cancellation token                              |

**Returns**: `IAsyncEnumerable<ChatResponseUpdate>` yielding content chunks.

{% code title="Example" %}

```csharp
var messages = new[]
{
    new ChatMessage(ChatRole.User, "Write a story about a robot.")
};

await foreach (var update in _chatService.GetStreamingChatResponseAsync(messages))
{
    Console.Write(update.Text);
}
```

{% endcode %}

### GetChatClientAsync

Gets a configured `IChatClient` for advanced scenarios.

{% code title="Signature" %}

```csharp
Task<IChatClient> GetChatClientAsync(
    Guid? profileId = null,
    CancellationToken cancellationToken = default);
```

{% endcode %}

| Parameter           | Type                | Description                       |
| ------------------- | ------------------- | --------------------------------- |
| `profileId`         | `Guid?`             | Profile ID. Uses default if null. |
| `cancellationToken` | `CancellationToken` | Cancellation token                |

**Returns**: Configured `IChatClient` with middleware applied.

{% code title="Example" %}

```csharp
// Get client for advanced usage
var client = await _chatService.GetChatClientAsync();

// Use M.E.AI methods directly
var response = await client.GetChatResponseAsync(
    messages,
    new ChatOptions { Temperature = 0.5f });
```

{% endcode %}

## ChatOptions

Profile settings can be overridden via `ChatOptions`:

{% code title="ChatOptions" %}

```csharp
var options = new ChatOptions
{
    Temperature = 0.7f,
    MaxOutputTokens = 2000,
    StopSequences = new[] { "END" }
};

var response = await _chatService.GetChatResponseAsync(messages, options);
```

{% endcode %}

## Related Types

- `ChatMessage` - Message in a conversation (M.E.AI)
- `ChatResponse` - Completion response (M.E.AI)
- `ChatResponseUpdate` - Streaming chunk (M.E.AI)
- `ChatOptions` - Request options (M.E.AI)
