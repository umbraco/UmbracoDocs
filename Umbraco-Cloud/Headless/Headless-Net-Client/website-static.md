### ASP.NET Core MVC (Static route website)

_This example is for creating a statically routed website which means that it's a normal MVC application that defines it's own routes, like a brochure website. URLs will not be dynamic._

#### Setup, bootstrap & launch

The Headless client nuget package is hosted on a custom MyGet feed, so you need to create a `NuGet.config` file for your project which can be done via the command line. If you don't do this then you would need to use the `--source` parameter and a few other tricks so it's just simpler to use a `Nuget.config` file. 

So __before__ you run any script for creating a project, you will need to do this in the new folder where you are creating your project:

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
Now to create a new .NET Core website and add references:
   * _(Ensure you've created the `Nuget.config`, see above)_
   * `dotnet new mvc`
   * `dotnet add package UmbracoCms.Headless.Client -v 0.9.7-*`   
   * `dotnet add package UmbracoCms.Headless.Client.Web -v 0.9.7-*`  
      * _NOTE: You use this same command to update to the latest version_
* Add a config file
    * use the standard .NET Core naming conventions: `appsettings.json`
    * this needs to contain the `umbracoHeadless` section:
        ```json
        {
            "umbracoHeadless": {
                "url": "https://YOUR-PROJECT-URL.s1.umbraco.io",
                "username": "YOUR@USERNAME.com",
                "password": "YOUR-PASSWORD",
                "imageBaseUrl": "https://YOUR-PROJECT-URL.s1.umbraco.io",
                "restApiVersion": "1.0.0"
            }
        }
        ```
* You need to bootstrap the headless client which is done in your `Startup.cs` file:
   * Add `using Umbraco.Headless.Client.Net.Web;`.
   * In `ConfigureServices` add the headless client services: `services.AddUmbracoHeadlessClient(Configuration);`
* Now run the project
   * `dotnet run`
      * _If you want to launch in debug mode, set the environment variable in the current cmd window before running this command: `set ASPNETCORE_ENVIRONMENT=Development`_

Now you can have the `Umbraco.Headless.Client.Net.Services.PublishedContentService` injected into any of your controllers, services, etc. The `Umbraco.Headless.Client.Net.Services.PublishedContentService` is the starting point for all headless operations.

You can also inject the `PublishedContentService` or `IHeadlessConfig` into any view by using this syntax:
```
@using Umbraco.Headless.Client.Net.Web.Configuration
@using Umbraco.Headless.Client.Net.Services

@inject IHeadlessConfiguration HeadlessConfig
@inject PublishedContentService PublishedContentService
```

#### Example usage

* Add `using Umbraco.Headless.Client.Net.Services;` to the `HomeController`
* Inject the `PublishedContentService` into the `HomeController` and store a reference:
   ```cs
    public HomeController(PublishedContentService PublishedContentService)
    {
        this._publishedContentService = PublishedContentService;
    }
    private readonly PublishedContentService _publishedContentService;
   ```
* Create a new controller Action:
    ```cs
    public async Task<IActionResult> Headless()
    {
        // Get content by ContentType
        var content = await _publishedContentService.GetAll("contentTypeAlias");
        return View(content);
    }
    ```
* Create a view at `/Views/Home/Headless.cshtml`:
    ```
    @model IEnumerable<ContentItem>
    @using Umbraco.Headless.Client.Net.Models

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
