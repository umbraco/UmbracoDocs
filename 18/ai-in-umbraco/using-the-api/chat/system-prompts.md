---
description: >-
    Control AI behavior with system prompts in chat requests.
---

# System Prompts

System prompts set the AI model's role, personality, and constraints. They are sent as the first message in a conversation and shape how the model responds to all subsequent messages.

## Adding a System Prompt

Include a `ChatRole.System` message at the start of your messages list:

{% code title="SystemPrompt.cs" %}

```csharp
var messages = new List<ChatMessage>
{
    new(ChatRole.System, "You are a helpful content editor for an Umbraco website. " +
                         "Always respond in a professional tone. " +
                         "Keep answers concise and actionable."),
    new(ChatRole.User, "Suggest a better title for my blog post about CMS platforms.")
};

var response = await _chatService.GetChatResponseAsync(
    chat => chat.WithAlias("content-editor"),
    messages);
```

{% endcode %}

## Profile-Level System Prompts

Rather than including system prompts in every request, configure them on the profile. The system prompt is then applied automatically:

{% code title="ProfileSystemPrompt.cs" %}

```csharp
var profile = new AIProfile
{
    Alias = "content-assistant",
    Name = "Content Assistant",
    Capability = AICapability.Chat,
    ConnectionId = connectionId,
    Model = new AIModelRef("openai", "gpt-4o"),
    Settings = new AIChatProfileSettings
    {
        SystemPromptTemplate = "You are a content assistant for an Umbraco website. " +
                               "Help editors write engaging content."
    }
};

await _profileService.SaveProfileAsync(profile);
```

{% endcode %}

When using this profile, the system prompt is injected automatically. You only need to send user messages:

{% code title="UsingProfilePrompt.cs" %}

```csharp
var messages = new List<ChatMessage>
{
    new(ChatRole.User, "Write a meta description for our About page.")
};

// The profile's system prompt is prepended automatically
var response = await _chatService.GetChatResponseAsync(
    chat => chat.WithAlias("content-assistant").WithProfile(profileId),
    messages);
```

{% endcode %}

{% hint style="info" %}
If you include a system message in your request and the profile also has a system prompt, both are sent. The profile's system prompt comes first.
{% endhint %}

## System Prompt Best Practices

1. **Be specific about the role** - "You are a content editor" is better than "You are helpful"
2. **Set constraints early** - Include tone, length, and format requirements
3. **Use profiles for reuse** - Configure system prompts on profiles rather than hardcoding them in every request

## Related

- [Basic Chat](basic-chat.md) - Sending chat requests
- [Profiles](../../concepts/profiles.md) - Configuring profile settings
