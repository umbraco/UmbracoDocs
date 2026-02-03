# Load Balancing the Backoffice

This article contains specific information about load balancing the Umbraco backoffice. Ensure you read the [Load Balancing Overview](./) and relevant articles about general load balancing principles before you begin.

By default, the Umbraco load balancing setup assumes there is a single backoffice server and multiple front-end servers. From version 17, it's possible to load balance the backoffice. This means there's no need to differentiate between backoffice servers and front-end servers. However, this requires some additional configuration steps.

## Sticky Sessions vs Stateless

Before configuring backoffice load balancing, you need to decide between two approaches:

### Option 1: Sticky Sessions

Configure your load balancer to use sticky sessions (session affinity). This ensures all requests from a client are routed to the same server.

**Requirements:**
- Sticky sessions enabled on your load balancer
- Any SignalR backplane (SQL Server, Redis, or Azure SignalR Service)

This approach works well for most scenarios.

### Option 2: Fully Stateless

If you want true horizontal scaling without server affinity, you need additional configuration:

**Requirements:**
- [Azure SignalR Service](./signalR-in-backoffice-load-balanced-environment.md) for SignalR connection management
- [IDistributedCache](https://learn.microsoft.com/en-us/aspnet/core/performance/caching/distributed) for session state management

{% hint style="info" %}
Umbraco's cache is built on Microsoft's HybridCache, which automatically uses IDistributedCache as a second-level cache when configured. This means setting up IDistributedCache for session management also enables distributed caching of Umbraco content across all servers. See [Cache Settings](../../../../reference/configuration/cache-settings.md) for more information.
{% endhint %}

{% hint style="warning" %}
Traditional SignalR backplanes (SQL Server, Redis) only distribute messages between servers. The WebSocket connection remains tied to a specific server. Without sticky sessions, you will encounter intermittent "No connection with that ID" errors. Only Azure SignalR Service supports stateless operation because it centralizes connection management.
{% endhint %}

## Server Role Accessor

Umbraco uses server roles to differentiate between backoffice servers and front-end servers. Since all servers will be backoffice servers, you need to add a custom `IServerRoleAccessor` to specify this.

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

When load balancing the backoffice, all servers have their own repository caches. Changes made on one server are not reflected on other servers until their cache expires.

To solve this issue, a cache versioning mechanism is used. This is similar to optimistic concurrency control. Each server has a version number for its cache. When a server makes a change, it updates the version identifier. The other servers can then check the version identifier before accessing the cache. If the cache is out of date, they invalidate it.

This means the server needs to check the version identifier before a cache lookup. By default, this behavior is disabled. It's only required when load balancing the backoffice.

You can enable this on the Umbraco builder, either in `Program.cs` or via a Composer:

```csharp
umbracoBuilder.LoadBalanceIsolatedCaches();
```

## SignalR

The Umbraco backoffice uses SignalR for real-time updates and notifications. When load balancing the backoffice, ensure SignalR is configured correctly based on your chosen approach (sticky sessions or stateless). See [SignalR in a Backoffice Load Balanced Environment](./signalR-in-backoffice-load-balanced-environment.md) for configuration details.


## Background Jobs

If you have custom recurring background jobs that should only run on a single server, you'll need to implement `IDistributedBackgroundJob`. See [Scheduling documentation](../../../../reference/scheduling.md#background-jobs-when-load-balancing-the-backoffice) for more information.

## Temporary File Storage

When load balancing the backoffice, temporary files uploaded through `/umbraco/management/api/v1/temporary-file`, for instance media uploads, must be accessible across all server instances.

Temporary files are saved to `umbraco/Data/TEMP/TemporaryFile/` by default.

**Azure deployments using scale out:** No additional configuration is required, as the `umbraco` folder is shared between instances.

**Other Environments:** Configure a shared storage location using [the `Umbraco:CMS:Hosting:TemporaryFileUploadLocation` setting.](../../../../reference/configuration/hostingsettings.md#temporary-file-upload-location)

Ensure this path points to a location accessible by all server instances, such as a shared drive or volume.

**Advanced Scenarios:** You can implement a custom `ITemporaryFileRepository` for external storage solutions such as Azure Blob Storage.
