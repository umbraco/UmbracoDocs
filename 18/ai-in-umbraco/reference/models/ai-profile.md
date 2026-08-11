---
description: >-
    Profile configuration for AI model usage.
---

# AIProfile

Represents a profile that combines a connection, model, and settings for a specific use case.

## Namespace

{% code title="Namespace" %}

```csharp
using Umbraco.AI.Core.Profiles;
```

{% endcode %}

## Class Definition

{% code title="AIProfile" %}

```csharp
public sealed class AIProfile : IAIVersionableEntity
{
    public Guid Id { get; internal set; }
    public required string Alias { get; set; }
    public required string Name { get; set; }
    public AICapability Capability { get; init; } = AICapability.Chat;
    public AIModelRef Model { get; set; }
    public required Guid ConnectionId { get; set; }
    public IAIProfileSettings? Settings { get; set; }
    public IReadOnlyList<string> Tags { get; set; } = Array.Empty<string>();
    public int Version { get; internal set; }
    public DateTime DateCreated { get; init; }
    public DateTime DateModified { get; set; }
    public Guid? CreatedByUserId { get; set; }
    public Guid? ModifiedByUserId { get; set; }
}
```

{% endcode %}

## Properties

| Property       | Type                    | Description                             |
| -------------- | ----------------------- | --------------------------------------- |
| `Id`           | `Guid`                  | Unique identifier (assigned on save)    |
| `Alias`        | `string`                | Unique alias for code references        |
| `Name`         | `string`                | Display name                            |
| `Capability`   | `AICapability`          | Type of AI capability (Chat, Embedding, Speech-to-Text) |
| `Model`        | `AIModelRef`            | Reference to provider and model         |
| `ConnectionId` | `Guid`                  | ID of the connection to use             |
| `Settings`     | `IAIProfileSettings?`   | Capability-specific settings            |
| `Tags`         | `IReadOnlyList<string>` | Optional categorization tags            |
| `Version`      | `int`                   | Version number, starts at 1, increments with each save |
| `DateCreated`  | `DateTime`              | Creation timestamp                      |
| `DateModified` | `DateTime`              | Last modification timestamp             |
| `CreatedByUserId` | `Guid?`              | ID of the user who created the profile  |
| `ModifiedByUserId` | `Guid?`             | ID of the user who last modified the profile |

## Settings Types

Settings are polymorphic based on capability.

### AIChatProfileSettings

{% code title="Chat Settings" %}

```csharp
public class AIChatProfileSettings : IAIProfileSettings
{
    public float? Temperature { get; init; }
    public int? MaxTokens { get; init; }
    public string? SystemPromptTemplate { get; init; }
    public IReadOnlyList<Guid> ContextIds { get; init; }
    public IReadOnlyList<Guid> GuardrailIds { get; init; }
}
```

{% endcode %}

| Property               | Type      | Description                                   |
| ---------------------- | --------- | --------------------------------------------- |
| `Temperature`          | `float?`  | Randomness (0.0-1.0, default varies by model) |
| `MaxTokens`            | `int?`    | Maximum response tokens                       |
| `SystemPromptTemplate` | `string?` | Default system prompt                         |
| `ContextIds`           | `IReadOnlyList<Guid>` | Context IDs for injection              |
| `GuardrailIds`         | `IReadOnlyList<Guid>` | Guardrail IDs for safety               |

### AIEmbeddingProfileSettings

{% code title="Embedding Settings" %}

```csharp
public class AIEmbeddingProfileSettings : IAIProfileSettings
{
    public int? Dimensions { get; init; }
}
```

{% endcode %}

| Property     | Type   | Description                                                                    |
| ------------ | ------ | ------------------------------------------------------------------------------ |
| `Dimensions` | `int?` | Number of dimensions for embeddings; uses the model's default when `null`      |

### AISpeechToTextProfileSettings

{% code title="Speech-to-Text Settings" %}

```csharp
public class AISpeechToTextProfileSettings : IAIProfileSettings
{
    public string? Language { get; init; }
}
```

{% endcode %}

| Property   | Type      | Description                                                  |
| ---------- | --------- | ------------------------------------------------------------ |
| `Language` | `string?` | BCP-47 language hint for transcription (e.g., `en`, `de`, `ja`) |

## Creating a Profile

{% code title="Example" %}

```csharp
using Umbraco.AI.Core.Profiles;
using Umbraco.AI.Core.Models;

var profile = new AIProfile
{
    Alias = "content-assistant",
    Name = "Content Assistant",
    Capability = AICapability.Chat,
    Model = new AIModelRef("openai", "gpt-4o"),
    ConnectionId = connectionId,
    Settings = new AIChatProfileSettings
    {
        Temperature = 0.7f,
        MaxTokens = 4096,
        SystemPromptTemplate = "You are a helpful content assistant."
    },
    Tags = new[] { "content", "assistant" }
};

var saved = await profileService.SaveProfileAsync(profile);
```

{% endcode %}

## Notes

- `AIProfile` implements `IAIVersionableEntity` for version tracking
- `Id` is assigned automatically when saving a new profile
- `Version` starts at 1 and increments with each save
- `Capability` is immutable after creation (`init` setter)
- `Alias` must be unique across all profiles
- `ConnectionId` must reference a valid connection with a matching provider
