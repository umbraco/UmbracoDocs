---
description: Run a background job on a recurring basis
---

# Scheduling

You can run recurring code using a recurring background job. The recommended way is to inherit from the abstract `RecurringBackgroundJobBase` class. The class provides defaults for delay, server roles, and event handling. Pass the `Period` to the base constructor and implement `RunJobAsync(CancellationToken)`.

Alternatively, implement the `IRecurringBackgroundJob` interface directly — for example, when your job class already inherits from another base class. The interface provides the same defaults via default interface methods, so you only need to override what you want to change.

Once you have created your background job class, register it using `AddRecurringBackgroundJob<TJob>()`. The job is detected at startup and a new hosted service is created to run it.

{% hint style="warning" %}
Be aware you may or may not want this background job to run on all servers. If you are using Load Balancing with multiple servers, see the [load balancing documentation](../../run-in-production/infrastructure-and-ops/server-setup/load-balancing/) for more information.
{% endhint %}

## `RecurringBackgroundJobBase` Properties and Methods

The members below are defined on `IRecurringBackgroundJob` and either inherited or overridden via `RecurringBackgroundJobBase`. The signatures and behavior are the same whether you inherit the base class or implement the interface directly.

### Period

Defines how often the job runs. This property is a `TimeSpan`. Pass the initial value to the base constructor.

```csharp
// Run this job every 5 minutes
public CleanUpYourRoom()
    : base(TimeSpan.FromMinutes(5))
{
}
```

