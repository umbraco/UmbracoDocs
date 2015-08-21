#Routing for Umbraco Authorized Controllers
The Umbraco Authorized controller `Umbraco.Web.Mvc.UmbracoAuthorizedController` is not auto-routed like Surface or Api controllers and requires specific routing in order for Umbraco to correctly route requests for controllers created by inheriting from this and authenticate the user appropriately.

Both `UmbracoAuthorizedJsonController` and `UmbracoAuthorizedApiController` are auto-routed with the default route:

* `/umbraco/backoffice/api/{controller}/{action}`

##Defining a route
When you create a controller that inherits from `UmbracoAuthorizedController` you need to explicitly define a route.  There a several ways to do this, all are standard Mvc.  One approach is to define a route in Umbraco ApplicationStarted event similar to the following:

```
protected override void ApplicationStarted(UmbracoApplicationBase umbracoApplication, ApplicationContext applicationContext) 
{ 
  RouteTable.Routes.MapRoute( 
    name: "cats", 
    url: "backoffice/cats/{action}/{id}", 
    defaults: 
    new 
    { 
       controller = "Cats", 
       action = "Meow",
       id = UrlParameter.Optional
    }); 
}
```

Note the route must contain `/backoffice` in order for Umbraco to check user authentication.

###What about Surface Controllers?
Surface Controllers should not be used in the back office.  Surface Controllers are not designed to work with the back office, they are not meant to be used there and will not be supported being used there. 

##Umbraco Authorized Controller For MVC

 `Umbraco.Web.Mvc.UmbracoAuthorizedController`

This is the same as using Umbraco.Web.Mvc.UmbracoController with the `[UmbracoAuthorize]` attribute.

##Umbraco Authorized Controller For WebApi

`Umbraco.Web.WebApi.UmbracoAuthorizedApiController`

This is the same as using `Umbraco.Web.WebApi.UmbracoApiController` with the `[UmbracoAuthorize]` attribute and the `[IsBackOffice]` attribute.
 
`UmbracoAuthorizedJsonController`

This inherits from `Umbraco.Web.WebApi.UmbracoAuthorizedApiController` but has the attributes `[AngularJsonOnlyConfiguration]` and `[ValidateAngularAntiForgeryToken]` applied.

##Backoffice Routes for User Authentication
There are some special routes Umbraco checks to determine if the authernication should check a member of a user.
         
If any route has an extension in the path like `.aspx` or the below are always back office routes:

* /Umbraco/RestServices
* /Umbraco/BackOffice

If the route is not any of the above, and there's no extension then Umbraco cannot determine if it's back office or front-end - so front-end is assumed. This will occur if a `UmbracoApiController` is used for the back office rather than `UmbracoAuthorizedApiController` and the `[IsBackOffice]` attribute is not used.

In all of the above user authentication will be used.

##Front-end Routes for Member Authentication
These are always front-end routes

* /Umbraco/Surface 
* /Umbraco/Api

In al of the above member authentication will be used.
