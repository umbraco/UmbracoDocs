---
versionFrom: 9.0.0
---

# Advanced techniques with Flexible Load Balancing

_This describes some more advanced techniques that you could achieve with flexible load balancing_

## Explicit Master Scheduling server

It is recommended to configure an explicit master scheduling server since this reduces the amount
complexity that the master election process performs.

The first thing to do is create a couple small classes for your front-end servers and master server to use:

```csharp
public class MasterServerServerRoleAccessor : IServerRoleAccessor
{
    public ServerRole CurrentServerRole => ServerRole.Master;
}

public class FrontEndReadOnlyServerRoleAccessor : IServerRoleAccessor
{
    public ServerRole CurrentServerRole => ServerRole.Replica;
}
```

then you'll need to replace the default `IServerRoleAccessor` for the your custom registrars.
You'll can do this by using the `SetServerRegistrar()` extension method on `IUmbracoBuilder` from a [Composer](../../../../Implementation/Composing/index.md) or directly in your `startup.cs`.

```csharp
// This should be executed on your master server
builder.SetServerRegistrar<MasterServerRoleAccessor>();

// This should be executed on your replica servers
builder.SetServerRegistrar<FrontEndReadOnlyServerRoleAccessor>();
```

Now that your front-end servers are using your custom `FrontEndReadOnlyServerRoleAccessor` class, they will always be deemed 'Replica' servers and will not attempt any master election or task scheduling.

By setting your master server to use your custom `MasterServerRoleAccessor` class, it will always be deemed the 'Master' and will always be the one that executes all task scheduling.

## Front-end servers - Read-only database access

:::note
This description pertains ONLY to Umbraco database tables
:::

In some cases infrastructure admins will not want their front-end servers to have write access to the database.
By default front-end servers will require write full access to the following tables:

* `umbracoServer`
* `umbracoNode`

This is because by default each server will inform the database that they are active and more importantly it is
used for task scheduling. Only a single server can execute task scheduling and these tables are used for servers
to use a master server election process without the need for any configuration. So in the case that a front-end
server becomes the master task scheduler, **it will require write access to all of the Umbraco tables**.

In order to have read-only database access configured for your front-end servers, you need to implement
the [Explicit master scheduling server](#explicit-master-scheduling-server) configuration mentioned above.

Now that your front-end servers are using your custom `FrontEndReadOnlyServerRoleAccessor` class, they will always be deemed 'Replica' servers and will not attempt any master election or task scheduling.
Because you are no longer using the default `ElectedServerRoleAccessor` they will not try to ping the umbracoServer table.

:::note
If using [SqlMainDomLock](azure-web-apps.md#appdomain-synchronization) on Azure WebApps then write-permissions are required for the following tables for all server roles including 'Replica'.

* `umbracoLock`
* `umbracoKeyValue`

SQL Server Replica databases cannot be used as they are read-only without replacing the default MainDomLock with a custom provider.
:::

## Controlling how often the load balancing instructions from the database are processed and pruned

The configurations can be adjusted to control how often the load balancing instructions from the database are processed and pruned.
Below is shown how to do this from a JSON configuration source.
```json
{
    "Umbraco": {
        "CMS": {
            "Global": {
                "DatabaseServerMessenger": {
                    "MaxProcessingInstructionCount": 1000,
                    "TimeBetweenPruneOperations": "00:01:00",
                    "TimeBetweenSyncOperations": "00:00:05",
                    "TimeToRetainInstructions": "2.00:00:00"
                }
            }
        }
    }
}

```

Options:

* `TimeToRetainInstructions` - The timespan to keep instructions in the database; records older than this number will be pruned.
* `MaxProcessingInstructionCount` - The maximum number of instructions that can be processed at startup; otherwise the server cold-boots (rebuilds its caches)
* `TimeBetweenSyncOperations` - The timespan to wait between each sync operations
* `TimeBetweenPruneOperations` - The timespan to wait between each prune operation
