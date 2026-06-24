---
description: >-
    Use the chat API for conversational AI, text generation, and completions.
---

# Chat

The chat API provides access to conversational AI capabilities. Use it for text generation, question answering, content creation, and more.

## IAIChatService

The primary interface for chat operations:

{% code title="IAIChatService.cs" %}

```csharp
public interface IAIChatService
{
    // Non-streaming responses
    Task<ChatResponse> GetChatResponseAsync(
        Action<AIChatBuilder> configure,
        IEnumerable<ChatMessage> messages,
        CancellationToken cancellationToken = default);

    // Streaming responses
    IAsyncEnumerable<ChatResponseUpdate> StreamChatResponseAsync(
        Action<AIChatBuilder> configure,
        IEnumerable<ChatMessage> messages,
        CancellationToken cancellationToken = default);

    // Advanced: Create the underlying client
    Task<IChatClient> CreateChatClientAsync(
        Action<AIChatBuilder> configure,
        CancellationToken cancellationToken = default);
}
```

{% endcode %}

## Basic Usage

{% code title="ContentAssistant.cs" %}

```csharp
using Microsoft.Extensions.AI;
using Umbraco.AI.Core.Chat;

public class ContentAssistant
{
    private readonly IAIChatService _chatService;

    public ContentAssistant(IAIChatService chatService)
    {
        _chatService = chatService;
    }

    public async Task<string> GetSuggestion(string prompt)
    {
        var messages = new List<ChatMessage>
        {
            new(ChatRole.User, prompt)
        };

        var response = await _chatService.GetChatResponseAsync(
            chat => chat.WithAlias("content-assistant"),
            messages);

        return response.Message.Text ?? string.Empty;
    }
}
```

{% endcode %}

## Message Roles

| Role                 | Description                                     |
| -------------------- | ----------------------------------------------- |
| `ChatRole.System`    | Instructions for the AI (set behavior, context) |
| `ChatRole.User`      | Messages from the user                          |
| `ChatRole.Assistant` | Previous responses from the AI                  |
| `ChatRole.Tool`      | Results from tool/function calls                |

## Multi-Turn Conversations

Include previous messages to maintain context:

{% code title="ConversationExample.cs" %}

```csharp
var conversation = new List<ChatMessage>
{
    new(ChatRole.System, "You are a helpful content editor."),
    new(ChatRole.User, "Write a headline for a blog about baking."),
    new(ChatRole.Assistant, "The Art of Perfect Sourdough: A Beginner's Journey"),
    new(ChatRole.User, "Make it shorter.")
};

var response = await _chatService.GetChatResponseAsync(
    chat => chat.WithAlias("content-editor"),
    conversation);
// Response considers the full conversation context
```

{% endcode %}

## Choosing a Profile

### Default Profile

Once you have [configured a default chat profile](../../backoffice/managing-settings.md) in the backoffice, you can call without specifying a profile:

```csharp
var response = await _chatService.GetChatResponseAsync(
    chat => chat.WithAlias("default-chat"),
    messages);
```

### Specific Profile

Pass the profile ID using the builder:

```csharp
var response = await _chatService.GetChatResponseAsync(
    chat => chat
        .WithAlias("profiled-chat")
        .WithProfile(profileId),
    messages);
```

Or use the profile alias directly:

```csharp
var response = await _chatService.GetChatResponseAsync(
    chat => chat
        .WithAlias("content-assistant")
        .WithProfile("content-assistant"),
    messages);
```

## In This Section

{% content-ref url="basic-chat.md" %}
[Basic Chat](basic-chat.md)
{% endcontent-ref %}

{% content-ref url="streaming.md" %}
[Streaming](streaming.md)
{% endcontent-ref %}

{% content-ref url="system-prompts.md" %}
[System Prompts](system-prompts.md)
{% endcontent-ref %}

{% content-ref url="advanced-options.md" %}
[Advanced Options](advanced-options.md)
{% endcontent-ref %}
