#Custom MVC Routes

**Applies to: Umbraco 4.10.0+**

_Documentation about how to setup your own custom controllers and routes that need to exist alongside of the Umbraco pipeline_

##Where to put your routing logic?

In 4.10.0+ we have a custom global.asax class called `Umbraco.Web.UmbracoApplication` which you **must** inherit from if you want your own custom global.asax. Putting your own custom routes in your global.asax class is easily done by overriding the method: `OnApplicationStarted`. Any custom route logic should be done in this method.

Alternatively, if you require custom routes to be distributed in a package, or you just don't like global.asax for some reason, you can create a custom `Umbraco.Web.ApplicationEventHandler` class and override the  `ApplicationStarted` method. There you can add any custom routing logic you like.

*NOTE: `Umbraco.Web.ApplicationEventHandler` is available from v6.1.0+ . Otherwise if you are running a previous version: use the interface `Umbraco.Core.IApplicationEventHandler` and put your routing logic in the `OnApplicationStarted` method*

##Custom MVC routes & controllers with Umbraco data & views

This is an advanced technique that some devs may be interested in. This post will describe how you can declare your own custom MVC routes in order to execute your own custom controllers in Umbraco but still be able to render Umbraco views with the same model that Umbraco uses natively.

See: [http://shazwazza.com/post/Custom-MVC-routing-in-Umbraco](http://shazwazza.com/post/Custom-MVC-routing-in-Umbraco)
