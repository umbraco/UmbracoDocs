# Headless .NET client

### IMPORTANT

For all projects, you'll need to create a Headless project on Cloud. Go to __[https://www.s1.umbraco.io/projects?sku=headless]()__ and select create project, select Starter plan.

## Setup/Installation

The Headless client nuget package is hosted on a custom MyGet feed, so you need to create a `Nuget.config` file for your project which can be done via the command line. If you don't do this then you would need to use the `--source` parameter and a few other tricks so it's just simpler to use a `Nuget.config` file. 

So __before__ you run any script for creating a project below, you will need to do this in the new folder that you will create your project (`sln` file):

* `dotnet new nugetconfig`
* Edit the `Nuget.config` file, remove the `<clear/>` and add our custom source, it should look like this:
    ```xml
    <?xml version="1.0" encoding="utf-8"?>
    <configuration>
        <packageSources>
            <add key="umbracoMyGet" 
                 value="https://www.myget.org/F/uaas/api/v3/index.json" 
                 protocolVersion="3" />
        </packageSources>
    </configuration>
    ```

## Using the client

_Here are examples for various types of projects_

### ASP.NET Core MVC - Static route website

_A static route website simply means that it's a normal MVC application that defines it's own routes, like a broshure website. URLs will not be dynamic._

#### Setup, bootstrap & launch

