#Controllers in Umbraco

_There are are few types of controllers in Umbraco that perform different tasks_

##Render MVC Controllers

These are the controllers that get executed when rendering content during an Umbraco route. 

These controllers are of type `Umbraco.Web.MVC.RenderMvcController`.

See [Controller & Action Selection for details on using these controllers](../Default-Routing/Controller-Selection/)

##Surface Controllers

A SurfaceController is an MVC controller that interacts with the front-end rendering of an UmbracoPage. 
They can be used for rendering MVC Child Actions and for handling form data submissions. 
SurfaceControllers are auto-routed meaning that you don't have to add/create your own routes for these controllers to work. 

All implementations of SurfaceControllers inherit from the base class `Umbraco.Web.Mvc.SurfaceController`.

See [Reference documentation on SurfaceControllers for full details](../../../Reference/Routing/surface-controllers.md)

##Umbraco Api Controllers   

An Umbraco API Controller is an ASP.Net WebApi controller that is used for creating REST services. 
These controllers are auto-routed meaning that you don't have to add/create your own routes for these controllers to work.

All implementations of SurfaceControllers inherit from the base class `Umbraco.Web.WebApi.UmbracoApiController`.

See [Reference documentation on Umbraco Api Controllers for full details](../../../Reference/Routing/WebApi/index.md)