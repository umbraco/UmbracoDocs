# Advanced Techniques With Flexible Load Balancing

_This describes some more advanced techniques that you could achieve with flexible load balancing_

The election process that runs during the startup of an Umbraco instance determines the server role that instance will undertake.

There are two server roles to be aware of for flexible load balancing:

* `SchedulingPublisher` - The Umbraco instance usually used for backoffice access, responsible for running scheduled tasks.
* `Subscriber` - A scalable instance that subscribes to content updates from the SchedulingPublisher server, not recommended to be used for backoffice access.

{% hint style="info" %}
These new terms replace 'Master and Replica', in Umbraco versions 7 and 8.
{% endhint %}

## Explicit SchedulingPublisher server

It is recommended to configure an explicit SchedulingPublisher server since this reduces the amount of complexity that the election process performs.

The first thing to do is create a couple of small classes that implement `IServerRoleAccessor` one for each of the different server roles:

```csharp
public class SchedulingPublisherServerRoleAccessor : IServerRoleAccessor
{
    public ServerRole CurrentServerRole => ServerRole.SchedulingPublisher;
}

public class SubscriberServerRoleAccessor : IServerRoleAccessor
{
    public ServerRole CurrentServerRole => ServerRole.Subscriber;
}
```

then you'll need to replace the default `IServerRoleAccessor` for the your custom registrars. You'll can do this by using the `SetServerRegistrar()` extension method on `IUmbracoBuilder` from a [Composer](../../../../implementation/composing.md).

```csharp
// This should be executed on your single `SchedulingPublisher` server
builder.SetServerRegistrar<SchedulingPublisherServerRoleAccessor>();

// This should be executed on your `Subscriber` servers
builder.SetServerRegistrar<SubscriberServerRoleAccessor>();
```

Now that your subscriber servers are using your custom `SubscriberServerRoleAccessor` class, they will always be deemed 'Subscriber' servers and will not attempt to run the automatic server role election process or task scheduling.

By setting your SchedulingPublisher server to use your custom `SchedulingPublisherServerRoleAccessor` class, it will always be deemed the 'SchedulingPublisher' and will always be the one that executes all task scheduling.

## Subscriber servers - Read-only database access

{% hint style="info" %}
This description pertains only to Umbraco database tables
{% endhint %}

In some cases infrastructure admins will not want their front-end servers to have write access to the database. By default front-end servers will require write full access to the following tables:

* `umbracoServer`
* `umbracoNode`

This is because by default each server will inform the database that they are active and more importantly it is used for task scheduling. Only a single server can execute task scheduling and these tables are used for servers to use a server role election process without the need for any configuration. So in the case that a subscriber server becomes the SchedulingPublisher task scheduler, **it will require write access to all of the Umbraco tables**.

In order to have read-only database access configured for your front-end servers, you need to implement the [Explicit SchedulingPublisher server](flexible-advanced.md#explicit-schedulingpublisher-server) configuration mentioned above.

Now that your subscriber servers are using your custom `SubscriberServerRoleAccessor` class, they will always be deemed 'Subscriber' servers and will not attempt to run the automatic server role election process or task scheduling. Because you are no longer using the default `ElectedServerRoleAccessor` they will not try to ping the umbracoServer table.

{% hint style="info" %}
If using [SqlMainDomLock](azure-web-apps.md#appdomain-synchronization) on Azure WebApps then write-permissions are required for the following tables for all server roles including 'Subscriber'.

* `umbracoLock`
* `umbracoKeyValue`

SQL Server Replica databases cannot be used as they are read-only without replacing the default MainDomLock with a custom provider.
{% endhint %}

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

These setting would normally be applied to all environments as they are added to the global app settings. If you need these settings to be environment specific, we recommend using [environment specific `appSetting` files](../../../../reference/configuration/).
