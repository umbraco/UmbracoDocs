---
description: >-
    Stream chat responses in real-time for a better user experience.
---

# Streaming

Streaming returns response chunks as they're generated, rather than waiting for the complete response. Streaming provides a better user experience for longer responses.

## Why Use Streaming

| Approach      | Best For                                             |
| ------------- | ---------------------------------------------------- |
| Non-streaming | Short responses, background processing               |
| Streaming     | User-facing chat, long responses, real-time feedback |

Streaming lets users see the response as it's being generated, reducing perceived latency.

## Basic Streaming

{% code title="BasicStreaming.cs" %}

```csharp
using Microsoft.Extensions.AI;
using Umbraco.AI.Core.Chat;

public class StreamingExample
{
    private readonly IAIChatService _chatService;

    public StreamingExample(IAIChatService chatService)
    {
        _chatService = chatService;
    }

    public async Task StreamToConsole(string question)
    {
        var messages = new List<ChatMessage>
        {
            new(ChatRole.User, question)
        };

        await foreach (var update in _chatService.StreamChatResponseAsync(
            chat => chat.WithAlias("console-stream"),
            messages))
        {
            // Each update contains a chunk of text
            Console.Write(update.Text);
        }

        Console.WriteLine(); // New line at end
    }
}
```

{% endcode %}

## Understanding ChatResponseUpdate

Each streamed chunk is a `ChatResponseUpdate`:

| Property       | Type                | Description                            |
| -------------- | ------------------- | -------------------------------------- |
| `Text`         | `string?`           | The text content of this chunk         |
| `Role`         | `ChatRole?`         | The role (usually only in first chunk) |
| `FinishReason` | `ChatFinishReason?` | Set in the final chunk                 |

{% code title="UpdateDetails.cs" %}

```csharp
await foreach (var update in _chatService.StreamChatResponseAsync(
    chat => chat.WithAlias("update-details"),
    messages))
{
    if (update.Text is not null)
    {
        // Append text chunk
        responseBuilder.Append(update.Text);
    }

    if (update.FinishReason is not null)
    {
        // This is the last chunk
        Console.WriteLine($"Finished: {update.FinishReason}");
    }
}
```

{% endcode %}

## Streaming in an API Controller

Return a streaming response to the client:

{% code title="StreamingController.cs" %}

```csharp
[ApiController]
[Route("api/chat")]
public class ChatController : UmbracoApiController
{
    private readonly IAIChatService _chatService;

    public ChatController(IAIChatService chatService)
    {
        _chatService = chatService;
    }

    [HttpPost("stream")]
    public async Task StreamChat([FromBody] ChatRequest request)
    {
        Response.Headers.Append("Content-Type", "text/event-stream");
        Response.Headers.Append("Cache-Control", "no-cache");
        Response.Headers.Append("Connection", "keep-alive");

        var messages = new List<ChatMessage>
        {
            new(ChatRole.User, request.Message)
        };

        await foreach (var update in _chatService.StreamChatResponseAsync(
            chat => chat.WithAlias("chat-stream"),
            messages))
        {
            if (update.Text is not null)
            {
                await Response.WriteAsync($"data: {update.Text}\n\n");
                await Response.Body.FlushAsync();
            }
        }

        await Response.WriteAsync("data: [DONE]\n\n");
    }
}

public record ChatRequest(string Message);
```

{% endcode %}

## Collecting the Full Response

To collect the full text while streaming, append each `update.Text` to a `StringBuilder` inside the `await foreach` loop.

{% hint style="info" %}
`StreamChatResponseAsync` accepts a `CancellationToken` parameter to support user cancellation.
{% endhint %}

## Using a Specific Profile

{% code title="StreamWithProfile.cs" %}

```csharp
// With profile ID
await foreach (var update in _chatService.StreamChatResponseAsync(
    chat => chat
        .WithAlias("profiled-stream")
        .WithProfile(profileId),
    messages))
{
    Console.Write(update.Text);
}

// With options
var options = new ChatOptions { Temperature = 0.8f };

await foreach (var update in _chatService.StreamChatResponseAsync(
    chat => chat
        .WithAlias("custom-options-stream")
        .WithChatOptions(options),
    messages))
{
    Console.Write(update.Text);
}
```

{% endcode %}

## Next Steps

{% content-ref url="system-prompts.md" %}
[System Prompts](system-prompts.md)
{% endcontent-ref %}

{% content-ref url="advanced-options.md" %}
[Advanced Options](advanced-options.md)
{% endcontent-ref %}
