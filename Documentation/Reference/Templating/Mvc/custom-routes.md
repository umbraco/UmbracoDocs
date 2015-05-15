#Custom MVC Routes

_Documentation about how to setup your own custom controllers and routes that need to exist alongside of the Umbraco pipeline_

##Where to put your routing logic?

In Umbraco the best place to put your routing logic is in a custom `Umbraco.Web.ApplicationEventHandler` class and override the `ApplicationStarted` method. There you can add any custom routing logic you like and you can be sure that the Umbraco application has completed it's booting sequence.

##Custom MVC routes & controllers with Umbraco data & views

This is an advanced technique that some devs may be interested in. This post will describe how you can declare your own custom MVC routes in order to execute your own custom controllers in Umbraco but still be able to render Umbraco views with the same model that Umbraco uses natively.

See: [http://shazwazza.com/post/custom-mvc-routes-within-the-umbraco-pipeline/](http://shazwazza.com/post/custom-mvc-routes-within-the-umbraco-pipeline/)
