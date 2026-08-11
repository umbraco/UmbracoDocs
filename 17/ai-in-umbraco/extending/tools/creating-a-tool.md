---
description: >-
    Step-by-step guide to creating a custom AI tool.
---

# Creating a Tool

This guide walks through creating a complete AI tool from start to finish.

## Step 1: Define Arguments (Optional)

If your tool needs input, create an arguments record with `[Description]` attributes:

{% code title="ContentSearchArgs.cs" %}

```csharp
using System.ComponentModel;

namespace MyProject.Tools;

/// <summary>
/// Arguments for the content search tool.
/// </summary>
public record ContentSearchArgs(
    [property: Description("The search query")] string Query,
    [property: Description("Content type to filter by (optional)")] string? ContentType = null,
    [property: Description("Maximum results (1-50, default 10)")] int MaxResults = 10);
```

{% endcode %}

{% hint style="info" %}
Use records for arguments - they're immutable and provide good serialization behavior.
{% endhint %}

## Step 2: Create the Tool Class

Choose the appropriate base class:

- `AIToolBase` - For tools without arguments
- `AIToolBase<TArgs>` - For tools with typed arguments

{% code title="ContentSearchTool.cs" %}

```csharp
using Umbraco.AI.Core.Tools;
using Umbraco.Cms.Core;
using Umbraco.Cms.Core.Models.PublishedContent;
using Umbraco.Cms.Core.Web;

namespace MyProject.Tools;

[AITool("search_content", "Search Content", ScopeId = "content-read")]
public class ContentSearchTool : AIToolBase<ContentSearchArgs>
{
    private readonly IUmbracoContextFactory _contextFactory;

    public ContentSearchTool(IUmbracoContextFactory contextFactory)
    {
        _contextFactory = contextFactory;
    }

    public override string Description =>
        "Searches Umbraco content by text query. Returns matching content items with their URLs.";

    protected override Task<object> ExecuteAsync(
        ContentSearchArgs args,
        CancellationToken cancellationToken = default)
    {
        using var context = _contextFactory.EnsureUmbracoContext();
        var cache = context.UmbracoContext?.Content;

        if (cache == null)
            return Task.FromResult<object>(new { Error = "Content cache unavailable" });

        var results = SearchContent(cache, args);

        return Task.FromResult<object>(new ContentSearchResult
        {
            Query = args.Query,
            TotalFound = results.Count,
            Items = results
        });
    }

    private List<ContentItem> SearchContent(IPublishedContentCache cache, ContentSearchArgs args)
    {
        // Simple search implementation
        var root = cache.GetAtRoot().FirstOrDefault();
        if (root == null) return new List<ContentItem>();

        var allContent = root.DescendantsOrSelf()
            .Where(c => c.Name?.Contains(args.Query, StringComparison.OrdinalIgnoreCase) == true);

        if (!string.IsNullOrEmpty(args.ContentType))
        {
            allContent = allContent.Where(c =>
                c.ContentType.Alias.Equals(args.ContentType, StringComparison.OrdinalIgnoreCase));
        }

        return allContent
            .Take(Math.Min(args.MaxResults, 50))
            .Select(c => new ContentItem
            {
                Id = c.Id,
                Name = c.Name ?? "",
                ContentType = c.ContentType.Alias,
                Url = c.Url()
            })
            .ToList();
    }
}

public class ContentSearchResult
{
    public string Query { get; set; } = "";
    public int TotalFound { get; set; }
    public List<ContentItem> Items { get; set; } = new();
}

public class ContentItem
{
    public int Id { get; set; }
    public string Name { get; set; } = "";
    public string ContentType { get; set; } = "";
    public string? Url { get; set; }
}
```

{% endcode %}

## Step 3: Configure the AITool Attribute

The `[AITool]` attribute provides metadata:

{% code title="Attribute Options" %}

```csharp
[AITool(
    "tool_id",              // Unique identifier (required)
    "Display Name",         // Human-readable name (required)
    ScopeId = "scope-id",   // Scope identifier for tool grouping
    IsDestructive = false,  // Whether tool modifies data (default: false)
    Tags = new[] { "tag1", "tag2" }  // Additional tags (default: empty)
)]
```

{% endcode %}

## Step 4: Test Your Tool

Create a test to verify the tool works:

{% code title="ContentSearchToolTests.cs" %}

```csharp
using Moq;
using Xunit;

public class ContentSearchToolTests
{
    [Fact]
    public async Task ExecuteAsync_ReturnsResults()
    {
        // Arrange
        var contextFactory = CreateMockContextFactory();
        var tool = new ContentSearchTool(contextFactory);

        // Act
        // The protected ExecuteAsync is invoked via the IAITool interface
        var result = await ((IAITool)tool).ExecuteAsync(
            new ContentSearchArgs("test"),
            CancellationToken.None);

        // Assert
        var searchResult = result as ContentSearchResult;
        Assert.NotNull(searchResult);
    }

    private IUmbracoContextFactory CreateMockContextFactory()
    {
        // Set up mocks...
    }
}
```

{% endcode %}

## Tool Without Arguments

For tools that don't need input:

{% code title="ServerInfoTool.cs" %}

```csharp
using Umbraco.AI.Core.Tools;
using Umbraco.Cms.Core.Configuration;

[AITool("get_server_info", "Get Server Info", ScopeId = "system")]
public class ServerInfoTool : AIToolBase
{
    private readonly IUmbracoVersion _version;

    public ServerInfoTool(IUmbracoVersion version)
    {
        _version = version;
    }

    public override string Description =>
        "Returns information about the Umbraco server.";

    protected override Task<object> ExecuteAsync(CancellationToken cancellationToken = default)
    {
        return Task.FromResult<object>(new
        {
            UmbracoVersion = _version.Version.ToString(),
            ServerTime = DateTime.UtcNow,
            Environment = Environment.GetEnvironmentVariable("ASPNETCORE_ENVIRONMENT") ?? "Production"
        });
    }
}
```

{% endcode %}

## Handling Errors

Return error information in the result rather than throwing exceptions:

{% code title="Error Handling" %}

```csharp
protected override async Task<object> ExecuteAsync(
    MyArgs args,
    CancellationToken cancellationToken = default)
{
    try
    {
        var result = await _service.DoSomethingAsync(args.Id, cancellationToken);

        if (result == null)
        {
            return new { Error = $"Item with ID {args.Id} not found" };
        }

        return new { Success = true, Data = result };
    }
    catch (UnauthorizedAccessException)
    {
        return new { Error = "Access denied to this resource" };
    }
    catch (Exception ex)
    {
        // Log the exception
        _logger.LogError(ex, "Tool execution failed");
        return new { Error = "An unexpected error occurred" };
    }
}
```

{% endcode %}

## Best Practices

- **Write clear descriptions** - Be specific about what the tool does and what it returns so the AI knows when to use it.
- **Use descriptive argument names** - Include `[Description]` attributes that explain the expected format and constraints.
- **Keep tools focused** - Each tool should do one thing well. Prefer separate `GetUser` and `CreateUser` tools over a single `ManageUsers` tool.
- **Mark destructive operations** - Set `IsDestructive = true` on tools that modify or delete data.
