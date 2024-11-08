---
description: Faster development thanks to the Fluent API of Umbraco Commerce.
---

# Fluent API

An added side effect of having [ReadOnly and Writable entities](readonly-and-writable-entities.md) is that all of an entity's write operations are now performed via methods. This is instead of property setters, enabling to us convert Umbraco Commerce's write API in a fluent API.

## Writing fluently

You could perform a write operation as follows:

```csharp
await _uowProvider.ExecuteAsync(async (uow) =>
{
    // Fetch the currency
    var currency = await _currencyService.GetCurrencyAsync(currencyId);

    // Convert the currency into it's Writable form
    var writableCurrency = await currency.AsWritableAsync(uow);

    // Perform the write operation
    await writableCurrency.SetNameAsync("New Name");

    // Persist the changes to the database
    await _currencyService.SaveCurrencyAsync(currency);

    // Close the transaction
    await uow.CompleteAsync();
});

```

This could be simplified further by defining these actions fluently, chaining all of the entity methods into a succinct command sequence as follows:

```csharp
await _uowProvider.ExecuteAsync(async (uow) =>
{
    var currency = await _currencyService.GetCurrencyAsync(currencyId)
        .AsWritableAsync(uow)
        .SetNameAsync("New Name");

    await _currencyService.SaveCurrencyAsync(currency);

    await uow.CompleteAsync();
});

```

{% hint style="info" %}
We know not everyone likes to write their code fluently and so the Umbraco Commerce Fluent API is an optional feature. Both code examples above are valid coding styles that will both work as well as each other. The Fluent API is an opt-in layer of syntax sugar that developers can use depending on their preferred style of coding.
{% endhint %}
