---
description: >-
    Service for managing AI profiles.
---

# IAIProfileService

Service for profile CRUD operations and lookups.

## Namespace

{% code title="Namespace" %}

```csharp
using Umbraco.AI.Core.Profiles;
using Umbraco.AI.Core.Models;
```

{% endcode %}

## Interface

{% code title="IAIProfileService" %}

```csharp
public interface IAIProfileService
{
    Task<AIProfile?> GetProfileAsync(Guid id, CancellationToken cancellationToken = default);

    Task<AIProfile?> GetProfileByAliasAsync(string alias, CancellationToken cancellationToken = default);

    Task<IEnumerable<AIProfile>> GetAllProfilesAsync(CancellationToken cancellationToken = default);

    Task<IEnumerable<AIProfile>> GetProfilesAsync(AICapability capability, CancellationToken cancellationToken = default);

    Task<(IEnumerable<AIProfile> Items, int Total)> GetProfilesPagedAsync(
        string? filter = null,
        AICapability? capability = null,
        int skip = 0,
        int take = 100,
        CancellationToken cancellationToken = default);

    Task<AIProfile> GetDefaultProfileAsync(AICapability capability, CancellationToken cancellationToken = default);

    Task<AIProfile> SaveProfileAsync(AIProfile profile, CancellationToken cancellationToken = default);

    Task<bool> DeleteProfileAsync(Guid id, CancellationToken cancellationToken = default);

    Task<bool> HasDefaultProfileAsync(AICapability capability, CancellationToken cancellationToken = default);

    Task<AIProfile> GetClassifierProfileAsync(CancellationToken cancellationToken = default);

    Task<(IEnumerable<AIEntityVersion> Items, int Total)> GetProfileVersionHistoryAsync(
        Guid profileId,
        int skip,
        int take,
        CancellationToken cancellationToken = default);

    Task<AIProfile?> GetProfileVersionSnapshotAsync(
        Guid profileId,
        int version,
        CancellationToken cancellationToken = default);

    Task<AIProfile> RollbackProfileAsync(
        Guid profileId,
        int targetVersion,
        CancellationToken cancellationToken = default);

    Task<bool> ProfileAliasExistsAsync(
        string alias,
        Guid? excludeId = null,
        CancellationToken cancellationToken = default);

    Task<bool> ProfilesExistWithConnectionAsync(
        Guid connectionId,
        CancellationToken cancellationToken = default);
}
```

{% endcode %}

## Methods

### GetProfileAsync

Gets a profile by its unique identifier.

| Parameter           | Type                | Description        |
| ------------------- | ------------------- | ------------------ |
| `id`                | `Guid`              | The profile ID     |
| `cancellationToken` | `CancellationToken` | Cancellation token |

**Returns**: The profile if found, otherwise `null`.

{% code title="Example" %}

```csharp
var profile = await _profileService.GetProfileAsync(profileId);
if (profile != null)
{
    Console.WriteLine($"Profile: {profile.Name}");
    Console.WriteLine($"Model: {profile.Model}");
}
```

{% endcode %}

### GetProfileByAliasAsync

Gets a profile by its alias.

| Parameter           | Type                | Description        |
| ------------------- | ------------------- | ------------------ |
| `alias`             | `string`            | The profile alias  |
| `cancellationToken` | `CancellationToken` | Cancellation token |

**Returns**: The profile if found, otherwise `null`.

{% code title="Example" %}

```csharp
var profile = await _profileService.GetProfileByAliasAsync("content-assistant");
```

{% endcode %}

### GetAllProfilesAsync

Gets all profiles.

**Returns**: All profiles in the system.

### GetProfilesAsync

Gets profiles for a specific capability.

| Parameter           | Type                | Description                 |
| ------------------- | ------------------- | --------------------------- |
| `capability`        | `AICapability`      | The capability to filter by |
| `cancellationToken` | `CancellationToken` | Cancellation token          |

**Returns**: Profiles matching the capability.

{% code title="Example" %}

