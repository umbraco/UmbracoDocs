---
description: >-
    Global AI settings configure default profiles and system-wide behavior.
---

# Settings

AI Settings provide a central place to configure system-wide defaults for Umbraco.AI. These settings are stored in the database and managed through the backoffice or programmatically.

## What Settings Store

| Property                    | Description                                                            |
| --------------------------- | ---------------------------------------------------------------------- |
| `Id`                        | Fixed identifier (always the same GUID)                                |
| `DefaultChatProfileId`      | The profile used when no profile is specified for chat operations      |
| `DefaultEmbeddingProfileId` | The profile used when no profile is specified for embedding operations |
| `ClassifierChatProfileId`   | Optional profile for internal classification tasks (e.g., agent routing). Falls back to default chat profile |

{% hint style="info" %}
Settings are a singleton entity - there is only one settings record for the entire application.
{% endhint %}

## Configuring Default Profiles

The recommended way to configure default profiles is through the backoffice. See [Managing Settings](../backoffice/managing-settings.md) for step-by-step instructions.

## Using Settings in Code

### Getting Current Settings

{% code title="Example.cs" %}

```csharp
public class SettingsExample
{
    private readonly IAISettingsService _settingsService;

    public SettingsExample(IAISettingsService settingsService)
    {
        _settingsService = settingsService;
    }

    public async Task<AISettings> GetCurrentSettings()
    {
        return await _settingsService.GetSettingsAsync();
    }
}
```

{% endcode %}

### Updating Settings

{% code title="Example.cs" %}

```csharp
public async Task UpdateDefaultProfile(Guid chatProfileId)
{
    var settings = await _settingsService.GetSettingsAsync();
    settings.DefaultChatProfileId = chatProfileId;
    await _settingsService.SaveSettingsAsync(settings);
}
```

{% endcode %}

## How Default Profiles Work

When you call an AI service without specifying a profile:

1. The service checks for a default profile in AI Settings (database)
2. If not found, an exception is thrown

{% code title="Example.cs" %}

```csharp
// Uses the default chat profile from Settings
var response = await _chatService.GetChatResponseAsync(
    chat => chat.WithAlias("content-chat"),
    messages);

// Explicitly specifies a profile (overrides default)
var response = await _chatService.GetChatResponseAsync(
    chat => chat.WithAlias("content-chat").WithProfile(profileId),
    messages);
```

{% endcode %}

## Classifier Chat Profile

The classifier chat profile is an optional setting that allows you to designate a cheaper or faster model for internal classification tasks. Currently, this is used by the Copilot's "Auto" agent mode to classify user prompts and route them to the best available agent.

### Fallback Chain

When the classifier profile is requested:

1. **Database settings** — `ClassifierChatProfileId` (configured in backoffice)
2. **Configuration file** — `ClassifierChatProfileAlias` in `appsettings.json`
3. **Default chat profile** — Falls back to the standard default chat profile

The fallback chain means you only need to configure the classifier profile if you want to use a different (typically cheaper) model for classification. If not set, the default chat profile is used automatically.

## Configuration File Fallback

For advanced scenarios like Continuous Integration/Continuous Deployment (CI/CD) pipelines or infrastructure-as-code, you can configure defaults via `appsettings.json`:

{% code title="appsettings.json" %}

```json
{
    "Umbraco": {
        "AI": {
            "DefaultChatProfileAlias": "content-writer",
            "DefaultEmbeddingProfileAlias": "embeddings",
            "ClassifierChatProfileAlias": "fast-classifier"
        }
    }
}
```

{% endcode %}

{% hint style="warning" %}
Database settings (configured via backoffice) take precedence over configuration file settings. Use configuration files only when you need environment-specific defaults that can't be managed through the backoffice.
{% endhint %}

## Managing Settings

### Via Backoffice

You can configure settings through the backoffice. See [Managing Settings](../backoffice/managing-settings.md) for step-by-step instructions.

### Via Management API

{% code title="Management API endpoints" %}

```http
GET /umbraco/management/api/v1/ai/settings
PUT /umbraco/management/api/v1/ai/settings
```

{% endcode %}

See [Settings API](../management-api/settings/README.md) for details.

## Related

- [Profiles](profiles.md) - The profiles that can be set as defaults
- [Managing Settings](../backoffice/managing-settings.md) - Backoffice guide
