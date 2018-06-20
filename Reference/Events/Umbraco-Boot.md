
# Umbraco Startup

This is the actual startup/bootstrap process, this occurs before even the global.asax is executed and the logic starts in [CoreBootManager](../../apidocs/csharp/api/Umbraco.Core.CoreBootManager.html) and WebBootManager.

Examine actually doesn't do anything on startup if the indexes are built.

Slow startup can occur if: 
* no indexes exist
* models builder is used and is using Live modes and it's the first time it's compiling (you can use DLL mode to avoid this entirely)
* the umbraco cache file doesn't exist
* the `/App_Data/TEMP/PluginCache` is empty or if one of your DLLs has changed. This means a new scan of plugins will occur. Plugin scanning has also been heavily optimized since v7.5 (IIRC)
* packages that do stuff on startup that don't need to 
* custom code that do things on startup that don't need to

_Troubleshooting tip: You can change your log4net config to output Debug level logs, this will give you detailed timing information on almost all aspects of startup so you can diagnose what might be running slow._

# The request process

Once booting is complete, then the request process occurs which is the [normal routing](../Routing/) phase.

On first request the only thing that would be slower than the second request is resolving the URL to the published content item which is subsequently cached. I don't think this is a bottleneck though.

# The rendering process

Once the request process is complete, then your razor views are rendered.

There's several factors that can cause this part to be slow but this all comes down to implementation details especially if you have decided that caching will solve all of your issues. If that is the case than the first request will always be slow and fixing that comes down to solving the performance issues that have been 'fixed' by putting caching in front of it.