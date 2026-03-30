---
description: >-
    Send chat messages and receive complete responses from AI models.
---

# Basic Chat

Send messages and receive a complete response from AI models. This is suitable for most use cases where you don't need real-time streaming.

## Basic Request

{% code title="SimpleChat.cs" %}

```csharp
using Microsoft.Extensions.AI;
using Umbraco.AI.Core.Chat;

public class ChatController : UmbracoApiController
{
    private readonly IAIChatService _chatService;

    public ChatController(IAIChatService chatService)
    {
        _chatService = chatService;
    }

    [HttpPost]
    public async Task<IActionResult> Ask([FromBody] string question)
    {
        var messages = new List<ChatMessage>
        {
            new(ChatRole.User, question)
        };

        var response = await _chatService.GetChatResponseAsync(messages);

        return Ok(new
        {
            Answer = response.Message.Text,
            TokensUsed = response.Usage?.TotalTokenCount
        });
    }
}
```

{% endcode %}

## Understanding ChatResponse

The `ChatResponse` object contains:

| Property       | Type                | Description                           |
| -------------- | ------------------- | ------------------------------------- |
| `Message`      | `ChatMessage`       | The AI's response message             |
| `FinishReason` | `ChatFinishReason?` | Why the response ended                |
| `Usage`        | `UsageDetails?`     | Token usage statistics                |
| `ModelId`      | `string?`           | The model that generated the response |

{% code title="ResponseDetails.cs" %}

```csharp
var response = await _chatService.GetChatResponseAsync(messages);

// The response text
string? text = response.Message.Text;

// Why the response finished
ChatFinishReason? reason = response.FinishReason;
// Possible values: Stop, Length, ToolCalls, ContentFilter

// Token usage
if (response.Usage is { } usage)
{
    int? input = usage.InputTokenCount;
    int? output = usage.OutputTokenCount;
    int? total = usage.TotalTokenCount;
}
```

{% endcode %}

## With System Prompt

Add a system message to set the AI's behavior:

{% code title="WithSystemPrompt.cs" %}

```csharp
var messages = new List<ChatMessage>
{
    new(ChatRole.System, "You are a helpful assistant that writes concise answers. " +
                         "Keep responses under 100 words."),
    new(ChatRole.User, "Explain what a CMS is.")
};

var response = await _chatService.GetChatResponseAsync(messages);
```

{% endcode %}

{% hint style="info" %}
System prompts can also be configured in the profile settings, so they're applied automatically without including them in every request.
{% endhint %}

## Multi-Turn Conversation

Include previous messages to maintain context:

{% code title="Conversation.cs" %}

```csharp
public class ConversationService
{
    private readonly IAIChatService _chatService;
    private readonly List<ChatMessage> _history = new();

    public ConversationService(IAIChatService chatService)
    {
        _chatService = chatService;
        _history.Add(new ChatMessage(ChatRole.System,
            "You are a helpful assistant."));
    }

    public async Task<string> SendMessage(string userMessage)
    {
        // Add user message to history
        _history.Add(new ChatMessage(ChatRole.User, userMessage));

        // Send entire conversation
        var response = await _chatService.GetChatResponseAsync(_history);

        // Add assistant response to history
        _history.Add(response.Message);

        return response.Message.Text ?? string.Empty;
    }
}
```

{% endcode %}

## Using a Specific Profile

### By Profile ID

{% code title="ByProfileId.cs" %}

```csharp
public async Task<string> GetResponse(Guid profileId, string question)
{
    var messages = new List<ChatMessage>
    {
        new(ChatRole.User, question)
    };

    var response = await _chatService.GetChatResponseAsync(profileId, messages);

    return response.Message.Text ?? string.Empty;
}
```

{% endcode %}

### By Profile Alias

{% code title="ByProfileAlias.cs" %}

```csharp
public class ProfiledChatService
{
    private readonly IAIChatService _chatService;
    private readonly IAIProfileService _profileService;

    public ProfiledChatService(
        IAIChatService chatService,
        IAIProfileService profileService)
    {
        _chatService = chatService;
        _profileService = profileService;
    }

    public async Task<string> GetCreativeResponse(string prompt)
    {
        var profile = await _profileService.GetProfileByAliasAsync("creative-writer");
        if (profile is null)
        {
            throw new InvalidOperationException("Profile 'creative-writer' not found");
        }

        var messages = new List<ChatMessage>
        {
            new(ChatRole.User, prompt)
        };

        var response = await _chatService.GetChatResponseAsync(profile.Id, messages);

        return response.Message.Text ?? string.Empty;
    }
}
```

{% endcode %}

## Overriding Profile Settings

Pass `ChatOptions` to override profile defaults:

{% code title="WithOptions.cs" %}

```csharp
var messages = new List<ChatMessage>
{
    new(ChatRole.User, "Write a creative tagline for a coffee shop.")
};

var options = new ChatOptions
{
    Temperature = 0.9f,        // More creative
    MaxOutputTokens = 50       // Keep it short
};

var response = await _chatService.GetChatResponseAsync(messages, options);
```

{% endcode %}

## Error Handling

{% code title="ErrorHandling.cs" %}

```csharp
public async Task<string?> SafeGetResponse(string question)
{
    try
    {
        var messages = new List<ChatMessage>
        {
            new(ChatRole.User, question)
        };

        var response = await _chatService.GetChatResponseAsync(messages);
        return response.Message.Text;
    }
    catch (InvalidOperationException ex) when (ex.Message.Contains("profile"))
    {
        // Profile not found or not configured
        _logger.LogError(ex, "Chat profile configuration error");
        return null;
    }
    catch (HttpRequestException ex)
    {
        // Network or API error
        _logger.LogError(ex, "Failed to reach AI provider");
        return null;
    }
}
```

{% endcode %}

## Next Steps

{% content-ref url="streaming.md" %}
[Streaming](streaming.md)
{% endcontent-ref %}

{% content-ref url="system-prompts.md" %}
[System Prompts](system-prompts.md)
{% endcontent-ref %}
