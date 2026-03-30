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

Connections are typically created through the Umbraco backoffice:

1. Navigate to the **AI** section > **Connections**
2. Click **Create Connection**
3. Select a provider
4. Enter the required settings
5. Save the connection

## Configuration References

Connection settings support configuration references. Values starting with `$` are resolved from `appsettings.json` at runtime.

{% code title="Connection Settings" %}

```
API Key: $OpenAI:ApiKey
```

{% endcode %}

{% code title="appsettings.json" %}

```json
{
    "OpenAI": {
        "ApiKey": "sk-your-actual-key"
    }
}
```

{% endcode %}

Benefits of configuration references:

- Sensitive values stay out of the database
- Different values per environment (dev/staging/prod)
- Works with Azure Key Vault, environment variables, and more

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

## Enabling and Disabling Connections

The `IsActive` flag controls whether a connection is available for use:

- **Active (`IsActive = true`)** - Connection can be used by profiles
- **Inactive (`IsActive = false`)** - Connection is disabled and cannot be used

{% hint style="info" %}
Deactivating a connection is useful when you need to temporarily disable an API key without deleting the connection configuration.
{% endhint %}

## Testing Connections

You can test a connection via the Management API to verify credentials work:

{% code title="Example.cs" %}

```csharp
// Using HttpClient to call the Management API
var response = await httpClient.PostAsync(
    $"/umbraco/ai/management/api/v1/connections/{connectionId}/test",
    null);

var result = await response.Content.ReadFromJsonAsync<ConnectionTestResult>();
if (result.Success)
{
    // Connection works
}
else
{
    // Check result.ErrorMessage for details
}
```

{% endcode %}

{% hint style="info" %}
Connection testing is currently available via the API only. A backoffice UI test button will be added in a future release.
{% endhint %}

## Connection Lifecycle

1. **Created** - Connection saved with settings
2. **Active** - Available for use by profiles (default state)
3. **Inactive** - Disabled but configuration preserved
4. **Deleted** - Removed from the system

{% hint style="warning" %}
Deleting a connection that profiles depend on will break those profiles. Deactivate connections instead of deleting them if you're unsure.
{% endhint %}

## Related

- [Providers](providers.md) - The services connections authenticate with
- [Profiles](profiles.md) - Use connections to make AI requests
