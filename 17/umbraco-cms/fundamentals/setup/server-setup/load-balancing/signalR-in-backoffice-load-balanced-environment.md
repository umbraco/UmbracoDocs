# SignalR in a Backoffice Load Balanced Environment
When load balancing the backoffice, we also need to take care of the client to server communication outside of web requests.
Umbraco uses SignalR to abstract away these types of communication. This also allows us to support load balancing by replacing how the communication is done by introducing a backplane.

## Introducing a SignalR Backplane
A SignalR backplane is akin to a load balancer for direct client to server web traffic. It keeps track of which client is connected to which server. So that when a client sends a message, it arrives at the right server. It also allows any connected server to send a message to all clients, even those that are not directly connected to it.

## Choosing the right backplane
Choosing the right backplane comes down to a few things
- Message throughput
- Cost
- What infrastructure you already have in place

Microsoft has a good list of available backplanes in its [SignalR load balancing article](https://learn.microsoft.com/en-us/aspnet/core/signalr/scale?view=aspnetcore-10.0), including a list of well known [third party offerings](https://learn.microsoft.com/en-us/aspnet/core/signalr/scale?view=aspnetcore-9.0#third-party-signalr-backplane-providers).

## Code examples
The following code examples show you how you can activate SignalR load balancing using an Umbraco composer.
Note: Both Umbraco Core and these composers use `.AddSignalR().` which is ok since the underlying code registers the required services as singletons.

### Using existing infrastructure
It is possible to use your existing database as a backplane. If this database is hosted in Azure it is not possible to enable Service Broker which will have an impact on message throughput. We do however feel that when you start out with load balancing, it might be enough to cover your needs.
For more information, check out the [GitHub page](https://github.com/IntelliTect/IntelliTect.AspNetCore.SignalR.SqlServer).
- Add a reference to the IntelliTect.AspNetCore.SignalR.SqlServer NuGet package
- Add the following composer to your project
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
- Setup a resource as described in the [Microsoft tutorial](https://learn.microsoft.com/en-us/azure/azure-signalr/signalr-quickstart-dotnet-core#create-an-azure-signalr-resource)
- Make sure the connectionstring is setup under the following key: `Azure:SignalR:ConnectionString`
- Add a reference to the Microsoft.Azure.SignalR NuGet package
- Add the following composer to your project
```csharp
using Umbraco.Cms.Core.Composing;

namespace Umbraco.Cms.Web.UI.SignalRLoadBalancing;

public class SignalRComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder) => builder.Services.AddSignalR().AddAzureSignalR();
}
```
