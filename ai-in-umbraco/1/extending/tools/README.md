---
description: >-
    Create custom tools that AI models can invoke.
---

# Custom Tools

Tools (also called functions) are actions that AI models can request to be executed. They enable AI to interact with your application, query data, or perform operations.

## What Are Tools?

When you enable tools in a chat request, the AI model can:

1. Recognize when it needs to perform an action
2. Request tool execution with arguments
3. Use the result to continue the conversation

```
User: "What's the current inventory for product SKU-123?"

AI thinks: "I should use the inventory lookup tool"

AI requests: InventoryTool.Execute({ sku: "SKU-123" })

Tool returns: { quantity: 47, location: "Warehouse A" }

AI responds: "Product SKU-123 has 47 units in stock at Warehouse A."
```

## Tool Architecture

A tool consists of:

1. **Metadata** - ID, name, description, category via `[AITool]` attribute
2. **Arguments** - Optional input parameters as a typed class
3. **Implementation** - The `ExecuteAsync` method

```
MyTool/
├── MyToolArgs.cs        # Input parameters (optional)
├── MyTool.cs            # Tool implementation with [AITool] attribute
└── MyToolResult.cs      # Return type (optional)
```

## Quick Start

### Tool Without Arguments

{% code title="CurrentTimeTool.cs" %}

```csharp
using Umbraco.AI.Core.Tools;

[AITool("get_current_time", "Get Current Time")]
public class CurrentTimeTool : AIToolBase
{
    public override string Description =>
        "Returns the current server date and time.";

    protected override Task<object> ExecuteAsync(CancellationToken cancellationToken = default)
    {
        return Task.FromResult<object>(new
        {
            DateTime = DateTime.UtcNow,
            Timezone = "UTC"
        });
    }
}
```

{% endcode %}

### Tool With Arguments

{% code title="InventoryTool.cs" %}

```csharp
using System.ComponentModel;
using Umbraco.AI.Core.Tools;

public record InventoryArgs(
    [property: Description("The product SKU to look up")] string Sku);

[AITool("lookup_inventory", "Lookup Inventory", Category = "Products")]
public class InventoryTool : AIToolBase<InventoryArgs>
{
    private readonly IProductService _productService;

    public InventoryTool(IProductService productService)
    {
        _productService = productService;
    }

    public override string Description =>
        "Looks up current inventory levels for a product by SKU.";

    protected override async Task<object> ExecuteAsync(
        InventoryArgs args,
        CancellationToken cancellationToken = default)
    {
        var product = await _productService.GetBySkuAsync(args.Sku, cancellationToken);

        if (product == null)
            return new { Error = $"Product {args.Sku} not found" };

        return new
        {
            Sku = args.Sku,
            Quantity = product.StockLevel,
            Location = product.WarehouseLocation
        };
    }
}
```

{% endcode %}

## Registration

Tools are auto-discovered via the `[AITool]` attribute and `IDiscoverable` interface. To manually control registration:

{% code title="MyComposer.cs" %}

```csharp
using Umbraco.AI.Extensions;
using Umbraco.Cms.Core.Composing;

public class MyComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        // Add a tool that isn't auto-discovered
        builder.AITools()
            .Add<MyCustomTool>();

        // Exclude an auto-discovered tool
        builder.AITools()
            .Exclude<SomeUnwantedTool>();
    }
}
```

{% endcode %}

## Key Concepts

### Arguments Use Description Attributes

The `[Description]` attribute tells the AI what each argument is for:

```csharp
public record SearchArgs(
    [property: Description("The search query text")] string Query,
    [property: Description("Maximum results to return (1-100)")] int MaxResults = 10,
    [property: Description("Include archived items")] bool IncludeArchived = false);
```

### Tools Support Dependency Injection

Inject services through the constructor:

```csharp
[AITool("send_email", "Send Email")]
public class SendEmailTool : AIToolBase<EmailArgs>
{
    private readonly IEmailService _emailService;
    private readonly ILogger<SendEmailTool> _logger;

    public SendEmailTool(IEmailService emailService, ILogger<SendEmailTool> logger)
    {
        _emailService = emailService;
        _logger = logger;
    }

    // ...
}
```

### Mark Destructive Tools

Tools that modify data should be marked as destructive:

```csharp
[AITool("delete_item", "Delete Item", IsDestructive = true)]
public class DeleteItemTool : AIToolBase<DeleteArgs>
{
    // ...
}
```

## In This Section

{% content-ref url="creating-a-tool.md" %}
[Creating a Tool](creating-a-tool.md)
{% endcontent-ref %}
