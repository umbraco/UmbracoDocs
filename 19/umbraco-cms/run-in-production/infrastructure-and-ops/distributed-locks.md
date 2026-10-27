# Distributed Locks

During save operations, Umbraco will generally take a database lock to avoid concurrency issues.

Access to this feature is via the `IScope` interface, for example:

```csharp
 using (var scope = _scopeProvider.CreateScope())
{
    scope.WriteLock(Constants.Locks.Domains);

    // Carry out save operation.

    scope.Complete();
}
```

Each lockable entity is represented by an integer Id, stored along with the state of the lock in the `umbracoLock` database table.

Packages or custom solutions working with custom data via the `IScope` interface can introduce their own records to this table. However it's important to not clash with either core identifiers or those introduced by other packages.

A reference is maintained here of known identifiers:

| Id           | Name                 | Used By          |
|--------------|----------------------|------------------|
| -1000        | MainDom              | Umbraco CMS      |
| -331 to -340 | Various              | Umbraco CMS      |
| -800         | DeployTransferQueue  | Umbraco Deploy   |



