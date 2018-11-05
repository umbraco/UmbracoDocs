### ASP.NET Framework website

_This example shows how to build a traditional ASP.NET Framework website on Windows and Visual Studio using the Umbraco Headless Client._

* Create new VS "Web Application .NET Framework" project
* Ensure that the target .NET Framework is at least .NET 4.6.1
* Choose "MVC" for the template
* Install the package, using the "Package Manager Console" enter `Install-Package UmbracoCms.Headless.Client -Source https://www.myget.org/F/uaas/api/v3/index.json -Pre`
   * If you need to update to the latest execute this command: `Update-Package UmbracoCms.Headless.Client -Source https://www.myget.org/F/uaas/api/v3/index.json -Pre`
* Add the following keys to the web.config in `appSettings`
    ```xml
    <add key="umbracoHeadless:url" value="https://YOUR-PROJECT-URL.s1.umbraco.io" />
    <add key="umbracoHeadless:username" value="YOUR@USERNAME.com" />
    <add key="umbracoHeadless:password" value="YOUR-PASSWORD" />
    ```

#### Quick start

At this stage the client is installed and you have a working website. So now we can start using the `PublishedContentService`. There are several ways that you can use the `PublishedContentService` and in many cases you will be using IoC/Dependency Injection (_recommended_) however for this demo, we will manage our own singleton for brevity.

* Create a Singleton class:
    ```cs
    public class HeadlessClient
    {
        public static PublishedContentService Instance { get; } = new PublishedContentService(ConfigurationManager.AppSettings["umbracoHeadless:url"]);
    }
    ```
* Modify the `HomeController`, add a new action:
    ```cs
    public async Task<ActionResult> Headless()
    {
        // Get all content by ContentType
        var content = await HeadlessClient.Instance.GetAll("contentTypeAlias");
        return View(content);
    }
    ```
* Create a view at `/Views/Home/Headless.cshtml`:
    ```
    @model IEnumerable<ContentItem>
    @using Umbraco.Headless.Client.Net.Models

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
