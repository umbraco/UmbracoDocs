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

[AITool("search_content", "Search Content", Category = "Content")]
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
    Category = "Category",  // Grouping category (default: "General")
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
        var result = await tool.ExecuteAsync(
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

[AITool("get_server_info", "Get Server Info", Category = "System")]
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

### Write Clear Descriptions

The description helps the AI understand when to use the tool:

```csharp
// Good - specific and actionable
public override string Description =>
    "Searches for products by SKU, name, or category. Returns product details including price and stock level.";

// Bad - vague
public override string Description =>
    "Gets product information.";
```

### Use Descriptive Argument Names

```csharp
// Good - clear purpose
public record OrderArgs(
    [property: Description("Customer email address")] string CustomerEmail,
    [property: Description("Order total in cents")] int TotalCents);

// Bad - unclear
public record OrderArgs(
    [property: Description("Email")] string E,
    [property: Description("Amount")] int A);
```

### Keep Tools Focused

Each tool should do one thing well:

```csharp
// Good - single responsibility
[AITool("get_user", "Get User")]
public class GetUserTool : AIToolBase<GetUserArgs> { }

[AITool("create_user", "Create User", IsDestructive = true)]
public class CreateUserTool : AIToolBase<CreateUserArgs> { }

// Bad - too many responsibilities
[AITool("manage_users", "Manage Users")]
public class ManageUsersTool : AIToolBase<ManageUsersArgs> { }
```

### Mark Destructive Operations

```csharp
[AITool("delete_content", "Delete Content", IsDestructive = true)]
public class DeleteContentTool : AIToolBase<DeleteArgs>
{
    public override string Description =>
        "Permanently deletes a content item. This action cannot be undone.";
}
```

## Complete Example: Weather Tool

{% code title="WeatherTool.cs" %}

```csharp
using System.ComponentModel;
using Microsoft.Extensions.Logging;
using Umbraco.AI.Core.Tools;

namespace MyProject.Tools;

public record WeatherArgs(
    [property: Description("City name (e.g., 'London', 'New York')")] string City,
    [property: Description("Temperature unit: 'celsius' or 'fahrenheit'")] string Unit = "celsius");

public record WeatherResult(
    string City,
    double Temperature,
    string Unit,
    string Condition,
    int Humidity,
    DateTime RetrievedAt);

[AITool("get_weather", "Get Weather", Category = "Utilities", Tags = new[] { "weather", "external" })]
public class WeatherTool : AIToolBase<WeatherArgs>
{
    private readonly HttpClient _httpClient;
    private readonly ILogger<WeatherTool> _logger;

    public WeatherTool(HttpClient httpClient, ILogger<WeatherTool> logger)
    {
        _httpClient = httpClient;
        _logger = logger;
    }

    public override string Description =>
        "Gets current weather conditions for a city. Returns temperature, conditions, and humidity.";

    protected override async Task<object> ExecuteAsync(
        WeatherArgs args,
        CancellationToken cancellationToken = default)
    {
        try
        {
            // Call weather API (simplified example)
            var response = await _httpClient.GetAsync(
                $"https://api.weather.example.com/current?city={args.City}",
                cancellationToken);

            if (!response.IsSuccessStatusCode)
            {
                return new { Error = $"Weather data unavailable for {args.City}" };
            }

            var data = await response.Content.ReadFromJsonAsync<WeatherApiResponse>(
                cancellationToken: cancellationToken);

            var temperature = args.Unit.ToLower() == "fahrenheit"
                ? data!.TempCelsius * 9 / 5 + 32
                : data!.TempCelsius;

            return new WeatherResult(
                City: args.City,
                Temperature: Math.Round(temperature, 1),
                Unit: args.Unit,
                Condition: data.Condition,
                Humidity: data.Humidity,
                RetrievedAt: DateTime.UtcNow);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Failed to get weather for {City}", args.City);
            return new { Error = "Unable to retrieve weather data" };
        }
    }
}

internal class WeatherApiResponse
{
    public double TempCelsius { get; set; }
    public string Condition { get; set; } = "";
    public int Humidity { get; set; }
}
```

{% endcode %}
