---
versionFrom: 8.0.0
---

# Creating custom package actions

In addition to utilizing the [built-in package actions](index.md), you can also create your own package actions. Package actions are custom code that runs on install and uninstall of a package. You can do whatever you want in a package action - however some things are more common than others.

## Basic package action implementation

To create a custom package action you need to create a new class and implement the `IPackageAction` interface. The empty package action would then look like this:

```cs
using System.Xml.Linq;
using Umbraco.Core.PackageActions;

namespace CustomPackageAction.PackageActions
{
    public class CustomPackageAction : IPackageAction
    {
        public string Alias() => "CustomPackageAction";

        public bool Execute(string packageName, XElement xmlData)
        {
            // do things on install
            return true;
        }

        public bool Undo(string packageName, XElement xmlData)
        {
            // if you want to clean up things added in the Execute method do it here
            return true;
        }
    }
}
```

A package action consists of 3 mandatory methods:

**Alias()** 
In this method you specify the package action alias. This is used when you select a package action in the backoffice. It can look like this:

```xml
<actions>
    <Action runat="install" alias="CustomPackageAction" />
</actions>
```

However if you want it to be more configurable you can add extra parameters to it. For example you could do something like this:

```xml
<actions>
    <Action runat="install" alias="CustomPackageAction" rootNodeName="Home" />
</actions>
```

```cs
using System.Xml.Linq;
using Umbraco.Core.PackageActions;
using Umbraco.Core.Composing;

namespace CustomPackageAction.PackageActions
{
    public class CustomPackageAction : IPackageAction
    {
        public string Alias() => "CustomPackageAction";

        public bool Execute(string packageName, XElement xmlData)
        {
            var rootNodeName = xmlData.AttributeValue<string>("rootNodeName");

            var siteRootNodes = Current.Services.ContentService.GetRootContent();

            foreach (var siteRootNode in siteRootNodes)
            {
                if (siteRootNode.Name.Trim() == rootNodeName.Trim() && siteRootNode.ContentType != null)
                {
                    Current.Services.ContentService.SaveAndPublishBranch(siteRootNode, true);
                    break;
                }
            }
            return true;
        
            
        }

        public bool Undo(string packageName, XElement xmlData)
        {
            // if you want to clean up things added in the Execute method do it here
            return true;
        }
    }
}
```

Here you can see we added an attribute called `rootNodeName` and then retrieved it within the `Execute()` method from the `xmlData` object. This may not be super useful if you are only creating one package, but if you want reusable package actions across packages you can add configuration like this.

## Examples of custom Package Actions

Even though you can do whatever you want within a package action, most packages use package actions for either installing content / media or adding configuration. To help you get started here are some examples of popular packages using these package actions:

### Installing content / media

- [The Umbraco Starter Kit](https://github.com/umbraco/The-Starter-Kit/blob/dev-v8/src/Umbraco.SampleSite/InstallPackageAction.cs)
- [CodeShare Umbraco Starter Kit](https://github.com/prjseal/CodeShare-Umbraco-Starter-Kit-for-v8/blob/master/src/CSUSK.Core/PackageActions/CreateMediaHandler.cs)
- [Articulate](https://github.com/Shazwazza/Articulate/blob/master/src/Articulate/Packaging/ArticulateInstallPackageAction.cs)


### Adding configuration

- [UmbracoFileSystemProviders.Azure](https://github.com/umbraco-community/UmbracoFileSystemProviders.Azure/blob/master-umbraco-version-8/src/UmbracoFileSystemProviders.Azure.Installer/PackageActions.cs)
- [Slimsy](https://github.com/Jeavon/Slimsy/blob/dev-v3/Slimsy/Packaging/PackageActions.cs)

## When to use a Package Action

A lot of the things you would use a package action for can also be accomplished in other ways - for example via a [composer](../../../Implementation/Composing/index.md) or [migration](../../Database/index.md). Package Actions have two important differences though:
1. They only run on install and uninstall - no need to worry about startup cost for your site or add extra checks to see if it ran.
1. You can ensure your package uninstalls cleanly - it has the `Undo()` method by default where you can clean up after yourself.

So if you have something you know should only run on install or uninstall then package actions are a great fit!
