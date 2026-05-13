---
description: >-
    Connection to an AI provider with credentials.
---

# AIConnection

Represents a connection to an AI provider with authentication settings.

## Namespace

{% code title="Namespace" %}

```csharp
using Umbraco.AI.Core.Connections;
```

{% endcode %}

## Class Definition

{% code title="AIConnection" %}

```csharp
public class AIConnection : IAIVersionableEntity
{
    public Guid Id { get; internal set; }
    public required string Alias { get; set; }
    public required string Name { get; set; }
    public required string ProviderId { get; init; }
    public object? Settings { get; set; }
    public bool IsActive { get; set; } = true;
    public DateTime DateCreated { get; init; } = DateTime.UtcNow;
    public DateTime DateModified { get; set; } = DateTime.UtcNow;
    public int Version { get; internal set; } = 1;
    public Guid? CreatedByUserId { get; set; }
    public Guid? ModifiedByUserId { get; set; }
}
```

{% endcode %}

## Properties

| Property       | Type       | Description                                  |
| -------------- | ---------- | -------------------------------------------- |
| `Id`           | `Guid`     | Unique identifier (assigned on save)         |
| `Alias`        | `string`   | Unique alias for lookups                     |
| `Name`         | `string`   | Display name                                 |
| `ProviderId`   | `string`   | ID of the provider (for example, `"openai"`) |
| `Settings`     | `object?`  | Provider-specific settings                   |
| `IsActive`     | `bool`     | Whether connection is enabled                |
| `DateCreated`  | `DateTime` | Creation timestamp (UTC)                     |
| `DateModified` | `DateTime` | Last modification timestamp (UTC)            |
| `Version`      | `int`      | Version number, starts at 1, increments with each save |
| `CreatedByUserId` | `Guid?` | ID of the user who created the connection    |
| `ModifiedByUserId` | `Guid?` | ID of the user who last modified the connection |

## Settings

Settings are provider-specific. Each provider defines its own settings class.

### OpenAI Example

{% code title="OpenAI Settings" %}

```csharp
public class OpenAIProviderSettings
{
    public required string ApiKey { get; set; }
    public string? OrganizationId { get; set; }
    public string? BaseUrl { get; set; }
}
```

{% endcode %}

### Configuration References

Settings values starting with `$` are resolved from configuration:

{% code title="Using Config References" %}

```csharp
var connection = new AIConnection
{
    Alias = "production-openai",
    Name = "Production OpenAI",
    ProviderId = "openai",
    Settings = new
    {
        ApiKey = "$OpenAI:ApiKey"  // Resolved from appsettings.json
    }
};
```

{% endcode %}

{% code title="appsettings.json" %}

```json
{
    "OpenAI": {
        "ApiKey": "sk-actual-key-here"
    }
}
```

{% endcode %}

## Creating a Connection

{% code title="Example" %}

```csharp
using Umbraco.AI.Core.Connections;

var connection = new AIConnection
{
    Alias = "my-openai",
    Name = "My OpenAI Connection",
    ProviderId = "openai",
    Settings = new
    {
        ApiKey = "$OpenAI:ApiKey",
        OrganizationId = "org-123"
    },
    IsActive = true
};

var saved = await connectionService.SaveConnectionAsync(connection);
Console.WriteLine($"Connection ID: {saved.Id}");
```

{% endcode %}

## Notes

- `AIConnection` implements `IAIVersionableEntity` for version tracking
- `Id` is assigned automatically when saving
- `Version` starts at 1 and increments with each save
- `Alias` is mutable and can be changed after creation
- `ProviderId` is immutable after creation (`init` setter)
- `ProviderId` must match a registered provider
- Settings are validated against the provider's schema on save
