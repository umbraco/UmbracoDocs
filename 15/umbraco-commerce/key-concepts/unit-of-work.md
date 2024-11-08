---
description: Transactional updates using the Unit of Work pattern in Umbraco Commerce.
---

# Unit of Work

## Unit of Work

When working with Umbraco Commerce's API it is important that data integrity is maintained should any errors occur. In order to achieve this Umbraco Commerce uses the [Unit of Work pattern](https://www.martinfowler.com/eaaCatalog/unitOfWork.html) to effectively create a transaction that wraps around sections of your code ensuring that all Umbraco Commerce write operations that occur within that code block must succeed and be persisted in their entirety, otherwise, none of them should, and the database should rollback to its state prior to when those changes were made.

### Creating a Unit of Work

Creating a unit of work will require access to Umbraco Commerce's `IUnitOfWorkProvider` which can be [injected into your Controller directly](dependency-injection.md), or can also be accessed via the `UoW` property on the `IUmbraco CommerceApi` helper.

Once you have access to either of these entry points, you can define a Unit of Work as follows

```csharp
await _uowProvider.ExecuteAsync(async (uow) =>
{
    // Perform your write operations here

    uow.Complete();
});

```

The anatomy of a Unit of Work is an `ExecuteAsync` method call on the `IUnitOfWorkProvider` instance which accepts an async delegate function with a `uow` argument. Inside the delegate, we perform our tasks and confirm the Unit of Work as complete by calling `uow.Complete()`. If we fail to call `uow.Complete()` either due to forgetting to add the `uow.Complete()` call or due to an exception in our code, then any write operations that occur within that code block will **not** be persisted in the database.

### Unit of Work Best Practice

When using a Unit of Work it is best practice that you should perform **all** write operations inside a single Unit of Work and **not** create individual Units of Work per write operation.

{% hint style="info" %}
Perform all write operations in a single Unit of Work
{% endhint %}

```csharp
await _uowProvider.ExecuteAsync(async (uow) =>
{
    // Create a Country
    var country = await Country.CreateAsync(uow, storeId, "DK", "Denmark");

    await _countryService.SaveCountryAsync(country);

    // Create a Currency
    var currency = await Currency.CreateAsync(uow, storeId, "DKK", "Danish Kroner", "da-DK");

    await _currencyService.SaveCurrencyAsync(currency);

    uow.Complete();
});
```

{% hint style="info" %}
It is not recommended to create a Unit of Work per write operation.
{% endhint %}

```csharp
await _uowProvider.ExecuteAsync(async (uow) =>
{
    // Create a Country
    var country = await Country.CreateAsync(uow, storeId, "DK", "Denmark");

    await _countryService.SaveCountryAsync(country);

    uow.Complete();
});

await _uowProvider.ExecuteAsync(async (uow) =>
{
    // Create a Currency
    var currency = await Currency.CreateAsync(uow, storeId, "DKK", "Danish Kroner", "da-DK");

    await _currencyService.SaveCurrencyAsync(currency);

    uow.Complete();
});
```
