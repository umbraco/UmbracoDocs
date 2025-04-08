---
description: Learn how to create an order via code in Umbraco Commerce.
---

# Create an Order via Code

In some cases, such as when importing orders from another system, it may be necessary to create a fully finalized order via code. 

An example of the code to do this is shown below. Here the `api` variable is an instance of the `IUmbracoCommerceApi` interface, which is an injectable service you access via [dependency injection](../key-concepts/dependency-injection.md).

```csharp
await api.Uow.ExecuteAsync(async (uow) =>
{
    // Fetch the store
    var store = await api.GetStoreAsync("blendid");
    
    // Create or get the current order
    var order = await api.GetOrCreateCurrentOrderAsync(store.Id).AsWritableAsync(uow);

    // Add product
    var productId = "2fa949e4-2acb-4aef-bb7c-4d3a5f7bbe52"; // The product node Key
    await order.AddProductAsync(productId, null, 1);

    // Set customer details
    var country = await api.GetCountryAsync(store.Id, "GB");
    await order.SetPropertiesAsync(new Dictionary<string, string>
        {
            { Constants.Properties.Customer.EmailPropertyAlias, $"customer@example.com" },
            { "marketingOptIn", "0" },
            { Constants.Properties.Customer.FirstNamePropertyAlias, "Example" },
            { Constants.Properties.Customer.LastNamePropertyAlias, $"Customer" },
            { "billingAddressLine1", "10 Example Road" },
            { "billingCity", "Example City" },
            { "billingZipCode", "EX3 3PL" },
            { "billingTelephone", "0123456789" },
            { "shippingSameAsBilling", "1" }
        })
        .SetPaymentCountryRegionAsync(country, null)
        .SetShippingCountryRegionAsync(country, null);

    // Set shipping method
    var shippingMethod = await api.GetShippingMethodAsync(store.Id, "pickup");
    await order.SetShippingMethodAsync(shippingMethod);

    // Set payment method
    var paymentMethod = await api.GetPaymentMethodAsync(store.Id, "invoicing");
    await order.SetPaymentMethodAsync(paymentMethod);

    // Recalculate order
    await order.RecalculateAsync();

    // Finalize order
    await order.InitializeTransactionAsync();
    await order.FinalizeAsync(order.TransactionAmount.Value, Guid.NewGuid().ToString("N"), PaymentStatus.Authorized);

    // Save order
    await api.SaveOrderAsync(order);

    // Commit the unit of work
    uow.Complete();
});
```
