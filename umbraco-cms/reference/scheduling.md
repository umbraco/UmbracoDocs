---
description: "Use hosted services (RecurringHostedServiceBase) to run a background task in Umbraco CMS."
---

# Scheduling

It is possible to run recurring code using a hosted service. Below is a complete example showing how to create and register a hosted service that will regularly empty out the recycle bin every five minutes.

{% hint style="warning" %}
Be aware you may or may not want this hosted service code to run on all servers, if you are using Load Balancing with multiple servers, see [load balancing documentation](../fundamentals/setup/server-setup/load-balancing/) for more information
{% endhint %}

## RecurringHostedService example

```chsarp
using System;
using System.Threading.Tasks;
using Microsoft.Extensions.Logging;
using Umbraco.Cms.Core;
using Umbraco.Cms.Core.Logging;
using Umbraco.Cms.Core.Scoping;
using Umbraco.Cms.Core.Services;
using Umbraco.Cms.Core.Sync;
using Umbraco.Cms.Infrastructure.HostedServices;

namespace Umbraco.Docs.Samples.Web.RecurringHostedService
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
            : base(logger, HowOftenWeRepeat, DelayBeforeWeStart)
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
            _logger.LogInformation("You have {NumberOfThingsInTheBin} items to clean", numberOfThingsInBin);

            if (_contentService.RecycleBinSmells())
            {
                // Take out the trash
                using (_profilingLogger.TraceDuration<CleanUpYourRoom>("Mum, I am emptying out the bin",
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

{% hint style="info" %}
If you are using an Umbraco version before v9.4 you can't pass in an instance of `ILogger` in to the base constructor. See the code example below:

```
public CleanUpYourRoom(
    ...)
    : base(HowOftenWeRepeat, DelayBeforeWeStart)
{
    ...
}
```
{% endhint %}

### Registering with extension method

First we need to create our extension method where we register the hosted service with `AddHostedService`:

```
using Microsoft.Extensions.DependencyInjection;
using Umbraco.Cms.Core.DependencyInjection;

namespace Umbraco.Docs.Samples.Web.RecurringHostedService
{
    public static class UmbracoBuilderHostedServiceExtensions
    {
        public static IUmbracoBuilder AddCustomHostedServices(this IUmbracoBuilder builder)
        {
            builder.Services.AddHostedService<CleanUpYourRoom>();
            return builder;
        }
    }
}
```

Now we can invoke it in the `ConfigureServices` method in `Startup.cs`:

```
public void ConfigureServices(IServiceCollection services)
{
#pragma warning disable IDE0022 // Use expression body for methods
    services.AddUmbraco(_env, _config)
        .AddBackOffice()
        .AddWebsite()
        .AddComposers()
        .AddCustomHostedServices() // Register CleanUpYourRoom
        .Build();
#pragma warning restore IDE0022 // Use expression body for methods
}
```

### Registering with a composer

All we need to do here is to create the composer where we register the hosted service with `AddHostedService`, which will be run automatically:

```
using Microsoft.Extensions.DependencyInjection;
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.DependencyInjection;

namespace Umbraco.Docs.Samples.Web.RecurringHostedService
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

The `RecurringHostedServiceBase` is a base class that implements the netcore interface `IHostedService` and makes the task recurring, if you don't need your task to run recurringly you can implement `IHostedService` yourself, and register your hosted service in the same way. For more information about hosted services, take a look at the [Microsoft documentation](https://docs.microsoft.com/en-us/aspnet/core/fundamentals/host/hosted-services?view=aspnetcore-5.0).

## BackgroundTaskRunner Notifications

In earlier versions of Umbraco, there were a series of events triggered by background tasks, with the switch to notifications this no longer exists, however, fear not, because you can publish any custom notification you desire from within your background task. For more information about creating and publishing your own custom notifications see: [Creating and Publishing Custom Notifications](notifications/creating-and-publishing-notifications.md)

## Using ServerRoleAccessor

In the example above you could add the following switch case at the beginning to help determine the server role & thus if you don't want to run code on that type of server you can exit out early.

```
// Do not run the code on subscribers or unknown role servers
// ONLY run for SchedulingPublisher server or Single server roles
switch (_serverRoleAccessor.CurrentServerRole)
{
    case ServerRole.Subscriber:
        _logger.LogDebug("Does not run on subscriber servers.");
        return Task.CompletedTask; // We return Task.CompletedTask to try again as the server role may change!
    case ServerRole.Unknown:
        _logger.LogDebug("Does not run on servers with unknown role.");
        return Task.CompletedTask; // We return Task.CompletedTask to try again as the server role may change! 
}
```