```csharp
var chatProfiles = await _profileService.GetProfilesAsync(AICapability.Chat);
var embeddingProfiles = await _profileService.GetProfilesAsync(AICapability.Embedding);
```

{% endcode %}

### GetProfilesPagedAsync

Gets profiles with pagination and optional filtering.

| Parameter           | Type                | Description                                |
| ------------------- | ------------------- | ------------------------------------------ |
| `filter`            | `string?`           | Filter by name (case-insensitive contains) |
| `capability`        | `AICapability?`     | Filter by capability                       |
| `skip`              | `int`               | Items to skip                              |
| `take`              | `int`               | Items to take                              |
| `cancellationToken` | `CancellationToken` | Cancellation token                         |

**Returns**: Tuple of (profiles, total count).

{% code title="Example" %}

```csharp
var (profiles, total) = await _profileService.GetProfilesPagedAsync(
    filter: "assistant",
    capability: AICapability.Chat,
    skip: 0,
    take: 10);

Console.WriteLine($"Found {total} profiles, showing {profiles.Count()}");
```

{% endcode %}

### GetDefaultProfileAsync

Gets the default profile for a capability.

| Parameter           | Type                | Description        |
| ------------------- | ------------------- | ------------------ |
| `capability`        | `AICapability`      | The capability     |
| `cancellationToken` | `CancellationToken` | Cancellation token |

**Returns**: The default profile.

**Throws**: `InvalidOperationException` if no default profile is configured.

{% code title="Example" %}

```csharp
try
{
    var defaultChat = await _profileService.GetDefaultProfileAsync(AICapability.Chat);
    Console.WriteLine($"Default chat profile: {defaultChat.Alias}");
}
catch (InvalidOperationException ex)
{
    Console.WriteLine("No default chat profile configured");
}
```

{% endcode %}

### SaveProfileAsync

Creates or updates a profile.

| Parameter           | Type                | Description         |
| ------------------- | ------------------- | ------------------- |
| `profile`           | `AIProfile`         | The profile to save |
| `cancellationToken` | `CancellationToken` | Cancellation token  |

**Returns**: The saved profile with ID assigned.

{% code title="Example" %}

```csharp
var profile = new AIProfile
{
    Alias = "new-assistant",
    Name = "New Assistant",
    Capability = AICapability.Chat,
    Model = new AIModelRef("openai", "gpt-4o"),
    ConnectionId = connectionId,
    Settings = new AIChatProfileSettings
    {
        Temperature = 0.7f,
        MaxTokens = 4096
    }
};

var saved = await _profileService.SaveProfileAsync(profile);
Console.WriteLine($"Created profile with ID: {saved.Id}");
```

{% endcode %}

### DeleteProfileAsync

Deletes a profile by ID.

| Parameter           | Type                | Description        |
| ------------------- | ------------------- | ------------------ |
| `id`                | `Guid`              | The profile ID     |
| `cancellationToken` | `CancellationToken` | Cancellation token |

**Returns**: `true` if deleted, `false` if not found.

{% code title="Example" %}

```csharp
var deleted = await _profileService.DeleteProfileAsync(profileId);
if (deleted)
{
    Console.WriteLine("Profile deleted");
}
```

{% endcode %}

### HasDefaultProfileAsync

Checks if a default profile is configured and exists for the given capability.

| Parameter           | Type                | Description        |
| ------------------- | ------------------- | ------------------ |
| `capability`        | `AICapability`      | The capability     |
| `cancellationToken` | `CancellationToken` | Cancellation token |

**Returns**: `true` if a default profile is configured and exists, otherwise `false`.

{% code title="Example" %}

```csharp
if (await _profileService.HasDefaultProfileAsync(AICapability.Chat))
{
    var profile = await _profileService.GetDefaultProfileAsync(AICapability.Chat);
    // Use profile
}
```

{% endcode %}

### GetClassifierProfileAsync

Gets the classifier profile. Falls back to the default chat profile if no dedicated classifier profile is configured.

