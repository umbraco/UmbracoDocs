# Load Balancing the Backoffice

This article contains specific information about load balancing the Umbraco backoffice. Ensure you read the [Load Balancing Overview](./) and relevant articles about general load balancing principles before you begin.

By default, the Umbraco load balancing setup assumes there is a single backoffice server and multiple front-end servers. From version 17, it's possible to load balance the backoffice. This means there's no need to differentiate between backoffice servers and front-end servers. However, this requires some additional configuration steps.

## Server Role Accessor

Umbraco has the concept of server roles to differentiate between backoffice servers and front-end servers. Since all servers will be backoffice servers, we need to add a custom `IServerRoleAccessor` to specify this.

Start by implementing a custom `IServerRoleAccessor` that pins the role as `SchedulingPublisher`:

```csharp
 public class StaticServerAccessor : IServerRoleAccessor
{
    public ServerRole CurrentServerRole => ServerRole.SchedulingPublisher;
}
```

You can now register this accessor either in `Program.cs` or via a Composer:

```csharp
umbracoBuilder.SetServerRegistrar(new StaticServerAccessor());
```

This will ensure that all servers are treated as backoffice servers.

## Load Balancing Repository Caches

One of the issues with load balancing the backoffice is that all servers will have their own repository caches. This means that if you make a change on one server, it won't be reflected on the other servers until their cache expires.

To solve this issue, a cache versioning mechanism is used. This is similar to optimistic concurrency control. Each server has a version number for its cache. When a server makes a change, it updates the version identifier. The other servers can then check the version identifier before accessing the cache. If the cache is out of date, they invalidate it.

This does mean that the server needs to check this version identifier before a cache lookup. By default, this behaviour is disabled. It's only required when load balancing the backoffice.

You can enable this on the Umbraco builder, either in `Program.cs` or via a Composer:

```csharp
umbracoBuilder.LoadBalanceIsolatedCaches();
```

## SignalR

The Umbraco Backoffice uses SignalR for multiple things, including real-time updates and notifications. When load balancing the backoffice, it's important to ensure that SignalR is configured correctly. See the [SignalR in a Backoffice Load Balanced Environment](./signalR-in-backoffice-load-balanced-environment.md) document for information regarding this.


## Background Jobs

If you have custom recurring background jobs that should only run on a single server, you'll need to implement `IDistributedBackgroundJob`. See [Scheduling documentation](../../../../reference/scheduling.md#background-jobs-when-load-balancing-the-backoffice) for more information.
