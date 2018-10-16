### .NET Core Console Application

The Headless client nuget package is hosted on a custom MyGet feed, so you need to create a `NuGet.config` file for your project which can be done via the command line. If you don't do this then you would need to use the `--source` parameter and a few other tricks so it's just simpler to use a `Nuget.config` file. 

So __before__ you run any script for creating a project, you will need to do this in the new folder where you are creating your project (`sln` file):

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
_This example is for creating a .NET Core Console (command line) application_

* Creating a .NET Core website and adding references:
   * _(Ensure you've created the `Nuget.config`, see above)_
   * `dotnet new console`
   * `dotnet add package UmbracoCms.Headless.Client -v 0.9.7-*`
      * _NOTE: You use this same command to update to the latest version_
* Update the `Program.cs` file to use the Headless client:
   * Add the required `using` to the file:
   ```cs
    using Umbraco.Headless.Client.Net.Services;
   ```
   * Create an instance of the `PublishedContentService` and pass in the endpoint and credentials:
   ```cs
   var publishedContentService = new PublishedContentService(
                    "https://YOUR-PROJECT-URL.s1.umbraco.io",
                    "YOUR@USERNAME.com",
                    "YOUR-PASSWORD");
   ```
   * Start using the `PublishedContentService`:
   ```cs
    // get content by ContentType and list their names
    var content = publishedContentService.GetAll("contentTypeAlias").Result;
    foreach(var item in content) {
        Console.WriteLine($"{item.Id} - {item.Name}");
    }
   ```
* At this point your Program.cs file  will look like this:
    ```cs
    using System;
    using Umbraco.Headless.Client.Net.Services;

    namespace MyAwesomeHeadlessProject
    {
        class Program
        {
            static void Main(string[] args)
            {
                var publishedContentService = new PublishedContentService(
                    "https://YOUR-PROJECT-URL.s1.umbraco.io",
                    "YOUR@USERNAME.com",
                    "YOUR-PASSWORD");            
                
                // get content by ContentType and list their names
                var content = publishedContentService.GetAll("contentTypeAlias").Result;
                foreach(var item in content) {
                    Console.WriteLine($"{item.Id} - {item.Name}");
                }
            }  
        }
    }

    ```

* Now run the project
   * `dotnet run`
* You will get an output like this:
    ![Console output](images/Console-output.png)

### Console app notes

The Headless client APIs are async but because a console app is non-async by nature, the above example uses `.Result` to block the operation until complete. It is possible to have a proper async console app, you just have to create an async method to run your operations. [An example can be found here](https://stackoverflow.com/a/17630538/694494).

The above example is in its simplest form, if you wish to use DI, logging, async, config files, etc... here is an example of how to do that:
:::note
You will need to install some additional packages for this to work, for example the Headless WebClient:
`dotnet add package UmbracoCms.Headless.Client.Web -v 0.9.7-*`
:::

First of all, make sure you also set the configuration in an appsettings.json file to the following:

```json
{
    "umbracoHeadless": {
        "url": "https://YOUR-PROJECT-ALIAS.s1.umbraco.io",
        "username": "CLOUD@EMAIL.COM",
        "password": "CLOUDPASSWORD",
        "imageBaseUrl": "https://YOUR-PROJECT-ALIAS.s1.umbraco.io",
        "restApiVersion": "1.0.0"
    }
}
```

Now you can update the `Program.cs` file:

```cs
using System;
using Umbraco.Headless.Client.Net.Services;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using System.IO;
using Umbraco.Headless.Client.Net.Web;

namespace MyAwesomeHeadlessProject
{
    class Program
    {
        static void Main(string[] args)
        {
            var builder = new ConfigurationBuilder()
                .SetBasePath(Directory.GetCurrentDirectory())
                .AddJsonFile("appsettings.json", optional: true, reloadOnChange: true);

            var configuration = builder.Build();

            // setup a container
            var services = new ServiceCollection()
                .AddLogging(config => config.AddConsole().SetMinimumLevel(LogLevel.Debug))
                
                // include the Umbraco headless services and pass in the config instance
                .AddUmbracoHeadlessClient(configuration)
                .BuildServiceProvider();

            var logger = services.GetRequiredService<ILogger<Program>>();
            var client = services.GetRequiredService<PublishedContentService>();
            // get all all content and list their names
            var allContent = client.GetAll("testpage").Result;
            foreach(var item in allContent) {
                logger.LogDebug($"{item.Id} - {item.Name}");
            }

            (services as IDisposable)?.Dispose();
        }
    
    }
}

```
