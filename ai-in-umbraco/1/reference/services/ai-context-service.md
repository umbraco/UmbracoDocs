---
description: >-
    Service for managing AI contexts.
---

# IAIContextService

Service for context CRUD operations and lookups. Contexts store brand voice, guidelines, and content for AI injection.

## Namespace

```csharp
using Umbraco.AI.Core.Contexts;
```

## Interface

{% code title="IAIContextService" %}

```csharp
public interface IAIContextService
{
    Task<AIContext?> GetContextAsync(Guid id, CancellationToken cancellationToken = default);

    Task<AIContext?> GetContextByAliasAsync(string alias, CancellationToken cancellationToken = default);

    Task<IEnumerable<AIContext>> GetContextsAsync(CancellationToken cancellationToken = default);

    Task<(IEnumerable<AIContext> Items, int Total)> GetContextsPagedAsync(
        string? filter = null,
        int skip = 0,
        int take = 100,
        CancellationToken cancellationToken = default);

    Task<AIContext> SaveContextAsync(AIContext context, CancellationToken cancellationToken = default);

    Task<bool> DeleteContextAsync(Guid id, CancellationToken cancellationToken = default);

    Task<bool> ContextAliasExistsAsync(string alias, Guid? excludeId = null, CancellationToken cancellationToken = default);

    Task<(IEnumerable<AIEntityVersion> Items, int Total)> GetContextVersionHistoryAsync(Guid contextId, int skip, int take, CancellationToken cancellationToken = default);

    Task<AIContext?> GetContextVersionSnapshotAsync(Guid contextId, int version, CancellationToken cancellationToken = default);

    Task<AIContext> RollbackContextAsync(Guid contextId, int targetVersion, CancellationToken cancellationToken = default);
}
```

{% endcode %}

## Methods

### GetContextAsync

Gets a context by its unique identifier.

| Parameter           | Type                | Description        |
| ------------------- | ------------------- | ------------------ |
| `id`                | `Guid`              | The context ID     |
| `cancellationToken` | `CancellationToken` | Cancellation token |

**Returns**: The context if found, otherwise `null`.

{% code title="Example" %}

```csharp
var context = await _contextService.GetContextAsync(contextId);
if (context != null)
{
    Console.WriteLine($"Context: {context.Name}");
    Console.WriteLine($"Resources: {context.Resources.Count}");
}
```

{% endcode %}

### GetContextByAliasAsync

Gets a context by its alias.

| Parameter           | Type                | Description        |
| ------------------- | ------------------- | ------------------ |
| `alias`             | `string`            | The context alias  |
| `cancellationToken` | `CancellationToken` | Cancellation token |

**Returns**: The context if found, otherwise `null`.

{% code title="Example" %}

```csharp
var brandContext = await _contextService.GetContextByAliasAsync("brand-voice");
```

{% endcode %}

### GetContextsAsync

Gets all contexts.

**Returns**: All contexts in the system.

{% code title="Example" %}

```csharp
var allContexts = await _contextService.GetContextsAsync();
foreach (var ctx in allContexts)
{
    Console.WriteLine($"{ctx.Alias}: {ctx.Name}");
}
```

{% endcode %}

### GetContextsPagedAsync

Gets contexts with pagination and optional filtering.

| Parameter           | Type                | Description                                |
| ------------------- | ------------------- | ------------------------------------------ |
| `filter`            | `string?`           | Filter by name (case-insensitive contains) |
| `skip`              | `int`               | Items to skip                              |
| `take`              | `int`               | Items to take                              |
| `cancellationToken` | `CancellationToken` | Cancellation token                         |

**Returns**: Tuple of (contexts, total count).

{% code title="Example" %}

```csharp
var (contexts, total) = await _contextService.GetContextsPagedAsync(
    filter: "brand",
    skip: 0,
    take: 10);

Console.WriteLine($"Found {total} contexts, showing {contexts.Count()}");
```

{% endcode %}

### SaveContextAsync

Creates or updates a context. When updating, a new version is created automatically.

| Parameter           | Type                | Description         |
| ------------------- | ------------------- | ------------------- |
| `context`           | `AIContext`         | The context to save |
| `cancellationToken` | `CancellationToken` | Cancellation token  |

