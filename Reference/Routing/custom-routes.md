#Custom MVC Routes

_Documentation about how to setup your own custom controllers and routes that need to exist alongside of the Umbraco pipeline_

##Where to put your routing logic?

In Umbraco the best place to put your routing logic is in a custom `Umbraco.Web.ApplicationEventHandler` class and override the `ApplicationStarted` method. There you can add any custom routing logic you like and you can be sure that the Umbraco application has completed it's booting sequence.

##User defined routes

Umbraco doesn't interfere with any user defined routes that you wish to have. Your custom routes to your own custom controllers will work perfectly and seamlessly alongside of Umbraco.

##Custom routes within the Umbraco pipeline

You can specify your own custom MVC routes to work within the Umbraco pipeline. This requires you to use an implementation of `Umbraco.Web.Mvc.UmbracoVirtualNodeRouteHandler` with your custom route. 

As an example:

    //custom route to MyProductController which will use a node with ID 1234 as the 
    // IPublishedContent for the current rendering page
    routes.MapUmbracoRoute(
        "test",
        "Products/{action}/{sku}",
        new
        {
            controller = "MyProduct",
            sku = UrlParameter.Optional
        },
        new UmbracoVirtualNodeByIdRouteHandler(1234));

TODO: Write these docs ([https://github.com/umbraco/Umbraco4Docs/issues/200](https://github.com/umbraco/Umbraco4Docs/issues/200)), in the meantime, this blog post describes a bit about this process See: [http://shazwazza.com/post/custom-mvc-routes-within-the-umbraco-pipeline/](http://shazwazza.com/post/custom-mvc-routes-within-the-umbraco-pipeline/)

