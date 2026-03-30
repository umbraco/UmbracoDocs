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
public class AIEntityVersion
{
    public Guid Id { get; set; }
    public Guid EntityId { get; set; }
    public string EntityType { get; set; } = string.Empty;
    public int Version { get; set; }
    public string Snapshot { get; set; } = string.Empty;
    public DateTime DateCreated { get; set; }
    public Guid? CreatedByUserId { get; set; }
    public string? ChangeDescription { get; set; }
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

# AIVersionComparison

Result of comparing two entity versions.

{% code title="AIVersionComparison" %}

```csharp
public class AIVersionComparison
{
    public Guid EntityId { get; set; }
    public string EntityType { get; set; } = string.Empty;
    public int FromVersion { get; set; }
    public int ToVersion { get; set; }
    public DateTime FromDate { get; set; }
    public DateTime ToDate { get; set; }
    public IReadOnlyList<AIVersionChange> Changes { get; set; } = Array.Empty<AIVersionChange>();
    public string? FromSnapshot { get; set; }
    public string? ToSnapshot { get; set; }
}
```

{% endcode %}

---

# AIVersionChange

Represents a single change between two versions.

{% code title="AIVersionChange" %}

```csharp
public class AIVersionChange
{
    public string Path { get; set; } = string.Empty;
    public AIVersionChangeType ChangeType { get; set; }
    public string? FromValue { get; set; }
    public string? ToValue { get; set; }
}

public enum AIVersionChangeType
{
    Added = 0,
    Removed = 1,
    Modified = 2
}
```

{% endcode %}

---

# AIVersionCleanupResult

Result of version cleanup operation.

{% code title="AIVersionCleanupResult" %}

```csharp
public class AIVersionCleanupResult
{
    public int DeletedCount { get; set; }
    public DateTime? OldestRetained { get; set; }
}
```

{% endcode %}

---

# IAIVersionableEntity

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
