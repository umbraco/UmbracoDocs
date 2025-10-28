---
description: Run a background job on a recurring basis
---

# Scheduling

It is possible to run recurring code using a recurring background job. Background job classes should implement the `IRecurringBackgroundJob` interface, which controls when and where the job gets run.

Once you have created your background job class, register it using a Composer. It will be detected at startup and a new `HostedService` will be created to run your job.

{% hint style="warning" %}
Be aware you may or may not want this background job to run on all servers. If you are using Load Balancing with multiple servers, see [load balancing documentation](../fundamentals/setup/server-setup/load-balancing/) for more information
{% endhint %}

## `IRecurringBackgroundJob` Properties and Methods

### Period

Defines how often the job runs. This property is a `TimeSpan`.

```csharp
// Run this job every 5 minutes
TimeSpan Period = TimeSpan.FromMinutes(5);
```

### Delay

Defines how long to wait after application startup before running the task for the first time. Default is 3 minutes. This property is a `TimeSpan`.

```csharp
// Wait 3 minutes after application startup before starting to run this job.
TimeSpan Delay = TimeSpan.FromMinutes(3);
```

### ServerRoles

Specifies a list of roles that should run this job. In a multi-server setup, you may want your job to run on _all_ servers or only on _one_ of your servers.

For example, a temporary file cleanup task might need to run on all servers. A database import job might be better to be run once per day on a single server.

By default: `{ Single, SchedulingPublisher }`, meaning it runs on one server only.

```csharp
// Run this job on all servers
ServerRole[] ServerRoles = Enum.GetValues<ServerRole>();
```

