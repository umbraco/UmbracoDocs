---
keywords: logging serilog messagetemplates logs v8 version8
versionFrom: 8.6.2
---

# Logging

In Umbraco v8.0+ we have changed the underlying logging framework from [Log4Net](https://logging.apache.org/log4net/) to [Serilog](https://serilog.net/).

Out of the box for v8.0+ we will write a JSON log file that contains a more rich logfile, that allows tools to perform searches & correlation on log patterns a lot easier.

The default location of this file is written to `App_Data/Logs` and contains the Machine name, along with the date too:

* `/App_Data/Logs/UmbracoTraceLog.DELLBOOK.20181108.json`

## Structured logging

Serilog is a logging framework that allows us to do structured logging or write log messages using the message template format. This allows us to have a more detailed log message, rather than the traditional text message in a long txt file.

```xml
2018-11-12 08:34:50,419 [P27004/D2/T1] INFO   Umbraco.Core.Runtime.CoreRuntime - Booted. (4586ms) [Timing 9e76e5f]
```

Here is an example of the same log message represented as JSON, you can see here we have much more information that would allow us to search & filter logs based on these properties with an appropriate logging system.

```json
{
  "@t": "2018-11-12T08:34:50.4190399Z",
  "@mt": "{EndMessage} ({Duration}ms) [Timing {TimingId}]",
  "EndMessage": "Booted.",
  "Duration": 4586,
  "TimingId": "9e76e5f",
  "SourceContext": "Umbraco.Core.Runtime.CoreRuntime",
  "ProcessId": 27004,
  "ProcessName": "iisexpress",
  "ThreadId": 1,
  "AppDomainId": 2,
  "AppDomainAppId": "LMW3SVC2ROOT",
  "MachineName": "DELLBOOK",
  "Log4NetLevel": "INFO ",
  "HttpRequestNumber": 1,
  "HttpRequestId": "557f45ba-0888-4216-8723-e226d795a2f7"
}
```

To learn more about structured logging and message templates you can read more about it over on the [https://messagetemplates.org](https://messagetemplates.org) website or alternatively watch this video from the Serilog creator - [https://www.youtube.com/watch?v=OhmNp8UPEEg](https://www.youtube.com/watch?v=OhmNp8UPEEg)

## Writing to the log

Umbraco writes log messages, but you are also able to use the Umbraco logger to write the log file as needed, so you can get further insights and details about your implementation.

Here is an example of using the logger to write an Information message to the log which will contain one property of **Name** which will output the name variable that is passed into the method

```csharp
using Umbraco.Web.WebApi;
using Umbraco.Core.Logging;

namespace MyNamespace
{
    public class MyApiController : UmbracoApiController
    {
        public string GetSayHello(string name)
        {
            Logger.Info<MyApiController>("We are saying hello to {Name}", name);
            return $"Hello {name}";
        }
    }
}
```

The incorrect way to log the message would be use string interpolation or string concatenation such as

```csharp
//GOOD - Do use :)
Logger.Info<MyApiController>("We are saying hello to {Name}", name);

//BAD - Do not use :(
Logger.Info<MyApiController>($"We are saying hello to {name}");

//BAD - Do not use :(
Logger.Info<MyApiController>("We are saying hello to " + name);
```

The bad examples above will write to the log file, but we will not get a separate property logged with the message. This means we can't find them by searching for log messages that use the message template `We are saying hello to {Name}`

If you are writing classes that inherit from one of these special Umbraco base classes:

* RenderMvcController
* SurfaceController
* UmbracoApiController
* UmbracoAuthorizedApiController

Then you can access the logging functionality via a special 'Logger' property included in those base classes and use the friendlier syntax of `Logger.Info<T>` to pass the type, if you add a reference to `Umbraco.Core.Logging` as a Using statement.

Outside of these places, eg a ContentFinder or your own custom code, you can get a reference to the logger via Dependency Injection. While using Dependency Injection is the recommended way, it is possible to use Current.Logger instead, if DI is not an option.

```csharp
using Umbraco.Core.Logging;
using Umbraco.Web.Routing;

namespace MyNamespace
{
    public class MyContentFinder : IContentFinder
    {
        private readonly ILogger _logger;

        public MyContentFinder(ILogger logger)
        {
            _logger = logger;
        }
        public bool TryFindContent(PublishedRequest frequest)
        {
            _logger.Info<MyContentFinder>("Trying to find content for url {RequestUrl}", frequest.Uri);

            //Do Content Finder Logic...
        }
    }
}
```

You will need to register your ContentFinder [using a Composer](../../../../Implementation/Composing/index.md)

## Log Levels

Serilog uses levels as the primary means for assigning importance to log events. The levels in increasing order of importance are:

1. **Verbose** - tracing information and debugging minutiae; generally only switched on in unusual situations
1. **Debug** - internal control flow and diagnostic state dumps to facilitate pinpointing of recognised problems
1. **Information** - events of interest or that have relevance to outside observers; the default enabled minimum logging level
1. **Warning** - indicators of possible issues or service/functionality degradation
1. **Error** - indicating a failure within the application or connected system
1. **Fatal** - critical errors causing complete failure of the application

The default log levels we ship with in Umbraco v8.0+ are:

* .txt file **Debug**
* .json file **Verbose**

## Configuration

Serilog can be configured and extended by using the two XML configuration files on disk.

* `/config/serilog.config` is used to modify the main Umbraco logging pipeline
* `/config/serilog.user.config` which is a sublogger and allows you to make modifications without affecting the main Umbraco logger

Info on the Serilog config [here](../../../../Reference/Config/Serilog/index.md).

## Advanced

### Full C# control over Serilog configuration

If you like using Serilog but prefer to use C# to configure the logging pipeline then you can do so with the following example. This sets the minimum logging level from a web.config AppSetting, allowing you to set different minimum logging levels in different environments using web config transforms.

```csharp
using System;
using System.Configuration;
using Umbraco.Web;
using Umbraco.Core;
using Umbraco.Web.Runtime;
using Umbraco.Core.Logging.Serilog;

using Serilog;
using Serilog.Core;
using Serilog.Events;

namespace MyNamespace
{
    public class FineTuneLoggingApplication : UmbracoApplication
    {
        protected override IRuntime GetRuntime()
        {
            var logLevelSetting = ConfigurationManager.AppSettings["YourMinimumLoggingLevel"]; //Warning, Debug, Information, etc

            const bool ignoreCase = true; //this is to clarify the function of the boolean second parameter in the TryParse
            if (!Enum.TryParse(logLevelSetting, ignoreCase, out LogEventLevel minimumLevel))
            {
                minimumLevel = LogEventLevel.Information;//set to this level if the config setting is missing or doesn't match a valid enumeration
            }

            var levelSwitch = new LoggingLevelSwitch { MinimumLevel = minimumLevel };

            var loggerConfig = new LoggerConfiguration()
                .MinimalConfiguration()
                .ReadFromConfigFile()
                .ReadFromUserConfigFile()
                .MinimumLevel.ControlledBy(levelSwitch);

            var logger = new SerilogLogger(loggerConfig);

            var runtime = new WebRuntime(this, logger, GetMainDom(logger));

            return runtime;
        }
    }
}
```

You will then need to update the `global.asax` file on disk to use our FineTuneLogging class like so

```xml
<%@ Application Inherits="MyNamespace.FineTuneLoggingApplication" Language="C#" %>
```

## The logviewer dashboard

Learn more about the [logviewer dashboard](../../../Backoffice/LogViewer/) in the backoffice and how it can be extended.

## The logviewer desktop app

This is a tool for viewing & querying JSON log files from disk in the same way as the built in log viewer dashboard.

<a href='//www.microsoft.com/store/apps/9N8RV8LKTXRJ?cid=storebadge&ocid=badge'><img src='https://developer.microsoft.com/store/badges/images/English_get-it-from-MS.png' alt='English badge' style='height: 38px;' height="38" /></a> <a href="https://itunes.apple.com/gb/app/compact-log-viewer/id1456027499"><img src="https://developer.apple.com/app-store/marketing/guidelines/images/badge-download-on-the-mac-app-store.svg" /></a>

## Serilog project/references shipped

Umbraco v8.0+ ships with the following Serilog projects, where you can find further information & details with the GitHub readme files as needed.

* [Serilog](https://github.com/serilog/serilog)
* [Serilog.Enrichers.Process](https://github.com/serilog/serilog-enrichers-process)
* [Serilog.Enrichers.Thread](https://github.com/serilog/serilog-enrichers-thread)
* [Serilog.Filters.Expressions](https://github.com/serilog/serilog-filters-expressions)
* [Serilog.Formatting.Compact](https://github.com/serilog/serilog-formatting-compact)
* [Serilog.Settings.AppSettings](https://github.com/serilog/Serilog-Settings-AppSettings)
* [Serilog.Sinks.File](https://github.com/serilog/serilog-sinks-file)

## Further Resources

If you are interested in learning more then the following resources will beneficial:

* [Serilog](https://serilog.net/)
* [Serilog Community Gitter Chatroom](https://gitter.im/serilog/serilog)
* [Nicholas Blumhardt Blog, creator of Serilog](https://nblumhardt.com/)
* [Serilog Pluralsight Course](https://www.pluralsight.com/courses/modern-structured-logging-serilog-seq)
* [Seq](https://getseq.net/) This is FREE for a single machine such as your own local development computer
