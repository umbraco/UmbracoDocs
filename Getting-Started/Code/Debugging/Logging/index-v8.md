---
keywords: logging serilog messagetemplates logs v8 version8
versionFrom: 8.0.0
---

# Logging

In Umbraco v8.0+ we have changed the underlying logging framework from [Log4Net](https://logging.apache.org/log4net/) to [Serilog](https://serilog.net/).

Out of the box for v8.0+ we will write two log files to disk, a .txt file in the same identical format as previously logged by Log4Net, so that you can continue to use any tools or regular expressions you may have used and secondly we will write a JSON file that contains a more rich logfile, that allows tools to perform searches & correlation on log patterns alot easier.

The default location of these files are written to `App_Data/Logs` and contains the Machine name, along with the date too:
* `/App_Data/Logs/UmbracoTraceLog.DELLBOOK.20181108.txt`
* `/App_Data/Logs/UmbracoTraceLog.DELLBOOK.20181108.json`

## Structured logging

Serilog is a logging framework that allows us to do structured logging or write log messages using the message template format, allowing us to have a more detailed log message, rather than the traditional text message in a long txt file.

```
2018-11-12 08:34:50,419 [P27004/D2/T1] INFO   Umbraco.Core.Runtime.CoreRuntime - Booted. (4586ms) [Timing 9e76e5f]
```

Here is an example of the same log message represented as JSON, you can see here we have much more information that would allow us to search & filter logs based on these properties with an appropiate logging system.

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

To learn more about structured logging and message templates you can read more about it over on the https://messagetemplates.org website or alternatively watch this video from the Serilog creator - https://www.youtube.com/watch?v=OhmNp8UPEEg

## Writing to the log

Umbraco writes log messages, but you are also able to use the Umbraco logger to write the log file as needed, so you can get further insights and details about your implementation.

Here is a simple example of using the logger to write an Information message to the log which will contain one property of **Name** which will output the name variable that is passed into the method

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

The incorrect way to log the message would be use string interpolation or string concatanation such as

```csharp
//GOOD - Do use :)
Logger.Info<MyApiController>("We are saying hello to {Name}", name);

//BAD - Do not use :(
Logger.Info<MyApiController>($"We are saying hello to {name}");

//BAD - Do not use :(
Logger.Info<MyApiController>("We are saying hello to " + name);
```

The above examples  which use the bad approach will write to the log file, however we will not get a seperate property logged with the message and we have no easy way to search for all log messages of this type.

Where as the previous example we would be able to find all log messages that use the message template `We are saying hello to {Name}`

If you are writing custom code and are inheriting from one of these special Umbraco base classes:

* RenderMvcController
* SurfaceController
* UmbracoApiController
* UmbracoAuthorizedApiController

Then you can access the logging functionality via a special 'Logger' property included in those base classes and use the friendlier syntax of `Logger.Info<T>` to pass the type, if you add a reference to `Umbraco.Core.Logging` as a Using statement.

Outside of these places, eg a ContentFinder or your own custom code, you can get a reference to the logger from the `Umbraco.Core.Composing` namespace, using the `Current.Logger` instance.

```csharp
using Umbraco.Core.Composing;
using Umbraco.Core.Logging;
using Umbraco.Web.Routing;

namespace MyNamespace
{
    public class MyContentFinder : IContentFinder
    {
        public bool TryFindContent(PublishedRequest frequest)
        {
            Current.Logger.Info<MyContentFinder>("Trying to find content for url {RequestUrl}", frequest.Uri);

            //Do Content Finder Logic...
        }
    }
}
```

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

Serilog can be configured and extended by using the two XML configuration files on disk found at `/config/serilog.config` which is used to modify the main Umbraco logging pipeline and a second configuration file that is at `/config/serilog.user.config` which is a sublogger and allows you to make modifications without affecting the main Umbraco logger.

### Changing the log level

This can be done by adding the following into either `serilog.config` or the sub logger configuration file `serilog.user.config`

```xml
<add key="serilog:minimum-level" value="Verbose" />
```

:::warning
If you change the main Umbraco logger in serilog.config to log only **Warning** you would not be able to have the serilog.user.config sub logger to be set to **Debug** as only Warning messages and higher will flow down into the child sub logger
:::


### Changing the log level for specific namespaces

This can be done by adding the following into either `serilog.config` or the sub logger configuration file `serilog.user.config`

```xml
<add key="serilog:minimum-level:override:Microsoft" value="Warning" />
<add key="serilog:minimum-level:override:Microsoft.AspNet.Mvc" value="Error" />
<add key="serilog:minimum-level:override:MyNamespace" value="Information" />
```

:::warning
If you change the **serilog:minimum-level** to be **Error** then the following example above would only log Error messages from *Microsoft.AspNet.Mvc* and not any warning, info or debug messages from the *Microsoft* namespace
:::

### Writing your own log messages to a custom file

Add the following to the `/config/serilog.user.config` file, which will create a new JSON log file

```xml
<!-- Write to a user log file -->
<add key="serilog:using:File" value="Serilog.Sinks.File" />
<add key="serilog:write-to:File.path" value="%BASEDIR%\my-logs\my-custom-logfile.txt" />
<add key="serilog:write-to:File.shared" value="true" />
<add key="serilog:write-to:File.restrictedToMinimumLevel" value="Debug" />
<add key="serilog:write-to:File.retainedFileCountLimit" value="32" /> <!-- Number of log files to keep (or remove value to keep all files) -->
<add key="serilog:write-to:File.rollingInterval" value="Day" /> <!-- Create a new log file every Minute/Hour/Day/Month/Year/infinite -->
```

### Filtering user log file to include only log messages from your namespace

With the above example we are able to write to a seperate JSON log file, but adding these additional lines to `serilog.user.config` will allow you to filter and include log messages. For further details on specific expressions you can write, refer to the readme of the [Serilog Filters Expression project](https://github.com/serilog/serilog-filters-expressions)

```xml
<!-- Filters all sink's in the serilog.user.config to use this expression -->
<!-- Common use case is to include SourceType starting with your own namespace -->
<add key="serilog:using:FilterExpressions" value="Serilog.Filters.Expressions" />
<add key="serilog:filter:ByIncluding.expression" value="StartsWith(SourceContext, 'MyNamespace')" />
```

### Writing log events to different storage types

Serilog has a similar concept to Log4Net with its appenders, which are referred to as Serilog Sinks.
A Serilog Sink, allows you to persist the structured log message to a data store of your choice. In v8.0+ we use the *Serilog.Sinks.File* to allow us to write a .txt or .json file to disk. But the Serilog project and the wider Serilog community allows you to store these logs in various locations.

[An extensive list of examples can be found here](https://github.com/serilog/serilog/wiki/Provided-Sinks)

For example you could install the Nuget package `PM> Install-Package Serilog.Sinks.Seq` and update the `serilog.user.config` file with the following XML snippet and if you already have the file example above it will write to that location as well as Seq.

```xml
<add key="serilog:using:Seq" value="Serilog.Sinks.Seq" />
<add key="serilog:write-to:Seq.serverUrl" value="http://localhost:5341" />
<add key="serilog:write-to:Seq.apiKey" value="[optional API key here]" />
```

### Adding a custom log property to all log items

You may wish to add a log property to all log messages. A good example could be a log property for the `environment` to determine if the log message came from `development` or `production`.

This is useful when you could be writing logs from all environments or multiple customer projects into a single logging source, such as ElasticSearch, this would then easily allow you to search and filter for a specific project and its environment to see the log messages.

In the `/config/serilog.user.config` file you can add the following lines, which the values could be changed or transformed as needed.

```xml
<add key="serilog:enrich:with-property:customer" value="Super Customer" />
<add key="serilog:enrich:with-property:environment" value="Production" />
```

## Advanced

### Full C# control over Serilog configuration

If you like using Serilog but prefer to use C# to configure the logging pipeline then you can do so with the following example

```csharp
using Umbraco.Web;
using Umbraco.Core.Logging.Serilog;
using Serilog;
using Serilog.Events;
using ILogger = Umbraco.Core.Logging.ILogger;

namespace MyNamespace
{
    public class FineTuneLogging : UmbracoApplication
    {
        protected override ILogger GetLogger()
        {
            var loggerConfig = new LoggerConfiguration();
            loggerConfig
                .Enrich.WithProperty("MyProperty", "whatIWant")
                .MinimalConfiguration()
                .OutputDefaultTextFile(LogEventLevel.Error)
                .OutputDefaultJsonFile(LogEventLevel.Information)
                .ReadFromConfigFile()
                .ReadFromUserConfigFile();

            return new SerilogLogger(loggerConfig);
        }
    }
}
```

You will then need to update the `global.asax` file on disk to use our FineTuneLogging class like so

```
<%@ Application Inherits="MyNamespace.FineTuneLogging" Language="C#" %>
```

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


