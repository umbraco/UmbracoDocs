---
versionFrom: 8.0.0
---

# Scheduling with BackgroundTaskRunner
In version Umbraco 8+ it is possible to run re-occuring code using the `BackgroundTaskRunner`.
Below is a complete example showing how to register the Task with the runner with a component that will regularly empty out the recycle bin every five minutes.

```csharp
using Umbraco.Core;
using Umbraco.Core.Composing;
using Umbraco.Core.Logging;
using Umbraco.Core.Services;
using Umbraco.Web.Scheduling;

namespace Umbraco.Web.UI
{
    public class CleanUpYourRoomComposer : ComponentComposer<CleanUpYourRoomComponent>
    {
    }

    public class CleanUpYourRoomComponent : IComponent
    {
        private IProfilingLogger _logger;
        private IRuntimeState _runtime;
        private IContentService _contentService;

        public CleanUpYourRoomComponent(IProfilingLogger logger, IRuntimeState runtime, IContentService contentService)
        {
            _logger = logger;
            _runtime = runtime;
            _contentService = contentService;
        }

        public void Initialize()
        {
            int delayBeforeWeStart = 60000; // 60000ms = 1min
            int howOftenWeRepeat = 300000; //300000ms = 5mins

            var cleanUpYourRoomRunner = new BackgroundTaskRunner<IBackgroundTask>("CleanYourRoom", _logger);
            var task = new CleanRoom(cleanUpYourRoomRunner, delayBeforeWeStart, howOftenWeRepeat, _runtime, _logger, _contentService);

            //As soon as we add our task to the runner it will start to run (after its delay period)
            cleanUpYourRoomRunner.TryAdd(task);
        }

        public void Terminate()
        {
        }
    }

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