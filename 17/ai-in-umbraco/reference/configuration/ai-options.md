---
description: >-
    Configuration options for AI services (fallback mechanism).
---

# AIOptions

Configuration options for Umbraco.AI services, bound from `appsettings.json`. These serve as a fallback when database settings are not configured.

{% hint style="info" %}
The recommended way to configure default profiles is through the backoffice (**Settings** > **AI** > **Settings**). Use `appsettings.json` only for advanced scenarios like CI/CD pipelines or infrastructure-as-code where database settings cannot be used.
{% endhint %}

## Namespace

{% code title="Namespace" %}

```csharp
using Umbraco.AI.Core.Models;
```

{% endcode %}

## Class Definition

{% code title="AIOptions" %}

```csharp
public class AIOptions
{
    public string? DefaultChatProfileAlias { get; set; }
    public string? DefaultEmbeddingProfileAlias { get; set; }
    public string? ClassifierChatProfileAlias { get; set; }
    public string? DefaultSpeechToTextProfileAlias { get; set; }
    public string? DefaultImageGenerationProfileAlias { get; set; }

    public IList<string> AllowedConfigurationKeyPrefixes { get; set; } = new List<string>
    {
        "Umbraco:AI:Secrets",
        "Umbraco:AI:Variables",
    };

    public IList<string> SecretConfigurationKeyPrefixes { get; set; } = new List<string>
    {
        "Umbraco:AI:Secrets",
    };
}
```

{% endcode %}

## Properties

| Property                          | Type      | Description                                             |
| --------------------------------- | --------- | ------------------------------------------------------- |
| `DefaultChatProfileAlias`         | `string?` | Fallback default profile alias for chat operations      |
| `DefaultEmbeddingProfileAlias`    | `string?` | Fallback default profile alias for embeddings           |
| `ClassifierChatProfileAlias`      | `string?` | Fallback profile alias for classification tasks         |
| `DefaultSpeechToTextProfileAlias` | `string?` | Fallback default profile alias for speech-to-text       |
| `DefaultImageGenerationProfileAlias` | `string?` | Fallback default profile alias for image generation (experimental) |
| `AllowedConfigurationKeyPrefixes` | `IList<string>` | Configuration sections that settings may resolve via `$` references. Defaults to `Umbraco:AI:Secrets` and `Umbraco:AI:Variables` |
| `SecretConfigurationKeyPrefixes`  | `IList<string>` | The subset of allowed prefixes treated as secret. Values under these may only be referenced from sensitive fields. Defaults to `Umbraco:AI:Secrets` |

## Configuration

{% code title="appsettings.json" %}

```json
{
    "Umbraco": {
        "AI": {
            "DefaultChatProfileAlias": "content-assistant",
            "DefaultEmbeddingProfileAlias": "document-embeddings",
            "ClassifierChatProfileAlias": "fast-classifier",
            "DefaultSpeechToTextProfileAlias": "voice-transcription"
        }
    }
}
```

{% endcode %}

## Experimental Features

Experimental capabilities are hidden and inert until enabled under the `Umbraco:AI:Experimental` section. Each flag defaults to `false`.

{% code title="appsettings.json" %}

```json
{
    "Umbraco": {
        "AI": {
            "Experimental": {
                "ImageGeneration": true
            }
        }
    }
}
```

{% endcode %}

| Flag | Default | Description |
| --- | --- | --- |
| `ImageGeneration` | `false` | Enables the [Image Generation](../../using-the-api/image-generation/README.md) capability. When off, the capability is hidden from discovery, not selectable in the profile editor, and its REST endpoint returns 404. |

## Configuration References

Editable model settings (such as connection API keys) support a `$Key:Path` syntax that resolves to a configuration value at runtime, letting you keep credentials and per-environment values in configuration rather than the database. For example, a connection's API Key field set to `$Umbraco:AI:Secrets:OpenAIApiKey` reads from:

{% code title="appsettings.json" %}

