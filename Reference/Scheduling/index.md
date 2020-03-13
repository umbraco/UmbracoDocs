---
versionFrom: 8.0.0
---

# Scheduling with BackgroundTaskRunner
In Umbraco 8+ it is possible to run recurring code using the `BackgroundTaskRunner`.
Below is a complete example showing how to register a Task Runner with a [component](../../Implementation/Composing/index.md) that will regularly empty out the recycle bin every five minutes.

:::warning
Be aware you may or may not want this background task code to run on all servers, if you are using Load Balancing with multiple servers - https://our.umbraco.com/Documentation/Getting-Started/Setup/Server-Setup/Load-Balancing/
:::

```csharp
using Umbraco.Core;
using Umbraco.Core.Composing;
using Umbraco.Core.Logging;
using Umbraco.Core.Services;
using Umbraco.Web.Scheduling;

namespace Umbraco.Web.UI
{
    // We start by setting up a composer and component so our task runner gets registered on application startup
    public class CleanUpYourRoomComposer : ComponentComposer<CleanUpYourRoomComponent>
    {
    }

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

            //As soon as we add our task to the runner it will start to run (after its delay period)
            _cleanUpYourRoomRunner.TryAdd(task);
        }

        public void Terminate()
        {
        }
    }

    // Now we get to define the recurring task
    public class CleanRoom : RecurringTaskBase
    {
        private IRuntimeState _runtime;
        private IProfilingLogger _logger;
        private IContentService _contentService;

        public CleanRoom(IBackgroundTaskRunner<RecurringTaskBase> runner, int delayBeforeWeStart, int howOftenWeRepeat, IRuntimeState runtime, IProfilingLogger logger, IContentService contentService)
            : base(runner, delayBeforeWeStart, howOftenWeRepeat)
        {
            _runtime = runtime;
            _logger = logger;
            _contentService = contentService;
        }

        public override bool PerformRun()
        {
            var numberOfThingsInBin = _contentService.CountChildren(Constants.System.RecycleBinContent);

            _logger.Info<CleanRoom>("Go clean your room - {ServerRole}", _runtime.ServerRole);
            _logger.Info<CleanRoom>("You have {NumberOfThingsInTheBin}", numberOfThingsInBin);

            if (_contentService.RecycleBinSmells())
            {
                // Take out the trash
                using (_logger.TraceDuration<CleanRoom>("Mum, I am emptying out the bin", "Its all clean now!"))
                {
                    _contentService.EmptyRecycleBin(userId: -1);
                }
            }

            // If we want to keep repeating - we need to return true
            // But if we run into a problem/error & want to stop repeating - return false
            return true;
        }

        public override bool IsAsync => false;
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
