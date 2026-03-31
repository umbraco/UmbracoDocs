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

## Why Use Contexts

Contexts provide these benefits:

- **Consistency** - Maintain brand voice across all AI interactions
- **Separation** - Keep guidelines separate from business logic
- **Reusability** - Share the same context across multiple profiles
- **Manageability** - Update guidelines without code changes
- **RAG Support** - Inject relevant content for RAG workflows

## Example Context Configurations

| Context            | Use Case         | Resources                           |
| ------------------ | ---------------- | ----------------------------------- |
| `brand-voice`      | Consistent tone  | Writing guidelines, terminology     |
| `product-catalog`  | E-commerce       | Product descriptions, pricing rules |
| `support-kb`       | Customer service | FAQ, troubleshooting guides         |
| `legal-compliance` | Regulatory       | Compliance rules, disclaimers       |

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
                Settings = "Always use a friendly, professional tone..."
            }
        }
    };

    return await _contextService.SaveContextAsync(context);
}
```

{% endcode %}

### Using Contexts with Profiles

Contexts are typically associated with prompts or agents rather than directly with profiles. When executing a prompt or running an agent, the associated contexts are automatically injected.

{% code title="Example.cs" %}

```csharp
// Contexts are injected automatically when using prompts
var result = await _promptService.ExecutePromptAsync(
    promptId,
    new AIPromptExecutionRequest
    {
        EntityContext = "The product being described..."
    });
```

{% endcode %}

## How Context Injection Works

When an AI operation executes with contexts:

1. All associated contexts are retrieved
2. Resources are sorted by `SortOrder`
3. Resources with matching `InjectionMode` are selected
4. Resource content is formatted and injected into the system message
5. The AI model receives the enriched request

## Context Resolution Order

When multiple contexts are used:

1. Contexts are processed in the order they're listed
2. Within each context, resources are processed by `SortOrder`
3. All resource content is concatenated into the system context

## Managing Contexts

### Via Backoffice

You can create, edit, and delete contexts through the backoffice. See [Managing Contexts](../backoffice/managing-contexts.md) for step-by-step instructions.

### Via Code

{% code title="Example.cs" %}

```csharp
public class ContextManagement
{
    private readonly IAIContextService _contextService;

    public ContextManagement(IAIContextService contextService)
    {
        _contextService = contextService;
    }

    public async Task<IEnumerable<AIContext>> GetAllContexts()
    {
        return await _contextService.GetContextsAsync();
    }

    public async Task<bool> DeleteContext(Guid id)
    {
        return await _contextService.DeleteContextAsync(id);
    }
}
```

{% endcode %}

## Version History

Contexts support version history. Every time you save a context, a new version is created. You can:

- View the version history
- Compare different versions
- Roll back to a previous version

See [Version History](versioning.md) for more information.

## Related

- [Profiles](profiles.md) - Use contexts with AI profiles
- [Version History](versioning.md) - Track context changes over time
- [Managing Contexts](../backoffice/managing-contexts.md) - Backoffice guide
