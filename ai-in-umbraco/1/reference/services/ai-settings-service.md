---
description: >-
    Service for managing global AI settings.
---

# IAISettingsService

Service for reading and updating global AI settings such as default profiles.

## Namespace

```csharp
using Umbraco.AI.Core.Settings;
```

## Interface

{% code title="IAISettingsService" %}

```csharp
public interface IAISettingsService
{
    Task<AISettings> GetSettingsAsync(CancellationToken cancellationToken = default);

    Task<AISettings> SaveSettingsAsync(AISettings settings, CancellationToken cancellationToken = default);
}
```

{% endcode %}

## Methods

### GetSettingsAsync

Gets the current global AI settings.

| Parameter           | Type                | Description        |
| ------------------- | ------------------- | ------------------ |
| `cancellationToken` | `CancellationToken` | Cancellation token |

**Returns**: The current settings. Creates default settings if none exist.

{% code title="Example" %}

```csharp
var settings = await _settingsService.GetSettingsAsync();

if (settings.DefaultChatProfileId.HasValue)
{
    Console.WriteLine($"Default chat profile: {settings.DefaultChatProfileId}");
}
else
{
    Console.WriteLine("No default chat profile configured");
}
```

{% endcode %}

### SaveSettingsAsync

Updates the global AI settings.

| Parameter           | Type                | Description          |
| ------------------- | ------------------- | -------------------- |
| `settings`          | `AISettings`        | The settings to save |
| `cancellationToken` | `CancellationToken` | Cancellation token   |

**Returns**: The saved settings with audit properties updated.

{% code title="Example" %}

```csharp
var settings = await _settingsService.GetSettingsAsync();
settings.DefaultChatProfileId = chatProfileId;
settings.DefaultEmbeddingProfileId = embeddingProfileId;

var saved = await _settingsService.SaveSettingsAsync(settings);
Console.WriteLine($"Settings updated at {saved.DateModified}");
```

{% endcode %}

## Usage Example

{% code title="SettingsManager.cs" %}

```csharp
public class SettingsManager
{
    private readonly IAISettingsService _settingsService;
    private readonly IAIProfileService _profileService;

    public SettingsManager(
        IAISettingsService settingsService,
        IAIProfileService profileService)
    {
        _settingsService = settingsService;
        _profileService = profileService;
    }

    public async Task SetDefaultChatProfileAsync(string profileAlias)
    {
        var profile = await _profileService.GetProfileByAliasAsync(profileAlias);
        if (profile == null)
        {
            throw new ArgumentException($"Profile '{profileAlias}' not found");
        }

        if (profile.Capability != AICapability.Chat)
        {
            throw new ArgumentException($"Profile '{profileAlias}' is not a chat profile");
        }

        var settings = await _settingsService.GetSettingsAsync();
        settings.DefaultChatProfileId = profile.Id;
        await _settingsService.SaveSettingsAsync(settings);
    }

    public async Task ClearDefaultsAsync()
    {
        var settings = await _settingsService.GetSettingsAsync();
        settings.DefaultChatProfileId = null;
        settings.DefaultEmbeddingProfileId = null;
        await _settingsService.SaveSettingsAsync(settings);
    }
}
```

{% endcode %}

## Notes

- Settings use a singleton pattern - there is always exactly one settings record
- Changes to settings are tracked in the audit log
- Settings are cached for performance; cache is invalidated on save

## Related

- [AISettings](../models/ai-settings.md) - The settings model
- [Settings Concept](../../concepts/settings.md) - Settings concepts
