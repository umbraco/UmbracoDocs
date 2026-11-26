---
description: >-
  Learn about the asynchronous APIs in Umbraco UI Builder, and how to move
  code from the removed synchronous repository and service APIs.
---

# Async APIs

Umbraco UI Builder 17.1 added asynchronous versions of the repository and service APIs and marked the synchronous ones as obsolete. Umbraco UI Builder 19 removes the synchronous repository and service APIs.

All asynchronous methods have an `Async` suffix. Each one accepts an optional `CancellationToken cancellationToken = default` as its last parameter.

## Deprecation Timeline

| Version | Status |
|---|---|
| **Version 17.1** | Sync methods marked `[Obsolete]`, async methods added. |
| **Version 19** | Sync methods removed. |

## What Was Removed

The synchronous members were removed from these types:

* `IRepository`, for example `Get`, `Save`, `Delete`, `GetAll`, `GetPaged`, and `GetCount`.
* `Repository<TEntity, TId>`, including the public methods and the `*Impl` methods that custom repositories override.
* `EntityService`, for example `GetEntity`, `SaveEntity`, `DeleteEntity`, and `FindEntities`.

Use the `*Async` version of each member, such as `GetAsync`, `SaveAsync`, `GetEntityAsync`, or `FindEntitiesAsync`.

## Migration Guide for Custom Repository Implementations

If you have a custom repository extending `Repository<TEntity, TId>` or `EFCoreRepository<TEntity, TId>`:

1. Delete the synchronous `*Impl` overrides. They no longer compile, because the methods they override were removed.
2. Implement all `*ImplAsync` abstract methods.
3. Migrate callers from sync to async methods.
4. Pass the `CancellationToken` through the call chain.

`InsertImplAsync` and `UpdateImplAsync` are optional. Both call `SaveImplAsync` unless you override them.

{% code title="ProductRepository.cs" %}
```csharp
// Before (version 18 and earlier)
protected override Product GetImpl(int id)
{
    return _myDataSource.Get(id);
}

// After (version 17.1 and later)
protected override async Task<Product> GetImplAsync(int id, CancellationToken cancellationToken = default)
{
    return await _myDataSource.GetAsync(id, cancellationToken);
}
```
{% endcode %}

For a full example, see the [Repositories](repositories.md) article.

## Asynchronous Extension Points

From Umbraco UI Builder 19, actions, cards, data views builders, and filter options builders also have asynchronous methods. Umbraco UI Builder only calls the asynchronous methods. By default, each one calls the synchronous method, so existing code keeps working.

| Extension point | Asynchronous method | Synchronous method | More information |
| --- | --- | --- | --- |
| Actions | `ExecuteAsync` | `Execute` | [The Basics](../actions/the-basics.md) |
| Custom cards | `GetValueAsync` | `GetValue` | [Custom Cards](../cards/custom-cards.md) |
| Data views builders | `GetDataViewsAsync` | `GetDataViews` | [Data Views Builders](../filtering/data-views/data-views-builders.md) |
| Filter options builders | `GetOptionsAsync` | `GetOptions` | [Filterable Properties](../filtering/filterable-properties.md) |

Override the asynchronous method when your code awaits anything, such as a database query or an HTTP call. Override only one of the two methods:

* A class that overrides neither method throws a `NotImplementedException` when it is used.
* A class that only overrides the asynchronous method throws a `NotImplementedException` when code calls the synchronous method.
