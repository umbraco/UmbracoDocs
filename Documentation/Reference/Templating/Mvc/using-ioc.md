#Using IoC with MVC in Umbraco

**Applies to: Umbraco 4.10.0+**

_This section will show you how to setup Ioc/Dependency Injection with your Umbraco installation for MVC. The examples will use Autofac but you can use whatever you want_ 

##Overview

We don't use IoC in the Umbraco source code whatsoever. This isn't because we don't like it or don't want to use it, it's because we want you as a developer to be able to use whatever IoC framework that you would like to use without jumping through any hoops. With that said, it means it is possible to implement whatever IoC engine that you'd like!

##Implementation

In most IoC frameworks you would setup your container in your global.asax class. To do that in Umbraco, you will need to inherit from our global.asax class called: `Umbraco.Web.UmbracoApplication`. You should then override the `OnApplicationStarted` method to build your container and initialize any of the IoC stuff that you require.
Alternatively you can implement the `Umbraco.Web.IApplicationEventHandler` interface.

##Example

This example will setup Autofac to work with Umbraco (see [their documentation](http://autofac.readthedocs.org/en/latest/) for full details)

For this example we're going to add a custom class to the IoC container as a Transient instance, here's the class:

	public class MyAwesomeContext
	{
		public MyAwesomeContext()
		{
			MyId = Guid.NewGuid();
		}
		public Guid MyId { get; private set; }
	}

Here's an example of a custom global.asax class which initializes the IoC container:

	/// <summary>
	/// The global.asax class
	/// </summary>
	
	public class MyApplication : Umbraco.Web.UmbracoApplication
	{
		protected override void OnApplicationStarted(object sender, EventArgs e)
		{
			base.OnApplicationStarted(sender, e);

			var builder = new ContainerBuilder();

			//register all controllers found in this assembly
			builder.RegisterControllers(typeof(MyApplication).Assembly);

			//add custom class to the container as Transient instance
			builder.RegisterType<MyAwesomeContext>();

			var container = builder.Build();
			DependencyResolver.SetResolver(new AutofacDependencyResolver(container));
		}
	}

*(NOTE: do not forget to change the inherits clause of the global.asax file in the web root.)*

If you like to use the `IApplicationEventHandler` alternative - here is an example for this approach:
	
	using Umbraco.Web;
	public class MyApplication : IApplicationEventHandler
	{
		public void OnApplicationStarted(
			UmbracoApplication httpApplication, Umbraco.Core.ApplicationContext applicationContext)
		{
			var builder = new ContainerBuilder();
		
			//register all controllers found in this assembly
			builder.RegisterControllers(typeof(MyApplication).Assembly);

			//add custom class to the container as Transient instance
			builder.RegisterType<MyAwesomeContext>();

			var container = builder.Build();
			DependencyResolver.SetResolver(new AutofacDependencyResolver(container));
		}

		public void OnApplicationInitialized(UmbracoApplication httpApplication, Umbraco.Core.ApplicationContext applicationContext)
		{
		}

		public void OnApplicationStarting(UmbracoApplication httpApplication, Umbraco.Core.ApplicationContext applicationContext)
		{
		}
	}

In this example we will assume that we have a Document Type called 'Home' Now we're going to create a custom controller to hijack a route for all content pages of type Home *(NOTE: we can target custom template names too, see the [Hijacking routes](custom-controllers.md) documentation for full details).* Notice that the constructor accepts a parameter the custom class, this will be injected via IoC.

	public class HomeController : RenderMvcController
	{
		private readonly MyAwesomeContext _myAwesome;

		public HomeController(MyAwesomeContext myAwesome)
		{
			_myAwesome = myAwesome;
		}

		public override ActionResult Index(Umbraco.Web.Models.RenderModel model)
		{
			//get the current template name
			var template = this.ControllerContext.RouteData.Values["action"].ToString();
			//return the view with the model as the id of the custom class
			return View(template, _myAwesome.MyId);
		}
	}

As another example, you can do the same with SurfaceControllers. Here we are creating a locally declared SurfaceController that has a Child Action and again just like the previous controller it will have a new instance of the custom class injected:

	public class MyTestSurfaceController : SurfaceController
	{
		private readonly MyAwesomeContext _myAwesome;

		public MyTestSurfaceController(MyAwesomeContext myAwesome)
		{
			_myAwesome = myAwesome;
		}

		[ChildActionOnly]
		public ActionResult HelloWorld()
		{
			return Content("Hello World! Here is my id " + _myAwesome.MyId);
		}
	}


##Things to note

We use a custom MVC controller builder in our code called `Umbraco.Web.Mvc.MasterControllerFactory`, which needs to always be the default controller factory, if you change this Umbraco will probably not work anymore. The good news is that you can specify 'slave' factories so you can specify custom controller factories for different purposes. You would just need to create a new class that inherits from `Umbraco.Web.Mvc.IFilteredControllerFactory` and ensure that the class is public (so it can be found). If your IoC implementation affects the default controller factory, you may have to modify it in order to support this implementation. For the most part, most IoC frameworks will just target setting a custom DependencyResolver which is 100% ok.
