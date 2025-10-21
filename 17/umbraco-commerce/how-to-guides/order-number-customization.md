---
description: Learn how to customize the default order number generated in Umbraco Commerce.
---

# Order Number Customization

Umbraco Commerce provides flexible options for customizing order numbers to meet your business requirements. This guide covers different approaches, from template-based customization to implementing fully custom generators.

## Built-in Generators

Before implementing a custom solution, understand that Umbraco Commerce includes two built-in order number generators:

- **CompactSortableOrderNumberGenerator** (Recommended) - Produces compact, time-sortable identifiers with high scalability and multi-node support
- **DateHashOrderNumberGenerator** (Legacy) - Date-based format maintained for backward compatibility

For detailed information about these generators and how they work, see the [Order Number Generators](../key-concepts/order-number-generators.md) key concepts documentation.

## Before Creating a Custom Generator

Consider these alternatives before implementing a custom generator:

### 1. Using Store Templates

You can customize order numbers through store-level templates. Templates allow you to add prefixes, suffixes, or formatting without writing any code:

```csharp
// Configure templates via the Store entity
await store.SetCartNumberTemplateAsync("CART-{0}");
await store.SetOrderNumberTemplateAsync("ORDER-{0}");
```

**Examples:**
- Template: `"ORDER-{0}"` + Generated: `"22345-67ABC"` = Final: `"ORDER-22345-67ABC"`
- Template: `"SO-{0}-2025"` + Generated: `"12345"` = Final: `"SO-12345-2025"`

This approach works with any generator and requires no custom code.

### 2. Using CompactSortableOrderNumberGenerator

The `CompactSortableOrderNumberGenerator` handles most common requirements:
- Compact format (10-11 characters)
- Time-sortable
- Multi-node safe
- High-volume capable (1,024 orders/sec per node)

If your store was upgraded from an earlier version and is using the legacy generator, you can explicitly switch to the recommended generator:

```csharp
public class MyComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.Services.AddUnique<IOrderNumberGenerator, CompactSortableOrderNumberGenerator>();
    }
}
```

## Implementing a Custom Order Number Generator

If the built-in generators don't meet your needs, you can create a custom implementation by implementing the `IOrderNumberGenerator` interface.

### Creating the Custom Generator

Define a class that implements the `IOrderNumberGenerator` interface:

{% code title="CustomOrderNumberGenerator.cs" %}

```csharp
using System;
using System.Threading;
using System.Threading.Tasks;
using Umbraco.Commerce.Core.Generators;
using Umbraco.Commerce.Core.Services;

public class CustomOrderNumberGenerator : IOrderNumberGenerator
{
    private readonly IStoreService _storeService;

    public CustomOrderNumberGenerator(IStoreService storeService)
    {
        _storeService = storeService;
    }

    public async Task<string> GenerateCartNumberAsync(Guid storeId, CancellationToken cancellationToken = default)
    {
        var store = await _storeService.GetStoreAsync(storeId);

        // Implement your custom logic for cart numbers
        var cartNumber = $"{DateTime.UtcNow:yyyyMMdd}-{Guid.NewGuid().ToString("N")[..8].ToUpperInvariant()}";

        // Apply store template if configured
        return string.Format(store.CartNumberTemplate ?? "{0}", cartNumber);
    }

    public async Task<string> GenerateOrderNumberAsync(Guid storeId, CancellationToken cancellationToken = default)
    {
        var store = await _storeService.GetStoreAsync(storeId);

        // Implement your custom logic for order numbers
        var orderNumber = $"{DateTime.UtcNow:yyyyMMdd}-{Random.Shared.Next(1000, 9999)}";

        // Apply store template if configured
        return string.Format(store.OrderNumberTemplate ?? "{0}", orderNumber);
    }
}
```

{% endcode %}

### Registering the Custom Implementation

After creating your custom generator, register it in `Program.cs` to replace the default implementation:

{% code title="Program.cs" %}

```csharp
builder.Services.AddUnique<IOrderNumberGenerator, CustomOrderNumberGenerator>();
```

{% endcode %}

The `AddUnique` method ensures that your custom generator replaces the default `IOrderNumberGenerator`, overriding both the automatic selection system and the built-in generators. For more details on dependency injection, see the [Dependency Injection](dependency-injection.md) article.

## Important Considerations

Before implementing a custom order number generator, be aware of the following:

- **Performance Implications:** Sequential order numbers may require database access to ensure uniqueness, which can become a performance bottleneck under heavy load. The default Umbraco Commerce generator uses a timestamp and random seed based algorithm to create numbers in memory, avoiding database hits.
- **Order Number Gaps:** In Umbraco Commerce, order numbers are generated before redirecting to the payment gateway. If a customer cancels or modifies their order after an order number has been assigned, a new number is generated for the subsequent attempt, leading to gaps in the sequence. This behavior can be problematic if sequential numbering is used for official records like VAT receipts, as such records typically require continuous sequences without gaps.
- **Accounting Considerations:** Umbraco Commerce is not designed as an accounting platform. If strict sequential numbering is required for accounting purposes, it is recommended to integrate with a dedicated accounting system to handle such requirements.

By understanding these factors, you can implement a custom order number generator that aligns with your specific requirements while maintaining optimal performance and compliance.

## Related Documentation

- [Order Number Generators](../key-concepts/order-number-generators.md) - Detailed documentation about the built-in generators
- [Dependency Injection](dependency-injection.md) - Learn more about registering services in Umbraco Commerce
