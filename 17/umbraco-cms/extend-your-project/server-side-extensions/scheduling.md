---
description: Run a background job on a recurring basis
---

# Scheduling

You can run recurring code using a recurring background job. The recommended way is to inherit from the abstract `RecurringBackgroundJobBase` class. The class provides defaults for delay, server roles, and event handling, so you only need to set the `Period` and implement `RunJobAsync(CancellationToken)`.

If you need more control, you can implement the `IRecurringBackgroundJob` interface directly.

Once you have created your background job class, register it using a Composer. The job is detected at startup and a new `HostedService` is created to run it.

{% hint style="warning" %}
Be aware you may or may not want this background job to run on all servers. If you are using Load Balancing with multiple servers, see the [load balancing documentation](../../run-in-production/infrastructure-and-ops/server-setup/load-balancing/) for more information.
{% endhint %}

## `RecurringBackgroundJobBase` Properties and Methods

The members below are defined on `IRecurringBackgroundJob` and either inherited or overridden via `RecurringBackgroundJobBase`. The signatures and behavior are the same whether you inherit the base class or implement the interface directly.

### Period

Defines how often the job runs. This property is a `TimeSpan`.

```csharp
// Run this job every 5 minutes
public override TimeSpan Period => TimeSpan.FromMinutes(5);
```

