---
description: >-
    Service for managing AI guardrails.
---

# IAIGuardrailService

Service for guardrail CRUD operations, lookups, and version management. Guardrails define rules that evaluate AI inputs and responses for safety, compliance, and quality.

## Namespace

```csharp
using Umbraco.AI.Core.Guardrails;
```

## Interface

{% code title="IAIGuardrailService" %}

```csharp
public interface IAIGuardrailService
{
    Task<AIGuardrail?> GetGuardrailAsync(Guid id, CancellationToken cancellationToken = default);

    Task<AIGuardrail?> GetGuardrailByAliasAsync(string alias, CancellationToken cancellationToken = default);

    Task<IEnumerable<AIGuardrail>> GetGuardrailsAsync(CancellationToken cancellationToken = default);

    Task<(IEnumerable<AIGuardrail> Items, int Total)> GetGuardrailsPagedAsync(
        string? filter = null, int skip = 0, int take = 100,
        CancellationToken cancellationToken = default);

    Task<IEnumerable<AIGuardrail>> GetGuardrailsByIdsAsync(
        IEnumerable<Guid> ids, CancellationToken cancellationToken = default);

    Task<AIGuardrail> SaveGuardrailAsync(AIGuardrail guardrail, CancellationToken cancellationToken = default);

    Task<bool> DeleteGuardrailAsync(Guid id, CancellationToken cancellationToken = default);

    Task<bool> GuardrailAliasExistsAsync(
        string alias, Guid? excludeId = null, CancellationToken cancellationToken = default);

    Task<(IEnumerable<AIEntityVersion> Items, int Total)> GetGuardrailVersionHistoryAsync(
        Guid guardrailId, int skip, int take, CancellationToken cancellationToken = default);

    Task<AIGuardrail?> GetGuardrailVersionSnapshotAsync(
        Guid guardrailId, int version, CancellationToken cancellationToken = default);

    Task<AIGuardrail> RollbackGuardrailAsync(
        Guid guardrailId, int targetVersion, CancellationToken cancellationToken = default);
}
```

{% endcode %}

## Methods

### GetGuardrailAsync

Gets a guardrail by its unique identifier.

| Parameter           | Type                | Description          |
| ------------------- | ------------------- | -------------------- |
| `id`                | `Guid`              | The guardrail ID     |
| `cancellationToken` | `CancellationToken` | Cancellation token   |

**Returns**: The guardrail if found, otherwise `null`.

{% code title="Example" %}

```csharp
var guardrail = await _guardrailService.GetGuardrailAsync(guardrailId);
if (guardrail != null)
{
    Console.WriteLine($"Guardrail: {guardrail.Name}");
    Console.WriteLine($"Rules: {guardrail.Rules.Count}");
}
```

{% endcode %}

### GetGuardrailByAliasAsync

Gets a guardrail by its alias.

| Parameter           | Type                | Description          |
| ------------------- | ------------------- | -------------------- |
| `alias`             | `string`            | The guardrail alias  |
| `cancellationToken` | `CancellationToken` | Cancellation token   |

**Returns**: The guardrail if found, otherwise `null`.

{% code title="Example" %}

```csharp
var safetyGuardrail = await _guardrailService.GetGuardrailByAliasAsync("content-safety");
```

{% endcode %}

### GetGuardrailsAsync

Gets all guardrails.

**Returns**: All guardrails in the system.

{% code title="Example" %}

```csharp
var allGuardrails = await _guardrailService.GetGuardrailsAsync();
foreach (var gr in allGuardrails)
{
    Console.WriteLine($"{gr.Alias}: {gr.Name} ({gr.Rules.Count} rules)");
}
```

{% endcode %}

### GetGuardrailsPagedAsync

Gets guardrails with pagination and optional filtering.

| Parameter           | Type                | Description                                    |
| ------------------- | ------------------- | ---------------------------------------------- |
| `filter`            | `string?`           | Optional filter (case-insensitive contains)    |
| `skip`              | `int`               | Number of items to skip (default: 0)           |
| `take`              | `int`               | Number of items to take (default: 100)         |
| `cancellationToken` | `CancellationToken` | Cancellation token                             |

**Returns**: A tuple of the paginated guardrails and total count.

{% code title="Example" %}

```csharp
var (items, total) = await _guardrailService.GetGuardrailsPagedAsync(
    filter: "safety", skip: 0, take: 10);
Console.WriteLine($"Found {total} guardrails matching 'safety'");
```

{% endcode %}

### GetGuardrailsByIdsAsync

