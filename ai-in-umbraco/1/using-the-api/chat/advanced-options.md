---
description: >-
    Fine-tune AI responses with ChatOptions for temperature, token limits, and more.
---

# Advanced Options

Override profile defaults on a per-request basis using `ChatOptions`. These options are passed directly to the AI provider.

## ChatOptions

Pass `ChatOptions` as the second parameter to any chat method:

{% code title="WithOptions.cs" %}

```csharp
var messages = new List<ChatMessage>
{
    new(ChatRole.User, "Write three tagline options for a coffee shop.")
};

var options = new ChatOptions
{
    Temperature = 0.9f,
    MaxOutputTokens = 200,
    TopP = 0.95f,
    StopSequences = ["---"]
};

var response = await _chatService.GetChatResponseAsync(
    chat => chat.WithAlias("tagline-writer").WithChatOptions(options),
    messages);
```

{% endcode %}

## Available Options

| Option | Type | Description |
| --- | --- | --- |
| `Temperature` | `float?` | Controls randomness (0 = deterministic, 1 = creative) |
| `MaxOutputTokens` | `int?` | Maximum tokens in the response |
| `TopP` | `float?` | Nucleus sampling threshold |
| `StopSequences` | `IList<string>?` | Sequences that stop generation |
| `FrequencyPenalty` | `float?` | Penalizes repeated tokens |
| `PresencePenalty` | `float?` | Penalizes tokens already present |
| `Seed` | `long?` | Seed for reproducible outputs |
| `ResponseFormat` | `ChatResponseFormat?` | Request JSON or text output |

{% hint style="info" %}
Not all providers support every option. Unsupported options are ignored. Check the provider documentation for supported parameters.
{% endhint %}

## Requesting JSON Output

Use `ChatResponseFormat` to request structured JSON responses:

{% code title="JsonResponse.cs" %}

```csharp
var options = new ChatOptions
{
    ResponseFormat = ChatResponseFormat.Json
};

var messages = new List<ChatMessage>
{
    new(ChatRole.System, "Return a JSON object with 'title' and 'summary' fields."),
    new(ChatRole.User, "Describe Umbraco CMS.")
};

var response = await _chatService.GetChatResponseAsync(
    chat => chat.WithAlias("json-responder").WithChatOptions(options),
    messages);
// response.Message.Text contains JSON: {"title": "...", "summary": "..."}
```

{% endcode %}

## Combining with Profiles

Options override profile settings for that request only. The profile settings remain unchanged:

{% code title="Override.cs" %}

```csharp
// Profile has Temperature = 0.7
var options = new ChatOptions
{
    Temperature = 0.2f  // Override to more deterministic for this request
};

var response = await _chatService.GetChatResponseAsync(
    chat => chat.WithAlias("profile-example").WithProfile(profileId).WithChatOptions(options),
    messages);
```

{% endcode %}

## Related

- [Basic Chat](basic-chat.md) - Sending chat requests
- [Streaming](streaming.md) - Streaming with options
- [Profiles](../../concepts/profiles.md) - Default profile settings
