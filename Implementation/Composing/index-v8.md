---
keywords: composing composers components runtime boot booting v8 version8
versionFrom: 8.0.0
---

# Composing
With Umbraco V8+ you are now able to customise how your Umbraco application runs and boots by composing different components of the system. You may wish to add your own customisations on how Umbraco works or alternatively disable or remove specific functions in Umbraco. You can achieve this with composers & components.


### Changing Umbraco
Below is a simple sample of changing the Umbraco application to allow Spotify URLs to be used as OEmbed in the Grid and Rich Text Editors inside Umbraco. As the collection for OEmbedProviders is not typed scanned, then you will see that we need to explicitly add to the collection.

```csharp
using System.Collections.Generic;
using Umbraco.Web.Media.EmbedProviders;

namespace My.Website
{
    public class Spotify : EmbedProviderBase
    {
        public override string ApiEndpoint => "https://embed.spotify.com/oembed/";

        // Playlist
        // https://open.spotify.com/user/spotify/playlist/37i9dQZF1E4sNI4jZloSZr?si=cueBooBfTnqCGriSa4N_Kg
        // spotify:user:spotify:playlist:37i9dQZF1E4sNI4jZloSZr

        // Artist
        // https://open.spotify.com/artist/0iirUbtgwt9jEkc2Grin8C?si=TLeUR2cHR-KPRJJhW6YiVg
        // spotify:artist:0iirUbtgwt9jEkc2Grin8C

        // Album
        // https://open.spotify.com/album/0lvtdqkqIln6uDBBUT7DHL?si=XTVJIEmnS_OVv9l6ktPFiw
        // spotify:album:0lvtdqkqIln6uDBBUT7DHL

        // Track
        // https://open.spotify.com/track/7aCk4XfXIEJM2MecU6Gmf2?si=vESDzI0xTNeA9FQ_dvf1eQ
        // spotify:track:7aCk4XfXIEJM2MecU6Gmf2

        public override string[] UrlSchemeRegex => new string[]
        {
            @".*.spotify.com/.*",
            @"spotify:.*"
        };

        public override Dictionary<string, string> RequestParams => new Dictionary<string, string>();

        public override string GetMarkup(string url, int maxWidth = 0, int maxHeight = 0)
        {
            var requestUrl = base.GetEmbedProviderUrl(url, maxWidth, maxHeight);
            var oembed = base.GetJsonResponse<OEmbedResponse>(requestUrl);

            return oembed.GetHtml();
        }
    }
}
```

```csharp
using Umbraco.Core.Components;
using Umbraco.Web;

namespace My.Website
{
    public class CustomOEmbedComposer : IUserComposer
    {
        public void Compose(Composition composition)
        {
            // Change the OEmbedProviders collection
            // by adding our new EmbedProvider for Spotify
            composition.OEmbedProviders().Append<Spotify>();
        }
    }
}
```


### Creating a component, to listen for ContentService.Saving events
Below is a simple sample of listening to the `ContentService.Saving` event, where you could run some logic such as checking for explicit words or some custom business logic needed for your own needs.

```csharp
using System.Linq;
using Umbraco.Core;
using Umbraco.Core.Composing;
using Umbraco.Core.Events;
using Umbraco.Core.Services;
using Umbraco.Core.Services.Implement;

namespace My.Website
{
    [RuntimeLevel(MinLevel = RuntimeLevel.Run)]
    public class MyComposer : IUserComposer
    {
        public void Compose(Composition composition)
        {
            // Append our component to the collection of Components
            // It will be the last one to be run
            composition.Components().Append<MyComponent>();
        }
    }

    public class MyComponent : IComponent
    {
        // initialize: runs once when Umbraco starts
        public void Initialize()
        {
            ContentService.Saving += ContentService_Saving;
        }

        // terminate: runs once when Umbraco stops
        public void Terminate()
        {
        }

        private void ContentService_Saving(IContentService sender, ContentSavingEventArgs e)
        {
            foreach (var content in e.SavedEntities
                //Check if the content item type has a specific alias
                .Where(c => c.ContentType.Alias.InvariantEquals("MyContentType")))
            {
                //Do something if the content is using the MyContentType doctype
            }
        }
    }
}
```


