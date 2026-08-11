---
description: >-
    Contexts define brand voice, guidelines, and additional content that get injected into AI operations.
---

# Contexts

A context is a collection of resources that provide additional information to AI operations. Contexts enable you to maintain consistent brand voice, inject guidelines, or include relevant content (like retrieval-augmented generation (RAG) data) into every AI request.

## What Contexts Store

| Property    | Description                                  |
| ----------- | -------------------------------------------- |
| `Id`        | Unique identifier (GUID)                     |
| `Alias`     | Unique string for programmatic lookup        |
| `Name`      | Display name shown in the backoffice         |
| `Resources` | Collection of context resources              |
| `Version`   | Current version number (for version history) |

## Context Resources

Each context contains one or more resources. A resource represents a piece of content that gets injected into AI requests.

| Property         | Description                                     |
| ---------------- | ----------------------------------------------- |
| `Id`             | Unique identifier (GUID)                        |
| `ResourceTypeId` | The type of resource (e.g., "text", "document") |
| `Name`           | Display name for the resource                   |
| `Description`    | Optional description                            |
| `SortOrder`      | Controls injection order                        |
| `Settings`       | Type-specific settings                           |
| `InjectionMode`  | When the resource is injected                   |

### Injection Modes

Resources can be injected based on different conditions:

| Mode       | Description                                         |
| ---------- | --------------------------------------------------- |
| `Always`   | Resource is always included (default)               |
| `OnDemand` | Resource is included only when explicitly requested |

## Using Contexts in Code

### Getting a Context

{% code title="Example.cs" %}

```csharp
public class ContextExample
{
    private readonly IAIContextService _contextService;

    public ContextExample(IAIContextService contextService)
    {
        _contextService = contextService;
    }

    public async Task<AIContext?> GetBrandContext()
    {
        return await _contextService.GetContextByAliasAsync("brand-voice");
    }
}
```

{% endcode %}

### Creating a Context

{% code title="Example.cs" %}

```csharp
using Umbraco.AI.Core.Contexts.ResourceTypes.BuiltIn;

public async Task<AIContext> CreateContext()
{
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
                Settings = new TextResourceSettings
                {
                    Content = "Always use a friendly, professional tone..."
                }
            }
        }
    };

    return await _contextService.SaveContextAsync(context);
}
```

{% endcode %}

## How Context Injection Works

When an AI operation executes with contexts:

1. All associated contexts are retrieved.
2. Resources are sorted by `SortOrder`.
3. Resources with matching `InjectionMode` are selected.
4. Resource content is formatted and injected into the system message.
5. The AI model receives the enriched request.

When multiple contexts are used, they are processed in the order they are listed. Within each context, resources are processed by `SortOrder`, and all resource content is concatenated into the system context.

## Managing Contexts

### Via Backoffice

You can create, edit, and delete contexts through the backoffice. See [Managing Contexts](../backoffice/managing-contexts.md) for step-by-step instructions.

### Via Code

For programmatic context management, see the [IAIContextService](../reference/services/ai-context-service.md) reference.

## Version History

Contexts support version history. Every time you save a context, a new version is created. You can:

- View the version history.
- Compare different versions.
- Roll back to a previous version.

See [Version History](versioning.md) for more information.

## Related

- [Profiles](profiles.md) - Use contexts with AI profiles
- [Version History](versioning.md) - Track context changes over time
- [Managing Contexts](../backoffice/managing-contexts.md) - Backoffice guide