* Go to a new folder to create a new .NET Core website and add references:
   * _(Ensure you've created the `Nuget.config`, see above)_
   * `dotnet new mvc`
   * `dotnet add package UmbracoCms.Headless.Client -v 0.9.0-*`   
      * _NOTE: You use this same command to update to the latest version_
* Add a config file
    * use the standard .NET Core naming conventions: `appsettings.json`
    * this needs to contain the `umbracoHeadless` section:
        ```json
        {
            "umbracoHeadless": {
                "url": "https://YOUR-PROJECT-URL.s1.umbraco.io",
                "username": "YOUR@USERNAME.com",
                "password": "YOUR-PASSWORD"
            }
        }
        ```
* You need to bootstrap the headless client which is done in your `Startup.cs` file:
   * In `ConfigureServices` add the headless client services: `services.AddUmbracoHeadlessClient(Configuration);`
* Now run the project
   * `dotnet run`
      * _If you want to launch in debug mode, set the environment variable in the current cmd window before running this command: `set ASPNETCORE_ENVIRONMENT=Development`_

Now you can have the `Umbraco.Headless.Client.Services.HeadlessService` injected into any of your controllers, services, etc... The `Umbraco.Headless.Client.Services.HeadlessService` is the starting point for all headless operations.

You can also inject the `HeadlessService` or `IHeadlessConfig` into any view by using this syntax:
```
@using Umbraco.Headless.Client.Configuration
@using Umbraco.Headless.Client.Services

@inject IHeadlessConfiguration HeadlessConfig
@inject HeadlessService HeadlessService
```

#### Example usage

* Add `using Umbraco.Headless.Client.Services;` to the `HomeController`
* Inject the `HeadlessService` into the `HomeController` ctor and store a reference:
   ```cs
    public HomeController(HeadlessService headlessService)
    {
        this._headlessService = headlessService;
    }
    private readonly HeadlessService _headlessService;
   ```
* Create a new controller Action:
    ```cs
    public async Task<IActionResult> Headless()
    {
        //Get all content
        var allContent = await _headlessService.Query().GetAll();
        return View(allContent);
    }
    ```
* Create a view at `/Views/Home/Headless.cshtml`:
    ```
    @model IEnumerable<ContentItem>
    @using Umbraco.Headless.Client.Models

    @{
        ViewData["Title"] = "Headless test";
    }
    <h2>@ViewData["Title"]</h2>

    <p>This will list the names of all content items in your Umbraco headless CMS</p>

    <ul>
    @foreach(var item in Model) {
        <li>@item.Id - @item.Name</li>
    }
    </ul>
    ```
* Start the site: `dotnet run` and navigate to [http://localhost:5000/home/headless]()

### ASP.NET Core MVC - Content Managed Website

_This example means that URLs will be dynamic and be based on the same URLs generated in Umbraco._


#### Setup, bootstrap & launch

* Go to a new folder to create a new .NET Core website and add references:
   * _(Ensure you've created the `Nuget.config`, see above)_
   * `dotnet new mvc`
   * `dotnet add package UmbracoCms.Headless.Client -v 0.9.0-*`   
      * _NOTE: You use this same command to update to the latest version_
   * `dotnet add package UmbracoCms.Headless.Client.Web -v 0.9.0-*`   
* Add a config file
    * use the standard .NET Core naming conventions: `appsettings.json`
    * this needs to contain the `umbracoHeadless` section:
        ```json
        {
            "umbracoHeadless": {
                "url": "https://YOUR-PROJECT-URL.s1.umbraco.io",
                "username": "YOUR@USERNAME.com",
                "password": "YOUR-PASSWORD"
            }
        }
        ```
* You need to bootstrap the headless client which is done in your `Startup.cs` file:
   * In `ConfigureServices` add the headless client services: `services.AddUmbracoHeadlessClient(Configuration);`
   * In `ConfigureServices` add the headless web routing engine: `services.AddUmbracoHeadlessWebEngine();`
   * In `Configure` replace the `UseMvc` block with `app.UseUmbracoHeadlessWebEngine();` (or you can just put this line above the existing `UseMvc` block)
* You will need to add a view to be rendered (TODO: We need to optimize the Nuget install for the `UmbracoCms.Headless.Client.Web` package to do most of this for us)
   * Add a view file for the path `/Views/DefaultUmbraco/Index.cshtml`
   ```
    @using Umbraco.Headless.Client.Models
    @model ContentItem

    @{
        ViewData["Title"] = Model.Name;
    }

    <h2>@Model.Name</h2>

    <h3>Properties</h3>
    <ul>
        @foreach (var p in Model.Properties.Properties)
        {
            <li>@p.Alias = @p.Value</li>
        }
    </ul>
   ```
* Now run the project - the view above will be rendered and show the page name and property values for the content item matching the URL
   * `dotnet run`
      * _If you want to launch in debug mode, set the environment variable in the current cmd window before running this command: `set ASPNETCORE_ENVIRONMENT=Development`_

Now you can have the `Umbraco.Headless.Client.Services.HeadlessService` injected into any of your controllers, services, etc... The `Umbraco.Headless.Client.Services.HeadlessService` is the starting point for all headless operations.

You can also inject the `HeadlessService` or `IHeadlessConfig` into any view by using this syntax:
```
@using Umbraco.Headless.Client.Configuration
@using Umbraco.Headless.Client.Services

@inject IHeadlessConfiguration HeadlessConfig
@inject HeadlessService HeadlessService
```

#### Example usage

##### Navigation

* To make a dynamic navigation system, create a view at `/Views/Shared/HeaderNav.cshtml`
```
@using Umbraco.Headless.Client.Services
@model Umbraco.Headless.Client.Models.ContentItem
@inject HeadlessService HeadlessService

<nav class="navbar navbar-inverse navbar-fixed-top">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a href="" class="navbar-brand">HeadlessClientTest5</a>
        </div>
        <div class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
                <li><a href="@Model.Url">Home</a></li>
                @foreach (var child in await HeadlessService.GetChildren(Model))
                {
                    <li><a href="@child.Url">@child.Name</a></li>
                }
            </ul>
        </div>
    </div>
</nav>
```
* In the `/Views/Shared/_Layout.cshtml` file, we will fetch the `Site` node for the current content item:
```
@using Umbraco.Headless.Client.Models
@using Umbraco.Headless.Client.Services
@model Umbraco.Headless.Client.Models.ContentItem
@inject HeadlessService HeadlessService

@{
    var site = await HeadlessService.GetSite(Model);
}
```
* Replace the navigation structure in the `/Views/Shared/_Layout.cshtml` file and render the navigation partial view created above. (_The nav structure element to replace is this one `<nav class="navbar navbar-inverse navbar-fixed-top">`_)
```
@Html.Partial("HeaderNav", site)
```
* Start the site: `dotnet run` and navigate to [http://localhost:5000/]() and you'll see that your menu structure is dynamic based on your Umbraco content nodes. If you click on them, the engine will render the content item associated with that URL.

##### Hijacking routes

Just like in Umbraco, with this engine you can hijack routes! 

* Create a new controller to hijack a route for a document type. For example, if you document type is called `Page`, then create a controller: `/Controllers/PageController.cs`
```cs
public class PageController : DefaultUmbracoController
{
    public PageController(UmbracoContext umbracoContext, HeadlessService headlessService) : base(umbracoContext, headlessService)
    {
    }

    public override Task<IActionResult> Index()
    {
        //get the content for the current route
        var content = UmbracoContext.GetContent();
        //map the ContentItem to a custom model called Page (which would inherit from ContentItem)
        var model  = HeadlessService.MapTo<Page>(content);
        //return the view which will be located at /Views/Page/Index.cshtml
        return Task.FromResult((IActionResult)View(model));
    }
}
```
* The of course the Model of your view `/Views/Page/Index.cshtml` will need to be the custom `Page` model returned in your controller

### .NET Core Console

* Go to a new folder to create a new .NET Core website and add references:
   * _(Ensure you've created the `Nuget.config`, see above)_
   * `dotnet new console`
   * `dotnet add package UmbracoCms.Headless.Client -v 0.9.0-*`
      * _NOTE: You use this same command to update to the latest version_
* Update the `Program.cs` file to use the Headless client:
   * Add the required `using` to the file:
   ```cs
    using Umbraco.Headless.Client.Services;
    using Umbraco.Headless.Client.Configuration;
   ```
   * Create an instance of the `HeadlessService` and pass in the endpoint and credentials:
   ```cs
   var headlessService = new HeadlessService(
                new HeadlessConfiguration(
                    "https://YOUR-PROJECT-URL.s1.umbraco.io",
                    "YOUR@USERNAME.com",
                    "YOUR-PASSWORD"));
   ```
   * Start using the `HeadlessService`:
   ```cs
    //get all all content and list their names
    var allContent = headlessService.Query().GetAll().Result;
    foreach(var item in allContent) {
        Console.WriteLine($"{item.Id} - {item.Name}");
    }
   ```
* Now run the project
   * `dotnet run`

#### Console app notes

The Headless client APIs are async but since a console app is non-async by nature, the above example uses `.Result` to block the operation until complete. It is possible to have a proper async console app, you just have to create an async method to run your operations. An example can be found in this repository's source code console application.

The above example is in it's simplest form, if you wish to use DI, logging, async, config files, etc... this is all possible, have a look at the example console app in this repository's source code.

### ASP.NET Framework website

_To build a traditional ASP.NET Framework website on Windows and Visual Studio using the Umbraco Headless Client_

* Create new VS "Web Application .NET Framework" project
* Choose "MVC" for the template
* Ensure that the target .NET Framework is at least .NET 4.6.1
* Install the package, using the "Package Manager Console" enter `Install-Package UmbracoCms.Headless.Client -Source https://www.myget.org/F/uaas/api/v3/index.json -Pre`
   * If you need to update to the latest execute this command: `Update-Package UmbracoCms.Headless.Client -Source https://www.myget.org/F/uaas/api/v3/index.json -Pre`
* Add the following keys to the web.config in `appSettings`
    ```xml
    <add key="umbracoHeadless:url" value="https://YOUR-PROJECT-URL.s1.umbraco.io" />
    <add key="umbracoHeadless:username" value="YOUR@USERNAME.com" />
    <add key="umbracoHeadless:password" value="YOUR-PASSWORD" />
    ```

#### Quick start

At this stage the client is installed and you have a working website. So now we can start using the `HeadlessService`. There are several ways that you can use the `HeadlessService` and in many cases you will be using IoC/Dependency Injection (_recommended_) however for this demo, we will manage our own singleton for brevity.

* Create a Singleton class:
    ```cs
    public class HeadlessClient
    {
        public static HeadlessService Instance { get; } = new HeadlessService();
    }
    ```
* Modify the `HomeController`, add a new action:
    ```cs
    public async Task<ActionResult> Headless()
    {
        //Get all content
        var allContent = await HeadlessClient.Instance.Query().GetAll();
        return View(allContent);
    }
    ```
* Create a view at `/Views/Home/Headless.cshtml`:
    ```
    @model IEnumerable<ContentItem>
    @using Umbraco.Headless.Client.Models

    @{
        ViewBag.Title = "Headless test";
    }
    <h2>@ViewBag.Title.</h2>

    <p>This will list the names of all content items in your Umbraco headless CMS</p>

    <ul>
        @foreach(var item in Model) {
            <li>@item.Id - @item.Name</li>
        }
    </ul>
    ```
* Run the app (ctrl + F5) and navigate to the path `/home/headless`