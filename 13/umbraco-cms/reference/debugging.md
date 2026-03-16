---
description: >-
  Information on SourceLink and how to use it to debug the Umbraco CMS source
  code
---

# Debugging with SourceLink

Microsoft and Visual Studio have introduced a new debugging technology called 'SourceLink' that enables source code debugging of certain .NET assemblies from NuGet. This feature has been enabled to allow developers to step into the native Umbraco CMS source code.

## Enabling SourceLink in Visual Studio 2017 & 2019

1. Navigate to **Tools** -> **Options** -> **Debugging** -> **General**.
2. In the **General** window, uncheck `Enable Just My Code` option and check `Enable Source Link support` option.
3.  Click **OK** to save the changes.

    ![Visual Studio 2019 Debug Settings for SourceLink](<../.gitbook/assets/VS19-enable-sourcelink (1).png>)

## What is SourceLink?

To read about SourceLink, you can take a look at the following websites:

* [Microsoft Docs](https://docs.microsoft.com/en-us/dotnet/standard/library-guidance/sourcelink)
* [Scott Hanselman blog post on Sourcelink](https://www.hanselman.com/blog/ExploringNETCoresSourceLinkSteppingIntoTheSourceCodeOfNuGetPackagesYouDontOwn.aspx)
* [SourceLink on GitHub](https://github.com/dotnet/sourcelink)

## Working with SourceLink

* Create a new `.NET 5.0` Framework blank/empty website.
* Install the latest Umbraco CMS 9.0+ Nuget Packages from Nuget.org
* Create an IComposer or similar code in your new site/SLN that you want to F11/Step Into. [Example Code Snippet to try with SourceLink](debugging.md#example-code-snippet-to-try-with-sourcelink)
* Prompt will appear and the original source code file is fetched directly from GitHub. ![Visual Studio 2019 SourceLink dialog](<../.gitbook/assets/VS19-sourcelink-prompt (1).png>)
* How far can you `F11`, also known as `Step Into`, and go down the rabbit hole of the Umbraco CMS source code?

### Example Code Snippet to try with SourceLink

```csharp
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.DependencyInjection;
using Umbraco.Cms.Core.Services;
using Umbraco.Extensions;

namespace WebApplication23;

public class MyComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.Components().Append<MyComponent>();
    }
}

public class MyComponent : IComponent
{
    private IContentService _contentService;

    public MyComponent(IContentService contentService)
    {
        _contentService = contentService;
    }

    public void Initialize()
    {
        // Add break point & F11 into me
        var root = _contentService.GetRootContent();

        foreach (var item in root)
        {
            // Add break point & F11 into me
            var udi = item.GetUdi();
            var foo = 5;
        }
    }

    public void Terminate()
    {
    }
}
```
