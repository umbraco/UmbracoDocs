---
description: >-
    Version history tracks changes to AI entities and enables rollback to previous states.
---

# Version History

Umbraco.AI automatically tracks version history for key entities. Every time you save a connection, profile, context, prompt, or agent, a new version is created with a complete snapshot of the entity state.

## Supported Entity Types

| Entity Type  | Package           | Description                           |
| ------------ | ----------------- | ------------------------------------- |
| `connection` | Umbraco.AI        | API credentials and provider settings |
| `profile`    | Umbraco.AI        | Model configuration and settings      |
| `context`    | Umbraco.AI        | Brand voice and content resources     |
| `prompt`     | Umbraco.AI.Prompt | Prompt templates                      |
| `agent`      | Umbraco.AI.Agent  | AI agent definitions                  |

## How Versioning Works

When you save an entity:

1. The entity's `Version` property is incremented.
2. A complete JSON snapshot of the entity is created.
3. The snapshot is stored with metadata (timestamp, user, description).
4. The current entity is updated in the main table.

```mermaid
graph LR
    A[Save Entity] --> B[Increment Version]
    B --> C[Create Snapshot]
    C --> D[Store]
```

## Version Record Properties

Each version record stores:

| Property            | Description                                |
| ------------------- | ------------------------------------------ |
| `Id`                | Unique identifier for the version record   |
| `EntityId`          | The ID of the versioned entity             |
| `EntityType`        | Discriminator (e.g., "profile", "context") |
| `Version`           | Sequential version number                  |
| `Snapshot`          | JSON serialization of the entity state     |
| `DateCreated`       | When this version was created              |
| `CreatedByUserId`   | Who created this version                   |
| `ChangeDescription` | Optional description of changes            |

## Using Version History in Code

### Getting Version History

{% code title="Example.cs" %}

```csharp
public class VersioningExample
{
    private readonly IAIEntityVersionService _versionService;

    public VersioningExample(IAIEntityVersionService versionService)
    {
        _versionService = versionService;
    }

    public async Task<IEnumerable<AIEntityVersion>> GetProfileHistory(Guid profileId)
    {
        var (versions, total) = await _versionService.GetVersionHistoryAsync(
            profileId,
            "profile",
            skip: 0,
            take: 10);

        return versions;
    }
}
```

{% endcode %}

### Getting a Specific Version

{% code title="Example.cs" %}

```csharp
public async Task<AIProfile?> GetProfileAtVersion(Guid profileId, int version)
{
    return await _versionService.GetVersionSnapshotAsync<AIProfile>(
        profileId,
        version);
}
```

{% endcode %}

### Comparing Versions

{% code title="Example.cs" %}

```csharp
public async Task<AIVersionComparison?> CompareVersions(
    Guid entityId,
    int fromVersion,
    int toVersion)
{
    return await _versionService.CompareVersionsAsync(
        entityId,
        "profile",
        fromVersion,
        toVersion);
}
```

{% endcode %}

![Version comparison showing changes between two versions](../.gitbook/assets/backoffice-version-compare.png)

## Rolling Back

To roll back to a previous version:

1. Retrieve the snapshot from the desired version.
2. Save the restored entity (which creates a new version).

{% code title="Example.cs" %}

```csharp
public async Task RollbackProfile(Guid profileId, int targetVersion)
{
    // Get the snapshot from the target version
    var previousState = await _versionService.GetVersionSnapshotAsync<AIProfile>(
        profileId,
        targetVersion);

    if (previousState != null)
    {
        // Saving creates a new version with the restored state
        await _profileService.SaveProfileAsync(previousState);
    }
}
```

{% endcode %}

{% hint style="info" %}
Rolling back creates a new version rather than deleting versions. This preserves the complete audit trail.
{% endhint %}

## Version Cleanup

Over time, version history can accumulate. You can configure automatic cleanup:

{% code title="appsettings.json" %}

```json
{
    "Umbraco": {
        "AI": {
            "VersionCleanupPolicy": {
                "Enabled": true,
                "MaxVersionsPerEntity": 50,
                "RetentionDays": 90
            }
        }
    }
}
```

{% endcode %}

| Property               | Default | Description                                                       |
| ---------------------- | ------- | ----------------------------------------------------------------- |
| `Enabled`              | `true`  | Whether automatic version cleanup is enabled                      |
| `MaxVersionsPerEntity` | `50`    | Maximum versions to retain per entity (set to `0` to disable)     |
| `RetentionDays`        | `90`    | Days to retain version history (set to `0` to disable)            |

{% hint style="info" %}
When both `MaxVersionsPerEntity` and `RetentionDays` are set, versions must satisfy **both** conditions to be retained.
{% endhint %}

### Manual Cleanup

{% code title="Example.cs" %}

```csharp
public async Task<AIVersionCleanupResult> CleanupOldVersions()
{
    return await _versionService.CleanupVersionsAsync();
}
```

{% endcode %}

## Viewing Version History

### Via Backoffice

You can view, compare, and restore previous versions through the backoffice. See [Version History](../backoffice/version-history.md) for step-by-step instructions.

![The Version History tab showing version list for a profile](../.gitbook/assets/backoffice-version-history.png)

### Via Management API

The Management API provides a unified endpoint for version operations:

{% code title="Management API endpoints" %}

```http
GET /umbraco/management/api/v1/ai/versions/{entityType}/{entityId}
GET /umbraco/management/api/v1/ai/versions/{entityType}/{entityId}/{version}
GET /umbraco/management/api/v1/ai/versions/{entityType}/{entityId}/{from}/compare/{to}
POST /umbraco/management/api/v1/ai/versions/{entityType}/{entityId}/{version}/rollback
```

{% endcode %}

See [Versions API](../management-api/versions/README.md) for details.

## Related

- [Connections](connections.md) - Versioned credential storage
- [Profiles](profiles.md) - Versioned model configurations
- [Contexts](contexts.md) - Versioned content collections
- [Audit Logs](../backoffice/audit-logs.md) - Operational audit trail