For more information about server roles, see the [Load Balancing](../fundamentals/setup/server-setup/load-balancing/README.md#scheduling-and-server-role-election) documentation.

### PeriodChanged

An event used to notify the background job service if the job’s period changes dynamically. 

For example, if the period for your job is controlled by a configuration file setting, you can trigger the `PeriodChanged` event when the configuration changes.

```csharp
// No-op event as the period never changes on this job
public event EventHandler PeriodChanged { add { } remove { } }
```

See the [Example](#example) below on how to implement the `PeriodChanged` event.

### RunJobAsync()

The main method where your job logic is implemented.

```csharp
public Task RunJobAsync() {
// your job code goes here
}
```

## Example

This example shows the minimum code necessary to implement the `IRecurringBackgroundJob` interface. The job runs every 60 minutes on all servers.

```csharp
using Umbraco.Cms.Core;
using Umbraco.Cms.Core.Logging;
using Umbraco.Cms.Core.Scoping;
using Umbraco.Cms.Core.Services;
using Umbraco.Cms.Core.Sync;
using Umbraco.Cms.Infrastructure.BackgroundJobs;

namespace Umbraco.Docs.Samples.Web.RecurringBackgroundJob;

public class CleanUpYourRoom : IRecurringBackgroundJob
{
    public TimeSpan Period { get => TimeSpan.FromMinutes(60); }

    // Runs on all servers
    public ServerRole[] ServerRoles { get => Enum.GetValues<ServerRole>(); }

    // No-op event as the period never changes on this job
    public event EventHandler PeriodChanged { add { } remove { } }

    public async Task RunJobAsync()
    {
        // YOUR CODE GOES HERE
    }
}
```

## Example with dependency injection

This example shows how to inject other Umbraco services into your background job. This example cleans the recycle bin every 60 minutes. To do so, it injects an `IContentService` to access the Recycle bin and an `IScopeProvider` to provide an ambient scope for the `EmptyRecycleBin` method.

```csharp
using Umbraco.Cms.Core;
using Umbraco.Cms.Core.Logging;
using Umbraco.Cms.Core.Scoping;
using Umbraco.Cms.Core.Services;
using Umbraco.Cms.Core.Sync;
using Umbraco.Cms.Infrastructure.BackgroundJobs;

namespace Umbraco.Docs.Samples.Web.RecurringBackgroundJob;

public class CleanUpYourRoom : IRecurringBackgroundJob
{
    public TimeSpan Period { get => TimeSpan.FromMinutes(60); }

    // Runs on all servers
    public ServerRole[] ServerRoles { get => Enum.GetValues<ServerRole>(); }

    // No-op event as the period never changes on this job
    public event EventHandler PeriodChanged { add { } remove { } }

    private readonly IContentService _contentService;
    private readonly ICoreScopeProvider _scopeProvider;

    public CleanUpYourRoom(
        IContentService contentService,
        ICoreScopeProvider scopeProvider)
    {
        _contentService = contentService;
        _scopeProvider = scopeProvider;
    }

    public Task RunJobAsync()
    {
        // Wrap the three content service calls in a scope to do it all in one transaction.
        using ICoreScope scope = _scopeProvider.CreateCoreScope();

        int numberOfThingsInBin = _contentService.CountChildren(Constants.System.RecycleBinContent);

        if (_contentService.RecycleBinSmells())
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

The complex example builds on the previous one by injecting additional services. It includes a logger to log error messages, a profiler to capture timings, and an `IServerRoleAccessor` to log the current server role.  Additionally, it injects an `IOptionsMonitor` to allow the period to be updated while the server is running. It also demonstrates how to trigger the `PeriodChanged` event to signal the job's host.

```csharp
using Umbraco.Cms.Core;
using Umbraco.Cms.Core.Logging;
using Umbraco.Cms.Core.Scoping;
using Umbraco.Cms.Core.Services;
using Umbraco.Cms.Core.Sync;
using Umbraco.Cms.Infrastructure.BackgroundJobs;

namespace Umbraco.Docs.Samples.Web.RecurringBackgroundJob;

public class CleanUpYourRoom : IRecurringBackgroundJob
{
    public TimeSpan Period { get; set; } = TimeSpan.FromMinutes(60);

    // Runs on all servers
    public ServerRole[] ServerRoles { get => Enum.GetValues<ServerRole>(); }

    //
    private event EventHandler? _periodChanged;
    public event EventHandler PeriodChanged
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

        // if the settings are updated trigger the event to let the job host know
        healthChecksSettings.OnChange(x =>
        {
            Period = x.Notification.Period;
            _periodChanged?.Invoke(this, EventArgs.Empty);
        });
    }

    public Task RunJobAsync()
    {

        // Wrap the three content service calls in a scope to do it all in one transaction.
        using ICoreScope scope = _scopeProvider.CreateCoreScope();

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
```

### Registering with a composer

All we need to do here is to create the composer where we register the background job with `AddRecurringBackgroundJob`.

```csharp
using Umbraco.Cms.Core.Composing;

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
Learn more about how to register dependencies in the [Dependency Injection](./using-ioc.md) article.
{% endhint %}

## Base Classes

`RecurringHostedServiceBase` is a low-level base class. It implements the dotnetcore interface `IHostedService` to run itself in the background, and creates and manages the timer that runs the job on a recurring basis.

`RecurringBackgroundJobHostedService` is an Umbraco specific Hosted Service that extends `RecurringHostedServiceBase`. It uses some system-level Umbraco services to ensure that your jobs only execute once Umbraco is up and running. It checks:

- Server Roles - see above for more discussion about Server roles

- MainDom - The `MainDom` lock ensures that only one instance of Umbraco is running at a time on a given machine. This ensures the integrity of certain files used by Umbraco. See [Host Synchronization](../fundamentals/setup/server-setup/load-balancing/azure-web-apps.md#host-synchronization) for more details.

- Runtime State - On a fresh install or when waiting for a database upgrade, Umbraco may be fully up and running yet.

## Notifications

The `RecurringBackgroundJobHostedService` publishes a number of notifications that can be hooked to report on the status of background jobs. All notifications extend from the base `Umbraco.CMS.Infrastructure.Notifications.RecurringBackgroundJobNotification` class.

The following notifications are available:

- Starting
- Started
- Stopping
- Stopped
- Executing
- Executed
- Failed
- Ignored

### Start/Stop

The Starting/Started and Stopping/Stopped notification pairs are published when the `RecurringBackgroundJobHostedService` is started or stopped. The start event normally occurs soon after application start as part of the .Net WebHost startup process. Similarly the stop event would happen as part of application shutdown.

These notifications are there to support low-level debugging of background jobs to ensure they are starting/stopping correctly. Due to the timing of the notification, all handlers associated with these notifications should not depend on any Umbraco services, including database access.

### Ignored

The Ignored notification is published when a background job's schedule is triggered, but the Umbraco runtime checks prevent it from running.

This notification is there to support low-level debugging of background jobs to ascertain why they are/aren't running. As the runtime checks include runtime state readiness, this event may be triggered during the install phase. Any notification handlers associated with this notification should **also** conduct their own checks before relying on Umbraco services, including database access.

### Executing/Executed/Failed

These notifications will be triggered in pairs depending on the success/failure of the job itself.

- The executing notification is triggered before the job is run.
- The executed notification is triggered after the job is completed.
- The failed notification is triggered from the catch block if an exception is thrown.

For **successful** job runs, the following notifications will be published:

1. Executing
2. Executed

For **failed** job runs, the following notifications will be published:

1. Executing
2. Failed

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

When load balancing the backoffice, all servers will have the `SchedulingPublisher` role. This means the approach described above for restricting jobs to specific server roles will not work as intended. All servers will match the `SchedulingPublisher` role.

Instead, for jobs that should only run on a single server, you should implement an `IDistributedBackgroundJob`.

`IDistributedBackgroundJob` is separate from `IRecurringBackgroundJob`, and is tracked in the database to ensure that only a single server runs the job at any given time.
This also means that you are not guaranteed what server will run the job, but you are guaranteed that only one server will run it. 

By default, distributed background jobs are checked every 5 seconds, with an initial delay of 1 minute after application startup. These settings can be changed in appsettings, see [Distributed jobs settings](./configuration/distributedjobssettings.md) for more information.

### Implementing a custom distributed background job

To implement a custom distributed background job, create a class that implements the `IDistributedBackgroundJob` interface. Like with `IRecurringBackgroundJob` DI is available in the constructor.

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

It's required to give your job a unique name via the `Name` property. This is used to track the job in the database.

The period is specified via the `Period` property, which controls how often the job should be run, in this example it's every 20 seconds.

It's not required to manually register the job in the database, however you must register it to dependency injection so Umbraco can find it. This can be done with a composer or in `Program.cs`

```csharp
public class MyComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.Services.AddSingleton<IDistributedBackgroundJob, MyCustomBackgroundJob>();
    }
}
```
