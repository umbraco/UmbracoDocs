---
versionFrom: 9.0.0
product: "CMS"
meta.Title: "Adding a signlR hub"
meta.Description: "Umbraco ships with signalR installed, find out how to add your own hub(s) to the existing setup"

---

# Todo 
- Create a hub
- Define a custom route for it
- Add the routing to the umbraco composer
- Test the setup with some javascript

## Create a hub
We are going to go for the most simple implementation possible, a simple status ping. So create a new class with the following code
```csharp
using Microsoft.AspNetCore.SignalR;

public class TestHub : Hub
{
    public async Task Ping()
    {
        await Clients.All.SendAsync("Pong");
    }
}
```

### Define a custom route
Next up is defining a custom route, for this we are going to use a `IAreaRoutes` and the base umbrace backend path so we dont have to reserve another path in the settings
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

### Add the routing to the umbraco composer
Last step in the setup is registering our custom route

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
        builder.Services.AddUnique<TestHubRoutes>();
        builder.Services.AddSignalR();
        builder.Services.Configure<UmbracoPipelineOptions>(options =>
        {
            options.AddFilter(new UmbracoPipelineFilter(
                "test",
                applicationBuilder => { },
                applicationBuilder => { },
                applicationBuilder =>
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

### Testing the setup
And lastly we can test the setup with some js in our view
```html
<!-- We reference the signalR js file that comes with umbraco -->
<script type="text/javascript" src="/umbraco/lib/signalr/signalr.min.js"></script>
<script>
    var connection = new signalR.HubConnectionBuilder()
        .withUrl("/umbraco/testhub") // this is the url that we created in the routing `TestHubRoutes.GetTestHubRoute()`
        .withAutomaticReconnect()
        .configureLogging(signalR.LogLevel.Warning)
        .build();

    // start the connection
    connection.start().then(function () {
        console.info("signalR connection established");

        // connection is established => register our callbacks when the hub sends us something
        connection.on("Pong", function () {
            console.log("Pong");
        });

        // call a function on the hub
        connection.invoke("Ping").catch(function (err) {
            return console.error("Could not invoke method [Ping] on signalR connection", err.toString());
        });
    }).catch(function (err) {
        return console.error("could not establish a signalR connection", err.toString());
    });
</script>
```
When you insert this in a view, you should see a `signalR connection established` console message followed by `Pong`
