### ASP.NET Core MVC (Static route website)

_This example is for creating a staticly routed website which means that it's a normal MVC application that defines it's own routes, like a broshure website. URLs will not be dynamic._

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