### ASP.NET Core MVC (Content Managed website)

_This example is for creating a fully content managed website where URLs will be dynamic and be based on the same URLs generated in Umbraco. This also gives you the ability to Hijack routes for specific Document Types like in a normal Umbraco installation._

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
* You will need to add a view to be rendered (TODO: We need to optimize the NuGet install for the `UmbracoCms.Headless.Client.Web` package to do most of this for us)
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

* Create a new controller to hijack a route for a document type. For example, if your document type is called `Page`, then create a controller: `/Controllers/PageController.cs`
```cs
public class PageController : DefaultUmbracoController
{
    public PageController(UmbracoContext umbracoContext, HeadlessService headlessService) : base(umbracoContext, headlessService)
    {
    }

    public override Task<IActionResult> Index()
    {
        // get the content for the current route
        var content = UmbracoContext.GetContent();
        // map the ContentItem to a custom model called Page (which would inherit from ContentItem)
        var model  = HeadlessService.MapTo<Page>(content);
        // return the view which will be located at /Views/Page/Index.cshtml
        return Task.FromResult((IActionResult)View(model));
    }
}
```
* Then of course the Model of your view `/Views/Page/Index.cshtml` will need to be the custom `Page` model returned in your controller