## Types of Composers
Umbraco comes with the following Composer interfaces and runs them in this order:<br/>
`IRuntimeComposer`<br/>
There should only ever been one IRuntimeComposer and it belongs to Umbraco. You can safely ignore that one for now. Just know that it will compose before anything else.

`ICoreComposer`<br/>
Then, all ICoreComposer instances compose. They compose all the default elements that Umbraco needs to run.

`IUserComposer`<br/>
And then, all IUserComposer compose. If you are writing a package, or extending Umbraco, or creating a site, you most probably want to implement IUserComposer.

:::warning
Ordering of composers is important, as the last one added in can override previously added composers if you wish to override something.
:::


## Collections
>"Collections of elements", such as the content finders collection
Collections are another concept that Umbraco uses to make things simpler, on top of DI. A collection builder builds a collection, allowing users to add and remove types before anything is actually registered into DI.

Below is a list of collections that details their collection type and how items for this collection out of the box for Umbraco is registered.


| Collection                | Type      | Registration                                                      |
| ---                       | ---       | ---                                                               |
| CacheRefreshers           | Lazy      | Type scanned for `ICacheRefresher`                                |
| Components                | Ordered   | Explicit Registration                                             |
| ContentApps               | Ordered   | Package.manifest & Explicit Registration                          |
| ContentFinders            | Ordered   | Explicit Registration                                             |
| Dashboards                | Weighted  | Package.manifest & Type scanned for `IDashboard`                  |
| DataEditors               | Lazy      | Type scanned for `IDataEditor`                                    |
| FilderedControllerFactory | Ordered   | Explicit Registration                                             |
| HealthChecks              | Lazy      | Type scanned for `HealthCheck`                                    |
| OEmbedProviders           | Ordered   | Explicit Registration                                             |
| PackageActions            | Lazy      | Type scanned for `IPackageAction`                                 |
| PropertyValueConvertors   | Ordered   | Type scanned for `IPropertyValueConverter`                        |
| SearchableTrees           | Lazy      | Type scanned for `ISearchableTree`                                |
| Sections                  | Ordered   | Package.manifest & Explicit Registration                          |
| TourFilters               | Base      | Empty collection                                                  |
| Trees                     | Base      | Type scanned. Must inherit `TreeControllerBase` & use `[Tree]`    |
| UrlProviders              | Ordered   | Explicit Registration                                             |
| UrlSegmentProviders       | Ordered   | Explicit Registration                                             |
| Validators                | Lazy      | Explicit Registration                                             |


### Types of Collections
Ordered<br/>
`OrderedCollectionBuilderBase` The base class for collection builders that order their items explicitely.

Weighted<br/>
`WeightedCollectionBuilder` the base class for collection builders that order their items by the `[Weight]` attribute.

Lazy<br/>
`LazyCollectionBuilderBase` the base class for collection builders that resolve the types at the last moment, only when the collection is required.


### Modifying Collections

```csharp
using Umbraco.Core;
using Umbraco.Core.Composing;
using Umbraco.Web;
using Umbraco.Web.HealthCheck.Checks.Permissions;
using Umbraco.Web.HealthCheck.Checks.Security;

namespace My.Website
{
    [RuntimeLevel(MinLevel = RuntimeLevel.Run)]
    public class MyComposer : IUserComposer
    {
        public void Compose(Composition composition)
        {
            //Remove all HealthChecks
            composition.HealthChecks().Clear();

            //Explictly add back the ones we want to use
            composition.HealthChecks().Add<FolderAndFilePermissionsCheck>();
            composition.HealthChecks().Add<ExcessiveHeadersCheck>();

        }
    }
}
```


