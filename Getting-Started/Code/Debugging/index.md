# Debugging
During the development of your Umbraco site you can debug, and profile the code you have written to analyse and discover bugs, bottlenecks in your code, or just help uncover what on earth is going wrong.


### Tracing
Tracing enables you to view diagnostic information about a single request for a page on your site at runtime. The trace will show the flow of page level events and display any errors in code along with diagnostic information, eg Server variables, Cookie, Form and Querystring Collections, Application State etc

#### Enabling Trace
NB Do not enable trace in your production environment, it reveals an awful lot about your production environment.

By default trace is disabled, to enable: update the web.config; look for the trace element in the System.Web section and set the enabled attribute to true

    <trace enabled="true" requestLimit="100" pageOutput="false"
                  traceMode="SortByTime" localOnly="true"/>

#### Viewing Trace

With trace enabled visit the url **/trace.axd**

The current application trace of requests to your application will be displayed:

![Application Trace](images/application-trace.png)

Click 'Clear current trace' and then in a different tab visit the url of the page you would like to trace.

The trace requests for this page will appear if you refresh your trace.axd tab.

Click on 'View Details' for a particular request in the list to see the specific trace information for the page.

![Trace Request Details](images/trace-request-details.png)

### MiniProfiler

Umbraco includes the Mini Profiler project in its core (see [https://miniprofiler.com](https://miniprofiler.com) for more details).
The MiniProfiler profiles your code method calls, giving you a greater insight into code duration, and query time for underlying SQL queries. It's great for tracking down performance issues in your site's implementation.

#### Displaying the MiniProfiler

To display the profiler ensure that the debug attribute of the compilation element is set to true in your web.config and then add ?umbDebug=true to the querystring of any request.
NB: debug mode should be disabled for your site in a production environment.

![?umbDebug=true](images/umb-debug-equals-true.png)

If you click 'Show Trivial' you can seen the kind of detail the MiniProfiler makes available to you about the execution path of your page:

![Show Trivial](images/show-trivial.png)

and any underlying SQL Statements that are being executed for a part of the execution

![Underlying SQL queries](images/underlying-sql-queries.png)

#### Writing to the MiniProfiler

If within your implementation there are certain lines of code that you think may contain a bottleneck, the MiniProfiler gives you a method for timing just those specific lines of code:

    var profiler = ApplicationContext.ProfilingLogger;
    using(profiler.DebugDuration<Products>("Artificially Slow Example"))
    {
        // you would place the code you wanted to measure in here...
        // just make this sleep for a second, for example purposes:
        System.Threading.Thread.Sleep(1000);
    }

and now in the profiler you can see

![Show Trivial](images/writing-to-miniprofiler.png)

#### Umbraco Productivity Tool - Chrome Extension

If you are using the Google Chrome browser you can install this [Umbraco Productivity Tool Chrome Extension](https://chrome.google.com/webstore/detail/umbraco-productivity/kepkgaeokeknlghbiiipbhgclikjgkdp?hl=en)

To enable you to easily access and switch between the Mini-profiler / Trace debugging modes.

![Umbraco Productivity Tool](images/umbraco-productivity-chrome-extension.png)

### [Logging](Logging/)
Learn how Umbraco writes log files and how you can write to them.