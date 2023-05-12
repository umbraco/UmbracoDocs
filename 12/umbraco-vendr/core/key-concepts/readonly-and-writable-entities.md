---
title: ReadOnly and Writable Entities
description: Great performance and simplified change tracking using ReadOnly and Writable entities in Vendr, the eCommerce solution for Umbraco
---

When working with the Vendr entities, it's important to know that all entities come in two states, ReadOnly and Writable, and that by default all Vendr API methods will return entities in their ReadOnly state. This means that when you are accessing Vendr entities directly from an API endpoint you will be able to read and iterate over any of it's properties freely, however you won't be able to make changes to that entity without first converting it into it's Writable state.

## Why have ReadOnly and Writable entities?

The reason why we have split entities in this way is for a number of reasons, however the two primary factors are:

* **Making APIs fast by default** - By returning ReadOnly entities by default we can ensure all API methods are as fast as possible by feeding values directly out of our caching layer. Because the entities can't change it means we don't have to laden the entities with extra change tracking logic, we can feed out the cached values directly and only worry about that logic when the entities become Writable.

* **Simplified change tracking** - When we convert a ReadOnly entity to it's writable state, internally we take a deep clone of that state so that changes can occur within a scoped "sandbox". At the same time, we retain a copy of the original state meaning when it comes time to persist those changes we have two copies of the state we can perform a comparison on, simplifying the whole change tracking process.

## Converting a ReadOnly entity into a Writable entity

To convert a ReadOnly entity into it's Writable form, we achieve this by calling the entities `AsWritable(uow)` method, passing in a valid Unit of Work instance to perform the write operations on. Once we have a Writable entity, we can then perform the write operations we desire and persist those changes back to the database.

```csharp
_uowProvider.Execute(uow =>
{
    // Fetch the currency
    var currency = _currencyService.GetCurrency(currencyId);

    // Convert the currency into it's Writable form
    var writableCurrency = currency.AsWritable(uow);

    // Peform our write operation
    writableCurrency.SetName("New Name");

    // Persist the changes to the database
    _currencyService.SaveCurrency(currency);

    // Close our transaction
    uow.Complete();
});

```

{% hint style="info" %}
All write operations must occur within a Unit of Work so by passing in a Unit of Work instance into the entities `AsWritable` method, we are ensuring that you are in fact within an active Unit of Work.
{% endhint %}