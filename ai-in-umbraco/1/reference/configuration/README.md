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

| Class                      | Section                         | Description                                       |
| -------------------------- | ------------------------------- | ------------------------------------------------- |
| [AIOptions](ai-options.md) | `Umbraco:AI`                    | Default profile aliases (fallback)                |
| `AIAuditLogOptions`        | `Umbraco:AI:AuditLog`           | Audit log persistence and retention               |
| `AIAnalyticsOptions`       | `Umbraco:AI:Analytics`          | Usage analytics retention and dimensions          |
| `AIVersionCleanupPolicy`   | `Umbraco:AI:VersionCleanupPolicy` | Version history cleanup                        |
| `AIMediaOptions`           | `Umbraco:AI:Media`              | Image downscaling for AI media resolution         |
| `AIWebFetchOptions`        | `Umbraco:AI:Tools:WebFetch`     | Web fetch tool limits and caching                 |
| `AIAgentOptions`           | `Umbraco:AI:Agent`              | Agent file retention                              |

`AIAuditLogOptions` is documented on the [Audit Logs](../../backoffice/audit-logs.md) page. `AIAnalyticsOptions` is documented on the [Usage Analytics](../../backoffice/usage-analytics.md) page. `AIVersionCleanupPolicy` is documented on the [Version History](../../backoffice/version-history.md) page.

## Media

Configure how images are resolved and downscaled before being sent to AI providers. Most providers enforce hard limits on image payload size and pixel dimensions (for example, Anthropic Claude rejects images above 5 MB).

{% code title="AIMediaOptions" %}

```csharp
public class AIMediaOptions
{
    public bool AutoDownscale { get; set; } = true;
    public long MaxSizeBytes { get; set; } = 4 * 1024 * 1024;
    public int MaxDimension { get; set; } = 2048;
    public int JpegQuality { get; set; } = 85;
}
```

{% endcode %}

| Property        | Type   | Default     | Description                                                         |
| --------------- | ------ | ----------- | ------------------------------------------------------------------- |
| `AutoDownscale` | `bool` | `true`      | Automatically downscale oversized images before sending to providers |
| `MaxSizeBytes`  | `long` | `4194304`   | Maximum image payload size in bytes (4 MB) before re-encoding       |
| `MaxDimension`  | `int`  | `2048`      | Maximum pixel dimension (longest edge) before proportional resizing |
| `JpegQuality`   | `int`  | `85`        | JPEG quality (1-100) used when re-encoding oversized images         |

{% code title="appsettings.json" %}

```json
{
    "Umbraco": {
        "AI": {
            "Media": {
                "AutoDownscale": true,
                "MaxSizeBytes": 4194304,
                "MaxDimension": 2048,
                "JpegQuality": 85
            }
        }
    }
}
```

{% endcode %}

## Web Fetch Tool

Configure the built-in web fetch tool that agents can use to retrieve content from URLs. Use the allow and block lists to restrict which domains can be fetched.

{% code title="AIWebFetchOptions" %}

```csharp
public class AIWebFetchOptions
{
    public bool Enabled { get; set; } = true;
    public long MaxResponseSizeBytes { get; set; } = 5 * 1024 * 1024;
    public int TimeoutSeconds { get; set; } = 30;
    public int MaxRedirects { get; set; } = 5;
    public List<string> AllowedDomains { get; set; } = new();
    public List<string> BlockedDomains { get; set; } = new();
    public bool EnableCaching { get; set; } = true;
    public int CacheDurationMinutes { get; set; } = 60;
}
```

{% endcode %}

| Property               | Type           | Default    | Description                                                    |
| ---------------------- | -------------- | ---------- | -------------------------------------------------------------- |
| `Enabled`              | `bool`         | `true`     | Whether the web fetch tool is enabled                          |
| `MaxResponseSizeBytes` | `long`         | `5242880`  | Maximum response size in bytes (5 MB)                          |
| `TimeoutSeconds`       | `int`          | `30`       | Request timeout in seconds                                     |
| `MaxRedirects`         | `int`          | `5`        | Maximum number of redirects to follow                          |
| `AllowedDomains`       | `List<string>` | `[]`       | Domain allow list (empty means no allow list filtering)        |
| `BlockedDomains`       | `List<string>` | `[]`       | Domain block list (blocks specific domains even if allowed)    |
| `EnableCaching`        | `bool`         | `true`     | Whether fetched content is cached                              |
| `CacheDurationMinutes` | `int`          | `60`       | Cache duration in minutes                                      |

{% code title="appsettings.json" %}

```json
{
    "Umbraco": {
        "AI": {
            "Tools": {
                "WebFetch": {
                    "Enabled": true,
                    "MaxResponseSizeBytes": 5242880,
                    "TimeoutSeconds": 30,
                    "MaxRedirects": 5,
                    "AllowedDomains": [],
                    "BlockedDomains": [],
                    "EnableCaching": true,
                    "CacheDurationMinutes": 60
                }
            }
        }
    }
}
```

{% endcode %}

## Agent

Configure the Agent Runtime add-on. Available when the `Umbraco.AI.Agent` package is installed.

{% code title="AIAgentOptions" %}

```csharp
public class AIAgentOptions
{
    public int FileRetentionHours { get; set; } = 24;
}
```

{% endcode %}

| Property             | Type  | Default | Description                                                                  |
| -------------------- | ----- | ------- | ---------------------------------------------------------------------------- |
| `FileRetentionHours` | `int` | `24`    | Retention period (in hours) for uploaded file attachments on agent threads   |

Thread directories whose files have not been modified within this period are cleaned up.

{% code title="appsettings.json" %}

```json
{
    "Umbraco": {
        "AI": {
            "Agent": {
                "FileRetentionHours": 24
            }
        }
    }
}
```

{% endcode %}

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