| Parameter           | Type                | Description        |
| ------------------- | ------------------- | ------------------ |
| `cancellationToken` | `CancellationToken` | Cancellation token |

**Returns**: The classifier profile.

{% code title="Example" %}

```csharp
var classifierProfile = await _profileService.GetClassifierProfileAsync();
Console.WriteLine($"Classifier uses model: {classifierProfile.Model}");
```

{% endcode %}

### GetProfileVersionHistoryAsync

Gets paginated version history for a profile.

| Parameter           | Type                | Description        |
| ------------------- | ------------------- | ------------------ |
| `profileId`         | `Guid`              | The profile ID     |
| `skip`              | `int`               | Items to skip      |
| `take`              | `int`               | Items to take      |
| `cancellationToken` | `CancellationToken` | Cancellation token |

**Returns**: Tuple of (version history items, total count).

{% code title="Example" %}

```csharp
var (versions, total) = await _profileService.GetProfileVersionHistoryAsync(
    profileId, skip: 0, take: 10);

foreach (var version in versions)
{
    Console.WriteLine($"Version {version.Version} - {version.DateModified}");
}
```

{% endcode %}

### GetProfileVersionSnapshotAsync

Gets a snapshot of a profile at a specific version.

| Parameter           | Type                | Description        |
| ------------------- | ------------------- | ------------------ |
| `profileId`         | `Guid`              | The profile ID     |
| `version`           | `int`               | The version number |
| `cancellationToken` | `CancellationToken` | Cancellation token |

**Returns**: The profile at the specified version, or `null` if not found.

{% code title="Example" %}

```csharp
var snapshot = await _profileService.GetProfileVersionSnapshotAsync(profileId, version: 3);
if (snapshot != null)
{
    Console.WriteLine($"Profile at v{snapshot.Version}: {snapshot.Name}");
}
```

{% endcode %}

### RollbackProfileAsync

Rolls back a profile to a previous version. This creates a new version with the content from the target version.

| Parameter           | Type                | Description                        |
| ------------------- | ------------------- | ---------------------------------- |
| `profileId`         | `Guid`              | The profile ID                     |
| `targetVersion`     | `int`               | The version number to roll back to |
| `cancellationToken` | `CancellationToken` | Cancellation token                 |

**Returns**: The profile after rollback (with a new version number).

{% code title="Example" %}

```csharp
var rolledBack = await _profileService.RollbackProfileAsync(profileId, targetVersion: 2);
Console.WriteLine($"Rolled back to v2, now at v{rolledBack.Version}");
```

{% endcode %}

### ProfileAliasExistsAsync

Checks if a profile alias already exists. Optionally excludes a specific profile ID (useful when updating).

| Parameter           | Type                | Description                          |
| ------------------- | ------------------- | ------------------------------------ |
| `alias`             | `string`            | The alias to check                   |
| `excludeId`         | `Guid?`             | Profile ID to exclude from the check |
| `cancellationToken` | `CancellationToken` | Cancellation token                   |

**Returns**: `true` if the alias is already in use, otherwise `false`.

{% code title="Example" %}

```csharp
var exists = await _profileService.ProfileAliasExistsAsync("content-assistant");
if (exists)
{
    Console.WriteLine("Alias already taken");
}

// When updating, exclude the current profile
var taken = await _profileService.ProfileAliasExistsAsync("content-assistant", excludeId: profileId);
```

{% endcode %}

### ProfilesExistWithConnectionAsync

Checks if any profiles reference a specific connection. Useful before deleting a connection.

| Parameter           | Type                | Description        |
| ------------------- | ------------------- | ------------------ |
| `connectionId`      | `Guid`              | The connection ID  |
| `cancellationToken` | `CancellationToken` | Cancellation token |

**Returns**: `true` if one or more profiles reference the connection, otherwise `false`.

{% code title="Example" %}

```csharp
var inUse = await _profileService.ProfilesExistWithConnectionAsync(connectionId);
if (inUse)
{
    Console.WriteLine("Cannot delete connection: profiles are using it");
}
```

{% endcode %}
