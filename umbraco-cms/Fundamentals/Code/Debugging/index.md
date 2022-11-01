---
meta.Title: "Debugging"
meta.Description: "Debugging in Umbraco"
versionFrom: 9.0.0
---

# Debugging

During the development of your Umbraco site you can debug and profile the code you have written to analyse and discover bugs/bottlenecks in your code or to help uncover what on earth is going wrong.

To perform proper debugging on your site you need to set your application to have debug enabled.
This can be done by setting `Umbraco:CMS:Hosting:Debug="true"` e.g. in `appsettings.json`  file:

:::warning
Debug should always be set to false in production.
:::

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

## Tracing

Logging and tracing are really two names for the same technique. In Umbraco 8 and before, it was possible to do explicit named tracing. This is not an option in ASP.NET Core and Umbraco 9.
Instead, you need to configure what log messages you wanna log.

### Enabling Trace Logging

:::warning
Do not enable trace logging in your production environment! It reveals an awful lot of (sensitive) information about your production environment.
:::


We recommend at least logging the following namespace at minimum (Verbose) level to enable valuable trace logging:

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

Umbraco includes the Mini Profiler project in its core (see [https://miniprofiler.com](https://miniprofiler.com) for more details).
The MiniProfiler profiles your code method calls, giving you a greater insight into code duration and query time for (for example) underlying SQL queries.
 It's great for tracking down performance issues in your site's implementation.

### Displaying the MiniProfiler

To display the profiler ensure that the configuration `Umbraco:CMS:Hosting:Debug` is set to `true` e.g. in you appSettings.json and then add `?umbDebug=true` to the query string of any request.

Also, ensure your template calls `@Html.RenderProfiler()` as one of the last things.


![?umbDebug=true](images/v8-miniprofiler-view.png)

If you click 'Show Trivial' you can seen the kind of detail the MiniProfiler makes available to you about the execution path of your page:

![Show Trivial](images/v8-miniprofiler-trivial.png)

and any underlying SQL Statements that are being executed for a part of the execution:

![Underlying SQL queries](images/v8-miniprofiler-sql-trigger.png)

![Underlying SQL query details](images/v8-miniprofiler-sql-details.png)

### Writing to the MiniProfiler

If you feel like a part of your application is slow you can use the MiniProfiler in your own code to test the speed of it.

All you have to do is inject the IProfiler interface and add a step around your logic:

```csharp
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.ViewEngines;
using Microsoft.Extensions.Logging;
using Umbraco.Cms.Core.Logging;
using Umbraco.Cms.Core.Web;
using Umbraco.Cms.Web.Common.Controllers;

namespace MyCustomUmbracoProject
{
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
}
```

and now in the profiler you can see:

![Show Trivial](images/v8-miniprofiler-write.png)

## Umbraco Productivity Tool - Chrome Extension

If you are using the Google Chrome browser you can install this [Umbraco Productivity Tool Chrome Extension](https://chrome.google.com/webstore/detail/umbraco-productivity/kepkgaeokeknlghbiiipbhgclikjgkdp?hl=en).

This will allow you to quickly switch between debugging with the MiniProfiler, Trace viewer and normal mode.

![Umbraco Productivity Tool](images/chrome-tool.png)

## [Logging](Logging/)

Learn how Umbraco writes log files and how you can write to them.