```json
{
    "Umbraco": {
        "AI": {
            "Secrets": {
                "OpenAIApiKey": "sk-your-actual-key"
            },
            "Variables": {
                "OpenAIEndpoint": "https://api.openai.com/v1"
            }
        }
    }
}
```

{% endcode %}

References resolve only from the sections listed in `AllowedConfigurationKeyPrefixes`. Two sections are allowed by default:

- `Umbraco:AI:Secrets` - for sensitive values (API keys, tokens). Listed in `SecretConfigurationKeyPrefixes`, so these values may only be referenced from settings fields marked `[AIField(IsSensitive = true)]`.
- `Umbraco:AI:Variables` - for non-sensitive per-environment values (endpoints, IDs, flags). These may be referenced from any field.

Prefix matching is segment-aware and case-insensitive: `Umbraco:AI:Secrets` permits `Umbraco:AI:Secrets:OpenAIApiKey` but not `Umbraco:AI:SecretsBackup:Key`.

To reference values that already live in another configuration section, add that section's prefix to `AllowedConfigurationKeyPrefixes`:

{% code title="appsettings.json" %}

```json
{
    "Umbraco": {
        "AI": {
            "AllowedConfigurationKeyPrefixes": [
                "Umbraco:AI:Secrets",
                "Umbraco:AI:Variables",
                "OpenAI"
            ]
        }
    }
}
```

{% endcode %}

{% hint style="info" %}
`AllowedConfigurationKeyPrefixes` and `SecretConfigurationKeyPrefixes` are configured in `appsettings.json` only - they are not editable from the backoffice.
{% endhint %}

## Precedence

Database settings (configured via backoffice) take precedence over configuration file settings:

1. **Database settings** - Configured in backoffice (primary)
2. **Configuration file** - `appsettings.json` (fallback)

## Usage

### Setting Defaults

When you call `IAIChatService.GetChatResponseAsync()` without specifying a profile ID, it first checks for a default in database settings. If not found, it falls back to the profile with the alias specified in `DefaultChatProfileAlias`.

{% code title="Example" %}

```csharp
// Uses the default chat profile (database settings or appsettings.json fallback)
var response = await _chatService.GetChatResponseAsync(
    chat => chat.WithAlias("content-chat"),
    messages);

// Uses a specific profile
var response = await _chatService.GetChatResponseAsync(
    chat => chat.WithAlias("content-chat").WithProfile(specificProfileId),
    messages);
```

{% endcode %}

### Accessing Options

You can inject `IOptions<AIOptions>` to access configuration:

{% code title="Example" %}

```csharp
using Microsoft.Extensions.Options;
using Umbraco.AI.Core.Models;

public class MyService
{
    private readonly AIOptions _options;

    public MyService(IOptions<AIOptions> options)
    {
        _options = options.Value;
    }

    public void LogDefaults()
    {
        Console.WriteLine($"Default chat: {_options.DefaultChatProfileAlias}");
        Console.WriteLine($"Default embedding: {_options.DefaultEmbeddingProfileAlias}");
    }
}
```

{% endcode %}

## Behavior When Not Set

If default profiles are not configured in either database settings or configuration files:

1. **Chat**: Throws `InvalidOperationException` when calling methods without a profile ID
2. **Embedding**: Throws `InvalidOperationException` when calling methods without a profile ID

{% hint style="warning" %}
Always configure default profiles if your application uses the simplified service methods that don't require explicit profile IDs.
{% endhint %}

## Environment Variables

Override configuration via environment variables:

{% code title="Environment Variables" %}

```bash
export Umbraco__AI__DefaultChatProfileAlias=production-chat
export Umbraco__AI__DefaultEmbeddingProfileAlias=production-embedding
export Umbraco__AI__ClassifierChatProfileAlias=fast-classifier
export Umbraco__AI__DefaultSpeechToTextProfileAlias=production-speech
```

{% endcode %}

Note the double underscores (`__`) as section separators.

## Related

- [Settings Concept](../../concepts/settings.md) - Primary way to configure defaults
- [Managing Settings](../../backoffice/managing-settings.md) - Backoffice configuration
