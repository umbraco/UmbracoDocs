# Troubleshooting slow startup

Slow startup can occur if: 
* no Examine indexes exist
* models builder is used in [Pure Live mode](../Reference/Templating/Modelsbuilder/Builder-Modes.md#pure-live-models). Depending on the number of models, compilation (the first time) will take some time. You can use the other modes (DLL, AppData or API) to avoid this entirely.
* the Umbraco cache file (/app_data/umbraco.config) doesn't exist
* the `/App_Data/TEMP/PluginCache` is empty or if one of your DLLs has changed. This means a new scan of plugins will occur. Plugin scanning has also been heavily optimized since v7.5 (IIRC)
* third party packages and plugins may also run code on startup, and may have configuration or settings to avoid this, or there may be workarounds or indeed 'different' plugins
* Your application may also be executing code on startup, and other strategies could be used to prevent slow startup time, eg instead of 'loading' data into memory at startup, consider doing so when it is first requested

_Troubleshooting tip: You can change your log4net config to *output Debug* level logs, this will give you detailed timing information on almost all aspects of startup so you can diagnose what might be running slow._

# The request process

Once booting is complete, then the request process occurs which is the [normal routing](../Routing/index.md) phase.

On first request the only thing that would be slower than the second request is resolving the URL to the published content item which is subsequently cached.

# The rendering process

Once the request process is complete, then the controller for the route will be launched followed by the rendering of the razor views.

If your rendering is slow, be sure to review which controller is used. By default the [RenderMvcController](../../Implementation/default-routing/Controller-Selection/index.md) will be used.  But it is possible to implement [custom routing](../Implementation/Custom-Routing/index.md) to have bad performing code in a custom controller. Or the default RenderMvcController is replaced at startup with a custom RenderMvcController that may contain bad performing code.

There's several factors that can cause this part to be slow but this all comes down to implementation details. Especially if you have decided that caching will solve all of your issues. If that is the case, than the first request will always be slow and fixing that comes down to solving the performance issues that have been 'fixed' by putting caching in front of them.

## Related Links
* [More information about BootManager](Understanding-BootManagers.md) (EXPERT)
* [Adding startup logic and plugin on c# events](Application-Startup.md) (EXPERT)
* [Overriding UmbracoApplication](Extending-UmbracoApplication.md) (EXPERT)