## Attributes
Umbraco has some useful C# attributes to decorate your composer classes or Types used in collections.

### [ComposeBefore]` and `[ComposeAfter]`
A finer-grain mechanism can then be used to refine the order of composition. Each composer can specify that it should compose before or after another composer, using the ComposeBefore and ComposeAfter attributes. For instance:

```csharp
[ComposeBefore(typeof(ThatOtherComposer))]
public class ThisComposer : IUserComposer
{
    public void Compose(Composition composition)
    {
    }
}
```

:::warning
If you create a circular dependancy then Umbraco will fail to boot and will report the conflicting/circular dependancy.
:::

### [Weight]
This attribute is used only for `WeightedCollectionBuilders` and specifies an integer for the item to be added/sorted in the weighted collection and is not to be applied to Composers themselves.

```csharp
using System;
using Umbraco.Core;
using Umbraco.Core.Composing;
using Umbraco.Core.Dashboards;

namespace Umbraco.Web.Dashboards
{
    [Weight(10)]
    public class FormsDashboard : IDashboard
    {
        public string Alias => "formsInstall";
        public string[] Sections => new [] { Constants.Applications.Forms };
        public string View => "views/dashboard/forms/formsdashboardintro.html";
        public IAccessRule[] AccessRules => Array.Empty<IAccessRule>();
    }
}
```

### [HideFromTypeFinder]
This is used to hide a type from being auto scanned/added to a collection as in some cases certain items/types may need to be added to a collection manually.

### [DisableComposer] & [Disable]
Let's say Umbraco ships with two different ways of doing "something" (for instance, two front-end caches). Each way has its own composer, which registers all the relevant elements. Of course, if both composers are detected, there will be some sort of collision. Ideally, we want to disable one of them. That can be achieved with the Disable attribute:

```csharp
[Disable]
public void Way2Composer : IComposer
{ ... }
```

When used without arguments, these attributes apply to the composer they are marking. But, and this is where it becomes interesting, they can be used with an argument to act on another component. Therefore, should a user want to replace our "something" with hers, she would write the following code:

```csharp
[Disable(typeof(Way1Composer))]
public void MyComposer : IComposer
{
    public void Compose(Composition composition)
    { ... }
}
```

But maybe she just wants to swap our two "something" implementations? In this case, assembly-level attributes can be used:
```csharp
[assembly:DisableComposer(typeof(Way1Composer))]
[assembly:EnableComposer(typeof(Way2Composer))]
```

:::tip
Note that Umbraco also has a `[Enable]` & `[EnableComposer]` attributes but all composers are enabled by default.
:::

### [RuntimeLevel]
The most common usecase for this is to set this attribute on your own composers and to set the minimum level to Run. Which will mean this composer will not be invoked until Umbraco is fully booted and is running. So if an upgrade or Umbraco is still booting your own custom composer code won't run until everything is all setup and good.

```csharp
using Umbraco.Core;
using Umbraco.Core.Composing;

namespace My.Website
{
    [RuntimeLevel(MinLevel = RuntimeLevel.Run)]
    public class MyComposer : IUserComposer
    {
        public void Compose(Composition composition)
        {
        }
    }
}
```

:::tip
If you wish to see the order of components when Umbraco boots, then you can see this information in the logs of Umbraco
:::

## Runtime Levels

The `Umbraco.Core.RuntimeLevel` enum contains the following values:<br/>
`BootFailed`<br/>
The runtime has failed to boot and cannot run.

`Unknown`<br/>
The level is unknown.

`Boot`<br/>
The runtime is booting.

`Install`<br/>
The runtime has detected that Umbraco is not installed at all, ie there is no database, and is currently installing Umbraco.

`Upgrade`<br/>
The runtime has detected an Umbraco install which needed to be upgraded, and is currently upgrading Umbraco.

`Run`<br/>
The runtime has detected an up-to-date Umbraco install and is running.