Gets multiple guardrails by their IDs.

| Parameter           | Type                 | Description                  |
| ------------------- | -------------------- | ---------------------------- |
| `ids`               | `IEnumerable<Guid>`  | The guardrail IDs to look up |
| `cancellationToken` | `CancellationToken`  | Cancellation token           |

**Returns**: The guardrails that were found.

{% code title="Example" %}

```csharp
var guardrails = await _guardrailService.GetGuardrailsByIdsAsync(profile.Settings.GuardrailIds);
```

{% endcode %}

### SaveGuardrailAsync

Creates or updates a guardrail. If the guardrail has no ID (or `Guid.Empty`), a new one is created. If it has an existing ID, the current state is saved to version history before updating.

| Parameter           | Type                | Description             |
| ------------------- | ------------------- | ----------------------- |
| `guardrail`         | `AIGuardrail`       | The guardrail to save   |
| `cancellationToken` | `CancellationToken` | Cancellation token      |

**Returns**: The saved guardrail with ID and version assigned.

{% code title="Example" %}

```csharp
// Create
var guardrail = new AIGuardrail
{
    Alias = "content-safety",
    Name = "Content Safety Policy",
    Rules =
    [
        new AIGuardrailRule
        {
            EvaluatorId = "contains",
            Name = "Block prohibited terms",
            Phase = AIGuardrailPhase.PostGenerate,
            Action = AIGuardrailAction.Block,
            SortOrder = 0
        }
    ]
};

var created = await _guardrailService.SaveGuardrailAsync(guardrail);

// Update
created.Name = "Updated Safety Policy";
var updated = await _guardrailService.SaveGuardrailAsync(created);
Console.WriteLine($"Updated to version {updated.Version}");
```

{% endcode %}

### DeleteGuardrailAsync

Deletes a guardrail and its version history.

| Parameter           | Type                | Description          |
| ------------------- | ------------------- | -------------------- |
| `id`                | `Guid`              | The guardrail ID     |
| `cancellationToken` | `CancellationToken` | Cancellation token   |

**Returns**: `true` if deleted, `false` if not found.

{% code title="Example" %}

```csharp
var deleted = await _guardrailService.DeleteGuardrailAsync(guardrailId);
```

{% endcode %}

### GuardrailAliasExistsAsync

Checks if an alias is already in use.

| Parameter           | Type                | Description                          |
| ------------------- | ------------------- | ------------------------------------ |
| `alias`             | `string`            | The alias to check                   |
| `excludeId`         | `Guid?`             | Optional ID to exclude (for updates) |
| `cancellationToken` | `CancellationToken` | Cancellation token                   |

**Returns**: `true` if alias exists, `false` otherwise.

{% code title="Example" %}

```csharp
if (await _guardrailService.GuardrailAliasExistsAsync("content-safety"))
{
    Console.WriteLine("Alias already in use");
}
```

{% endcode %}

### GetGuardrailVersionHistoryAsync

Gets the version history for a guardrail with pagination.

| Parameter           | Type                | Description                    |
| ------------------- | ------------------- | ------------------------------ |
| `guardrailId`       | `Guid`              | The guardrail ID               |
| `skip`              | `int`               | Number of versions to skip     |
| `take`              | `int`               | Maximum versions to return     |
| `cancellationToken` | `CancellationToken` | Cancellation token             |

**Returns**: A tuple of paginated version history (ordered by version descending) and total count.

### GetGuardrailVersionSnapshotAsync

Gets a specific version snapshot of a guardrail.

| Parameter           | Type                | Description             |
| ------------------- | ------------------- | ----------------------- |
| `guardrailId`       | `Guid`              | The guardrail ID        |
| `version`           | `int`               | The version to retrieve |
| `cancellationToken` | `CancellationToken` | Cancellation token      |

**Returns**: The guardrail at that version, or `null` if not found.

### RollbackGuardrailAsync

Rolls back a guardrail to a previous version. The current state is saved to version history before restoring.

| Parameter           | Type                | Description                    |
| ------------------- | ------------------- | ------------------------------ |
| `guardrailId`       | `Guid`              | The guardrail ID               |
| `targetVersion`     | `int`               | The version to rollback to     |
| `cancellationToken` | `CancellationToken` | Cancellation token             |

**Returns**: The updated guardrail at the new version.

**Throws**: `InvalidOperationException` if the guardrail or target version is not found.

## Related

- [AIGuardrail](../models/ai-guardrail.md) - The guardrail model
- [Guardrails Concept](../../concepts/guardrails.md) - Guardrail concepts
