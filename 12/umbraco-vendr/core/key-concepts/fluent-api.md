---
description: Faster development thanks to the Fluent API of Vendr, the eCommerce solution for Umbraco
---

# Fluent API

An added side effect of having [ReadOnly and Writable entities](../readonly-and-wrtiable-entities/) is that all of an entities write operations are now performed via methods. This is instead of property setters, enabling to us convert Vendr's write API in a fluent API.

## Writing fluently

You could perform a write operation as follows:

```csharp
_uowProvider.Execute(uow =>
{
    // Fetch the currency
    var currency = _currencyService.GetCurrency(currencyId);

    // Convert the currency into it's Writable form
    var writableCurrency = currency.AsWritable(uow);

    // Perform the write operation
    writableCurrency.SetName("New Name");

    // Persist the changes to the database
    _currencyService.SaveCurrency(currency);

    // Close the transaction
    uow.Complete();
});

```

This could be simplified further by defining these actions fluently, chaining all of the entity methods into a succinct command sequence as follows:

```csharp
_uowProvider.Execute(uow =>
{
    var currency = _currencyService.GetCurrency(currencyId)
        .AsWritable(uow)
        .SetName("New Name");

    _currencyService.SaveCurrency(currency);

    uow.Complete();
});

```

{% hint style="info" %}
We know not everyone likes to write their code fluently and so the Vendr Fluent API is an optional feature. Both code examples above are valid coding styles which will both work as well as each other. The Fluent API is an opt-in layer of syntax sugar that developers can use depending on their preferred style of coding.
{% endhint %}
