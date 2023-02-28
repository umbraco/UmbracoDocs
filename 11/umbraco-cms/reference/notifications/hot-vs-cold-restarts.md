---
description: 
---

# Hot vs. cold restarts

When we talk about startup time there are different things folks are referring to. Let us cover all startup scenarios with comments.

* **Production website**: A site that is running live which means it has compilation `debug="false"` in the `web.config` file and it is built in Release mode and without log4net Debug mode enabled (these are important factors)
* **Hot start**: When a site is recycled in production without DLL, code or view file changes
* **Cold start**: When a site is recycled in production with DLL, code or view file changes

## Startup scenarios

### Hot start

A production website that gets restarted, possibly by a change in the `web.config` file or a scheduled IIS recycle.

There's an important thing to know about this scenario. ASP.NET has a built in CodeGen folder which it compiles all things to including App_Code, View files, DLLs and Resources.

On first run ASP.NET will compile a lot and it's important to know that if you have `debug="true"` and/or have compiled in Debug mode, this compilation time and the amount of information included is exponentially larger. This means that it might take much longer on the first run.

A normal "hot start" in Umbraco will mean there is no assembly scanning taking place since Umbraco caches all assembly scans for its plugins unless any files in the `/bin` folder changes.

### Cold start

A production website that gets restarted by changing the `global.asax` or changes made in any of these folders: `~/Resource`, `~/WebReferences`, `~/App_Code`, `~/bin`.

This scenario can be caused by various changes and it doesn't always come down to shipping new code. If you bump the `global.asax`, this will also cause a "cold start".

A good reference is the [BuildManager source code](https://referencesource.microsoft.com/#System.Web/Compilation/BuildManager.cs,577) that controls this. You can see what files are monitored which will force a cold start.

A cold start means that the CodeGen folder is cleared and all of the intermediate ASP.NET compilations will be gone and will need to be done again. It's important to understand the above comment with regards to `debug="true"` and Debug/Release modes.

## Troubleshooting slow startup

Slow startup can occur if:

* No Examine indexes exist.
* Models builder is used in [Pure Live mode](../Templating/Modelsbuilder/Builder-Modes.md#pure-live-models). Depending on the number of models, compilation (the first time) will take some time. You can use the other modes (DLL, AppData or API) to avoid this entirely.
* The Umbraco cache file (/app_data/umbraco.config) doesn't exist.
* The `/App_Data/TEMP/PluginCache` is empty or if one of your DLLs has changed. This means a new scan of plugins will occur - Plugin scanning has also been heavily optimized since v7.5 (IIRC).
* Third party packages and plugins may also run code on startup, and may have configuration or settings to avoid this, or there may be workarounds or indeed 'different' plugins.
* Your application may also be executing code on startup, and other strategies could be used to prevent slow startup time, eg instead of 'loading' data into memory at startup, consider doing so when it is first requested.

_Troubleshooting tip: You can change your log4net config to *output Debug* level logs, this will give you detailed timing information on almost all aspects of startup so you can diagnose what might be running slow._

# The request process

Once booting is complete, then the request process occurs which is the [normal routing](../Routing/index.md) phase.

On first request the only thing that would be slower than the second request is resolving the URL to the published content item which is subsequently cached.

# The rendering process

Once the request process is complete, then the controller for the route will be launched followed by the rendering of the razor views.

If your rendering is slow, be sure to review which controller is used. By default the [RenderMvcController](../../Implementation/Default-Routing/Controller-Selection/index.md) will be used.  But it is possible to implement [custom routing](../../Implementation/Custom-Routing/index.md) to have bad performing code in a custom controller. Or the default RenderMvcController is replaced at startup with a custom RenderMvcController that may contain bad performing code.

There's several factors that can cause this part to be slow but this all comes down to implementation details. Especially if you have decided that caching will solve all of your issues. If that is the case, than the first request will always be slow and fixing that comes down to solving the performance issues that have been 'fixed' by putting caching in front of them.

## Related Links
* [More information about BootManager](Understanding-Bootmanagers.md) (EXPERT)
* [Adding startup logic and plugin on c# events](Application-Startup.md) (EXPERT)
* [Overriding UmbracoApplication](Extending-UmbracoApplication.md) (EXPERT)