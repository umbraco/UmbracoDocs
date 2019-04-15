---
versionFrom: 7.0.0
needsV8Update: "true"
---

# Using IoC with Umbraco

_This section will show you how to setup Ioc/Dependency Injection with your Umbraco installation. The examples will use Autofac but you can use whatever you want_ 

## Overview

We don't use IoC in the Umbraco source code. This isn't because we don't like it or don't want to use it; it's because we want you as a developer to be able to use whatever IoC framework that you would like to use without jumping through any hoops. With that said, it means it is possible to implement whatever IoC engine that you'd like!

## Implementation

In most IoC frameworks, you would setup your container in your global.asax class. To do that in Umbraco, you will need to inherit from our global.asax class called: `Umbraco.Web.UmbracoApplication`. You should then override the `OnApplicationStarted` method to build your container, and initialize any of the IoC stuff that you require.
Alternatively, you can implement the `Umbraco.Web.IApplicationEventHandler` interface.

## Autofac Example

This example will setup Autofac to work with Umbraco (see [their documentation](https://autofac.readthedocs.org/en/latest/) for full details). Our examples make use of the following NuGet packages: `Autofac`, `Autofac.Mvc5`, `Autofac.WebApi2`.

For this example, we're going to add a custom class to the IoC container as a Transient instance; here's the class:

```csharp
public class MyAwesomeContext
{
    public MyAwesomeContext()
    {
        MyId = Guid.NewGuid();
    }
    public Guid MyId { get; private set; }
}
```

Here's an example of a custom global.asax class which initializes the IoC container:

```csharp
/// <summary>
/// The global.asax class
/// </summary>

public class MyApplication : Umbraco.Web.UmbracoApplication
{
    protected override void OnApplicationStarted(object sender, EventArgs e)
    {
        base.OnApplicationStarted(sender, e);

        var builder = new ContainerBuilder();

        // register all controllers found in your assembly
        builder.RegisterControllers(typeof(MyApplication).Assembly);
        builder.RegisterApiControllers(typeof(MyApplication).Assembly);

        // register Umbraco MVC + web API controllers used by the admin site
        builder.RegisterControllers(typeof(UmbracoApplication).Assembly);
        builder.RegisterApiControllers(typeof(UmbracoApplication).Assembly);

        // add custom class to the container as Transient instance
        builder.RegisterType<MyAwesomeContext>();

        var container = builder.Build();
        DependencyResolver.SetResolver(new AutofacDependencyResolver(container));
        GlobalConfiguration.Configuration.DependencyResolver = new AutofacWebApiDependencyResolver(container);
    }
}
```

Do not forget to change the Application tag inside the global.asax file in the web root:

```csharp
<%@ Application CodeBehind="Global.asax.cs" Inherits="MyProject.MyNamespace.MyApplication" Language="C#" %>
```

If you like to use the `IApplicationEventHandler` alternative, here is an example for this approach:

```csharp
using Umbraco.Web;
public class MyApplication : IApplicationEventHandler
{
    public void OnApplicationStarted(
        UmbracoApplication httpApplication, Umbraco.Core.ApplicationContext applicationContext)
    {
        var builder = new ContainerBuilder();

        // register all controllers found in this assembly
        builder.RegisterControllers(typeof(MyApplication).Assembly);
        builder.RegisterApiControllers(typeof(MyApplication).Assembly);

        // register Umbraco MVC + web API controllers used by the admin site
        builder.RegisterControllers(typeof(UmbracoApplication).Assembly);
        builder.RegisterApiControllers(typeof(UmbracoApplication).Assembly);

        // add custom class to the container as Transient instance
        builder.RegisterType<MyAwesomeContext>();

        var container = builder.Build();
        DependencyResolver.SetResolver(new AutofacDependencyResolver(container));
        GlobalConfiguration.Configuration.DependencyResolver = new AutofacWebApiDependencyResolver(container);
    }

    public void OnApplicationInitialized(UmbracoApplication httpApplication, Umbraco.Core.ApplicationContext applicationContext)
    {
    }

    public void OnApplicationStarting(UmbracoApplication httpApplication, Umbraco.Core.ApplicationContext applicationContext)
    {
    }
}
```

In this example, we will assume that we have a Document Type called 'Home'. Now we're going to create a custom controller to hijack a route for all content pages of type Home.

:::note
we can target custom template names too - see the [Hijacking routes](routing/custom-controllers) documentation for full details)
:::

Notice that the constructor accepts a parameter the custom class; this will be injected via IoC.

```csharp
public class HomeController : RenderMvcController
{
    private readonly MyAwesomeContext _myAwesome;

    public HomeController(MyAwesomeContext myAwesome)
    {
        _myAwesome = myAwesome;
    }

    public override ActionResult Index(Umbraco.Web.Models.RenderModel model)
    {
        // get the current template name
        var template = this.ControllerContext.RouteData.Values["action"].ToString();
        // return the view with the model as the id of the custom class
        return View(template, _myAwesome.MyId);
    }
}
```

As another example, you can do the same with SurfaceControllers. Here we are creating a locally declared SurfaceController that has a Child Action, and again, just like the previous controller, it will have a new instance of the custom class injected:

```csharp
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
```

## What assemblies and controllers do I need to register?

You need to register all assemblies that may contain MVC or WebApi controllers. In Umbraco this is the `umbraco` assembly which you can get a direct assembly reference to using the example syntax used above:

```csharp
typeof(UmbracoApplication).Assembly
```

If you don't register assemblies that contain controllers, you may end up with YSOD errors. If you do not register a controller, then ASP.NET will try to create the controller, but if it doesn't have an empty constructor, you'll get a YSOD.

## Things to note

We use a custom MVC controller builder in our code called `Umbraco.Web.Mvc.MasterControllerFactory`, which needs to always be the default controller factory; if you change this, Umbraco will probably not work anymore. The good news is that you can specify 'slave' factories so you can specify custom controller factories for different purposes. You would just need to create a new class that inherits from `Umbraco.Web.Mvc.IFilteredControllerFactory` and ensure that the class is public (so it can be found). If your IoC implementation affects the default controller factory, you may have to modify it in order to support this implementation. For the most part, most IoC frameworks will just target setting a custom DependencyResolver which is 100% ok.

## Unity Example

Install the Unity, Unity.Mvc and Unity.AspNet.WebApi packages.
Remove the Mvc and Api specific files created; we will be merging those files shortly.
Leave the UnityConfig file as is.

Now create the following files to configure Unity correctly for an Umbraco site.

```csharp
class UnityEvents : IApplicationEventHandler
{
    public void OnApplicationStarted(
        UmbracoApplicationBase httpApplication,
        ApplicationContext applicationContext
    )
    {
        var container = UnityConfig.GetConfiguredContainer();

        // Web API
        GlobalConfiguration.Configuration.DependencyResolver 
            = new Microsoft.Practices.Unity.WebApi.UnityDependencyResolver(container);
        // MVC
        DependencyResolver.SetResolver(new Microsoft.Practices.Unity.Mvc.UnityDependencyResolver(container));

        // This will automatically scan an assembly for classes fitting this convention:
        // Interface name: IMyClass
        // Class name: MyClass
        // and automatically register those types for you.
        // If you do decide to use this feature, make sure it is the first one called.
        // Conflicting registrations that follow will override previous ones.
        container.RegisterTypes(
            AllClasses.FromAssemblies(typeof(UnityEvents).Assembly),
            WithMappings.FromMatchingInterface,
            WithName.Default
        );

        // The UmbracoContext must be registered so that the Umbraco backoffice controllers 
        // can be successfully resolved.
        container.RegisterType<UmbracoContext>(
            new PerRequestLifetimeManager(), 
            new InjectionFactory(c => UmbracoContext.Current)
        );

        // Unity by default chooses the constructor with the most amount of arguments.
        // In the case of the LegacyTreeController, this means we must instruct Unity instead to
        // use the default constructor by passing in a parameterless InjectionConstructor during registration.
        container.RegisterType<LegacyTreeController>(new InjectionConstructor());
    }

    public void OnApplicationInitialized(UmbracoApplicationBase httpApplication, ApplicationContext applicationContext) { }

    public void OnApplicationStarting(UmbracoApplicationBase httpApplication, ApplicationContext applicationContext) { }
}
```

And here is the merged UnityActivator:

```csharp
[assembly: WebActivatorEx.PreApplicationStartMethod(typeof(UnityActivator), "Start")]
[assembly: WebActivatorEx.ApplicationShutdownMethod(typeof(UnityActivator), "Shutdown")]

/// <summary>Provides the bootstrapping for integrating Unity when it is hosted in ASP.NET.</summary>
public static class UnityActivator
{
    /// <summary>Integrates Unity when the application starts.</summary>
    public static void Start()
    {
        // This is required if you intend to follow the example above and use the PerRequestLifetimeManager.
        // If you are developing a library using umbracoCms.Core and Unity, 
        // you might want to reconsider depending on this module.
        // If the library consumers also use Unity, they might also register the per request http module, 
        // bloating the request pipeline with multiple modules performing similar tasks.
        Microsoft.Web.Infrastructure.DynamicModuleHelper.DynamicModuleUtility.RegisterModule(typeof(UnityPerRequestHttpModule));
    }

    /// <summary>Disposes the Unity container when the application is shut down.</summary>
    public static void Shutdown()
    {
        var container = UnityConfig.GetConfiguredContainer();
        container.Dispose();
    }
}
```
