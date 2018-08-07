# Hot versus cold restarts in Umbraco

When we talk about startup time there are several different things folks are referring to. Let us cover all startup scenarios with comments.

* **Production website** a site that is running live which means it has compilation debug="false" in the web.config and it's built in Release mode and definitely not log4net Debug mode enabled (these are important factors)
* **Hot start** when a site is recycled in production without DLL, code or view changes
* **Cold start** when a site is recycled in production with DLL, code or view changes

## Startup scenarios

### Hot start
a production website that gets restarted, possibly by a web.config 

### Change or a scheduled IIS recycle
There's an important thing to know about this scenario, ASP.NET has a built in CodeGen folder which it compiles all things to including App_Code, Views, DLLs, Resources, and lots of other stuff. On first run ASP.NET will compile a bunch of stuff and it's important to know that if you have debug='true' and/or have compiled in Debug and not release mode, this compilation time and the amount of information included in the compiled result is exponentially larger which means it takes much longer!

A normal Hot start in Umbraco will mean there is no assembly scanning taking place since Umbraco caches all assembly scans for it's plugins unless the /bin changes

### Hot start /w assembly scan

If a Hot start occurs and the /App_Data/TEMP/PluginCache is cleared, than Umbraco will scan assemblies on startup for finding certain plugins.
        This is rare and will generally only be caused on purpose by a developer

### Cold start

a production website that gets restarted by changing the global.asax, ~/Resource, ~/WebReferences, ~/App_Code, ~/bin

This scenario can be caused by various changes, it doesn't always come down to shipping new code! If you bump the global.asax, this will also cause a Cold start

A good reference is the BuildManager source code that controls this, see here: https://referencesource.microsoft.com/#System.Web/Compilation/BuildManager.cs,577 ... you can see what files are monitored which will force a Cold start

A Cold start means that the CodeGen folder is cleared and all of the intermediate ASP.NET compilations will be gone and will need to be done again. So again, its important to understand the above comment with regards to debug='true' and Debug/Release modes.

### Cold start w/ assembly rescan

If a Cold start is triggered because of /bin folder changes than Umbraco will scan assemblies on startup for finding certain plugins.

### VS cold start

This occurs during local development with Visual Studio or even VS Code if you are using App_Code, or really anytime you are developing locally with assemblies built in Debug mode (not Release mode) and with debug='true' in your web.config and a Cold start occurs.

You will generally have log4net Debug or Info level enabled which can cause micro startup time increase.

This will always take a longer time than any of the above for the reasons mentioned before which has to do with how ASP.NET compiles things into it's CodeGen folder. Remember this from 2006? Things haven't changed much with regards to this apart from even more compilation taking place: https://weblogs.asp.net/scottgu/442448, here's a more recent detailed version of that https://blogs.msdn.microsoft.com/prashant_upadhyay/2011/07/14/why-debugfalse-in-asp-net-applications-in-production-environment/ and there are others. As for the Debug vs Release mode, there's a ton of info on this online and depending on the type of project it will vary on how much performance improvements Release mode is compared to Debug, but it's still a factor.

If you want to improve VS cold start times and you don't plan on debugging, change your web.config to debug="false" and try it out... but you won't get any detailed error information or be able to set breakpoints.
