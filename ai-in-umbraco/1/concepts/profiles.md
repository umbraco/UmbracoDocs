---
description: >-
    Profiles combine a connection with model settings to create reusable AI configurations.
---

# Profiles

A profile is a named configuration that combines a connection with specific model settings. Profiles let you create reusable AI configurations for different use cases.

## What Profiles Store

| Property       | Description                                            |
| -------------- | ------------------------------------------------------ |
| `Id`           | Unique identifier (GUID)                               |
| `Alias`        | Unique string for programmatic lookup                  |
| `Name`         | Display name shown in the backoffice                   |
| `Capability`   | The type of AI capability (Chat, Embedding, and so on) |
| `ConnectionId` | Which connection provides credentials                  |
| `Model`        | The specific AI model to use                           |
| `Settings`     | Capability-specific settings                           |
| `Tags`         | Optional tags for organization                         |

## Profile Settings by Capability

### Chat Profiles

| Setting                | Description                          | Type   |
| ---------------------- | ------------------------------------ | ------ |
| `Temperature`          | Controls randomness (0-2)            | float  |
| `MaxTokens`            | Maximum response length              | int    |
| `SystemPromptTemplate` | Instructions sent with every request | string |

### Embedding Profiles

Embedding profiles currently use model defaults. Additional settings may be added in future releases.

## Why Use Profiles

Profiles provide these benefits:

- **Consistency** - Same settings across your application
- **Reusability** - Configure once, use everywhere
- **Separation** - Different profiles for different tasks
- **Manageability** - Change settings without code changes

## Example Profile Configurations

| Profile          | Use Case        | Model                  | Temperature | System Prompt                         |
| ---------------- | --------------- | ---------------------- | ----------- | ------------------------------------- |
| `content-writer` | Blog posts      | gpt-4o                 | 0.8         | "You are a helpful content writer..." |
| `code-assistant` | Code help       | gpt-4o                 | 0.2         | "You are a code assistant..."         |
| `translator`     | Translation     | gpt-4o-mini            | 0.3         | "Translate to {language}..."          |
| `embeddings`     | Search indexing | text-embedding-3-small | -           | -                                     |

## Using Profiles in Code

### Default Profile

Configure a default profile through the backoffice:

1. Navigate to the **AI** section > **Settings**
2. Select "content-writer" via the **Default Chat Profile** picker
3. Click **Save**

Then use the service without specifying a profile:

{% code title="Example.cs" %}

```csharp
// Uses the default profile configured in Settings
var response = await _chatService.GetChatResponseAsync(
    chat => chat.WithAlias("content-chat"),
    messages);
```

{% endcode %}

### Named Profile

Look up and use a specific profile:

{% code title="Example.cs" %}

```csharp
var profile = await _profileService.GetProfileByAliasAsync("code-assistant");
var response = await _chatService.GetChatResponseAsync(
    chat => chat.WithAlias("code-assistant").WithProfile(profile!.Id),
    messages);
```

{% endcode %}

### Override Settings

Profile settings are defaults that can be overridden per-request:

{% code title="Example.cs" %}

```csharp
var options = new ChatOptions
{
    Temperature = 0.9f,  // Override profile's temperature
    MaxOutputTokens = 500
};

var response = await _chatService.GetChatResponseAsync(
    chat => chat.WithAlias("content-chat").WithChatOptions(options),
    messages);
```

{% endcode %}

## Profile Resolution

When you make a request:

1. Profile is resolved by ID or alias
2. Connection is retrieved for credentials
3. Model is selected from the profile
4. Settings are applied as defaults
5. Request-specific options override defaults
6. Middleware is applied
7. Request is sent

## Managing Profiles

### Via Backoffice

1. Navigate to the **AI** section > **Profiles**
2. Create, edit, or delete profiles through the UI

### Via Code

{% code title="Example.cs" %}

```csharp
public class ProfileManagement
{
    private readonly IAIProfileService _profileService;

    public ProfileManagement(IAIProfileService profileService)
    {
        _profileService = profileService;
    }

    public async Task<AIProfile> CreateProfile()
    {
        var profile = new AIProfile
        {
            Alias = "new-profile",
            Name = "New Profile",
            Capability = AICapability.Chat,
            ConnectionId = connectionId,
            Model = new AIModelRef("openai", "gpt-4o"),
            Settings = new AIChatProfileSettings
            {
                Temperature = 0.7f
            }
        };

        return await _profileService.SaveProfileAsync(profile);
    }
}
```

{% endcode %}

## Related

- [Connections](connections.md) - Provide credentials for profiles
- [Capabilities](capabilities.md) - Determine available profile types
- [Using the Chat API](../using-the-api/chat/README.md) - Use profiles for chat
