---
versionFrom: 7.0.0
needsV8Update: "true"
---

# Hot versus cold restarts in Umbraco

When we talk about startup time there are several different things folks are referring to. Let us cover all startup scenarios with comments.

* **Production website**: A site that is running live which means it has compilation `debug="false"` in the `web.config` file and it is built in Release mode and without log4net Debug mode enabled (these are important factors)
* **Hot start**: When a site is recycled in production without DLL, code or view file changes
* **Cold start**: When a site is recycled in production with DLL, code or view file changes

## Startup scenarios

### Hot start
A production website that gets restarted, possibly by a change in the `web.config` file or a scheduled IIS recycle.

There's an important thing to know about this scenario. ASP.NET has a built in CodeGen folder which it compiles all things to including App_Code, View files, DLLs and Resources.

On first run ASP.NET will compile a lot and it's important to know that if you have `debug="true"` and/or have compiled in Debug mode, this compilation time and the amount of information included is exponentially larger. This means that it might take much longer on the first run.

A normal "hot start" in Umbraco will mean there is no assembly scanning taking place since Umbraco caches all assembly scans for its plugins unless any files in the `/bin` folder changes.

### Hot start /w assembly scan

If a hot start occurs and the `/App_Data/TEMP/PluginCache` is cleared, then Umbraco will scan assemblies on startup for finding certain plugins.

This is rare and will generally only be caused on purpose by a developer.

### Cold start

A production website that gets restarted by changing the `global.asax` or changes made in any of these folders: `~/Resource`, `~/WebReferences`, `~/App_Code`, `~/bin`.

This scenario can be caused by various changes and it doesn't always come down to shipping new code. If you bump the `global.asax`, this will also cause a "cold start".

A good reference is the [BuildManager source code](https://referencesource.microsoft.com/#System.Web/Compilation/BuildManager.cs,577) that controls this. You can see what files are monitored which will force a cold start.

A cold start means that the CodeGen folder is cleared and all of the intermediate ASP.NET compilations will be gone and will need to be done again. It's important to understand the above comment with regards to `debug="true"` and Debug/Release modes.

### Cold start w/ assembly rescan

If a cold start is triggered because of `/bin` folder changes then Umbraco will scan assemblies on startup for finding certain plugins.

### Visual Studio cold start

This occurs during local development with Visual Studio or even VS Code if you are using `App_Code`. It also occurs anytime you are developing locally with assemblies built in Debug mode and with `debug="true"` in your `web.config`.

You will generally have log4net Debug or Info level enabled which can cause startup time increase.

This will always take a longer time than any of the above for the reasons mentioned before which has to do with how ASP.NET compiles things into its CodeGen folder.

As for the Debug vs Release mode, there's a ton of info on this online. Depending on the type of project, it will vary on how much performance improvements Release mode is compared to Debug, but it's still a factor.

If you want to improve VS cold start times and you don't plan on debugging, change your `web.config` to `debug="false"` and try it out. Be aware that you will not get any detailed error information or be able to set breakpoints.

#### External resources

* [Https://weblogs.asp.net/scottgu/442448](https://weblogs.asp.net/scottgu/442448)
* [Debug in ASP.NET applications](https://blogs.msdn.microsoft.com/prashant_upadhyay/2011/07/14/why-debugfalse-in-asp-net-applications-in-production-environment/)