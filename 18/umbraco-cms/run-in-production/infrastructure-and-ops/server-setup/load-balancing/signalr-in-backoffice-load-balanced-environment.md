# SignalR in a Backoffice Load Balanced Environment
When load balancing the backoffice, we also need to take care of the client-to-server communication outside of web requests.
Umbraco uses SignalR to abstract away these types of communication. This also allows us to support load balancing by replacing how the communication is done by introducing a backplane.

## Understanding SignalR Backplanes

A traditional SignalR backplane (such as SQL Server or Redis) distributes *messages* between servers. Any server can broadcast messages to clients connected to other servers. However, the WebSocket connection remains tied to the server the client initially connected to.

With negotiation enabled, routing the negotiation request and subsequent connection request to different servers can cause "No connection with that ID" errors. You can avoid sticky sessions by skipping negotiation and using WebSockets only, as described in Option 3.

**Azure SignalR Service** works differently. Instead of clients connecting directly to your servers, they connect to the Azure SignalR Service. This centralizes connection management, allowing requests to be handled by any server without sticky sessions.

## Sticky Sessions vs Stateless

When load balancing the backoffice, you can choose between three approaches:

### Option 1: Sticky Sessions with Any Backplane

Configure your load balancer to use sticky sessions (session affinity). This ensures that once a client connects to a server, all subsequent requests from that client go to the same server.

With sticky sessions enabled, any SignalR backplane works:

- SQL Server backplane
- Redis backplane
- Other third-party backplanes

This approach works if your load balancer supports sticky sessions.

### Option 2: Stateless with Azure SignalR Service

To run without sticky sessions using Azure SignalR Service, configure:

- **Azure SignalR Service** for SignalR connection management.
- **IDistributedCache** for session state management (see [Distributed Cache documentation](https://learn.microsoft.com/en-us/aspnet/core/performance/caching/distributed)).

This approach requires additional setup but allows for true horizontal scaling without server affinity.

{% hint style="info" %}
Umbraco's cache is built on Microsoft's HybridCache, which automatically uses IDistributedCache as a second-level cache when configured. This means that setting up IDistributedCache for session management also enables distributed caching of Umbraco content across all servers. See [Cache Settings](../../../../develop-with-umbraco/configuration/cache-settings.md) for more information.
{% endhint %}

### Option 3: Stateless with Your Own Backplane

You can run without sticky sessions using any compatible SignalR backplane, such as a database. Configure your backplane on every server. The [Using existing infrastructure](#using-existing-infrastructure) section shows a SQL Server example.

Set `Umbraco:CMS:SignalR:ClientShouldSkipNegotiation` to `true` in `appsettings.json` on every server:

{% code title="appsettings.json" %}
```json
{
  "Umbraco": {
    "CMS": {
      "SignalR": {
        "ClientShouldSkipNegotiation": true
      }
    }
  }
}
```
{% endcode %}

Umbraco's backoffice SignalR client skips negotiation and connects directly using WebSockets. Each new connection can reach any server without a preceding negotiation request tying the client to a particular server.

The established WebSocket connection remains on that server. Your backplane distributes messages between servers; the setting does not register or replace a backplane.

{% hint style="info" %}
Database backplanes can have lower message throughput than other options. Overall performance depends on your backplane.
{% endhint %}

{% hint style="warning" %}
Skipping negotiation requires WebSockets support in your clients, servers, proxies, and load balancer. Other SignalR transports cannot be used as fallbacks. Do not enable skipping negotiation with Azure SignalR Service, which requires negotiation to redirect clients to the service.
{% endhint %}

The setting removes SignalR's need for sticky sessions. If your application needs distributed session state, configure `IDistributedCache` as described in the [Distributed Cache documentation](https://learn.microsoft.com/en-us/aspnet/core/performance/caching/distributed).

## Choosing the Right Backplane

Choosing the right backplane comes down to a few factors:

- Whether you can use sticky sessions
- Whether your infrastructure supports WebSockets-only connections with negotiation disabled
- Message throughput requirements
- Cost
- The infrastructure you already have in place

Microsoft has a good list of available backplanes in its [SignalR load balancing article](https://learn.microsoft.com/en-us/aspnet/core/signalr/scale?view=aspnetcore-10.0), including a list of well-known [third-party offerings](https://learn.microsoft.com/en-us/aspnet/core/signalr/scale?view=aspnetcore-9.0#third-party-signalr-backplane-providers).

## Code examples
The following code examples show how you can activate SignalR load balancing using an Umbraco composer.

{% hint style="info" %}
Both Umbraco and these composers use `.AddSignalR()`.  This duplication isn't a concern as the underlying code registers the required services as singletons.
{% endhint %}

### Using existing infrastructure
It is possible to use your existing database as a backplane. If this database is hosted in Azure it is not possible to enable Service Broker which will have an impact on message throughput. Nevertheless, it might be sufficient to cover your needs.
For more information, check out the [GitHub page](https://github.com/IntelliTect/IntelliTect.AspNetCore.SignalR.SqlServer).
- Add a reference to the `IntelliTect.AspNetCore.SignalR.SqlServer` NuGet package.
- Add the following composer to your project:
```csharp
using Umbraco.Cms.Core.Composing;

namespace Umbraco.Cms.Web.UI.SignalRLoadBalancing;

public class SignalRComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        var connectionString = builder.Config.GetUmbracoConnectionString();
        if (connectionString is null)
        {
            return;
        }

        builder.Services.AddSignalR().AddSqlServer(connectionString);
    }
}
```

### Azure SignalR Service
- Set up a resource as described in the [Microsoft tutorial](https://learn.microsoft.com/en-us/azure/azure-signalr/signalr-quickstart-dotnet-core#create-an-azure-signalr-resource).
- Make sure the `connectionstring` is set up under the following key: `Azure:SignalR:ConnectionString`.
- Add a reference to `Microsoft.Azure.SignalR` NuGet package.
- Add the following composer to your project:
```csharp
using Umbraco.Cms.Core.Composing;

namespace Umbraco.Cms.Web.UI.SignalRLoadBalancing;

public class SignalRComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder) => builder.Services.AddSignalR().AddAzureSignalR();
}
```
