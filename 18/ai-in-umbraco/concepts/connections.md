---
description: >-
    Connections store the credentials and settings needed to authenticate with an AI provider.
---

# Connections

A connection represents a configured instance of an AI provider with credentials. It stores everything needed to authenticate and communicate with the provider's API.

## What Connections Store

| Property     | Description                                               |
| ------------ | --------------------------------------------------------- |
| `Id`         | Unique identifier (GUID)                                  |
| `Alias`      | Unique string for programmatic lookup                     |
| `Name`       | Display name shown in the backoffice                      |
| `ProviderId` | Which provider this connection uses                       |
| `Settings`   | Provider-specific settings (API key, endpoint, and so on) |
| `IsActive`   | Whether the connection is enabled                         |
| `Version`    | Current version number, increments with each save         |

## Connection vs Provider

Think of it this way:

- **Provider** = The service (for example, "OpenAI")
- **Connection** = Your account with that service (for example, "My OpenAI API Key")

You can have multiple connections to the same provider:

```
OpenAI Provider
    ├── Connection: "Development" (dev API key)
    ├── Connection: "Production" (prod API key)
    └── Connection: "Team A" (separate billing)
```

## Creating Connections

You can create and manage connections through the backoffice. See [Managing Connections](../backoffice/managing-connections.md) for step-by-step instructions.

## Configuration References

Connection settings support configuration references. Values starting with `$` are resolved from configuration (`appsettings.json`, environment variables, Azure Key Vault, and so on) at runtime.

References resolve from two dedicated configuration sections:

- `Umbraco:AI:Secrets` - for sensitive values such as API keys. These can only be referenced from settings fields marked as sensitive (see [Provider Settings](../extending/providers/provider-settings.md)).
- `Umbraco:AI:Variables` - for non-sensitive per-environment values such as endpoints, organization IDs, or feature flags.

Place the values you want to reference under these sections, then point the setting at them with the `$` prefix:

{% code title="Connection Settings" %}

```
API Key: $Umbraco:AI:Secrets:OpenAIApiKey
```

{% endcode %}

{% code title="appsettings.json" %}

```json
{
    "Umbraco": {
        "AI": {
            "Secrets": {
                "OpenAIApiKey": "sk-your-actual-key"
            }
        }
    }
}
```

{% endcode %}

Benefits of configuration references:

- Sensitive values stay out of the database.
- Different values per environment (dev/staging/prod)
- Works with Azure Key Vault, environment variables, and more.

{% hint style="info" %}
To reference values that already live in another configuration section, add that section's prefix to `Umbraco:AI:AllowedConfigurationKeyPrefixes`. See [AIOptions](../reference/configuration/ai-options.md#configuration-references).
{% endhint %}

## Accessing Connections in Code

Use `IAIConnectionService` to work with connections:

{% code title="Example.cs" %}

```csharp
public class ConnectionExample
{
    private readonly IAIConnectionService _connectionService;

    public ConnectionExample(IAIConnectionService connectionService)
    {
        _connectionService = connectionService;
    }

    public async Task<AIConnection?> GetByAlias(string alias)
    {
        return await _connectionService.GetConnectionByAliasAsync(alias);
    }

    public async Task<IEnumerable<AIConnection>> GetAllForProvider(string providerId)
    {
        return await _connectionService.GetConnectionsAsync(providerId);
    }
}
```

{% endcode %}

{% hint style="warning" %}
Deleting a connection that profiles depend on will break those profiles. Deactivate connections instead of deleting them if you are unsure.
{% endhint %}

## Related

- [Providers](providers.md) - The services connections authenticate with
- [Profiles](profiles.md) - Use connections to make AI requests
