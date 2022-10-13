---
meta.Title: "Debugging"
meta.Description: "Debugging in Umbraco"
versionFrom: 8.0.0
---

# Debugging

During the development of your Umbraco site you can debug and profile the code you have written to analyse and discover bugs/bottlenecks in your code or to help uncover what on earth is going wrong.

To perform proper debugging on your site you need to set your application to have debug enabled. This can be done by setting `debug="true"` (found in `System.Web`) in your `web.config` file:

:::warning
Debug should always be set to false in production.
:::

```xml
<compilation defaultLanguage="c#" debug="true" batch="true" targetFramework="4.7.2" numRecompilesBeforeAppRestart="50" />
```

## Tracing

Tracing enables you to view diagnostic information about a single request for a page on your site at runtime. The trace will show the flow of page level events and display any errors in code along with diagnostic information, such as server variables, cookies, form and querystring collections and application state.

### Enabling Trace

:::warning
Do not enable trace in your production environment! It reveals an awful lot of (sensitive) information about your production environment.
:::

Trace is disabled by default. To enable it look for `<trace` in `System.Web` and set `enabled="true"` in your `web.config` file:

```xml
<trace enabled="true" requestLimit="10" pageOutput="false" traceMode="SortByTime" localOnly="true"/>
```

### Viewing Trace

With trace enabled visit the url `/trace.axd`.

Here you'll be able to see the requests to your application:

![Application Trace](images/v8-trace.png)

You can clear the trace by clicking on `clear current trace`.

Click on 'View Details' for a particular request in the list to see the specific trace information for the page.

![Trace Request Details](images/v8-trace-details.png)

## MiniProfiler

Umbraco includes the Mini Profiler project in its core (see [https://miniprofiler.com](https://miniprofiler.com) for more details).
The MiniProfiler profiles your code method calls, giving you a greater insight into code duration and query time for (for example) underlying SQL queries. It's great for tracking down performance issues in your site's implementation.

### Displaying the MiniProfiler

To display the profiler ensure that the debug attribute of the compilation element is set to true in your web.config and then add `?umbDebug=true` to the querystring of any request.

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
using System.Web.Mvc;
using Umbraco.Core.Logging;
using Umbraco.Web.Models;
using Umbraco.Web.Mvc;

namespace OurUmbraco.Core.Controllers
{
    public class ProductsController : RenderMvcController
    {
        private readonly IProfiler _profiler;

        // Inject IProfiler
        public ProductsController(IProfiler profiler)
        {
            _profiler = profiler;
        }

        public ActionResult Products(IPublishedContent model)
        {
            // Perform a step
            using (_profiler.Step("Sleep"))
            {
                System.Threading.Thread.Sleep(1000);
            }

            return CurrentTemplate(model);
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
