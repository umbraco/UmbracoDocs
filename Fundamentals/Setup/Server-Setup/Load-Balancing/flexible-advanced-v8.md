---
versionFrom: 8.0.2
---

# Advanced techniques with Flexible Load Balancing

_This describes some more advanced techniques that you could achieve with flexible load balancing_

## Explicit Master Scheduling server

It is recommended to configure an explicit master scheduling server since this reduces the amount
complexity that the [master election](flexible.md#scheduling-and-master-election) process performs.

The first thing to do is create a couple classes for your front-end servers and master server to use:

```csharp
public class MasterServerRegistrar : IServerRegistrar
{
    public IEnumerable<IServerAddress> Registrations
    {
        get { return Enumerable.Empty<IServerAddress>(); }
    }
    public ServerRole GetCurrentServerRole()
    {
        return ServerRole.Master;
    }
    public string GetCurrentServerUmbracoApplicationUrl()
    {
        // NOTE: If you want to explicitly define the URL that your application is running on,
        // this will be used for the server to communicate with itself, you can return the
        // custom path here and it needs to be in this format:
        // http://www.mysite.com/umbraco

        return null;
    }
}

public class FrontEndReadOnlyServerRegistrar : IServerRegistrar
{
    public IEnumerable<IServerAddress> Registrations
    {
        get { return Enumerable.Empty<IServerAddress>(); }
    }
    public ServerRole GetCurrentServerRole()
    {
        return ServerRole.Replica;
    }
    public string GetCurrentServerUmbracoApplicationUrl()
    {
        return null;
    }
}
```

then you'll need to replace the default `DatabaseServerRegistrar` for the your custom registrars.
You'll need to create an [Composer](../../../../Implementation/Composing/index.md) to set the server registrar

```csharp
// This should be executed on your master server
public void Compose(Composition composition)
{
    composition.SetServerRegistrar(new MasterServerRegistrar());
}

// This should be executed on your replica servers
public void Compose(Composition composition)
{
    composition.SetServerRegistrar(new FrontEndReadOnlyServerRegistrar());
}
```

Now that your front-end servers are using your custom `FrontEndReadOnlyServerRegistrar` class, they will always be deemed 'Replica' servers and will not attempt any master election or task scheduling.

By setting your master server to use your custom `MasterServerRegistrar` class, it will always be deemed the 'Master' and will always be the one that executes all task scheduling.

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

Now that your front-end servers are using your custom `FrontEndReadOnlyServerRegistrar` class, they will always be deemed 'Replica' servers and will not attempt any master election or task scheduling. Because you are no longer using the default `DatabaseServerRegistrar` they will not try to ping the umbracoServer table.

:::note
If using [SqlMainDomLock](azure-web-apps.md#appdomain-synchronization) on Azure WebApps then write-permissions are required for the following tables for all server roles including 'Replica'.

* `umbracoLock`
* `umbracoKeyValue`

SQL Server Replica databases cannot be used as they are read-only without replacing the default MainDomLock with a custom provider. 
:::

## Controlling how often the load balancing instructions from the database are processed and pruned

During start up the `DatabaseServerMessengerOptions` can be adjusted to control how often the load balancing instructions from the database are processed and pruned.

You'll need to create an [Composer](../../../../Implementation/Composing/index.md) to set the messenger options

```csharp
public void Compose(Composition composition)
{
    composition.SetDatabaseServerMessengerOptions(factory =>
    {
        var options = DatabaseServerRegistrarAndMessengerComposer.GetDefaultOptions(factory);
        options.DaysToRetainInstructions = 10;
        options.MaxProcessingInstructionCount = 1000;
        options.ThrottleSeconds = 25;
        options.PruneThrottleSeconds = 60;
        return options;
    });
}
```

Options:

* DaysToRetainInstructions - The number of days to keep instructions in the database; records older than this number will be pruned.
* MaxProcessingInstructionCount - The maximum number of instructions that can be processed at startup; otherwise the server cold-boots (rebuilds its caches)
* ThrottleSeconds - The number of seconds to wait between each sync operations
* PruneThrottleSeconds - The number of seconds to wait between each prune operation
