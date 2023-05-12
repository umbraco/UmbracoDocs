---
description: How-To Guide to limit order line quantity in Vendr, the eCommerce solution for Umbraco.
---

# Limit Order Line Quantity

In this guide we will be looking at Validation events in Vendr. These enabled you to limit order line quantity based on:

* The existing stock value on the product, and
* The existing quantities of the product in the cart.

## ProductAddValidationHandler

When adding a product to the cart we need to verify that the product is in stock. We also need to verify that the customer does not already have the remaining quantities in cart.

```csharp
public class ProductAddValidationHandler : ValidationEventHandlerBase<ValidateOrderProductAdd>
{
    private readonly IProductService _productService;

    public ProductAddValidationHandler(IProductService productService)
    {
        _productService = productService;
    }

    public override void Validate(ValidateOrderProductAdd evt)
    {
        var order = evt.Order;
        var productReference = evt.ProductReference;

        var stock = _productService.GetProductStock(productReference);

        var totalQuantities = order?.OrderLines.Where(x => x.ProductReference == productReference).Sum(x => x.Quantity) ?? 0;

        if (stock.HasValue && totalQuantities >= stock.Value)
            evt.Fail($"Only {stock} quantities can be purchased for {productReference}.");
    }
}

```

## OrderLineQuantityValidationHandler

When changing the order line quantity on cart page, we need to ensure that the quantities being changed are in stock.

```csharp
public class OrderLineQuantityValidationHandler : ValidationEventHandlerBase<ValidateOrderLineQuantityChange>
{
    private readonly IProductService _productService;

    public OrderLineQuantityValidationHandler(IProductService productService)
    {
        _productService = productService;
    }

    public override void Validate(ValidateOrderLineQuantityChange evt)
    {
        var orderLine = evt.OrderLine;
        var productReference = orderLine.ProductReference;

        var stock = _productService.GetProductStock(productReference);

        if (stock.HasValue && evt.Quantity.To > stock.Value)
            evt.Fail($"Only {stock} quantities can be purchased for {productReference}.");
    }
}

```

## Register event handlers

Finally we need to register the Vendr event handlers via an `IVendrBuilder` extension.

```csharp
public static class VendrBuilderExtensions
{
    public static IVendrBuilder AddEventHandlers(IVendrBuilder builder)
    {
        // Register event handlers
        builder.WithValidationEvent<ValidateOrderProductAdd>()
            .RegisterHandler<ProductAddValidationHandler>();

        builder.WithValidationEvent<ValidateOrderLineQuantityChange>()
            .RegisterHandler<OrderLineQuantityValidationHandler>();

        return builder;
    }
}
```
