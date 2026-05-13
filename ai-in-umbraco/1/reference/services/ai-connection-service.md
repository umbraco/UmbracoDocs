---
description: >-
    Service for managing AI provider connections.
---

# IAIConnectionService

Service for connection management with validation and testing capabilities.

## Namespace

```csharp
using Umbraco.AI.Core.Connections;
using Umbraco.AI.Core.Models;
```

## Interface

{% code title="IAIConnectionService" %}

```csharp
public interface IAIConnectionService
{
    Task<AIConnection?> GetConnectionAsync(Guid id, CancellationToken cancellationToken = default);

    Task<AIConnection?> GetConnectionByAliasAsync(string alias, CancellationToken cancellationToken = default);

    Task<IEnumerable<AIConnection>> GetConnectionsAsync(string? providerId = null, CancellationToken cancellationToken = default);

    Task<(IEnumerable<AIConnection> Items, int Total)> GetConnectionsPagedAsync(
        string? filter = null,
        string? providerId = null,
        int skip = 0,
        int take = 100,
        CancellationToken cancellationToken = default);

    Task<IEnumerable<AIConnectionRef>> GetConnectionReferencesAsync(string providerId, CancellationToken cancellationToken = default);

    Task<AIConnection> SaveConnectionAsync(AIConnection connection, CancellationToken cancellationToken = default);

    Task DeleteConnectionAsync(Guid id, CancellationToken cancellationToken = default);

    Task<bool> ValidateConnectionAsync(string providerId, object? settings, CancellationToken cancellationToken = default);

    Task<bool> TestConnectionAsync(Guid id, CancellationToken cancellationToken = default);

    Task<IEnumerable<AICapability>> GetAvailableCapabilitiesAsync(CancellationToken cancellationToken = default);

    Task<IEnumerable<AIConnection>> GetConnectionsByCapabilityAsync(AICapability capability, CancellationToken cancellationToken = default);

    Task<IAIConfiguredProvider?> GetConfiguredProviderAsync(Guid connectionId, CancellationToken cancellationToken = default);

    Task<(IEnumerable<AIEntityVersion> Items, int Total)> GetConnectionVersionHistoryAsync(Guid connectionId, int skip, int take, CancellationToken cancellationToken = default);

    Task<AIConnection?> GetConnectionVersionSnapshotAsync(Guid connectionId, int version, CancellationToken cancellationToken = default);

    Task<AIConnection> RollbackConnectionAsync(Guid connectionId, int targetVersion, CancellationToken cancellationToken = default);

    Task<bool> ConnectionAliasExistsAsync(string alias, Guid? excludeId = null, CancellationToken cancellationToken = default);
}
```

{% endcode %}

## Methods

### GetConnectionAsync

Gets a connection by ID.

| Parameter           | Type                | Description        |
| ------------------- | ------------------- | ------------------ |
| `id`                | `Guid`              | The connection ID  |
| `cancellationToken` | `CancellationToken` | Cancellation token |

**Returns**: The connection if found, otherwise `null`.

### GetConnectionByAliasAsync

Gets a connection by alias (case-insensitive).

| Parameter           | Type                | Description          |
| ------------------- | ------------------- | -------------------- |
| `alias`             | `string`            | The connection alias |
| `cancellationToken` | `CancellationToken` | Cancellation token   |

**Returns**: The connection if found, otherwise `null`.

### GetConnectionsAsync

Gets all connections, optionally filtered by provider.

| Parameter           | Type                | Description              |
| ------------------- | ------------------- | ------------------------ |
| `providerId`        | `string?`           | Provider ID to filter by |
| `cancellationToken` | `CancellationToken` | Cancellation token       |

**Returns**: Matching connections.

{% code title="Example" %}

```csharp
// All connections
var all = await _connectionService.GetConnectionsAsync();

// OpenAI connections only
var openai = await _connectionService.GetConnectionsAsync("openai");
```

{% endcode %}

### GetConnectionsPagedAsync

Gets connections with pagination and filtering.

| Parameter           | Type                | Description        |
| ------------------- | ------------------- | ------------------ |
| `filter`            | `string?`           | Filter by name     |
| `providerId`        | `string?`           | Filter by provider |
| `skip`              | `int`               | Items to skip      |
| `take`              | `int`               | Items to take      |
| `cancellationToken` | `CancellationToken` | Cancellation token |

**Returns**: Tuple of (connections, total count).

### SaveConnectionAsync

Creates or updates a connection.

| Parameter           | Type                | Description            |
| ------------------- | ------------------- | ---------------------- |
| `connection`        | `AIConnection`      | The connection to save |
| `cancellationToken` | `CancellationToken` | Cancellation token     |

**Returns**: The saved connection with ID assigned.

{% code title="Example" %}

```csharp
var connection = new AIConnection
{
    Alias = "my-openai",
    Name = "My OpenAI Connection",
    ProviderId = "openai",
    Settings = new { ApiKey = "$OpenAI:ApiKey" },
    IsActive = true
};

var saved = await _connectionService.SaveConnectionAsync(connection);
```

{% endcode %}

### DeleteConnectionAsync

Deletes a connection.

