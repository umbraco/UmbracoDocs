### .NET Core Console Application

_This example is for creating a .NET Core Console (command line) application_

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

The Headless client APIs are async but because a console app is non-async by nature, the above example uses `.Result` to block the operation until complete. It is possible to have a proper async console app, you just have to create an async method to run your operations. [An example can be found here](https://stackoverflow.com/a/17630538/694494).

The above example is in it's simplest form, if you wish to use DI, logging, async, config files, etc... here is an example of how to do that:

```cs
static void Main(string[] args)
{
    var builder = new ConfigurationBuilder()
        .SetBasePath(Directory.GetCurrentDirectory())
        .AddJsonFile("appsettings.json", optional: true, reloadOnChange: true);

    var configuration = builder.Build();

    //setup a container
    var services = new ServiceCollection()
        .AddLogging(config => config.AddConsole().SetMinimumLevel(LogLevel.Debug))
        //include the umbraco headless services and pass in the config instance
        .AddUmbracoHeadlessClient(configuration)
        .BuildServiceProvider();

    var logger = services.GetRequiredService<ILogger<Program>>();
    var client = services.GetRequiredService<HeadlessService>();
    var getAllResult = client.Query().GetAll().Result.ToList();
    logger.LogDebug($"GetAll query returned {getAllResult.Count}");

    (services as IDisposable)?.Dispose();
}
```