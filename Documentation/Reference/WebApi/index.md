#Umbraco Api

**Applies to: Umbraco 6.1.0+**

_This section will describe how to work with Web Api in Umbraco to easily create REST services_ 

Related links:

* [Umbraco api routes and Urls](routing.md)
* [Umbraco api authorization](authorization.md)

##What is Web API?
The Microsoft Web API reference can be found [here](http://www.asp.net/web-api) - *"ASP.NET Web API is a framework that makes it easy to build HTTP services that reach a broad range of clients, including browsers and mobile devices. ASP.NET Web API is an ideal platform for building RESTful applications on the .NET Framework."*

Essentially it's a great platform for building REST services.

##Web Api in Umbraco

We've created a base Web Api controller for developers to inherit from which will expose all of the Umbraco related services and objects that you will require when working with Umbraco.

The class to inherit from is: `Umbraco.Web.WebApi.UmbracoApiController`

This will expose the following properties for you to use:

	ApplicationContext ApplicationContext {get;}
	ServiceContext Services {get;}
	DatabaseContext DatabaseContext {get;}
	UmbracoHelper Umbraco {get;}
	UmbracoContext UmbracoContext {get;}
	

##Creating a Web Api controller

There are 2 types of Umbraco Api controllers: 

1. A locally declared controller - it is **not** routed via an Area
1. A plugin based controller - it is routed via an Area

When working on your own projects you will normally be creating a locally declared controller which requires no additional steps. However, if you are creating an Umbraco package to be distributed you will want to create a plugin based controller so that it gets routed via its own area. This ensures that the route will not overlap with someone's locally declared controller if they are both named the same thing.

###Naming conventions

It is very important that you name your controllers according to these guidelines or else they will not get routed:

All controller class names must be suffixed with "**Controller**" and inherit from **UmbracoApiController**. Some examples:

	public class ProductsController : UmbracoApiController
	public class CustomersController : UmbracoApiController
	public class ScoresController : UmbracoApiController

###Locally declared controller

This is the most common way to create an Umbraco Api controller, you simply inherit from the class `Umbraco.Web.WebApi.UmbracoApiController` and that is all. You will of course need to follow the guidelines specified by Microsoft for creating a Web Api controller, documentation can be found [here](http://www.asp.net/web-api).

Example:

	public class ProductsController : UmbracoApiController
	{	    
	    public IEnumerable<string> GetAllProducts()
	    {
	        return new[] { "Table", "Chair", "Desk", "Computer", "Beer fridge" };
	    }
	}

All locally declared Umbraco api controllers will be routed under the url path of:

*~/Umbraco/Api/[YourControllerName]*

E.g *~/Umbraco/Api/Products/GetAllProducts*

###Plugin based controller

If you are creating an Umbraco Api controller to be shipped in an Umbraco package you will need to add the `Umbraco.Web.Mvc.PluginController` attribute to your controller to ensure that it is routed via an area. The area name is up to you to specify in the attribute. 

Example:

	[PluginController("AwesomeProducts")]
	public class ProductsController : UmbracoApiController
	{	    
	    public IEnumerable<string> GetAllProducts()
	    {
	        return new[] { "Table", "Chair", "Desk", "Computer", "Beer fridge" };
	    }
	}

Now this controller will be routed via the area called "AwesomeProducts". All plugin based Umbraco api controlleres will be routed under the url path of:

*~/Umbraco/[YourAreaName]/[YourControllerName]*

For more information about areas, Urls and routing see the [routing section](routing.md)

###Securing your API methods
API methods can be secured so that only members logged into your site can use them, you can do this using the `Umbraco.Web.WebApi.MemberAuthorize` attribute.

This attribute allows for the following protections to be set up:

- AlowAll: boolean (true by default)
- AllowType: list of allowed member types
- AllowGroup: list of allowed member groups
- AllowMembers: list of allowed members (login names)

`AllowAll` is only there for backwards compatibility, if any of the other "Allow" properties are set then AllowAll is set to false.

Example:
	
	[MemberAuthorize(AllowGroup = "Accounts,Editors")]
	public class ProductsController : UmbracoApiController
	{	    
	    public IEnumerable<string> GetAllProducts()
	    {
	        return new[] { "Table", "Chair", "Desk", "Computer", "Beer fridge" };
	    }
	}
	
When a member is logged in and is member of the member group "Accounts" or "Editors", they will get the result of the API call as normal. Anybody else will get an error telling them they're not allowed to call this method.

Any methods added to this class will have the same protection but you can also add the attribute to a single or a few of your methods when not all methods in your API Controller class need to have the same authorization.

##Backoffice controllers

If you are creating a controller to work within the Umbraco back office then you will need to ensure that it is secured  properly by inheriting from: `UmbracoAuthorizedJsonController`. This controller type will auto-route your controller like the above examples except that it will add another Uri path: 'backoffice'. For example:

*~/Umbraco/backoffice/Api/[YourControllerName]*
*~/Umbraco/backoffice/[YourAreaName]/[YourControllerName]*
