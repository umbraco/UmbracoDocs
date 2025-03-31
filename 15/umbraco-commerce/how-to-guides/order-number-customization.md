---
description: Learn how to customize the default order number generated in Umbraco Commerce.
---

# Order Number Customization

In Umbraco Commerce, the default order number generation can be customized by implementing the `IOrderNumberGenerator` interface. This interface defines two methods: `GenerateCartNumber(Guid storeId)` and `GenerateOrderNumber(Guid storeId)`, which you can override to create a custom numbering system.​

## Implementing a Custom Order Number Generator

To create a custom order number generator, define a class that implements the `IOrderNumberGenerator` interface, for example, `CustomOrderNumberGenerator.cs`:

{% code title="CustomOrderNumberGenerator.cs" %}

```csharp
using Umbraco.Commerce.Core.Generators;

public class CustomOrderNumberGenerator : IOrderNumberGenerator
{
    public string GenerateCartNumber(Guid storeId)
    {
        // Implement custom logic for cart numbers
    }

    public string GenerateOrderNumber(Guid storeId)
    {
        // Implement custom logic for order numbers
    }
}
```

{% endcode %}

## Registering the Custom Implementation

After creating your custom generator, register it in `Program.cs` to replace the default implementation:

```cs
builder.Services.AddUnique<IOrderNumberGenerator, MyOrderNumberGenerator>();
```

The `AddUnique` method ensures that your custom generator replaces the default `IOrderNumberGenerator`. For more details on dependency injection, see the [Dependency Injection](dependency-injection.md) article.

## Important Considerations

Before implementing a custom order number generator, be aware of the following:

- **Performance Implications:** Sequential order numbers may require database access to ensure uniqueness, which can become a performance bottleneck under heavy load. The default Umbraco Commerce generator uses a timestamp and random seed based algorithm to create numbers in memory, avoiding database hits.
- **Order Number Gaps:** In Umbraco Commerce, order numbers are generated before redirecting to the payment gateway. If a customer cancels or modifies their order after an order number has been assigned, a new number is generated for the subsequent attempt, leading to gaps in the sequence. This behavior can be problematic if sequential numbering is used for official records like VAT receipts, as such records typically require continuous sequences without gaps.
- **Accounting Considerations:** Umbraco Commerce is not designed as an accounting platform. If strict sequential numbering is required for accounting purposes, it is recommended to integrate with a dedicated accounting system to handle such requirements.

By understanding these factors, you can implement a custom order number generator that aligns with your specific requirements while maintaining optimal performance and compliance.
