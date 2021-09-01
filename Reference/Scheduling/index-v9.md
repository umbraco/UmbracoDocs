---
versionFrom: 9.0.0
verified-against: rc002
meta-title: Scheduling with hosted services in Umbraco
meta.Description: Use hosted services to run a background task
state: complete
update-links: true
---

# Scheduling with RecurringHostedServiceBase

In Umbraco 9 it is possible to run recurring code using a hosted service.
Below is a complete example showing how to create and register a hosted service that will regularly empty out the recycle bin every five minutes. 

:::warning
Be aware you may or may not want this hosted service code to run on all servers, if you are using Load Balancing with multiple servers, see [load balancing documentation](../../Fundamentals/Setup/Server-Setup/Load-Balancing/index-v9.md) for more information
:::

## RecurringHostedService example

```C#
using System;
using System.Threading.Tasks;
using Microsoft.Extensions.Logging;
using Umbraco.Cms.Core;
using Umbraco.Cms.Core.Logging;
using Umbraco.Cms.Core.Scoping;
using Umbraco.Cms.Core.Services;
using Umbraco.Cms.Core.Sync;
using Umbraco.Cms.Infrastructure.HostedServices;

namespace Umbraco.Cms.Web.UI
{
    public class CleanUpYourRoom : RecurringHostedServiceBase
    {
        private readonly IRuntimeState _runtimeState;
        private readonly IContentService _contentService;
        private readonly IServerRoleAccessor _serverRoleAccessor;
        private readonly IProfilingLogger _profilingLogger;
        private readonly ILogger<CleanUpYourRoom> _logger;
        private readonly IScopeProvider _scopeProvider;

        private static TimeSpan HowOftenWeRepeat => TimeSpan.FromMinutes(5);
        private static TimeSpan DelayBeforeWeStart => TimeSpan.FromMinutes(1);

        public CleanUpYourRoom(
            IRuntimeState runtimeState,
            IContentService contentService,
            IServerRoleAccessor serverRoleAccessor,
            IProfilingLogger profilingLogger,
            ILogger<CleanUpYourRoom> logger,
            IScopeProvider scopeProvider)
            : base(HowOftenWeRepeat, DelayBeforeWeStart)
        {
            _runtimeState = runtimeState;
            _contentService = contentService;
            _serverRoleAccessor = serverRoleAccessor;
            _profilingLogger = profilingLogger;
            _logger = logger;
            _scopeProvider = scopeProvider;
        }

        public override Task PerformExecuteAsync(object state)
        {
            // Don't do anything if the site is not running.
            if (_runtimeState.Level != RuntimeLevel.Run)
            {
                return Task.CompletedTask;
            }

            // Wrap the three content service calls in a scope to do it all in one transaction.
            using IScope scope = _scopeProvider.CreateScope();
            
            int numberOfThingsInBin = _contentService.CountChildren(Constants.System.RecycleBinContent);
            _logger.LogInformation("Go clean your room - {ServerRole}", _serverRoleAccessor.CurrentServerRole);
            _logger.LogInformation("You have {NumberOfThinsInTheBing} items to clean", numberOfThingsInBin);

            if (_contentService.RecycleBinSmells())
            {
                // Take out the trash
                using (_profilingLogger.TraceDuration<CleanUpYourRoom>("Mum, I am emptying out the bing",
                    "It's all clean now"))
                {
                    _contentService.EmptyRecycleBin(userId: -1);
                }
            }

            // Remember to complete the scope when done.
            scope.Complete();
            return Task.CompletedTask;
        }
    }
}

```

### Registering with extension method

First we needto create out extension method:

```C#
using Microsoft.Extensions.DependencyInjection;
using Umbraco.Cms.Core.DependencyInjection;

namespace Umbraco.Cms.Web.UI
{
    public static class BuilderExtensions
    {
        public static IUmbracoBuilder AddHostedServices(this IUmbracoBuilder builder)
        {
            builder.Services.AddHostedService<CleanUpYourRoom>();
            return builder;
        }
    }
}
```

Now we can invoke it in the `ConfigureServices` method in `Startup.cs`:

```C#
public void ConfigureServices(IServiceCollection services)
{
#pragma warning disable IDE0022 // Use expression body for methods
    services.AddUmbraco(_env, _config)
        .AddBackOffice()
        .AddWebsite()
        .AddComposers()
        .AddHostedServices() // Register CleanUpYourRoom
        .Build();
#pragma warning restore IDE0022 // Use expression body for methods
}
```

### Registering with a composer

All we need to do here is to create the composer which will be run automatically:

```C#
using Microsoft.Extensions.DependencyInjection;
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.DependencyInjection;

namespace Umbraco.Cms.Web.UI
{
    public class CleanUpYourRoomComposer : IComposer
    {
        public void Compose(IUmbracoBuilder builder)
        {
            builder.Services.AddHostedService<CleanUpYourRoom>();
        }
    }
}

```

## RecurringHostedServiceBase

This class provides the base class for any hosted service. 

You can override the `PerformExecuteAsync` method to implement the class. Hosted services are always run asynchronously.

The `RecurringHostedServiceBase` is a base class that implements the netcore interface `IHostedService`, and makes the task recurring, if you don't need your task to run recurringly you can implement `IHostedService` yourself, and register your hosted service in the same way. For more information about hosted services, take a look at [the Microsoft documentation](https://docs.microsoft.com/en-us/aspnet/core/fundamentals/host/hosted-services?view=aspnetcore-5.0).

## BackgroundTaskRunner Notifications

Background tasks can also trigger events. [Browse the API documentation for BackgroundTaskRunner events.](https://our.umbraco.com/apidocs/v8/csharp/api/Umbraco.Web.Scheduling.BackgroundTaskRunner-1.html#events)

You can subscribe to the events in the `Initialize` method of your `CleanUpYourRoomComponent`. The events are registered on the `BackgroundTaskRunner` object, in this case `_cleanUpYourRoomRunner`.

```csharp

public class CleanUpYourRoomComponent : IComponent
{
    private IProfilingLogger _logger;
    private IRuntimeState _runtime;
    private IContentService _contentService;
    private BackgroundTaskRunner<IBackgroundTask> _cleanUpYourRoomRunner;

    public CleanUpYourRoomComponent(IProfilingLogger logger, IRuntimeState runtime, IContentService contentService)
    {
        _logger = logger;
        _runtime = runtime;
        _contentService = contentService;
        _cleanUpYourRoomRunner = new BackgroundTaskRunner<IBackgroundTask>("CleanYourRoom", _logger);
    }

    public void Initialize()
    {
        int delayBeforeWeStart = 60000; // 60000ms = 1min
        int howOftenWeRepeat = 300000; //300000ms = 5mins

        var task = new CleanRoom(_cleanUpYourRoomRunner, delayBeforeWeStart, howOftenWeRepeat, _runtime, _logger, _contentService);

        //declare the events
        _cleanUpYourRoomRunner.TaskCompleted += Task_Completed;

        _cleanUpYourRoomRunner.TaskStarting += this.Task_Starting;

        _cleanUpYourRoomRunner.TaskCancelled += this.Task_Cancelled;

        _cleanUpYourRoomRunner.TaskError += this.Task_Error;

        //As soon as we add our task to the runner it will start to run (after its delay period)
        _cleanUpYourRoomRunner.TryAdd(task);
    }

    private void Task_Error(BackgroundTaskRunner<IBackgroundTask> sender, TaskEventArgs<IBackgroundTask> e)
    {
        _logger.Info<CleanUpYourRoomComponent>("CleanUpYourRoom error");
    }

    private void Task_Cancelled(BackgroundTaskRunner<IBackgroundTask> sender, TaskEventArgs<IBackgroundTask> e)
    {
        _logger.Info<CleanUpYourRoomComponent>("CleanUpYourRoom cancelled");
    }

    private void Task_Starting(BackgroundTaskRunner<IBackgroundTask> sender, TaskEventArgs<IBackgroundTask> e)
    {
        _logger.Info<CleanUpYourRoomComponent>("CleanUpYourRoom starting");
    }

    private void Task_Completed(BackgroundTaskRunner<IBackgroundTask> sender, TaskEventArgs<IBackgroundTask> e)
    {
        _logger.Info<CleanUpYourRoomComponent>("CleanUpYourRoom run finished");
    }

    public void Terminate()
    {
        //unsubscribe during shutdown
        _cleanUpYourRoomRunner.TaskCompleted -= Task_Completed;

        _cleanUpYourRoomRunner.TaskStarting -= this.Task_Starting;

        _cleanUpYourRoomRunner.TaskCancelled -= this.Task_Cancelled;

        _cleanUpYourRoomRunner.TaskError -= this.Task_Error;
    }
}

```

### Using RuntimeState

In the example above you could add the following switch case at the beginning to help determine the server role & thus if you want to run code on that type of server and exit out early.

```csharp
// Do not run the code on replicas nor unknown role servers
// ONLY run for Master server or Single
switch (_runtime.ServerRole)
{
    case ServerRole.Replica:
        _logger.Debug<CleanRoom>("Does not run on replica servers.");
        return true; // We return true to try again as the server role may change!
    case ServerRole.Unknown:
        _logger.Debug<CleanRoom>("Does not run on servers with unknown role.");
        return true; // We return true to try again as the server role may change!
}
```
