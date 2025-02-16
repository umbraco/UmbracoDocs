---
description: "Umbraco ships with signalR installed, find out how to add your own hub(s) to the existing setup"
---

# Adding a hub with SignalR and Umbraco

Umbraco ships with signalR installed. This article shows how to add your own hub(s) to the existing setup.

## Create a hub and its interface

We are going to go for the most basic implementation possible, a status ping. So first create a new interface with the following code:

```csharp
public interface ITestHubEvents
{
    // Define the events the clients can listen to
    public Task Pong();
}
```

And then the actual hub:

```csharp
using Microsoft.AspNetCore.SignalR;

public class TestHub : Hub<ITestHubEvents>
{
    // when a client sends us a ping
    public async Task Ping()
    {
        // we trigger the pong event on all clients
        await Clients.All.Pong();
    }
}
```

## Define a custom route

Next up, is defining a custom route. For this, we are going to use a `IAreaRoutes` and the base Umbraco backend path so we don't have to reserve another path in the settings.

```csharp
using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.DependencyInjection;
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.DependencyInjection;
using Umbraco.Cms.Web.Common.ApplicationBuilder;
using Umbraco.Extensions;

public class TestHubRoutes : IAreaRoutes
{
    private readonly IRuntimeState _runtimeState;
    private readonly string _umbracoPathSegment;

    public TestHubRoutes(
        IOptions<GlobalSettings> globalSettings,
        IHostingEnvironment hostingEnvironment,
        IRuntimeState runtimeState)
    {
        _runtimeState = runtimeState;
        _umbracoPathSegment = globalSettings.Value.GetUmbracoMvcArea(hostingEnvironment);
    }

    public void CreateRoutes(IEndpointRouteBuilder endpoints)
    {
        switch (_runtimeState.Level)
        {
            case Umbraco.Cms.Core.RuntimeLevel.Run:
                endpoints.MapHub<TestHub>(GetTestHubRoute());
                break;
        }

    }

    public string GetTestHubRoute()
    {
        return $"/{_umbracoPathSegment}/{nameof(TestHub)}";
    }
}
```

### Add the routing to the Umbraco Composer

Last step in the setup is registering our custom route:

```csharp
using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.DependencyInjection;
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.DependencyInjection;
using Umbraco.Cms.Web.Common.ApplicationBuilder;
using Umbraco.Extensions;

public class TestHubComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        // first we are going to add signalR to the serviceCollection if no hubs have been added yet
        // this is just in case Umbraco ever decides to use a different technology
        if (!builder.Services.Any(x => x.ServiceType == typeof(IHubContext<>)))
        {
            builder.Services.AddSignalR();
        }
        
        // next is adding the routes we defined earlier
        builder.Services.AddUnique<TestHubRoutes>();
        builder.Services.Configure<UmbracoPipelineOptions>(options =>
        {
            options.AddFilter(new UmbracoPipelineFilter(
                "test",
                 endpoints: applicationBuilder =>
                {
                    applicationBuilder.UseEndpoints(e =>
                    {
                        var hubRoutes = applicationBuilder.ApplicationServices.GetRequiredService<TestHubRoutes>();
                        hubRoutes.CreateRoutes(e);
                    });
                }
            ));
        });
    }
}
```

### Add the route in appsettings.json file

When setting up SignalR routes, add the route to `ReservedPaths` in the `appsettings.json` file like:

```cs
"Umbraco": {
    "CMS": {
        "Global": {
            "ReservedPaths": "~/app_plugins/,~/install/,~/mini-profiler-resources/,~/umbraco/,~/umbraco/testhub/,"
        }
    }
}
```

{% hint style="info" %}
You need to provide the default reserved paths, else you'll run into an issue as mentioned on [GitHub](https://github.com/umbraco/Umbraco-CMS/issues/12965).
{% endhint %}

### Test the setup

And lastly we can test the setup with some JavaScript in our view:

```html
<!-- We reference the signalR js file that comes with Umbraco -->
<script type="text/javascript" src="/umbraco/lib/signalr/signalr.min.js"></script>
<script>
    var connection = new signalR.HubConnectionBuilder()
        .withUrl("/umbraco/testhub") // this is the url that we created in the routing `TestHubRoutes.GetTestHubRoute()`
        .withAutomaticReconnect()
        .configureLogging(signalR.LogLevel.Warning)
        .build();
    
    // register our callbacks when the hub sends us an event
        connection.on("Pong", function () {
            console.log("Pong");
        });

    // start the connection
    connection.start().then(function () {
        console.info("signalR connection established");

        // connection is established => call a function on the hub
        connection.invoke("Ping").catch(function (err) {
            return console.error("Could not invoke method [Ping] on signalR connection", err.toString());
        });
    }).catch(function (err) {
        return console.error("could not establish a signalR connection", err.toString());
    });
</script>
```

When you insert this in a view, you should see a `signalR connection established` console message followed by `Pong`.
