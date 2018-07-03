# Headless .NET client

### IMPORTANT

Before you start, you'll need to create a Headless project on Cloud which can be done by following the instructions at __[umbraco.com/headless](https://www.umbraco.com/headless)__. 

_Be aware that the Umbraco headless is still in beta._

## Setup/Installation

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

## Using the client

_Below are examples for various types of projects_

### [ASP.NET Core MVC (Static route website)](website-static.md)

_This example is for creating a statically routed website which means that it's a normal MVC application that defines it's own routes, like a brochure website. URLs will not be dynamic._

### [ASP.NET Core MVC (Content Managed website)](website-managed.md)

_This example is for creating a fully content managed website where URLs will be dynamic and be based on the same URLs generated in Umbraco. This also gives you the ability to Hijack routes for specific Document Types like in a normal Umbraco installation._

### [.NET Core Console Application](console.md)

_This example is for creating a .NET Core Console (command line) application_

### [ASP.NET Framework website](website-framework.md)

_This example shows how to build a traditional ASP.NET Framework website on Windows and Visual Studio using the Umbraco Headless Client._