Set `Period` to `Timeout.InfiniteTimeSpan` to disable automatic scheduling. The job then only runs when [triggered manually](scheduling.md#on-demand-triggering).

### Delay

Defines how long to wait after application startup before running the job for the first time. The default is 3 minutes.

```csharp
// Wait 1 minute after application startup before running this job for the first time.
public override TimeSpan Delay => TimeSpan.FromMinutes(1);
```

Set `Delay` to `Timeout.InfiniteTimeSpan` to skip the automatic first run. The job then only runs when triggered manually.

### IgnoredDelay

Defines how long to wait after an ignored execution before re-evaluating execution conditions. The default is 1 minute.

A job is ignored when the runtime is not ready, the server role is not allowed, or this instance is not the main domain. The back-off prevents tight looping when `Period` is short and the runtime keeps skipping the job.

```csharp
// Wait 5 minutes before re-evaluating after an ignored execution.
public override TimeSpan IgnoredDelay => TimeSpan.FromMinutes(5);
```

Set `IgnoredDelay` to `Timeout.InfiniteTimeSpan` to disable the job for the rest of the application lifecycle once an ignored condition is encountered. Use this when the ignored condition is known not to change. For example, on a subscriber server where the job is restricted to a publisher role.

Set `IgnoredDelay` to `TimeSpan.Zero` to skip the back-off entirely.

### ServerRoles

Specifies the server roles that run this job. In a multi-server setup, you may want your job to run on _all_ servers or only on _one_ of your servers.

For example, a temporary file cleanup task might need to run on all servers. A database import job might be better to run once per day on a single server.

By default: `{ Single, SchedulingPublisher }`, meaning the job runs on one server only.

```csharp
// Run this job on all servers
public override ServerRole[] ServerRoles => Enum.GetValues<ServerRole>();
```

For more information about server roles, see the [Load Balancing](../../run-in-production/infrastructure-and-ops/server-setup/load-balancing/#scheduling-and-server-role-election) documentation.

### PeriodChanged

An event used to notify the background job service if the job's period changes dynamically.

For example, if the period for your job is controlled by a configuration file setting, raise the `PeriodChanged` event when the configuration changes.

`RecurringBackgroundJobBase` provides a no-op implementation. Override the event when you need to raise it. See the [Complex example](scheduling.md#complex-example) below for an implementation.

### RunJobAsync(CancellationToken)

The main method where your job logic is implemented. The `CancellationToken` is signaled when the host is shutting down. Pass it through to async operations to support cooperative cancellation.

```csharp
public override Task RunJobAsync(CancellationToken cancellationToken)
{
    // your job code goes here
    return Task.CompletedTask;
}
```

{% hint style="info" %}
The `RunJobAsync()` overload without a cancellation token is obsolete and scheduled for removal in Umbraco 19. New jobs should use `RunJobAsync(CancellationToken)`.
{% endhint %}

## Example

This example shows the minimum code necessary to implement a recurring background job using `RecurringBackgroundJobBase`. The job runs every 60 minutes on the default server roles (`Single` and `SchedulingPublisher`).

```csharp
using Umbraco.Cms.Infrastructure.BackgroundJobs;

namespace Umbraco.Docs.Samples.Web.RecurringBackgroundJob;

public class CleanUpYourRoom : RecurringBackgroundJobBase
{
    public override TimeSpan Period => TimeSpan.FromMinutes(60);

    public override Task RunJobAsync(CancellationToken cancellationToken)
    {
        // YOUR CODE GOES HERE
        return Task.CompletedTask;
    }
}
```

## Example with dependency injection

This example shows how to inject other Umbraco services into your background job. The job cleans the recycle bin every 60 minutes. It injects an `IContentService` to access the Recycle Bin and an `ICoreScopeProvider` to provide an ambient scope for the `EmptyRecycleBin` method.

```csharp
using Umbraco.Cms.Core;
using Umbraco.Cms.Core.Scoping;
using Umbraco.Cms.Core.Services;
using Umbraco.Cms.Core.Sync;
using Umbraco.Cms.Infrastructure.BackgroundJobs;

namespace Umbraco.Docs.Samples.Web.RecurringBackgroundJob;

public class CleanUpYourRoom : RecurringBackgroundJobBase
{
    private readonly IContentService _contentService;
    private readonly ICoreScopeProvider _scopeProvider;

    public CleanUpYourRoom(
        IContentService contentService,
        ICoreScopeProvider scopeProvider)
    {
        _contentService = contentService;
        _scopeProvider = scopeProvider;
    }

    public override TimeSpan Period => TimeSpan.FromMinutes(60);

    // Run on all servers
    public override ServerRole[] ServerRoles => Enum.GetValues<ServerRole>();

    public override Task RunJobAsync(CancellationToken cancellationToken)
    {
        // Wrap the content service calls in a scope to do them in one transaction.
        using ICoreScope scope = _scopeProvider.CreateCoreScope();

        int numberOfThingsInBin = _contentService.CountChildren(Constants.System.RecycleBinContent);

        if (numberOfThingsInBin > 0)
        {
            _contentService.EmptyRecycleBin(userId: -1);
        }

        // Remember to complete the scope when done.
        scope.Complete();
        return Task.CompletedTask;
    }
}
```

## Complex example

The complex example builds on the previous one by injecting additional services. It includes a logger to log error messages, a profiler to capture timings, and an `IServerRoleAccessor` to log the current server role. It also injects an `IOptionsMonitor` to allow the period to be updated while the server is running. It demonstrates how to override and raise the `PeriodChanged` event to signal the job's host.

```csharp
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Umbraco.Cms.Core;
using Umbraco.Cms.Core.Configuration.Models;
using Umbraco.Cms.Core.Logging;
using Umbraco.Cms.Core.Scoping;
using Umbraco.Cms.Core.Services;
using Umbraco.Cms.Core.Sync;
using Umbraco.Cms.Infrastructure.BackgroundJobs;

namespace Umbraco.Docs.Samples.Web.RecurringBackgroundJob;

public class CleanUpYourRoom : RecurringBackgroundJobBase
{
    private TimeSpan _period = TimeSpan.FromMinutes(60);

    public override TimeSpan Period => _period;

    // Run on all servers
    public override ServerRole[] ServerRoles => Enum.GetValues<ServerRole>();

    private event EventHandler? _periodChanged;
    public override event EventHandler PeriodChanged
    {
        add { _periodChanged += value; }
        remove { _periodChanged -= value; }
    }

    private readonly IContentService _contentService;
    private readonly IServerRoleAccessor _serverRoleAccessor;
    private readonly IProfilingLogger _profilingLogger;
    private readonly ILogger<CleanUpYourRoom> _logger;
    private readonly ICoreScopeProvider _scopeProvider;

    public CleanUpYourRoom(
        IContentService contentService,
        IServerRoleAccessor serverRoleAccessor,
        IProfilingLogger profilingLogger,
        ILogger<CleanUpYourRoom> logger,
        ICoreScopeProvider scopeProvider,
        IOptionsMonitor<HealthChecksSettings> healthChecksSettings)
    {
        _contentService = contentService;
        _serverRoleAccessor = serverRoleAccessor;
        _profilingLogger = profilingLogger;
        _logger = logger;
        _scopeProvider = scopeProvider;

        // When the settings change, update the period and raise the event so the host reschedules.
        healthChecksSettings.OnChange(x =>
        {
            _period = x.Notification.Period;
            _periodChanged?.Invoke(this, EventArgs.Empty);
        });
    }

    public override Task RunJobAsync(CancellationToken cancellationToken)
    {
        // Wrap the content service calls in a scope to do them in one transaction.
        using ICoreScope scope = _scopeProvider.CreateCoreScope();

        int numberOfThingsInBin = _contentService.CountChildren(Constants.System.RecycleBinContent);
        _logger.LogInformation("Go clean your room - {ServerRole}", _serverRoleAccessor.CurrentServerRole);
        _logger.LogInformation("You have {NumberOfThingsInTheBin} items to clean", numberOfThingsInBin);

        if (numberOfThingsInBin > 0)
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
```

### Registering with a composer

Create a composer and register the background job with `AddRecurringBackgroundJob`.

```csharp
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.DependencyInjection;

namespace Umbraco.Docs.Samples.Web.RecurringBackgroundJob;

public class CleanUpYourRoomComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.Services.AddRecurringBackgroundJob<CleanUpYourRoom>();
    }
}
```

{% hint style="info" %}
Learn more about how to register dependencies in the [Dependency Injection](../../develop-with-umbraco/application-code/backend-and-custom-logic/using-ioc.md) article.
{% endhint %}

## On-demand triggering

A recurring background job can be triggered to run immediately, in addition to its normal schedule. This is useful when you want to run a job in response to an event or a user action. For example, after a configuration change or from an API endpoint.

Triggering is opt-in. A job must implement the marker interface `ITriggerableRecurringBackgroundJob` to support manual triggering.

### Opting in to manual triggering

Add `ITriggerableRecurringBackgroundJob` to the job declaration. The interface is empty and extends `IRecurringBackgroundJob`.

```csharp
using Umbraco.Cms.Infrastructure.BackgroundJobs;

namespace Umbraco.Docs.Samples.Web.RecurringBackgroundJob;

public class CleanUpYourRoom : RecurringBackgroundJobBase, ITriggerableRecurringBackgroundJob
{
    public override TimeSpan Period => TimeSpan.FromMinutes(60);

    public override Task RunJobAsync(CancellationToken cancellationToken)
    {
        // your job code goes here
        return Task.CompletedTask;
    }
}
```

Register the job the usual way with `AddRecurringBackgroundJob<CleanUpYourRoom>()`. No additional registration is required to enable triggering.

### Triggering a job

Inject `IRecurringBackgroundJobTrigger<TJob>` where you want to trigger the job. The generic type parameter must be a class implementing `ITriggerableRecurringBackgroundJob`. The generic constraint makes requesting a trigger for a job without the marker interface a compile error.

```csharp
using Microsoft.AspNetCore.Mvc;
using Umbraco.Cms.Infrastructure.BackgroundJobs;

namespace Umbraco.Docs.Samples.Web.RecurringBackgroundJob;

public class CleanUpController : Controller
{
    private readonly IRecurringBackgroundJobTrigger<CleanUpYourRoom> _trigger;

    public CleanUpController(IRecurringBackgroundJobTrigger<CleanUpYourRoom> trigger)
    {
        _trigger = trigger;
    }

    public IActionResult RunNow()
    {
        bool triggered = _trigger.TriggerExecution();
        return Ok(triggered);
    }
}
```

`TriggerExecution` returns `false` if no hosted service is currently running for the job. For example, before `StartAsync` is called, or if the job is not registered.

### Controlling the next execution after a manual trigger

The `TriggerExecution` method has three overloads that control what happens after the triggered execution finishes.

| Overload | Behavior after the triggered execution |
| --- | --- |
| `TriggerExecution()` | Resume the original schedule. If the triggered execution overshot the next scheduled tick, skip it to avoid double-execution. Same as `NextExecutionStrategy.None`. |
| `TriggerExecution(NextExecutionStrategy.Reset)` | Wait a full period. The schedule shifts forward from the triggered execution. |
| `TriggerExecution(NextExecutionStrategy.Replace)` | The triggered execution replaces the next scheduled tick. The following execution occurs one full period after the originally-scheduled time. |
| `TriggerExecution(TimeSpan nextDelay)` | Wait the specified custom delay before the next execution. |

For example, to trigger a job and reset its schedule:

```csharp
_trigger.TriggerExecution(NextExecutionStrategy.Reset);
```

### Manual-only jobs

To create a job that only runs when triggered manually, set `Period` to `Timeout.InfiniteTimeSpan`. The job is registered and a hosted service is created for it, but no automatic execution occurs.

```csharp
public override TimeSpan Period => Timeout.InfiniteTimeSpan;
```

Combine this with `Delay => Timeout.InfiniteTimeSpan` to also skip the initial run after startup.

## Base Classes

`RecurringBackgroundJobBase` is the recommended base class for new jobs. It implements `IRecurringBackgroundJob` and provides defaults for `Delay`, `IgnoredDelay`, `ServerRoles`, and `PeriodChanged`. Implementors only need to provide `Period` and `RunJobAsync(CancellationToken)`.

`RecurringHostedServiceBase` is a low-level base class. It inherits from .NET's `BackgroundService` and runs the job on a recurring basis using a wait loop with cancellation support. The loop supports periodic execution, manual triggering, exception resilience, and cooperative cancellation on host shutdown.

`RecurringBackgroundJobHostedService` is an Umbraco-specific hosted service that extends `RecurringHostedServiceBase`. It uses Umbraco system services to ensure that your jobs only execute once Umbraco is up and running. It checks:

* Server Roles - see above for more discussion about Server roles.
* MainDom - The `MainDom` lock ensures that only one instance of Umbraco is running at a time on a given machine. This ensures the integrity of certain files used by Umbraco. See [Host Synchronization](../../run-in-production/infrastructure-and-ops/server-setup/load-balancing/azure-web-apps.md#host-synchronization) for more details.
* Runtime State - On a fresh install or when waiting for a database upgrade, Umbraco may not be fully up and running yet.

When any of these checks fail, the execution is ignored and the loop waits for `IgnoredDelay` before re-evaluating.

## Notifications

The `RecurringBackgroundJobHostedService` publishes a number of notifications that can be hooked to report on the status of background jobs. All notifications extend from the base `Umbraco.Cms.Infrastructure.Notifications.RecurringBackgroundJobNotification` class.

The following notifications are available:

* Starting
* Started
* Stopping
* Stopped
* Executing
* Executed
* Failed
* Canceled
* Ignored

### Start/Stop

The Starting/Started and Stopping/Stopped notification pairs are published when the `RecurringBackgroundJobHostedService` is started or stopped. The start event normally occurs soon after application start as part of the .NET WebHost startup process. Similarly, the stop event happens as part of application shutdown.

These notifications are there to support low-level debugging of background jobs to ensure they are starting and stopping correctly. Due to the timing of the notification, all handlers associated with these notifications should not depend on any Umbraco services, including database access.

### Ignored

The Ignored notification is published when a background job's schedule is triggered, but the Umbraco runtime checks prevent it from running.

This notification is there to support low-level debugging of background jobs to ascertain why they are or aren't running. As the runtime checks include runtime state readiness, this event may be triggered during the install phase. Any notification handlers associated with this notification should also conduct their own checks before relying on Umbraco services, including database access.

### Executing/Executed/Failed/Canceled

These notifications are triggered in pairs depending on the success, failure, or cancellation of the job.

* The Executing notification is triggered before the job is run.
* The Executed notification is triggered after the job completes.
* The Failed notification is triggered from the catch block if an exception is thrown.
* The Canceled notification is triggered when the job is cancelled during host shutdown.

For **successful** job runs, the following notifications are published:

1. Executing
2. Executed

For **failed** job runs, the following notifications are published:

1. Executing
2. Failed

For **cancelled** job runs (typically during host shutdown), the following notifications are published:

1. Executing
2. Canceled

```csharp
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

## Background jobs when load balancing the backoffice

When load balancing the backoffice, all servers have the `SchedulingPublisher` role. This means the approach described above for restricting jobs to specific server roles does not work as intended. All servers match the `SchedulingPublisher` role.

Instead, for jobs that should only run on a single server, implement an `IDistributedBackgroundJob`.

`IDistributedBackgroundJob` is separate from `IRecurringBackgroundJob`. The job is tracked in the database to ensure that only a single server runs it at any given time. This also means you are not guaranteed which server runs the job, but you are guaranteed that only one server runs it.

By default, distributed background jobs are checked every 5 seconds, with an initial delay of 1 minute after application startup. These settings can be changed via configuration. See [Distributed jobs settings](../../develop-with-umbraco/configuration/distributedjobssettings.md) for more information.

### Implementing a custom distributed background job

To implement a custom distributed background job, create a class that implements the `IDistributedBackgroundJob` interface. As with `IRecurringBackgroundJob`, dependency injection (DI) is available in the constructor.

```csharp
public class MyCustomBackgroundJob : IDistributedBackgroundJob
{
    private readonly ILogger<MyCustomBackgroundJob> _logger;
    public string Name => "MyCustomBackgroundJob";

    public TimeSpan Period { get; private set; }

    public MyCustomBackgroundJob(ILogger<MyCustomBackgroundJob> logger)
    {
        _logger = logger;
        Period = TimeSpan.FromSeconds(20);
    }

    public Task ExecuteAsync()
    {
        // Your custom background job logic here
        _logger.LogInformation("MyCustomBackgroundJob is executing.");
        return Task.CompletedTask;
    }
}
```

It's required to give your job a unique name via the `Name` property. The name is used to track the job in the database.

The period is specified via the `Period` property, which controls how often the job should run. In this example, it runs every 20 seconds.

It's not required to manually register the job in the database. However, you must register it with the dependency injection container so Umbraco can find it. This can be done with a composer or in `Program.cs`:

```csharp
public class MyComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.Services.AddSingleton<IDistributedBackgroundJob, MyCustomBackgroundJob>();
    }
}
```
