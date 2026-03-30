---
description: >-
    Configure default profiles and provider settings for Umbraco.AI.
---

# Configuration

After creating your first profile, you can configure default profiles and provider-specific settings.

## Setting Default Profiles

Default profiles determine which profile is used when calling AI services without specifying a profile ID. Configure defaults through the backoffice:

1. Navigate to the **AI** section > **Settings**
2. Select your default chat profile from the dropdown
3. Select your default embedding profile (if applicable)
4. Click **Save**

{% hint style="info" %}
See [Managing Settings](../backoffice/managing-settings.md) for detailed instructions.
{% endhint %}

## How Default Profiles Work

When you call `IAIChatService.GetChatResponseAsync()` without specifying a profile ID, the service uses the default profile configured in Settings.

{% code title="DefaultProfileUsage.cs" %}

```csharp
// Uses the default chat profile configured in Settings
var response = await _chatService.GetChatResponseAsync(
    chat => chat.WithAlias("content-chat"),
    messages);

// Or explicitly specify a profile
var response = await _chatService.GetChatResponseAsync(
    chat => chat.WithAlias("content-chat").WithProfile(profileId),
    messages);
```

{% endcode %}

{% hint style="warning" %}
If you call a method without specifying a profile and no default is configured, the service throws an exception. Either configure defaults or always specify profile IDs.
{% endhint %}

## Provider-Specific Configuration

Some providers support reading API keys from configuration. The system resolves values prefixed with `$` in connection settings from configuration.

{% code title="appsettings.json" %}

```json
{
    "OpenAI": {
        "ApiKey": "sk-..."
    }
}
```

{% endcode %}

When creating a connection in the backoffice, you can enter `$OpenAI:ApiKey` as the API key value. This resolves to the actual key from configuration at runtime.

{% hint style="info" %}
Using configuration references keeps sensitive values out of the database and allows different values per environment.
{% endhint %}

## Environment-Specific Configuration

Use standard .NET configuration patterns for environment-specific settings:

- `appsettings.Development.json` - Development settings
- `appsettings.Production.json` - Production settings
- Environment variables
- User secrets (for local development)

## Programmatic Settings

You can also configure default profiles programmatically:

{% code title="SettingsService.cs" %}

```csharp
public class SettingsExample
{
    private readonly IAISettingsService _settingsService;

    public SettingsExample(IAISettingsService settingsService)
    {
        _settingsService = settingsService;
    }

    public async Task SetDefaultChatProfile(Guid profileId)
    {
        var settings = await _settingsService.GetSettingsAsync();
        settings.DefaultChatProfileId = profileId;
        await _settingsService.SaveSettingsAsync(settings);
    }
}
```

{% endcode %}

## Next Steps

Learn more about using the chat API:

{% content-ref url="../using-the-api/chat/README.md" %}
[Chat](../using-the-api/chat/README.md)
{% endcontent-ref %}

Or explore the core concepts:

{% content-ref url="../concepts/README.md" %}
[Core Concepts](../concepts/README.md)
{% endcontent-ref %}
