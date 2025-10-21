# Debugging

During the development of your Umbraco site you can debug and profile the code you have written to analyse and discover bottlenecks in your code.

To perform proper debugging on your site you need to set your application to have debug enabled. This can be done by setting `Umbraco:CMS:Hosting:Debug="true"` for example in the `appsettings.json` file:

```json
{
  "Umbraco": {
    "CMS": {
      "Hosting": {
        "Debug": true
      }
    }
  }
}
```

{% hint style="warning" %}
Debug should always be set to false in production.
{% endhint %}

## Tracing

Tracing and trace logging are two names for the same technique. You need to configure which log messages you want to log.

### Enabling Trace Logging

{% hint style="warning" %}
Do not enable trace logging in your production environment! It reveals an awful lot of (sensitive) information about your production environment.
{% endhint %}

We recommend at least logging the following namespace at minimum (Verbose) level to enable valuable trace logging. Thereby you will have information about all endpoints that have been executed.

```json
{
  "Serilog": {
    "MinimumLevel": {
      "Override": {
        "Microsoft.AspNetCore.Mvc": "Verbose"
      }
    }
  }
}
```

The logged messages can as always be monitored in the log viewer in backoffice

## MiniProfiler

Umbraco includes the Mini Profiler project in its core (see [https://miniprofiler.com](https://miniprofiler.com) for more details). The MiniProfiler profiles your code method calls, giving you a greater insight into code duration and query time for (for example) underlying SQL queries. It's great for tracking down performance issues in your site's implementation.

### Displaying the MiniProfiler

To display the profiler ensure that the configuration `Umbraco:CMS:Hosting:Debug` is set to `true` in the appSettings.json file. Thereafter you can add `?umbDebug=true` to the query string of any request.

Also, ensure your template calls `@Html.RenderProfiler()` as one of the last things.

<figure><img src="images/v8-miniprofiler-view.png" alt=""><figcaption></figcaption></figure>

If you click 'Show Trivial' you can seen the kind of detail the MiniProfiler makes available to you about the execution path of your page:

<figure><img src="images/v8-miniprofiler-trivial.png" alt=""><figcaption></figcaption></figure>

and any underlying SQL Statements that are being executed for a part of the execution:

<figure><img src="images/v8-miniprofiler-sql-trigger.png" alt=""><figcaption></figcaption></figure>

![Underlying SQL query details](images/v8-miniprofiler-sql-details.png)

### Writing to the MiniProfiler

If you feel like a part of your application is slow you can use the MiniProfiler in your code to test the speed of it.

All you have to do is inject the IProfiler interface and add a step around your logic:

```csharp
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.ViewEngines;
using Microsoft.Extensions.Logging;
using Umbraco.Cms.Core.Logging;
using Umbraco.Cms.Core.Web;
using Umbraco.Cms.Web.Common.Controllers;

namespace MyCustomUmbracoProject;

public class RootController : RenderController
{
    private readonly IProfiler _profiler;

    public RootController(
        IProfiler profiler,
        ILogger<RenderController> logger,
        ICompositeViewEngine compositeViewEngine,
        IUmbracoContextAccessor umbracoContextAccessor)
        : base(logger, compositeViewEngine, umbracoContextAccessor)
    {
        _profiler = profiler;
    }

    public override IActionResult Index()
    {
        // Perform a step
        using (_profiler.Step("Sleep"))
        {
            System.Threading.Thread.Sleep(1000);
        }

        return base.Index();
    }
}
```

and now in the profiler you can see:

![Show Trivial](images/v8-miniprofiler-write.png)

## Umbraco Productivity Tool - Chrome Extension

If you are using the Google Chrome browser you can install this [Umbraco Productivity Tool Chrome Extension](https://chrome.google.com/webstore/detail/umbraco-productivity/kepkgaeokeknlghbiiipbhgclikjgkdp?hl=en).

This will allow you to quickly switch between debugging with the MiniProfiler, Trace viewer and normal mode.

![Umbraco Productivity Tool](images/chrome-tool.png)

## [Logging](logging.md)

Learn how Umbraco writes log files and how you can write to them.
