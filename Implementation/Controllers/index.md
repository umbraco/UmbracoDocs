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

##Umbraco Authorized Controllers
An Umbraco Authorized controller is used when the controller requires member or user authentication (authN) and/or authorization (authZ).  If either the authN or authZ fail the controller will return a "401 - unathorized response."  

The Umbraco Authorized controllers are:

* Umbraco.Web.Mvc.UmbracoAuthorizedController
* Umbraco.Web.Editors.UmbracoAuthorizedJsonController
* Umbraco.Web.WebApi.UmbracoAuthorizedApiController

All implementations of SurfaceControllers inherit from the base classes:

`Umbraco.Web.Mvc.UmbracoAuthorizedController`

`Umbraco.Web.Editors.UmbracoAuthorizedJsonController`

`Umbraco.Web.WebApi.UmbracoAuthorizedApiController`

###Members and Users - Routing
There are specific rules used to determine if the request should used front end authN (members) or backoffice authN (users).  For details on the routes and route requirements see [Routing for authentication](../../../Reference/Routing/Authorized/index.md)  Umbraco Authorized controllers are not auto-routed so it is required to create routes specifically for your custom controllers.