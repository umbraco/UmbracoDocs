---
versionFrom: 7.0.0
versionRemoved: 8.0.0
---

# Advanced techniques with Flexible Load Balancing

_This describes some more advanced techniques that you could achieve with flexible load balancing_

## Explicit Master Scheduling server

It is recommended to configure an explicit master scheduling server since this reduces the amount
complexity that the [master election](flexible.md#scheduling-and-master-election) process performs.

This is configurable and in order to do this you will need to have separate application startup handlers
for your front-end servers and your admin server... you can make this a configuration option in your own code.

The first thing to do is create a couple classes for your front-end servers and master server to use:

```csharp
public class MasterServerRegistrar : IServerRegistrar2
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

public class FrontEndReadOnlyServerRegistrar : IServerRegistrar2
{
    public IEnumerable<IServerAddress> Registrations
    {
        get { return Enumerable.Empty<IServerAddress>(); }
    }
    public ServerRole GetCurrentServerRole()
    {
        return ServerRole.Slave;
    }
    public string GetCurrentServerUmbracoApplicationUrl()
    {
        return null;
    }
}
```

then you'll need to swap the default `DatabaseServerRegistrar` for the your custom registrars during application startup.
You'll need to create an [ApplicationEventHandler](../../../../Reference/Events/Application-Startup.md) and override `ApplicationStarting`.
During this event you can swap the registrar objects:

```csharp
// This should be executed on your master server
ServerRegistrarResolver.Current.SetServerRegistrar(new MasterServerRegistrar());

// This should be executed on your slave servers
ServerRegistrarResolver.Current.SetServerRegistrar(new FrontEndReadOnlyServerRegistrar());
```

Now that your front-end servers are using your custom `FrontEndReadOnlyServerRegistrar` class, they will always be deemed 'Slave' servers and will not attempt any master election or task scheduling.

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

Now that your front-end servers are using your custom `FrontEndReadOnlyServerRegistrar` class, they will always be deemed 'Slave' servers and will not attempt any master election or task scheduling. Because you are no longer using the default `DatabaseServerRegistrar` they will not try to ping the umbracoServer table.

## Controlling how often the load balancing instructions from the database are processed and pruned

During start up the `DatabaseServerMessengerOptions` can be adjusted to control how often the load balancing instructions from the database are processed and pruned.

e.g. This example should be added within a [`ApplicationStarting`](../../../../Reference/Events/Application-Startup.md#startup-methods) event

```csharp
ServerMessengerResolver.Current.SetServerMessenger(
    new BatchedDatabaseServerMessenger(
        applicationContext,
        true,
        new DatabaseServerMessengerOptions()
        {
            DaysToRetainInstructions = 2, // 2 days
            ThrottleSeconds = 5, // 5 second
            MaxProcessingInstructionCount = 1000,
            PruneThrottleSeconds = 60 // 1 minute
        }
    )
);
```

Parameters:

* DaysToRetainInstructions - The number of days to keep instructions in the database; records older than this number will be pruned.
* MaxProcessingInstructionCount - The maximum number of instructions that can be processed at startup; otherwise the server cold-boots (rebuilds its caches)
* ThrottleSeconds - The number of seconds to wait between each sync operations
* PruneThrottleSeconds - The number of seconds to wait between each prune operation
