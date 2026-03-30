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
        Action<AIChatBuilder> configure,
        IEnumerable<ChatMessage> messages,
        CancellationToken cancellationToken = default);

    IAsyncEnumerable<ChatResponseUpdate> StreamChatResponseAsync(
        Action<AIChatBuilder> configure,
        IEnumerable<ChatMessage> messages,
        CancellationToken cancellationToken = default);

    Task<IChatClient> CreateChatClientAsync(
        Action<AIChatBuilder> configure,
        CancellationToken cancellationToken = default);
}
```

{% endcode %}

## AIChatBuilder

All methods accept an `Action<AIChatBuilder>` to configure the request. The builder provides the following fluent methods:

| Method | Description |
| --- | --- |
| `.WithAlias(string alias)` | **Required.** Sets an alias for auditing and telemetry. |
| `.WithProfile(Guid profileId)` | Selects a profile by ID. Uses default if omitted. |
| `.WithProfile(string profileAlias)` | Selects a profile by alias. |
| `.WithChatOptions(ChatOptions options)` | Overrides profile defaults for temperature, max tokens, etc. |
| `.WithGuardrails(params Guid[] guardrailIds)` | Applies guardrails by ID. |
| `.WithGuardrails(params string[] guardrailAliases)` | Applies guardrails by alias. |
| `.WithContextItems(IEnumerable<AIRequestContextItem> contextItems)` | Attaches context items to the request. |

{% code title="Builder example" %}

```csharp
var response = await _chatService.GetChatResponseAsync(
    chat => chat
        .WithAlias("my-summarizer")
        .WithProfile("default-chat")
        .WithChatOptions(new ChatOptions { Temperature = 0.7f }),
    messages,
    cancellationToken);
```

{% endcode %}

## Methods

### GetChatResponseAsync

Performs a chat completion and returns the full response.

{% code title="Signature" %}

```csharp
Task<ChatResponse> GetChatResponseAsync(
    Action<AIChatBuilder> configure,
    IEnumerable<ChatMessage> messages,
    CancellationToken cancellationToken = default);
```

{% endcode %}

| Parameter           | Type                       | Description                                          |
| ------------------- | -------------------------- | ---------------------------------------------------- |
| `configure`         | `Action<AIChatBuilder>`    | Builder action to set alias, profile, options, etc.  |
| `messages`          | `IEnumerable<ChatMessage>` | The conversation messages                            |
| `cancellationToken` | `CancellationToken`        | Cancellation token                                   |

**Returns**: `ChatResponse` with the assistant's message, usage stats, and finish reason.

{% code title="Example" %}

```csharp
var messages = new[]
{
    new ChatMessage(ChatRole.System, "You are a helpful assistant."),
    new ChatMessage(ChatRole.User, "What is Umbraco?")
};

var response = await _chatService.GetChatResponseAsync(
    chat => chat.WithAlias("my-assistant"),
    messages);

Console.WriteLine(response.Message.Text);
Console.WriteLine($"Tokens: {response.Usage?.TotalTokenCount}");
```

{% endcode %}

### StreamChatResponseAsync

Performs a streaming chat completion, yielding updates as they arrive.

{% code title="Signature" %}

```csharp
IAsyncEnumerable<ChatResponseUpdate> StreamChatResponseAsync(
    Action<AIChatBuilder> configure,
    IEnumerable<ChatMessage> messages,
    CancellationToken cancellationToken = default);
```

{% endcode %}

| Parameter           | Type                       | Description                                          |
| ------------------- | -------------------------- | ---------------------------------------------------- |
| `configure`         | `Action<AIChatBuilder>`    | Builder action to set alias, profile, options, etc.  |
| `messages`          | `IEnumerable<ChatMessage>` | The conversation messages                            |
| `cancellationToken` | `CancellationToken`        | Cancellation token                                   |

**Returns**: `IAsyncEnumerable<ChatResponseUpdate>` yielding content chunks.

{% code title="Example" %}

```csharp
var messages = new[]
{
    new ChatMessage(ChatRole.User, "Write a story about a robot.")
};

await foreach (var update in _chatService.StreamChatResponseAsync(
    chat => chat.WithAlias("story-writer"),
    messages))
{
    Console.Write(update.Text);
}
```

{% endcode %}

### CreateChatClientAsync

Creates a configured `IChatClient` for advanced scenarios.

{% code title="Signature" %}

```csharp
Task<IChatClient> CreateChatClientAsync(
    Action<AIChatBuilder> configure,
    CancellationToken cancellationToken = default);
```

{% endcode %}

| Parameter           | Type                    | Description                                          |
| ------------------- | ----------------------- | ---------------------------------------------------- |
| `configure`         | `Action<AIChatBuilder>` | Builder action to set alias, profile, options, etc.  |
| `cancellationToken` | `CancellationToken`     | Cancellation token                                   |

**Returns**: Configured `IChatClient` with middleware applied.

{% code title="Example" %}

```csharp
// Create client for advanced usage
var client = await _chatService.CreateChatClientAsync(
    chat => chat.WithAlias("advanced-client").WithProfile("default-chat"));

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

var response = await _chatService.GetChatResponseAsync(
    chat => chat
        .WithAlias("creative-chat")
        .WithChatOptions(options),
    messages);
```

{% endcode %}

## Related Types

- `ChatMessage` - Message in a conversation (M.E.AI)
- `ChatResponse` - Completion response (M.E.AI)
- `ChatResponseUpdate` - Streaming chunk (M.E.AI)
- `ChatOptions` - Request options (M.E.AI)
