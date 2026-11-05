---
description: Guide to limit order line quantity in Umbraco Commerce.
---

# Limit Order Line Quantity

{% hint style="info" %}
Since Commerce 15.3.2, there is a built-in orderline quantity check that handles the validation automatically.
{% endhint %}

This guide explains custom validation event handlers in Umbraco Commerce that enable limiting order line quantities based on:

* The existing stock value of the product, and
* The existing quantity of the product in the cart.

## ProductAddValidationHandler

When adding a product to the cart, verify that the product is in stock. Also, ensure the customer does not exceed the available quantity in the cart.

```csharp
public class ProductAddValidationHandler : ValidationEventHandlerBase<ValidateOrderProductAdd>
{
    private readonly IProductService _productService;

    public ProductAddValidationHandler(IProductService productService)
    {
        _productService = productService;
    }

    public override async Task ValidateAsync(ValidateOrderProductAdd evt)
    {
        var order = evt.Order;
        var productReference = evt.ProductReference;

        var stock = await _productService.GetProductStockAsync(productReference);

        var totalQuantities = order?.OrderLines.Where(x => x.ProductReference == productReference).Sum(x => x.Quantity) ?? 0;

        if (stock.HasValue && totalQuantities >= stock.Value)
            evt.Fail($"Only {stock} quantities can be purchased for {productReference}.");
    }
}

```

## OrderLineQuantityValidationHandler

When changing the order line quantity on the cart page, ensure that the quantities being changed are in stock.

```csharp
public class OrderLineQuantityValidationHandler : ValidationEventHandlerBase<ValidateOrderLineQuantityChange>
{
    private readonly IProductService _productService;

    public OrderLineQuantityValidationHandler(IProductService productService)
    {
        _productService = productService;
    }

    public override async Task ValidateAsync(ValidateOrderLineQuantityChange evt)
    {
        var orderLine = evt.OrderLine;
        var productReference = orderLine.ProductReference;

        var stock = await _productService.GetProductStockAsync(productReference);

        if (stock.HasValue && evt.Quantity.To > stock.Value)
            evt.Fail($"Only {stock} quantities can be purchased for {productReference}.");
    }
}

```

## Register event handlers

Register the Umbraco Commerce event handlers via an `IUmbracoCommerceBuilder` extension method.

```csharp
public static class UmbracoCommerceUmbracoBuilderExtensions
{
    public static IUmbracoCommerceBuilder AddEventHandlers(IUmbracoCommerceBuilder builder)
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
