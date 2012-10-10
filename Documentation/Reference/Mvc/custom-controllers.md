#Custom controllers (Hijacking Umbraco Routes)

**Applies to: Umbraco 4.10.0+**

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
