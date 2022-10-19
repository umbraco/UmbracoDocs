---
versionFrom: 8.0.0
product: "CMS"
complexity: "Intermediate"
audience: "Package developers"
meta.Title: "How to port packages from Umbraco v7 to Umbraco v8"
meta.Description: "This guide will tell you how you can turn your Umbraco v7 package into an Umbraco v8 package"
---
# Porting packages to V8

This is not a definitive guide for all scenarios but more of a working document which will evolve over time, especially as Umbraco 8 matures. Due to this, please keep in mind that things in this guide may change.

You have a useful Umbraco package built for Umbraco 7 and you would like to see it work for Umbraco 8?
This guide should give you a few pointers to get you started with the process and is mostly geared towards solutions that use C#.

## Upgrade .NET Framework

Upgrade your Visual Studio C# project to use and compile against the .NET Framework 4.7.2. This is because the minimum .NET Framework to run version 8 of Umbraco requires this specific version.

## Add references via Nuget

You will need to add `UmbracoCms.Core` via Nuget using the UI in Visual Studio or the Nuget Command Line with the following command

```shell
Install-Package UmbracoCms.Core
```

Optionally add a reference to `UmbracoCms.Web` if your code uses things like `UmbracoApiController` or `SurfaceController`. You will need to add the Nuget package reference of `UmbracoCms.Web` which in turn has a reference to `UmbracoCms.Core`

```shell
Install-Package UmbracoCMS.Web
```

## Try & build the solution

OK now the references have been updated, try and build the solution to see if any errors pop up.

## Fix up compile errors

As long as your Umbraco package was not using outdated APIs and is using the new APIs & Services in Umbraco V7 then most of this step will be trying to determine what the new V8 namespace equivalent is.

:::tip
Clone down the Umbraco CMS source code and checkout the `v8/dev` branch. Use this as a way to try and find the same method that the compiler is complaining about in its new namespace.
:::

## Bye bye ApplicationEventHandler, Hello Composer & Components

A common thing that most package developers and Umbraco developers use in their projects is an `ApplicationEventHandler` to do some logic at the startup of Umbraco or to register event listeners based on Umbraco events such as ContentService.Saved etc.

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
using Umbraco.Web;
using Umbraco.Core.Composing;
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
            //unsubscribe during shutdown
            ContentService.Saving -= this.ContentService_Saving;
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

As version 7 and version 8 of Umbraco have breaking changes in their APIs and code, it's recommended to ship a different version of your package to support Umbraco 8 only. You'll need to update the package.xml in your Umbraco package zip to use the 8.0.0 version like so.

```xml
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<umbPackage>
  <info>
    <package>
    <name>My Umbraco Package</name>
    ...
    <requirements>
        <major>8</major>
        <minor>0</minor>
        <patch>0</patch>
    </requirements>
    ...
```

## Optional - Update .nupkg dependencies

If you ship your package as a Nuget package, then you will need to add/update references to the `UmbracoCms.Core` or `UmbracoCms.Web` nupkg from the MyGet feed https://www.myget.org/F/umbracocore/api/v3/index.json

## Initial testing

Now you have updated and re-created a new package, it's time to test out your package be it via installing a local Umbraco ZIP package or installing it into a Website project via Nuget. You may have some final tweaking in relation to the UI as some parts of the Umbraco angular directives & components have changed slightly. This may require you to tweak some of your Angular views & Javascript accordingly so that it feels more at home in the Umbraco 8 backoffice.
