---
description: >-
    Model representing global AI settings.
---

# AISettings

Represents the global AI configuration settings, including default profiles.

## Namespace

```csharp
using Umbraco.AI.Core.Settings;
```

## Definition

{% code title="AISettings" %}

```csharp
public class AISettings : IAIAuditableEntity
{
    // Fixed settings ID (singleton)
    public static readonly Guid SettingsId = Guid.Parse("672BF83C-97E0-4D04-9D33-23FC2E5EBE42");

    public Guid Id => SettingsId;

    [AISetting]
    public Guid? DefaultChatProfileId { get; set; }

    [AISetting]
    public Guid? DefaultEmbeddingProfileId { get; set; }

    [AISetting]
    public Guid? ClassifierChatProfileId { get; set; }

    // Audit properties
    public DateTime DateCreated { get; init; } = DateTime.UtcNow;
    public DateTime DateModified { get; set; } = DateTime.UtcNow;
    public Guid? CreatedByUserId { get; init; }
    public Guid? ModifiedByUserId { get; set; }
}
```

{% endcode %}

## Properties

| Property                    | Type       | Description                              |
| --------------------------- | ---------- | ---------------------------------------- |
| `Id`                        | `Guid`     | Fixed identifier (always the same value) |
| `DefaultChatProfileId`      | `Guid?`    | Default profile for chat operations      |
| `DefaultEmbeddingProfileId` | `Guid?`    | Default profile for embedding operations |
| `ClassifierChatProfileId`   | `Guid?`    | Optional profile for classification tasks (falls back to default chat) |
| `DateCreated`               | `DateTime` | When settings were first created         |
| `DateModified`              | `DateTime` | When settings were last modified         |
| `CreatedByUserId`           | `Guid?`    | User who created                         |
| `ModifiedByUserId`          | `Guid?`    | User who last modified                   |

## Notes

- Settings use a singleton pattern with a fixed ID
- The `[AISetting]` attribute marks properties that are persisted to the database
- Settings are not versionable

## Example

{% code title="Example" %}

```csharp
// Get current settings
var settings = await _settingsService.GetSettingsAsync();

// Update default profiles
settings.DefaultChatProfileId = chatProfileId;
settings.DefaultEmbeddingProfileId = embeddingProfileId;

// Save
await _settingsService.SaveSettingsAsync(settings);
```

{% endcode %}

## Related

- [IAISettingsService](../services/ai-settings-service.md) - Settings service
- [Settings Concept](../../concepts/settings.md) - Settings concepts
