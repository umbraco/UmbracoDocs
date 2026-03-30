---
description: >-
    Model representing an AI context with resources.
---

# AIContext

Represents a collection of resources (brand voice, guidelines, content) that can be injected into AI operations.

## Namespace

```csharp
using Umbraco.AI.Core.Contexts;
```

## Definition

{% code title="AIContext" %}

```csharp
public class AIContext : IAIVersionableEntity
{
    public Guid Id { get; internal set; }
    public required string Alias { get; set; }
    public required string Name { get; set; }
    public IList<AIContextResource> Resources { get; set; } = new List<AIContextResource>();

    // Audit properties
    public DateTime DateCreated { get; init; } = DateTime.UtcNow;
    public DateTime DateModified { get; set; } = DateTime.UtcNow;
    public Guid? CreatedByUserId { get; init; }
    public Guid? ModifiedByUserId { get; set; }

    // Versioning
    public int Version { get; internal set; } = 1;
}
```

{% endcode %}

## Properties

| Property           | Type                       | Description                                     |
| ------------------ | -------------------------- | ----------------------------------------------- |
| `Id`               | `Guid`                     | Unique identifier (auto-generated)              |
| `Alias`            | `string`                   | Unique alias for programmatic lookup (required) |
| `Name`             | `string`                   | Display name (required)                         |
| `Resources`        | `IList<AIContextResource>` | Collection of resources                         |
| `DateCreated`      | `DateTime`                 | When created (UTC)                              |
| `DateModified`     | `DateTime`                 | When last modified (UTC)                        |
| `CreatedByUserId`  | `Guid?`                    | User who created                                |
| `ModifiedByUserId` | `Guid?`                    | User who last modified                          |
| `Version`          | `int`                      | Current version number                          |

## Example

{% code title="Example" %}

```csharp
var context = new AIContext
{
    Alias = "brand-guidelines",
    Name = "Brand Guidelines",
    Resources = new List<AIContextResource>
    {
        new AIContextResource
        {
            ResourceTypeId = "text",
            Name = "Tone of Voice",
            Description = "Writing style guidelines",
            SortOrder = 0,
            Data = "Always use a friendly, professional tone...",
            InjectionMode = AIContextResourceInjectionMode.Always
        },
        new AIContextResource
        {
            ResourceTypeId = "text",
            Name = "Product Terminology",
            SortOrder = 1,
            Data = "Use these terms when discussing products..."
        }
    }
};
```

{% endcode %}

## Related

- [AIContextResource](#aicontextresource) - Resource model
- [IAIContextService](../services/ai-context-service.md) - Context service

---

# AIContextResource

Represents a single resource within a context.

## Definition

{% code title="AIContextResource" %}

```csharp
public class AIContextResource
{
    public Guid Id { get; internal set; }
    public required string ResourceTypeId { get; init; }
    public required string Name { get; set; }
    public string? Description { get; set; }
    public int SortOrder { get; set; }
    public object? Data { get; set; }
    public AIContextResourceInjectionMode InjectionMode { get; set; } = AIContextResourceInjectionMode.Always;
}
```

{% endcode %}

## Properties

| Property         | Type                             | Description                            |
| ---------------- | -------------------------------- | -------------------------------------- |
| `Id`             | `Guid`                           | Unique identifier (auto-generated)     |
| `ResourceTypeId` | `string`                         | Type of resource (required, immutable) |
| `Name`           | `string`                         | Display name (required)                |
| `Description`    | `string?`                        | Optional description                   |
| `SortOrder`      | `int`                            | Order for injection                    |
| `Data`           | `object?`                        | Resource content (type-specific)       |
| `InjectionMode`  | `AIContextResourceInjectionMode` | When to inject                         |

## Resource Types

| Type ID    | Data Type | Description         |
| ---------- | --------- | ------------------- |
| `text`     | `string`  | Plain text content  |
| `document` | `object`  | Structured document |
| `url`      | `string`  | URL reference       |

## Injection Modes

{% code title="AIContextResourceInjectionMode" %}

```csharp
public enum AIContextResourceInjectionMode
{
    Always = 0,   // Always inject
    OnDemand = 1  // Only inject when explicitly requested
}
```

{% endcode %}