**Returns**: The saved context with ID assigned and version incremented.

{% code title="Example" %}

```csharp
var context = new AIContext
{
    Alias = "brand-voice",
    Name = "Brand Voice",
    Resources = new List<AIContextResource>
    {
        new AIContextResource
        {
            ResourceTypeId = "text",
            Name = "Tone of Voice",
            SortOrder = 0,
            Data = "Always use a friendly, professional tone..."
        }
    }
};

var saved = await _contextService.SaveContextAsync(context);
Console.WriteLine($"Saved context version {saved.Version}");
```

{% endcode %}

### DeleteContextAsync

Deletes a context by ID.

| Parameter           | Type                | Description        |
| ------------------- | ------------------- | ------------------ |
| `id`                | `Guid`              | The context ID     |
| `cancellationToken` | `CancellationToken` | Cancellation token |

**Returns**: `true` if deleted, `false` if not found.

{% code title="Example" %}

```csharp
var deleted = await _contextService.DeleteContextAsync(contextId);
```

{% endcode %}

### ContextAliasExistsAsync

Checks if an alias is already in use.

| Parameter           | Type                | Description                          |
| ------------------- | ------------------- | ------------------------------------ |
| `alias`             | `string`            | The alias to check                   |
| `excludeId`         | `Guid?`             | Optional ID to exclude (for updates) |
| `cancellationToken` | `CancellationToken` | Cancellation token                   |

**Returns**: `true` if alias exists, `false` otherwise.

{% code title="Example" %}

```csharp
// Check before creating
if (await _contextService.ContextAliasExistsAsync("brand-voice"))
{
    Console.WriteLine("Alias already in use");
}

// Check during update (exclude current context)
if (await _contextService.ContextAliasExistsAsync("new-alias", existingContextId))
{
    Console.WriteLine("Alias already in use by another context");
}
```

{% endcode %}

### GetContextVersionHistoryAsync

Gets the version history for a context.

| Parameter           | Type                | Description        |
| ------------------- | ------------------- | ------------------ |
| `contextId`         | `Guid`              | The context ID     |
| `skip`              | `int`               | Items to skip      |
| `take`              | `int`               | Items to take      |
| `cancellationToken` | `CancellationToken` | Cancellation token |

**Returns**: Tuple of (version entries, total count).

{% code title="Example" %}

```csharp
var (versions, total) = await _contextService.GetContextVersionHistoryAsync(
    contextId, skip: 0, take: 10);

foreach (var version in versions)
{
    Console.WriteLine($"Version {version.Version} at {version.CreatedUtc}");
}
```

{% endcode %}

### GetContextVersionSnapshotAsync

Gets a snapshot of a context at a specific version.

| Parameter           | Type                | Description        |
| ------------------- | ------------------- | ------------------ |
| `contextId`         | `Guid`              | The context ID     |
| `version`           | `int`               | The version number |
| `cancellationToken` | `CancellationToken` | Cancellation token |

**Returns**: The context as it was at the specified version, or `null` if not found.

{% code title="Example" %}

```csharp
var snapshot = await _contextService.GetContextVersionSnapshotAsync(contextId, version: 3);
if (snapshot != null)
{
    Console.WriteLine($"Context name at v3: {snapshot.Name}");
}
```

{% endcode %}

### RollbackContextAsync

Rolls back a context to a previous version.

| Parameter           | Type                | Description                     |
| ------------------- | ------------------- | ------------------------------- |
| `contextId`         | `Guid`              | The context ID                  |
| `targetVersion`     | `int`               | The version to roll back to     |
| `cancellationToken` | `CancellationToken` | Cancellation token              |

**Returns**: The context after rollback, with a new version number.

{% code title="Example" %}

```csharp
var rolledBack = await _contextService.RollbackContextAsync(contextId, targetVersion: 2);
Console.WriteLine($"Rolled back to v2, new version is {rolledBack.Version}");
```

{% endcode %}

## Related

- [AIContext](../models/ai-context.md) - The context model
- [Contexts Concept](../../concepts/contexts.md) - Context concepts