| Parameter           | Type                | Description        |
| ------------------- | ------------------- | ------------------ |
| `id`                | `Guid`              | The connection ID  |
| `cancellationToken` | `CancellationToken` | Cancellation token |

{% hint style="warning" %}
Cannot delete a connection that is in use by profiles.
{% endhint %}

### ValidateConnectionAsync

Validates connection settings against the provider schema.

| Parameter           | Type                | Description              |
| ------------------- | ------------------- | ------------------------ |
| `providerId`        | `string`            | The provider ID          |
| `settings`          | `object?`           | The settings to validate |
| `cancellationToken` | `CancellationToken` | Cancellation token       |

**Returns**: `true` if valid.

### TestConnectionAsync

Tests a connection by attempting to communicate with the provider.

| Parameter           | Type                | Description        |
| ------------------- | ------------------- | ------------------ |
| `id`                | `Guid`              | The connection ID  |
| `cancellationToken` | `CancellationToken` | Cancellation token |

**Returns**: `true` if connection works.

{% code title="Example" %}

```csharp
var success = await _connectionService.TestConnectionAsync(connectionId);
if (success)
{
    Console.WriteLine("Connection test passed");
}
else
{
    Console.WriteLine("Connection test failed");
}
```

{% endcode %}

### GetAvailableCapabilitiesAsync

Gets all capabilities available across configured connections.

**Returns**: Capabilities available from at least one connection.

{% code title="Example" %}

```csharp
var capabilities = await _connectionService.GetAvailableCapabilitiesAsync();
// Returns: [Chat, Embedding]
```

{% endcode %}

### GetConnectionsByCapabilityAsync

Gets connections that support a specific capability.

| Parameter           | Type                | Description                 |
| ------------------- | ------------------- | --------------------------- |
| `capability`        | `AICapability`      | The capability to filter by |
| `cancellationToken` | `CancellationToken` | Cancellation token          |

**Returns**: Connections supporting the capability.

### GetConfiguredProviderAsync

Gets a provider configured with a connection's settings.

| Parameter           | Type                | Description        |
| ------------------- | ------------------- | ------------------ |
| `connectionId`      | `Guid`              | The connection ID  |
| `cancellationToken` | `CancellationToken` | Cancellation token |

**Returns**: Configured provider, or `null` if not found.

{% code title="Example" %}

```csharp
var provider = await _connectionService.GetConfiguredProviderAsync(connectionId);
if (provider != null)
{
    // Access provider capabilities
    var chatCapability = provider.GetCapability<IAIChatCapability>();
}
```

{% endcode %}

### GetConnectionVersionHistoryAsync

Gets the version history for a connection.

| Parameter           | Type                | Description        |
| ------------------- | ------------------- | ------------------ |
| `connectionId`      | `Guid`              | The connection ID  |
| `skip`              | `int`               | Items to skip      |
| `take`              | `int`               | Items to take      |
| `cancellationToken` | `CancellationToken` | Cancellation token |

**Returns**: Tuple of (version entries, total count).

{% code title="Example" %}

```csharp
var (versions, total) = await _connectionService.GetConnectionVersionHistoryAsync(
    connectionId, skip: 0, take: 10);

foreach (var version in versions)
{
    Console.WriteLine($"Version {version.Version} at {version.DateCreated}");
}
```

{% endcode %}

### GetConnectionVersionSnapshotAsync

Gets a snapshot of a connection at a specific version.

| Parameter           | Type                | Description            |
| ------------------- | ------------------- | ---------------------- |
| `connectionId`      | `Guid`              | The connection ID      |
| `version`           | `int`               | The version number     |
| `cancellationToken` | `CancellationToken` | Cancellation token     |

**Returns**: The connection as it was at the specified version, or `null` if not found.

{% code title="Example" %}

```csharp
var snapshot = await _connectionService.GetConnectionVersionSnapshotAsync(connectionId, version: 3);
if (snapshot != null)
{
    Console.WriteLine($"Connection name at v3: {snapshot.Name}");
}
```

{% endcode %}

### RollbackConnectionAsync

Rolls back a connection to a previous version.

| Parameter           | Type                | Description                     |
| ------------------- | ------------------- | ------------------------------- |
| `connectionId`      | `Guid`              | The connection ID               |
| `targetVersion`     | `int`               | The version to roll back to     |
| `cancellationToken` | `CancellationToken` | Cancellation token              |

**Returns**: The connection after rollback, with a new version number.

{% code title="Example" %}

```csharp
var rolledBack = await _connectionService.RollbackConnectionAsync(connectionId, targetVersion: 2);
Console.WriteLine($"Rolled back to v2, new version is {rolledBack.Version}");
```

{% endcode %}

### ConnectionAliasExistsAsync

Checks if a connection alias is already in use.

| Parameter           | Type                | Description                          |
| ------------------- | ------------------- | ------------------------------------ |
| `alias`             | `string`            | The alias to check                   |
| `excludeId`         | `Guid?`             | Optional ID to exclude (for updates) |
| `cancellationToken` | `CancellationToken` | Cancellation token                   |

**Returns**: `true` if alias exists, `false` otherwise.

{% code title="Example" %}

```csharp
if (await _connectionService.ConnectionAliasExistsAsync("my-openai"))
{
    Console.WriteLine("Alias already in use");
}
```

{% endcode %}
