---
description: Learn about Async API Changes
---

# Async APIs

UI Builder `17.1.0` adds EF Core support, converting the data access pipeline to async-first. This update impacts API controllers, services, repositories, and database extensions. Existing sync methods are now obsolete and scheduled for removal in V19.

This migration handled the following:

* Every existing sync method gets an async counterpart with an `Async` suffix.
* Sync methods are marked `[Obsolete("Scheduled for removal in v19")]`.
* Sync methods are rewired to delegate to async via `.ConfigureAwait(false).GetAwaiter().GetResult()`.
* All async methods accept an optional `CancellationToken cancellationToken = default` as the last parameter.

## Deprecation Timeline

| Version | Status |
|---|---|
| **Current (v17)** | Sync methods marked `[Obsolete]`, async methods added. |
| **version 19** | Sync methods removed. |

## Migration Guide for Custom Repository Implementations

If you have a custom repository extending `Repository<TEntity, TId>` (or use the new `EFCoreRepository<TEntity, TId>`):

1. Implement all new `*ImplAsync` abstract methods.
2. Migrate callers from sync to async methods.
3. Pass `CancellationToken` through the call chain.
4. The sync `*Impl` methods still work but will be removed in version 19.

```csharp
// Before (v16)
protected override TEntity GetImpl(TId id)
{
    return _myDataSource.Get(id);
}

// After (v17+)
protected override async Task<TEntity> GetImplAsync(TId id, CancellationToken cancellationToken)
{
    return await _myDataSource.GetAsync(id, cancellationToken);
}
```
