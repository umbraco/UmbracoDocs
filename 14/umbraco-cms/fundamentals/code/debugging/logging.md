# Logging

In Umbraco we use the underlying logging framework of [Serilog](https://serilog.net/).

Out of the box, we write a JSON log file that contains a more detailed logfile. This allows tools to perform searches and correlations on log patterns more efficiently.

The default location of this file is written to `umbraco/Logs` and contains the Machine name, along with the date too:

* `umbraco/Logs/UmbracoTraceLog.DELLBOOK.20210809.json`

## Video Overview

{% embed url="<https://youtu.be/PDqIRVygAQ4>" %}
Watch this video to get an overview of how to view and manage logs and log files for your Umbraco CMS website.
{% endembed %}

## Structured logging

Serilog is a logging framework that allows us to do structured logging or write log messages using the message template format. This allows us to have a more detailed log message, rather than the traditional text message in a long txt file.

```cs
2021-08-10 09:33:23,677 [P25776/D1/T22] INFO   Umbraco.Cms.Core.Services.Implement.ContentService - Document Home (id=1062) has been published.
```

Here is an example of the same log message represented as JSON. More information is available and allows you to search and filter logs based on these properties with an appropriate logging system.

```json
{
  "@t":"2021-08-10T08:33:23.6778640Z",
  "@mt":"Document {ContentName} (id={ContentId}) has been published.",
  "ContentName":"Home",
  "ContentId":1062,
  "SourceContext":"Umbraco.Cms.Core.Services.Implement.ContentService",
  "ActionId":"7726d745-d502-4b2d-b55e-97731308041b",
  "ActionName":"Umbraco.Cms.Web.BackOffice.Controllers.ContentController.PostSave (Umbraco.Web.BackOffice)",
  "RequestId":"8000000c-0012-fb00-b63f-84710c7967bb",
  "RequestPath":"/umbraco/backoffice/umbracoapi/content/PostSave",
  "ProcessId":25776,
  "ProcessName":"iisexpress",
  "ThreadId":22,
  "AppDomainId":1,
  "AppDomainAppId":"2f4961977e5c252fa708f7d83915c269b53a620c",
  "MachineName":"DELLBOOK",
  "Log4NetLevel":"INFO ",
  "HttpRequestId":"318b6dd4-b127-4da3-8339-37701f4d1416",
  "HttpRequestNumber":4,
  "HttpSessionId":"0cea7395-ba29-e6c6-93ee-7c08a2fd7219"
}
```

To learn more about structured logging and message templates you can read more about it over on the [https://messagetemplates.org](https://messagetemplates.org) website. Alternatively watch this video from the Serilog creator - [https://www.youtube.com/watch?v=OhmNp8UPEEg](https://www.youtube.com/watch?v=OhmNp8UPEEg)

## Writing to the log

Umbraco writes log messages, but you are also able to use the Umbraco logger to write the log file as needed. This allows you to gain further insights and details about your implementation.

Here is an example of using the logger to write an Information message to the log. It will contain one property, **Name**, which will output the name variable that is passed into the method.

```csharp
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;

namespace Umbraco.Cms.Web.UI.NetCore;

[ApiController]
[Route("/umbraco/api/myapi")]
public class MyApiController : Controller
{
    private readonly ILogger<MyApiController> _logger;

    public MyApiController(ILogger<MyApiController> logger)
    {
        _logger = logger;
    }

    /// /umbraco/api/MyApi/SayHello?name=John
    [HttpGet("sayhello")]
    public string SayHello(string name)
    {
        _logger.LogInformation("We are saying hello to {Name}", name);
        return $"Hello {name}";
    }
}
```

{% hint style="info" %}
If you are Logging and using the MiniProfiler, you can inject `IProfilingLogger` that has a reference to both ILogger and IProfiler.
{% endhint %}

The incorrect way to log the message would be use string interpolation or string concatenation such as

```csharp
//GOOD - Do use :)
_logger.LogInformation("We are saying hello to {Name}", name);

//BAD - Do not use :(
_logger.LogInformation($"We are saying hello to {name}");

//BAD - Do not use :(
_logger.LogInformation("We are saying hello to " + name);
```

The bad examples above will write to the log file, but we will not get a separate property logged with the message. This means we can't find them by searching for log messages that use the message template `We are saying hello to {Name}`

## Log Levels

Serilog uses levels as the primary means for assigning importance to log events. The levels in increasing order of importance are:

1. **Verbose** - tracing information and debugging minutiae; generally only switched on in unusual situations
2. **Debug** - internal control flow and diagnostic state dumps to facilitate pinpointing of recognised problems
3. **Information** - events of interest or that have relevance to outside observers; the default enabled minimum logging level
4. **Warning** - indicators of possible issues or service/functionality degradation
5. **Error** - indicating a failure within the application or connected system
6. **Fatal** - critical errors causing complete failure of the application

## Configuration

Serilog can be configured and extended by using the .NET Core configuration such as the AppSetting.json files or environment variables. For more information, see the [Serilog config](../../../reference/configuration/serilog.md) article.

## The logviewer dashboard

Learn more about the [logviewer dashboard](../../backoffice/logviewer.md) in the backoffice and how it can be extended.

## The logviewer desktop app

This is a tool for viewing & querying JSON log files from disk in the same way as the built in log viewer dashboard.

[![English badge](https://developer.microsoft.com/store/badges/images/English\_get-it-from-MS.png)](https://www.microsoft.com/store/apps/9N8RV8LKTXRJ?cid=storebadge\&ocid=badge)

## Serilog project/references shipped

Umbraco ships with the following Serilog projects, where you can find further information & details with the GitHub readme files as needed.

* [Serilog](https://github.com/serilog/serilog)
* [Serilog.AspNetCore](https://github.com/serilog/serilog-aspnetcore)
* [Serilog.Enrichers.Process](https://github.com/serilog/serilog-enrichers-process)
* [Serilog.Enrichers.Thread](https://github.com/serilog/serilog-enrichers-thread)
* [Serilog.Expressions](https://github.com/serilog/serilog-expressions)
* [Serilog.Formatting.Compact](https://github.com/serilog/serilog-formatting-compact)
* [Serilog.Formatting.Compact.Reader](https://github.com/serilog/serilog-formatting-compact-reader)
* [Serilog.Settings.Configuration](https://github.com/serilog/serilog-settings-configuration)
* [Serilog.Sinks.Console](https://github.com/serilog/serilog-sinks-console)
* [Serilog.Sinks.File](https://github.com/serilog/serilog-sinks-file)

## Further Resources

If you are interested in learning more then the following resources will beneficial:

* [Serilog](https://serilog.net/)
* [Serilog Community Gitter Chatroom](https://gitter.im/serilog/serilog)
* [Nicholas Blumhardt Blog, creator of Serilog](https://nblumhardt.com/)
* [Serilog Pluralsight Course](https://www.pluralsight.com/courses/modern-structured-logging-serilog-seq)
* [Seq](https://getseq.net/) This is **free** for a single machine such as your own local development computer
