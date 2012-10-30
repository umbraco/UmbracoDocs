#Custom MVC Routes

**Applies to: Umbraco 4.10.0+**

_Documentation about how to setup your own custom controllers and routes that need to exist alongside of the Umbraco pipeline_

##Where to put your routing logic?

In 4.10.0+ we have a custom global.asax class called `Umbraco.Web.UmbracoApplication` which you **must** inherit from if you want your own custom global.asax. Putting your own custom routes in your global.asax class is easily done by overriding the method: `OnApplicationStarted`. Any custom route logic should be done in this method.

Alternatively, if you require custom routes to be distributed in a package, or you just don't like global.asax for some reason you can create a custom `Umbraco.Web.IApplicationEventHandler` class. Then in your `OnApplicationStarted` method, you can add any custom routing logic you like.

##Adding to the Umbraco ignore list

In order for you to get your custom route working 100%, you should add them to the ignore list in the web.config in the umbracoReservedUrls or the umbracoReservedPaths.