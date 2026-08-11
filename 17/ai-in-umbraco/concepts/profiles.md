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
| `Capability`   | The type of AI capability (Chat, Embedding, Speech-to-Text, and so on) |
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

| Setting      | Description                                                               | Type |
| ------------ | ------------------------------------------------------------------------- | ---- |
| `Dimensions` | Number of dimensions for the generated embeddings (model default if null) | int  |

### Speech-to-Text Profiles

| Setting    | Description                                                | Type   |
| ---------- | ---------------------------------------------------------- | ------ |
| `Language` | BCP-47 language hint for transcription (e.g., "en", "de") | string |

## Example Profile Configurations

| Profile          | Use Case        | Model                  | Temperature | System Prompt                         |
| ---------------- | --------------- | ---------------------- | ----------- | ------------------------------------- |
| `content-writer` | Blog posts      | gpt-4o                 | 0.8         | "You are a helpful content writer..." |
| `code-assistant` | Code help       | gpt-4o                 | 0.2         | "You are a code assistant..."         |
| `translator`     | Translation     | gpt-4o-mini            | 0.3         | "Translate to {language}..."          |
| `embeddings`     | Search indexing | text-embedding-3-small | -           | -                                     |

## Using Profiles in Code

### Default Profile

Configure a default profile through the backoffice. See [Managing Settings](../backoffice/managing-settings.md) for details.

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

Pass the profile alias (or ID) to `WithProfile`:

{% code title="Example.cs" %}

```csharp
var response = await _chatService.GetChatResponseAsync(
    chat => chat.WithAlias("code-assistant").WithProfile("code-assistant"),
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

When you make a request, the profile is resolved by ID or alias and its connection, model, and settings are applied as defaults. Any request-specific options override these defaults, and then middleware is applied before the request is sent.

## Managing Profiles

### Via Backoffice

You can create, edit, and delete profiles through the backoffice. See [Managing Profiles](../backoffice/managing-profiles.md) for step-by-step instructions.

### Via Code

For programmatic profile management, see the [IAIProfileService](../reference/services/ai-profile-service.md) reference.

## Related

- [Connections](connections.md) - Provide credentials for profiles
- [Capabilities](capabilities.md) - Determine available profile types
- [Using the Chat API](../using-the-api/chat/README.md) - Use profiles for chat
