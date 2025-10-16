---
title: Order Number Generators
description: Learn about the `IOrderNumberGenerator` interface in Umbraco Commerce
---

# Order Number Generators

Order Number Generators are responsible for generating unique, human-readable identifiers for carts and orders in Umbraco Commerce. These generators ensure that each cart and order receives a distinct number that can be used for tracking, customer communication, and administrative purposes.

## IOrderNumberGenerator Interface

The `IOrderNumberGenerator` interface defines the contract for generating order and cart numbers:

```csharp
public interface IOrderNumberGenerator
{
    Task<string> GenerateCartNumberAsync(Guid storeId, CancellationToken cancellationToken = default);
    Task<string> GenerateOrderNumberAsync(Guid storeId, CancellationToken cancellationToken = default);
}
```

The interface provides two key methods:

- **GenerateCartNumberAsync** - Generates a unique number for shopping carts (orders that haven't been finalized)
- **GenerateOrderNumberAsync** - Generates a unique number for finalized orders

Both methods are store-scoped, allowing different stores in a multi-tenant environment to have independent number sequences.

## Built-in Generators

Umbraco Commerce includes two built-in order number generators:

### CompactSortableOrderNumberGenerator (Recommended)

The `CompactSortableOrderNumberGenerator` is the recommended generator introduced in Umbraco Commerce 16.4. It produces compact, time-sortable identifiers with high scalability characteristics.

**Format:** 10-character Base32 encoded ID with hyphen formatting

Where:
- `timeComponent` - 7 Base32 characters encoding seconds since January 1, 2025 (supports ~1089 years)
- `nodeId` - 1 Base32 character representing the server/node ID (0-31)
- `sequence` - 2 Base32 characters encoding a per-second sequence number (0-1023)

**Example:** `22345-67ABC` (hyphen inserted at position 5 for readability)

**Characteristics:**
- **Compact** - Only 10 characters (11 with hyphen formatting)
- **Time-sortable** - Lexicographic ordering matches chronological ordering
- **Scalable** - Supports up to 1,024 orders per second per node (gracefully waits for the next second if capacity is exceeded rather than failing)
- **Multi-node safe** - Node ID prevents collisions in clustered environments
- **Visual variety** - Character rotation based on time reduces visual repetition

**Base32 Alphabet:** Uses Crockford-like Base32 (`23456789ABCDEFGHJKLMNPQRSTUVWXYZ`) which excludes ambiguous characters (0, 1, I, O).

**Number Template Support:**
Cart and order numbers can be formatted using the store's `CartNumberTemplate` and `OrderNumberTemplate` settings (defaults: `"CART-{0}"` and `"ORDER-{0}"`).

### DateHashOrderNumberGenerator (Legacy)

The `DateHashOrderNumberGenerator` is the legacy generator from earlier versions of Umbraco Commerce. It creates order numbers based on the current date and time, combined with a random string component.

{% hint style="info" %}
This generator is maintained for backward compatibility with existing stores, but will eventually be deprecated. New implementations should use `CompactSortableOrderNumberGenerator`.
{% endhint %}

**Format:** `{dayCount:00000}-{timeCount:000000}-{randomString}`

Where:
- **dayCount** - Number of days since January 1, 2020 (5 digits)
- **timeCount** - Number of seconds elapsed in the current day (6 digits for carts, 5 for orders)
- **randomString** - 5 random characters from the set `BCDFGHJKLMNPQRSTVWXYZ3456789`

**Example:** `02103-45678-H4K9P`

**Characteristics:**
- Human-readable with embedded date information
- Random component reduces predictability
- No sequential ordering within the same second
- Collision risk increases if multiple orders are placed simultaneously
- Not suitable for high-volume or multi-node scenarios

## How Generators Are Chosen

Since Umbraco Commerce 16.4, the platform automatically selects the appropriate generator based on your store's state:

- **New installations (16.4+)** - Uses `CompactSortableOrderNumberGenerator` for all new stores
- **Upgrades with existing orders** - Continues using `DateHashOrderNumberGenerator` for stores that already have orders, ensuring consistent number formats
- **Upgrades without orders** - Switches to `CompactSortableOrderNumberGenerator` for stores with no existing orders

Prior to version 16.4, all installations used `DateHashOrderNumberGenerator` by default.

This automatic selection ensures backward compatibility while enabling improved functionality for new stores.

## Explicitly Choosing a Generator

If you want to explicitly choose which generator to use, you can override the registration in your application startup.

### Using CompactSortableOrderNumberGenerator (Recommended)

To explicitly use the compact sortable generator (for example, when migrating an existing store to the new format):

```csharp
public class MyComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.Services.AddUnique<IOrderNumberGenerator, CompactSortableOrderNumberGenerator>();
    }
}
```

### Using DateHashOrderNumberGenerator (Legacy Only)

Only use this if you need to maintain the legacy format on a system that was upgraded:

```csharp
public class MyComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.Services.AddUnique<IOrderNumberGenerator, DateHashOrderNumberGenerator>();
    }
}
```

{% hint style="warning" %}
**Warning:** Changing the order number generator on an existing store will result in different number formats for new orders. Ensure your business processes and integrations can handle mixed formats before making changes.
{% endhint %}

## Creating a Custom Generator

You can create custom order number generators by implementing the `IOrderNumberGenerator` interface:

```csharp
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

        // Your custom cart number generation logic
        var cartNumber = Guid.NewGuid().ToString("N")[..8].ToUpperInvariant();

        // Apply store template if configured
        return string.Format(store.CartNumberTemplate ?? "{0}", cartNumber);
    }

    public async Task<string> GenerateOrderNumberAsync(Guid storeId, CancellationToken cancellationToken = default)
    {
        var store = await _storeService.GetStoreAsync(storeId);

        // Your custom order number generation logic
        var orderNumber = DateTime.UtcNow.ToString("yyyyMMdd") + "-" +
                         Random.Shared.Next(1000, 9999);

        // Apply store template if configured
        return string.Format(store.OrderNumberTemplate ?? "{0}", orderNumber);
    }
}
```

### Registering a Custom Generator

Register your custom generator during application startup to replace the default implementation:

```csharp
public class MyComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.Services.AddUnique<IOrderNumberGenerator, CustomOrderNumberGenerator>();
    }
}
```

### Important Considerations for Custom Generators

When implementing a custom generator, ensure:

1. **Uniqueness** - Generated numbers must be globally unique across all time
2. **Consistency** - The same store should produce numbers in a consistent format
3. **Thread-safety** - Handle concurrent calls safely, especially for sequential numbering
4. **Template support** - Apply the store's `CartNumberTemplate` and `OrderNumberTemplate` settings
5. **Store isolation** - Consider supporting store-specific sequences in multi-store scenarios
6. **Scalability** - Handle high-volume scenarios if your store expects significant traffic
7. **Cluster-awareness** - In multi-node environments, ensure numbers don't collide across nodes
8. **Readability** - Balance uniqueness with human readability for customer communication

{% hint style="warning" %}
**Important:** Order numbers may have gaps if customers cancel or modify orders during the checkout process. Umbraco Commerce is not designed as an accounting platform. If you require strict sequential numbering for accounting purposes, integration with a dedicated accounting system is recommended. Additionally, sequential numbering can impact performance due to potential database access requirements.
{% endhint %}

## Configuration

Order number templates are configured at the store level and provide a way to add prefixes or suffixes to generated numbers:

```csharp
// Set via the Store entity
await store.SetCartNumberTemplateAsync("CART-{0}");
await store.SetOrderNumberTemplateAsync("ORDER-{0}");
```

The `{0}` placeholder is replaced with the generated number from the active generator.

**Examples:**
- Template: `"ORDER-{0}"` + Generated: `"22345-67ABC"` = Final: `"ORDER-22345-67ABC"`
- Template: `"{0}"` + Generated: `"02103-45678-H4K9P"` = Final: `"02103-45678-H4K9P"`
- Template: `"SO-{0}-2025"` + Generated: `"12345"` = Final: `"SO-12345-2025"`

Templates are applied regardless of which generator is active, providing consistent branding across your order numbers.
