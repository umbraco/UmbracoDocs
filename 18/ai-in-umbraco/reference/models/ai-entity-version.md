---
description: >-
    Model representing an entity version history record.
---

# AIEntityVersion

Represents a version history record for a versioned AI entity.

## Namespace

```csharp
using Umbraco.AI.Core.Versioning;
```

## Definition

{% code title="AIEntityVersion" %}

```csharp
public sealed class AIEntityVersion
{
    public Guid Id { get; init; }
    public Guid EntityId { get; init; }
    public string EntityType { get; init; } = string.Empty;
    public int Version { get; init; }
    public string Snapshot { get; init; } = string.Empty;
    public DateTime DateCreated { get; init; }
    public Guid? CreatedByUserId { get; init; }
    public string? ChangeDescription { get; init; }
}
```

{% endcode %}

## Properties

| Property            | Type       | Description                        |
| ------------------- | ---------- | ---------------------------------- |
| `Id`                | `Guid`     | Version record identifier          |
| `EntityId`          | `Guid`     | ID of the versioned entity         |
| `EntityType`        | `string`   | Type discriminator                 |
| `Version`           | `int`      | Sequential version number          |
| `Snapshot`          | `string`   | JSON serialization of entity state |
| `DateCreated`       | `DateTime` | When this version was created      |
| `CreatedByUserId`   | `Guid?`    | User who created this version      |
| `ChangeDescription` | `string?`  | Optional description of changes    |

## Entity Types

| Type String    | Entity         | Package           |
| -------------- | -------------- | ----------------- |
| `"connection"` | `AIConnection` | Umbraco.AI        |
| `"profile"`    | `AIProfile`    | Umbraco.AI        |
| `"context"`    | `AIContext`    | Umbraco.AI        |
| `"guardrail"`  | `AIGuardrail`  | Umbraco.AI        |
| `"prompt"`     | `AIPrompt`     | Umbraco.AI.Prompt |
| `"agent"`      | `AIAgent`      | Umbraco.AI.Agent  |

## Example

{% code title="Example" %}

```csharp
// Getting version history
var (versions, total) = await _versionService.GetVersionHistoryAsync(
    profileId,
    "profile");

foreach (var version in versions)
{
    Console.WriteLine($"v{version.Version} - {version.DateCreated}");
    if (!string.IsNullOrEmpty(version.ChangeDescription))
    {
        Console.WriteLine($"  {version.ChangeDescription}");
    }
}
```

{% endcode %}

---

## AIVersionComparison

Result of comparing two entity versions.

{% code title="AIVersionComparison" %}

```csharp
public sealed class AIVersionComparison
{
    public Guid EntityId { get; init; }
    public string EntityType { get; init; } = string.Empty;
    public int FromVersion { get; init; }
    public int ToVersion { get; init; }
    public IReadOnlyList<AIValueChange> Changes { get; init; } = Array.Empty<AIValueChange>();
}
```

{% endcode %}

---

## AIValueChange

Represents a single change between two versions.

{% code title="AIValueChange" %}

```csharp
public sealed class AIValueChange
{
    public string Path { get; init; } = string.Empty;
    public string? OldValue { get; init; }
    public string? NewValue { get; init; }
}
```

{% endcode %}

---

## AIVersionCleanupResult

Result of version cleanup operation.

{% code title="AIVersionCleanupResult" %}

```csharp
public sealed class AIVersionCleanupResult
{
    public int DeletedByAge { get; init; }
    public int DeletedByCount { get; init; }
    public int TotalDeleted => DeletedByAge + DeletedByCount;
    public int RemainingVersions { get; init; }
    public bool WasSkipped { get; init; }
    public string? SkipReason { get; init; }
}
```

{% endcode %}

---

## IAIVersionableEntity

Interface implemented by entities that support versioning.

{% code title="IAIVersionableEntity" %}

```csharp
public interface IAIVersionableEntity : IAIAuditableEntity
{
    int Version { get; }
}
```

{% endcode %}

## Related

- [IAIEntityVersionService](../services/ai-entity-version-service.md) - Version service
- [Version History Concept](../../concepts/versioning.md) - Versioning concepts
