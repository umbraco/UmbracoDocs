---
description: >-
    Service for managing entity version history.
---

# IAIEntityVersionService

Service for accessing version history, comparing versions, and creating snapshots of AI entities.

## Namespace

```csharp
using Umbraco.AI.Core.Versioning;
```

## Interface

{% code title="IAIEntityVersionService" %}

```csharp
public interface IAIEntityVersionService
{
    Task<(IEnumerable<AIEntityVersion> Items, int Total)> GetVersionHistoryAsync(
        Guid entityId,
        string entityType,
        int skip = 0,
        int take = 20,
        CancellationToken cancellationToken = default);

    Task<AIEntityVersion?> GetVersionAsync(
        Guid entityId,
        string entityType,
        int version,
        CancellationToken cancellationToken = default);

    Task<TEntity?> GetVersionSnapshotAsync<TEntity>(
        Guid entityId,
        int version,
        CancellationToken cancellationToken = default)
        where TEntity : class, IAIVersionableEntity;

    Task SaveVersionAsync<TEntity>(
        TEntity entity,
        Guid? userId = null,
        string? changeDescription = null,
        CancellationToken cancellationToken = default)
        where TEntity : class, IAIVersionableEntity;

    Task DeleteVersionsAsync(
        Guid entityId,
        string entityType,
        CancellationToken cancellationToken = default);

    Task<AIVersionComparison?> CompareVersionsAsync(
        Guid entityId,
        string entityType,
        int fromVersion,
        int toVersion,
        CancellationToken cancellationToken = default);

    string CreateSnapshot<TEntity>(TEntity entity)
        where TEntity : class, IAIVersionableEntity;

    TEntity? RestoreFromSnapshot<TEntity>(string snapshot)
        where TEntity : class, IAIVersionableEntity;

    Task<AIVersionCleanupResult> CleanupVersionsAsync(
        CancellationToken cancellationToken = default);
}
```

{% endcode %}

## Methods

### GetVersionHistoryAsync

Gets the version history for an entity.

| Parameter           | Type                | Description                                  |
| ------------------- | ------------------- | -------------------------------------------- |
| `entityId`          | `Guid`              | The entity ID                                |
| `entityType`        | `string`            | The entity type (e.g., "profile", "context") |
| `skip`              | `int`               | Records to skip                              |
| `take`              | `int`               | Records to take                              |
| `cancellationToken` | `CancellationToken` | Cancellation token                           |

**Returns**: Tuple of (versions, total count).

{% code title="Example" %}

```csharp
var (versions, total) = await _versionService.GetVersionHistoryAsync(
    profileId,
    "profile",
    skip: 0,
    take: 10);

foreach (var v in versions)
{
    Console.WriteLine($"Version {v.Version}: {v.DateCreated}");
}
```

{% endcode %}

### GetVersionAsync

Gets a specific version record.

| Parameter           | Type                | Description        |
| ------------------- | ------------------- | ------------------ |
| `entityId`          | `Guid`              | The entity ID      |
| `entityType`        | `string`            | The entity type    |
| `version`           | `int`               | The version number |
| `cancellationToken` | `CancellationToken` | Cancellation token |

**Returns**: The version record if found, otherwise `null`.

### GetVersionSnapshotAsync

Gets the entity state at a specific version.

| Parameter           | Type                | Description        |
| ------------------- | ------------------- | ------------------ |
| `entityId`          | `Guid`              | The entity ID      |
| `version`           | `int`               | The version number |
| `cancellationToken` | `CancellationToken` | Cancellation token |

**Returns**: The deserialized entity at that version, or `null`.

{% code title="Example" %}

```csharp
var previousProfile = await _versionService.GetVersionSnapshotAsync<AIProfile>(
    profileId,
    version: 3);

if (previousProfile != null)
{
    Console.WriteLine($"Profile name at v3: {previousProfile.Name}");
    Console.WriteLine($"Temperature at v3: {previousProfile.Settings?.Temperature}");
}
```

{% endcode %}

### SaveVersionAsync

Saves a version snapshot for an entity. This is typically called automatically by entity services.

| Parameter           | Type                | Description              |
| ------------------- | ------------------- | ------------------------ |
| `entity`            | `TEntity`           | The entity to snapshot   |
| `userId`            | `Guid?`             | User who made the change |
| `changeDescription` | `string?`           | Description of changes   |
| `cancellationToken` | `CancellationToken` | Cancellation token       |

### DeleteVersionsAsync

Deletes all version history for an entity.

| Parameter           | Type                | Description        |
| ------------------- | ------------------- | ------------------ |
| `entityId`          | `Guid`              | The entity ID      |
| `entityType`        | `string`            | The entity type    |
| `cancellationToken` | `CancellationToken` | Cancellation token |

### CompareVersionsAsync

Compares two versions and returns the differences.

| Parameter           | Type                | Description        |
| ------------------- | ------------------- | ------------------ |
| `entityId`          | `Guid`              | The entity ID      |
| `entityType`        | `string`            | The entity type    |
| `fromVersion`       | `int`               | Source version     |
| `toVersion`         | `int`               | Target version     |
| `cancellationToken` | `CancellationToken` | Cancellation token |

**Returns**: Comparison result with changes.

{% code title="Example" %}

```csharp
var comparison = await _versionService.CompareVersionsAsync(
    profileId,
    "profile",
    fromVersion: 2,
    toVersion: 5);

if (comparison != null)
{
    foreach (var change in comparison.Changes)
    {
        Console.WriteLine($"{change.Path}: {change.ChangeType}");
        Console.WriteLine($"  From: {change.FromValue}");
        Console.WriteLine($"  To: {change.ToValue}");
    }
}
```

{% endcode %}

### CreateSnapshot / RestoreFromSnapshot

Creates and restores JSON snapshots of entities.

{% code title="Example" %}

```csharp
// Create a snapshot
var snapshot = _versionService.CreateSnapshot(profile);

// Later, restore from snapshot
var restored = _versionService.RestoreFromSnapshot<AIProfile>(snapshot);
```

{% endcode %}

### CleanupVersionsAsync

Removes old versions based on retention settings.

**Returns**: Cleanup result with count of removed versions.

{% code title="Example" %}

```csharp
var result = await _versionService.CleanupVersionsAsync();
Console.WriteLine($"Cleaned up {result.DeletedCount} old versions");
```

{% endcode %}

## Entity Types

| Type String    | Entity Class                            |
| -------------- | --------------------------------------- |
| `"connection"` | `AIConnection`                          |
| `"profile"`    | `AIProfile`                             |
| `"context"`    | `AIContext`                             |
| `"prompt"`     | `AIPrompt` (requires Umbraco.AI.Prompt) |
| `"agent"`      | `AIAgent` (requires Umbraco.AI.Agent)   |

## Related

- [AIEntityVersion](../models/ai-entity-version.md) - The version model
- [Version History Concept](../../concepts/versioning.md) - Versioning concepts