To change the period at runtime, assign the protected setter (`Period = newValue`). The base class validates the value, no-ops if the value is unchanged, and raises `PeriodChanged` automatically. See the [Complex example](scheduling.md#complex-example) below.

Set `Period` to `Timeout.InfiniteTimeSpan` to disable recurring runs. The job then only runs when [triggered manually](scheduling.md#on-demand-triggering).

### Delay

Defines how long to wait after application startup before running the job for the first time. The default is 3 minutes.

The delay prevents the job from competing with startup work for resources. It also gives caches and other dependencies time to populate before the first run.

```csharp
// Wait 1 minute after application startup before running this job for the first time.
public override TimeSpan Delay => TimeSpan.FromMinutes(1);
```

Set `Delay` to `Timeout.InfiniteTimeSpan` to not automatically start the recurring runs. The job then only runs (and starts recurring runs) when triggered manually.

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

An event used to notify the background job service when the job's period changes dynamically. The base class raises this automatically when `Period` is assigned via the protected setter.

For example, if the period for your job is controlled by a configuration file setting, assign `Period = newValue` when the configuration changes. See the [Complex example](scheduling.md#complex-example) below for an implementation.

### IgnoredDelayChanged

Mirrors `PeriodChanged`. The base class raises this event automatically when `IgnoredDelay` is assigned a new value via the protected setter. The recurring background job host listens for it and interrupts any in-progress ignored back-off so the new value is picked up immediately.

This makes it possible to start a job with `IgnoredDelay = Timeout.InfiniteTimeSpan` (effectively disabled after the first ignored execution until further notice). You can later re-enable it by assigning a finite value. This is useful when an external signal indicates that the previously-ignored condition has cleared.

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
using System;
using System.Threading;
using System.Threading.Tasks;
using Umbraco.Cms.Infrastructure.BackgroundJobs;

namespace Umbraco.Docs.Samples.Web.RecurringBackgroundJob;

public class CleanUpYourRoom : RecurringBackgroundJobBase
{
    public CleanUpYourRoom()
        : base(TimeSpan.FromMinutes(60))
    {
    }

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
using System;
using System.Threading;
using System.Threading.Tasks;
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
        : base(TimeSpan.FromMinutes(60))
    {
        _contentService = contentService;
        _scopeProvider = scopeProvider;
    }

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

The complex example builds on the previous one by injecting additional services. It includes a logger to log error messages, a profiler to capture timings, and an `IServerRoleAccessor` to log the current server role. It also injects an `IOptionsMonitor` to allow the period to be updated while the server is running. Assigning the new value to `Period` raises `PeriodChanged`, so the host reschedules. The `IOptionsMonitor.OnChange` registration is disposed via the base class's `Dispose(bool)` hook.

```csharp
using System;
using System.Threading;
using System.Threading.Tasks;
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
    private readonly IContentService _contentService;
    private readonly IServerRoleAccessor _serverRoleAccessor;
    private readonly IProfilingLogger _profilingLogger;
    private readonly ILogger<CleanUpYourRoom> _logger;
    private readonly ICoreScopeProvider _scopeProvider;
    private readonly IDisposable? _onChangeRegistration;

    // Run on all servers
    public override ServerRole[] ServerRoles => Enum.GetValues<ServerRole>();

    public CleanUpYourRoom(
        IContentService contentService,
        IServerRoleAccessor serverRoleAccessor,
        IProfilingLogger profilingLogger,
        ILogger<CleanUpYourRoom> logger,
        IOptionsMonitor<HealthChecksSettings> healthChecksSettings,
        ICoreScopeProvider scopeProvider)
        : base(healthChecksSettings.CurrentValue.Notification.Period)
    {
        _contentService = contentService;
        _serverRoleAccessor = serverRoleAccessor;
        _profilingLogger = profilingLogger;
        _logger = logger;
        _scopeProvider = scopeProvider;

        // When the period config changes, assign Period - the setter raises PeriodChanged.
        _onChangeRegistration = healthChecksSettings.OnChange(x => Period = x.Notification.Period);
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

    protected override void Dispose(bool disposing)
    {
        if (disposing)
        {
            _onChangeRegistration?.Dispose();
        }

        base.Dispose(disposing);
    }
}
```

### Registering with a composer

Create a composer and register the background job with `AddRecurringBackgroundJob<TJob>()`.

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
using System;
using System.Threading;
using System.Threading.Tasks;
using Umbraco.Cms.Infrastructure.BackgroundJobs;

namespace Umbraco.Docs.Samples.Web.RecurringBackgroundJob;

public class CleanUpYourRoom : RecurringBackgroundJobBase, ITriggerableRecurringBackgroundJob
{
    public CleanUpYourRoom()
        : base(TimeSpan.FromMinutes(60))
    {
    }

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

To create a job that only runs when triggered manually, pass `Timeout.InfiniteTimeSpan` to the base constructor and override `Delay` to the same value. The job is registered, and a hosted service is created for it, but no automatic execution occurs.

```csharp
public MyJob()
    : base(Timeout.InfiniteTimeSpan)
{
}

public override TimeSpan Delay => Timeout.InfiniteTimeSpan;
```

## Base Classes

`RecurringBackgroundJobBase` is the recommended base class for new jobs. It implements `IRecurringBackgroundJob` and provides defaults for `Delay`, `IgnoredDelay`, `ServerRoles`, `PeriodChanged`, and `IgnoredDelayChanged`. Implementors pass `Period` to the base constructor and provide `RunJobAsync(CancellationToken)`.

The base class also implements `IDisposable` with a `protected virtual Dispose(bool disposing)` hook. Subclasses with disposable resources (for example, an `IOptionsMonitor.OnChange` registration) should override the hook and call `base.Dispose(disposing)`.

`RecurringHostedServiceBase` is a low-level base class. It inherits from .NET's `BackgroundService` and runs the job on a recurring basis using a wait loop with cancellation support. The loop supports periodic execution, manual triggering, exception resilience, and cooperative cancellation on host shutdown.

`RecurringBackgroundJobHostedService` is an Umbraco-specific hosted service that extends `RecurringHostedServiceBase`. It uses Umbraco system services to ensure that your jobs only execute once Umbraco is up and running. It checks:

* Server Roles - see above for more discussion about Server roles.
* MainDom - The `MainDom` lock ensures that only one instance of Umbraco is running at a time on a given machine. This ensures the integrity of certain files used by Umbraco. See [Host Synchronization](../../run-in-production/infrastructure-and-ops/server-setup/load-balancing/azure-web-apps.md#host-synchronization) for more details.
* Runtime State - On a fresh install or when waiting for a database upgrade, Umbraco may not be fully up and running yet.

When any of these checks fail, the execution is ignored, and the loop waits for `IgnoredDelay` before re-evaluating.

## Notifications

The `RecurringBackgroundJobHostedService` publishes a number of notifications that can be used to report on the status of background jobs. All notifications extend from the base `Umbraco.Cms.Infrastructure.Notifications.RecurringBackgroundJobNotification` class.

The following notifications are available:

* `RecurringBackgroundJobStartingNotification` - published before starting the recurring job.
* `RecurringBackgroundJobStartedNotification` - published after the recurring job has started.
* `RecurringBackgroundJobExecutingNotification` - published before running the job.
* `RecurringBackgroundJobIgnoredNotification` - published when the job is ignored (see `IgnoredDelay`).
* `RecurringBackgroundJobExecutedNotification` - published after `RunJobAsync()` is called.
* `RecurringBackgroundJobCanceledNotification` - published when the job was cancelled due to application shutdown.
* `RecurringBackgroundJobFailedNotification` - published when an unhandled exception was thrown while running the job.
* `RecurringBackgroundJobStoppingNotification` - published before stopping the recurring job.
* `RecurringBackgroundJobStoppedNotification` - published after the recurring job has stopped.

### Start/Stop

The Starting/Started and Stopping/Stopped notification pairs are published when the `RecurringBackgroundJobHostedService` is started or stopped. The start event normally occurs soon after application start as part of the .NET WebHost startup process. Similarly, the stop event happens as part of the application shutdown.

These notifications are there to support low-level debugging of background jobs to ensure they are starting and stopping correctly. Due to the timing of the notification, all handlers associated with these notifications should not depend on any Umbraco services, including database access.

### Ignored

The Ignored notification is published when a background job's schedule is triggered, but the Umbraco runtime checks prevent it from running.

This notification is there to support low-level debugging of background jobs to ascertain why they are or aren't running. As the runtime checks include runtime state readiness, this event may be triggered during the install phase. Any notification handlers associated with this notification should also conduct their own checks before relying on Umbraco services, including database access.

For **ignored** job runs, the following notifications are published:

1. Executing
2. Ignored

### Executing/Executed/Failed/Canceled

These notifications are triggered in pairs depending on the success, failure, or cancellation of the job.

* The Executing notification is triggered before the job is run.
* The Executed notification is triggered after the job completes.
* The Failed notification is triggered from the catch block if an exception is thrown.
* The Canceled notification is triggered when the job is canceled during host shutdown.

For **successful** job runs, the following notifications are published:

1. Executing
2. Executed

For **failed** job runs, the following notifications are published:

1. Executing
2. Failed

For **canceled** job runs (typically during host shutdown), the following notifications are published:

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

By default, each server polls for runnable jobs every 5 seconds, after an initial startup delay of 1 minute. The first execution of a given job happens at `startup + Delay + Period`, where `Period` is the job's own `Period` property. The polling interval and startup delay are both configurable in appsettings. See [Distributed jobs settings](../../develop-with-umbraco/configuration/distributedjobssettings.md) for the available options.

{% hint style="info" %}

The job's `Period` (run frequency) and the `DistributedJobs:Period` setting (database polling frequency) are two different values sharing the same name.

{% endhint %}

### Implementing a custom distributed background job

To implement a custom distributed background job, create a class that implements the `IDistributedBackgroundJob` interface. As with `IRecurringBackgroundJob`, dependency injection is available in the constructor.

```csharp
using System;
using System.Threading.Tasks;
using Microsoft.Extensions.Logging;
using Umbraco.Cms.Infrastructure.BackgroundJobs;

public class MyCustomBackgroundJob : IDistributedBackgroundJob
{
    private readonly ILogger<MyCustomBackgroundJob> _logger;

    public string Name => nameof(MyCustomBackgroundJob);

    public TimeSpan Period { get; }

    public MyCustomBackgroundJob(ILogger<MyCustomBackgroundJob> logger)
    {
        _logger = logger;
        Period = TimeSpan.FromSeconds(20);
    }

    // Kept for backwards compatibility. Forward to the cancellation-aware overload.
    public Task ExecuteAsync() => ExecuteAsync(CancellationToken.None);

    public async Task ExecuteAsync(CancellationToken cancellationToken)
    {
        _logger.LogInformation("MyCustomBackgroundJob is executing.");
        await Task.Delay(TimeSpan.FromSeconds(1), cancellationToken);
    }
}
```

Give the job a unique `Name`. The name identifies the job's row in the database and must not collide with any other distributed job in the solution.

The `Period` property controls how often the job runs. In the example above, the job runs every 20 seconds.

You do not need to register the job in the database. You do need to register it in the dependency-injection container so Umbraco can discover it. Register it from a composer or in `Program.cs`:

```csharp
public class MyComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.Services.AddSingleton<IDistributedBackgroundJob, MyCustomBackgroundJob>();
    }
}
```

### Graceful shutdown

`IDistributedBackgroundJob` exposes two overloads of `ExecuteAsync`:

* `ExecuteAsync()` is kept for backwards compatibility.
* `ExecuteAsync(CancellationToken cancellationToken)` receives a token that is triggered when the host begins shutting down.

The host always calls the cancellation-aware overload. Jobs that pass the token to their async work (for example `Task.Delay`, `DbContext` queries, or `HttpClient` calls) can stop quickly and let the host shut down cleanly. When a job returns or throws — including via `OperationCanceledException` — the host clears the running flag in the database. This way other servers do not need to wait for the `MaximumExecutionTime` grace period before the job can run again.

Jobs that ignore the token continue running until they finish. The host waits for them, which extends the shutdown time.

{% hint style="info" %}
The `ExecuteAsync(CancellationToken)` overload was added in Umbraco 17.5. Existing jobs that only override `ExecuteAsync()` continue to work through a default interface implementation, but cannot participate in graceful shutdown.
{% endhint %}

### How the database tracks the job

Each distributed background job has a row in the database, keyed by `Name`, with two timestamps that drive scheduling:

* `LastAttemptedRun` is stamped when a server picks the job up, before `ExecuteAsync` is called.
* `LastRun` is stamped when `ExecuteAsync` returns — including when it throws or is cancelled — because the host stamps it from a `finally` block. The stamp is only skipped if the host process dies before the `finally` runs (for example, a hard crash or forced kill).

A job is eligible to run when more than `Period` has elapsed since `LastRun`. A job that is already marked as running is skipped. The exception is when more than `Period + MaximumExecutionTime` has elapsed since `LastAttemptedRun`. In that case the job is considered stale and another server can pick it up. See [Distributed jobs settings](../../develop-with-umbraco/configuration/distributedjobssettings.md) for details on `MaximumExecutionTime`.
