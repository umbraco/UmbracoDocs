---
description: >-
    Configuration options for Umbraco.AI.
---

# Configuration

Umbraco.AI supports configuration through both the backoffice and `appsettings.json`.

## Default Profiles

The recommended way to configure default profiles is through the backoffice:

1. Navigate to the **AI** section > **Settings**
2. Select your default chat profile
3. Select your default embedding profile
4. Click **Save**

For advanced scenarios (CI/CD, infrastructure-as-code), you can configure defaults in `appsettings.json` as a fallback:

{% code title="appsettings.json" %}

```json
{
    "Umbraco": {
        "AI": {
            "DefaultChatProfileAlias": "default-chat",
            "DefaultEmbeddingProfileAlias": "default-embedding"
        }
    }
}
```

{% endcode %}

{% hint style="info" %}
Database settings (configured via backoffice) take precedence over configuration file settings.
{% endhint %}

## Available Options

| Class                      | Description                            |
| -------------------------- | -------------------------------------- |
| [AIOptions](ai-options.md) | Configuration file settings (fallback) |

## Provider Credentials

Store provider credentials in configuration and reference them in connections:

{% code title="appsettings.json" %}

```json
{
    "OpenAI": {
        "ApiKey": "sk-your-api-key-here"
    },
    "Azure": {
        "ApiKey": "your-azure-key",
        "Endpoint": "https://your-resource.openai.azure.com"
    }
}
```

{% endcode %}

Reference these in connection settings using the `$` prefix:

- `$OpenAI:ApiKey` - Resolves to the OpenAI API key
- `$Azure:Endpoint` - Resolves to the Azure endpoint

## Environment-Specific Configuration

Use environment-specific files for different settings:

```
appsettings.json              # Base configuration
appsettings.Development.json  # Development overrides
appsettings.Production.json   # Production overrides
```

{% hint style="warning" %}
Never commit API keys to source control. Use environment variables, user secrets, or Azure Key Vault for production.
{% endhint %}

## Related

- [Settings Concept](../../concepts/settings.md) - Primary way to configure defaults
- [Managing Settings](../../backoffice/managing-settings.md) - Backoffice configuration

## In This Section

{% content-ref url="ai-options.md" %}
[AIOptions](ai-options.md)
{% endcontent-ref %}
