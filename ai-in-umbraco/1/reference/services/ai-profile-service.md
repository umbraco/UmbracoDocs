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
