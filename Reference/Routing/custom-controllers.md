#Custom controllers (Hijacking Umbraco Routes)

_If you need complete control over how your pages are rendered then Hijacking Umbraco Routes is for you_

##What is Hijacking Umbraco Routes?

By default all of the front end routing is executed via the `Umbraco.Web.Mvc.RenderMvcController` Index Action which should work fine for most people. However, in some cases people may want complete control over this execution and may  want their own Action to execute. Some reasons for this may be: to control exactly how views are rendered, custom/granular security for certain pages/templates or to be able to execute any custom code in the controller that renders the front end. The good news is that this is completely possible. This process is all about convention and it's really simple!

##Creating a custom controller

 It's easiest to demonstrate with an example : let's say you have a Document Type called 'Home'.  You can create a custom locally declared controller in your MVC web project called 'HomeController' and ensure that it inherits from `Umbraco.Web.Mvc.RenderMvcController` and now all pages that are of document type 'Home' will be routed through your custom controller! Pretty easy right :-)
OK so let's see how we can extend this concept. In order for you to run some code in your controller you'll need to override the Index Action. Here’s a quick example:

	public class HomeController : Umbraco.Web.Mvc.RenderMvcController
	{
	    public override ActionResult Index(RenderModel model)
	    {
	        //Do some stuff here, then return the base method
	        return base.Index(model);
	    }

	}
Now you can run any code that you want inside of that Action!

##Routing via template

To further extend this, we've also allowed routing to different Actions based on the Template that is being rendered. By default only the Index Action exists which will execute for all requests of the corresponding document type. However, if the template being rendered is called 'HomePage' and you have an Action on your controller called 'HomePage' then it will execute instead of the Index Action. As an example, say we have a Home Document Type which has 2 allowed Templates: ‘HomePage’ and ‘MobileHomePage’ and we only want to do some custom stuff for when the ‘MobileHomePage’ Template is executed:

	public class HomeController : Umbraco.Web.Mvc.RenderMvcController
	{
	    public ActionResult MobileHomePage(RenderModel model)
	    {
	        //Do some stuff here, the return the base Index method
	        return base.Index(model);
	    }
	}

##How the mapping works

* Document Type name = controller name
* 
Template name = action name, but if no action matches or is not specified then the 'Index' action will be executed.

In the near future we will allow setting a custom default controller to execute for all requests instead of the standard UmbracoController. Currently you'd have to create a controller for every document type to have a custom controller execute for all requests.

##Returning a view with a custom model

If you want to return a custom model to a view then there are a few steps that need to be taken. 

###Changing the @inherits directive of your template

First, the standard view that is created by Umbraco inherits from `Umbraco.Web.Mvc.UmbracoTemplatePage` which has a model defined of type `Umbraco.Web.Models.RenderModel`. You'll see the inherits directive at the top of the view as:

	@inherits Umbraco.Web.Mvc.UmbracoTemplatePage

If you are returning a custom model, then this directive will need to change because your custom model will not be an instance of `Umbraco.Web.Models.RenderModel`. Instead change your @inherits directive to inherit from `Umbraco.Web.Mvc.UmbracoViewPage<T>` where 'T' is the type of your custom model. So for exammple, if your custom model is of type 'MyCustomModel' then your @inherits directive will look like:

	@inherits Umbraco.Web.Mvc.UmbracoViewPage<MyCustomModel>

Please note that if your template uses a layout that expects the model to be of type `Umbraco.Web.Models.RenderModel` then changing the template to inherit from `Umbraco.Web.Mvc.UmbracoViewPage<MyCustomModel>` will cause an exception. This is due to the way ASP.NET MVC works with strongly typed views: the requirement for a specific type applies all the way from the top-most layout down to the template. There are two ways to solve this problem:

1. Break the dependency on `Umbraco.Web.Models.RenderModel` in your layout by having it inherit from `Umbraco.Web.Mvc.UmbracoViewPage<dynamic>` (this means `@Model` will be of type `dynamic` in the layout).
2. Make your custom model inherit from `Umbraco.Web.Models.RenderModel` (this means `@Model...` will continue to work in the layouts used by your template).

###Returning the correct view from your controller

In an example above we reference that you can use the following sytnax once you've hijacked a route:

	//Do some stuff here, the return the base Index method
    return base.Index(model);

This will work but the object (model) that you pass to the `Index` method must be an instance of `Umbraco.Web.Models.RenderModel` which will probably not be the case if you have a custom model. So to return a custom model to the current Umbraco template, we need to use different syntax. Here's an example:

	public class HomeController : Umbraco.Web.Mvc.RenderMvcController
	{
	    public ActionResult MobileHomePage(RenderModel model)
	    {
	        //we will create a custom model
			var myCustomModel = new MyCustomModel();

			//TODO: assign some values to the custom model...
			
			//now we need to return the current template with our custom model        
			//NOTE: This example shows 2 different syntaxes, one that works with 
			// Umbraco 4.10 and another that works with 
			// Umbraco 4.11+
			
			//Example for 4.10:
			
			//get the template name from the route values:
			var template = ControllerContext.RouteData.Values["action"].ToString();
			//return an empty content result if the template doesn't physically 
			//exist on the file system
			if (!EnsurePhsyicalViewExists(template))
			{
				return Content("");
			}
			//return the current template with an instance of MyCustomModel
			return View(template, myCustomModel);


			//Example for 4.11+
			
			//simply use the protected method CurrentTemplate<T>, this does all of the
			//above for you... much nicer.
			return CurrentTemplate(myCustomModel);
	    }
	}

##Change the default controller

**Applies to: Umbraco 6.1.0+**

In some cases you might want to have your own custom controller execute for all MVC requests when you haven't hijacked a route. This is possible by assigning your own default controller during application startup.

The code to do this is simple, an example to register a default controller of type 'MyCustomUmbracoController' :

	DefaultRenderMvcControllerResolver.Current.SetDefaultControllerType(typeof(MyCustomUmbracoController));

You can execute this code during application startup before resolution is frozen. The 2 most common ways of doing this is:

####Global.asax

In your global asax, you can override the `OnApplicationStarting` method and put this custom code in that method. Example:

    public class MyApplication : UmbracoApplication
	{
        protected override void OnApplicationStarting(object sender, EventArgs e)
        {
            DefaultRenderMvcControllerResolver.Current.SetDefaultControllerType(typeof(MyCustomUmbracoController));
            base.OnApplicationStarting(sender, e);
        }
	}

####Using ApplicationEventHandler

You can create an instance of `Umbraco.Core.ApplicationEventHandler` and override the method `ApplicationStarting`. Example:

    public class CustomApplicationEventHandler : ApplicationEventHandler
    {
        protected override void ApplicationStarting(UmbracoApplicationBase umbracoApplication, ApplicationContext applicationContext)
        {
            DefaultRenderMvcControllerResolver.Current.SetDefaultControllerType(typeof(MyCustomUmbracoController));
            base.ApplicationStarting(umbracoApplication, applicationContext);
        }
    }
