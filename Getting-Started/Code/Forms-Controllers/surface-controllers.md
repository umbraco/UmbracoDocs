#Surface Controllers

**Applies to: Umbraco 4.10.0+**

_A SurfaceController is an MVC controller that interacts with the front-end rendering of an UmbracoPage. They can be used for rendering Child Action content, for handling form data submissions and for rendering Child Action macros. SurfaceControllers are auto-routed meaning that you don't have to add/create your own routes for these controllers to work._

##What is a SurfaceController?

It is a regular ASP.Net MVC controller that:

* Is auto routed, meaning you don't have to setup any custom routes to make it work
* Is used for interacting with the front-end of Umbraco (not the back office)

Since any SurfaceController inherits from the `Umbraco.Web.Mvc.SurfaceController` class, the class instantly supports many of the helper methods and properties that are available on the base SurfaceController class including `UmbracoHelper` and `UmbracoContext`. Therefore, all Surface Controllers have native Umbraco support for:

* interacting with Umbraco routes during HTTP POSTs (i.e. `return CurrentUmbracoPage();` )
* rendering forms in Umbraco (i.e. `@Html.BeginUmbracoForm<MySurfaceController>(...)` )
* rendering ASP.Net MVC ChildAction (see [ChildActions](child-actions.md) documentation)
* rendering ChildAction macros (coming soon...)

##Creating a SurfaceController

SurfaceControllers are plugins, meaning they are found when the Umbraco application boots. There are 2 types of SurfaceController: **locally declared** & **plugin based**. The main difference between the two is that a plugin based controller gets routed via an MVC Area, which is defined in the controller (see below). Because a plugin based controller is routed via an MVC Area, it means that the views can be stored in a custom folder specific to the package it is being shipped in without interfering with the local developer's MVC files.

###Locally declared controllers

A locally declared SurfaceController is one that is not shipped within an Umbraco package. It is created by the developer of the website they are creating. If you are planning on shipping a SurfaceController in an Umbraco package then you will need to create a plugin based SurfaceController (see the next heading).

To create a locally declared SurfaceController: 

* Create a controller that inherits from `Umbraco.Web.Mvc.SurfaceController`
* The controller must be a 'public' class.
* The controller's name must be suffixed with the term 'SurfaceController'

For example:

	public class MySurfaceController : Umbraco.Web.Mvc.SurfaceController
	{
		public ActionResult Index() 
		{
			return Content("hello world");
		}
	}

####Routing for locally declared controllers

All locally declared controllers get routed to:

/umbraco/surface/{controllername}/{action}/{id}

They do not get routed via an MVC Area so any Views must exist in the following folders:

* ~/Views/{controllername}/ 
* ~/Views/Shared/
* ~/Views/

##Plugin based controllers

If you are shipping a SurfaceController in a package then you should definitely be creating a plugin based SurfaceController. The only difference between creating a plugin based controller and locally declared controller is that you need to add an attribute to your class which defines the MVC Area you'd like your controller routed through. Here's an example:

	[PluginController("SuperAwesomeAnalytics")]
	public class MySurfaceController : Umbraco.Web.Mvc.SurfaceController
	{
		public ActionResult Index() 
		{
			return Content("hello world");
		}
	}

In the above, I've specified that I'd like my MySurfaceController to belong to the MVC Area called 'SuperAwesomeAnalytics'. Perhaps it is obvious but if you are creating a package that contains many SurfaceControllers then you should most definitely ensure that all of your controllers are routed through the same MVC Area.

####Routing for plugin based controllers

All plugin based controllers get routed to:

/umbraco/{areaname}/{controllername}/{action}/{id}

Since they get routed via an MVC Area your views should be placed in the following folder:

* ~/App_Plugins/{areaname}/Views/{controllername}/
* ~/App_Plugins/{areaname}/Views/Shared/
