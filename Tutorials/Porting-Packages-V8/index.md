# Porting Umbraco V7 packages to work with V8
This is not a definitive guide for all scenarios and more of a working document and will evolve over time, especially whilst V8.0.0 is in development and things in this guide may change.

So you have a useful Umbraco package built for V7 and you would like to see it, work for V8?
Well then this guide, should give you a few pointers to get started with the process and is mostly geared towards solutions that use C#

## Upgrade .NET Framework
Upgrade your Visual Studio C# project to use and compile against the .NET Framework 4.7.2. This is because the minimum to run version 8 of Umbraco requires this specific version of the .NET Framework

## Add Nuget.config file to your solution
As Umbraco V8 is still in development and not been published to the official Nuget.org feed, then to allow you to easily add references to the Umbraco DLLs in your project.

Add the following `nuget.config` file to the root of your project, for Visual Studio to discover it

```xml
<?xml version="1.0" encoding="utf-8"?>
<configuration>
<!--
    this is Umbraco's NuGet configuration,
    content of this file is merged with the system-wide configuration,
    at %APPDATA%\NuGet\NuGet.config
-->
<packageSources>
    <add key="UmbracoCoreMyGet" value="https://www.myget.org/F/umbracocore/api/v3/index.json" />
    <add key="ExamineAppVeyor" value="https://ci.appveyor.com/nuget/examine-f73l6qv0oqfh/" />
</packageSources>
</configuration>
```

## Add references via Nuget
You will need to add `UmbracoCms.Core` via Nuget from the `UmbracoCoreMyGet` feed with the pre-release flag enabled.

Optionally add reference to `UmbracoCms.Web` if your code uses anything such as `UmbracoApiController` `SurfaceController` then you will need to add the Nuget package reference of `UmbracoCms.Web` which in turn has a reference to `UmbracoCms.Core`

## Try & build the solution
OK now the references have been updated, try and build the solution and then

## Fix up compile errors
As long as your Umbraco package was not using ancient APIs and using the new APIs & Services in Umbraco V7 then most of this step will be trying to determine what the new V8 namespace equivalent is.

### Handy tip
Clone down the Umbraco CMS source code and checkout the `temp8` branch and use this as a way to try and find that same method that the compiler is complaining about, in it's new namespace.

## Bye bye ApplicationEventHandler, Hello Composer & Components
The common thing that most package developers and Umbraco developers use in their projects is an `ApplicationEventHandler` to do some logic at the startup of Umbraco or to register event listeners based on Umbraco events such as ContentService.Saved etc.

In Umbraco version 8 this has been removed and replaced with Composer & Components.

### Old ApplicationEventHandler way

```csharp
using System.Linq;
using Umbraco.Core;
using Umbraco.Core.Events;
using Umbraco.Core.Models;
using Umbraco.Core.Services;
using Umbraco.Web.Routing;

namespace Umbraco.Web.UI
{
    public class RegisterEvents : ApplicationEventHandler
    {
        protected override void ApplicationStarting(UmbracoApplicationBase umbracoApplication, ApplicationContext applicationContext)
        {
            base.ApplicationStarting(umbracoApplication, applicationContext);
            ContentLastChanceFinderResolver.Current.SetFinder(new My404ContentFinder());
        }

        protected override void ApplicationStarted(UmbracoApplicationBase umbracoApplication, ApplicationContext applicationContext)
        {
            //Listen for when content is being saved
            ContentService.Saving += ContentService_Saving;
        }

        private void ContentService_Saving(IContentService sender, SaveEventArgs<IContent> e)
        {
            foreach (var content in e.SavedEntities
                //Check if the content item type has a specific alias
                .Where(c => c.ContentType.Alias.InvariantEquals("MyContentType"))
                //Check if it is a new item
                .Where(c => c.IsNewEntity()))
            {
                //check if the item has a property called 'richText'
                if (content.HasProperty("richText"))
                {
                    //get the rich text value
                    var val = c.GetValue("richText");

                    //if there is a rich text value, set a default value in a
                    // field called 'excerpt' that is the first
                    // 200 characters of the rich text value
                    c.SetValue("excerpt", val == null
                        ? string.Empty
                        : string.Join("", val.StripHtml().StripNewLines().Take(200)));
                }
            }
        }
    }
}
```


### New Composer & Component way

```csharp
using System.Linq;
using Umbraco.Core;
using Umbraco.Core.Components;
using Umbraco.Core.Events;
using Umbraco.Core.Models;
using Umbraco.Core.Services;
using Umbraco.Core.Services.Implement;

namespace MyProject.Components
{
    [RuntimeLevel(MinLevel = RuntimeLevel.Run)]
    public class MyComposer : IUserComposer
    {
        public void Compose(Composition composition)
        {
            composition.SetContentLastChanceFinder<My404ContentFinder>();

            composition.Components().Append<MyComponent>();
        }
    }

    public class MyComponent : IComponent
    {
        public void Initialize()
        {
            ContentService.Saving += this.ContentService_Saving;
        }

        public void Terminate()
        {
        }

        /// <summary>
        /// Listen for when content is being saved, check if it is a
        /// new item and fill in some default data.
        /// </summary>
        private void ContentService_Saving(IContentService sender, SaveEventArgs<IContent> e)
        {
            foreach (var content in e.SavedEntities
                //Check if the content item type has a specific alias
                .Where(c => c.ContentType.Alias.InvariantEquals("MyContentType"))
                //Check if it is a new item
                .Where(c => c.HasIdentity == false))
            {
                //check if the item has a property called 'richText'
                if (content.HasProperty("richText"))
                {
                    //get the rich text value
                    var val = content.GetValue<string>("richText");

                    //if there is a rich text value, set a default value in a
                    // field called 'excerpt' that is the first
                    // 200 characters of the rich text value
                    content.SetValue("excerpt", val == null
                        ? string.Empty
                        : string.Join(string.Empty, val.StripHtml().StripNewLines().Take(200)));
                }
            }
        }
    }
}
```


## Update package.xml for Umbraco ZIP packages
Currently the Umbraco packager in the backoffice is still undergoing changes (at the time of writing) and are unable to use the friendly packager UI in Umbraco.

As version 7 and version 8 of Umbraco has breaking changes in its APIs and code, its recommended to ship a different version of your package to support V8 only. So update the package.xml in your Umbraco package zip to have

## Optional - Update .nupkg dependencies
If you ship your package as a Nuget package, then you will need to add/update references to the `UmbracoCms.Core` or `UmbracoCms.Web` nupkg from the MyGet feed https://www.myget.org/F/umbracocore/api/v3/index.json

## Initial testing
Now you have updated and re-created a new package, it's time to test out your package be it via installing a local Umbraco ZIP package or installing it into a Website project via Nuget. You may have some final tweaking in relation to the UI as some parts of the Umbraco angular directives & components have changed slighlty, so this may require you to tweak some of your Angular views & Javascript accordingly so that it feels more at home in the Umbraco V8 backoffice.

## Got other suggestions
Then please edit this documentation on GitHub so the wider Umbraco Package Developer community can benefit from it :)
