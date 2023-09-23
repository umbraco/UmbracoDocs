---
description: "Customising the behaviour of an Umbraco Application at start up"
---

# Composing

Customising the behaviour of an Umbraco Application at 'start up'. for example adding, removing, or replacing the core functionality of Umbraco or registering custom code to subscribe to notifications.

## Overview

An Umbraco application is a `Composition` made of many different 'collections' and single items of specific functionality/implementation logic/components (eg. UrlProviders, ContentFinders - see below for a full list). These collections are populated when the Umbraco Application starts up.

'Composing' is the term used to describe the process of curating which pieces of functionality should be included in a particular collection. The code that implements these choices at start up is called a `Composer`.

A `Component` is a generic wrapper for writing custom code during composition, it has two methods: `Initialize()` and `Terminate()` and these are executed when the Umbraco Application starts up, and when it shuts down, respectively. The functionality of a `Component` is identical to having a class handling both the `UmbracoApplicationStartingNotification` and `UmbracoApplicationStoppingNotification`.

How are the collections populated? - Either by scanning the codebase for c# classes that inherit from a particular base class or implement a particular interface (typed scanned) or by being explicitly registered via a `Composer`.

Umbraco setup the default set of components and collections that deliver the core 'out of the box' Umbraco behaviour. These default collections can be removed, reordered, replaced, etc. by implementing `IComposer`'s and `IComponent`s to customise and extend Umbraco's behaviour.

### Example - Creating a Composer to listen for ContentSavingNotification

This example shows how to create a component and a notification handler for the `ContentSavingNotification`, (perhaps to check for explicit words, or some custom business logic that needs to run before the content item is saved in Umbraco).

We create a new C# class that implements `IComposer` and use it register our notification handler.

```csharp
using System.Linq;
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.DependencyInjection;
using Umbraco.Cms.Core.Events;
using Umbraco.Cms.Core.Notifications;
using Umbraco.Extensions;

namespace My.Website
{
    public class SubscribeToContentServiceSavingComposer : IComposer
    {
        public void Compose(IUmbracoBuilder builder)
        {
            builder.AddNotificationHandler<ContentSavingNotification, CustomContentSavingNotificationHandler>();
        }
    }

    public class CustomContentSavingNotificationHandler : INotificationHandler<ContentSavingNotification>
    {
        public void Handle(ContentSavingNotification notification)
        {
            foreach (var content in notification.SavedEntities
                // Check if the content item type has a specific alias
                .Where(c => c.ContentType.Alias.InvariantEquals("MyContentType")))
            {
                // Do something if the content is using the MyContentType doctype
            }
        }
    }
}
```

{% hint style="warning" %}
Ordering of composers is important, the last one added can override a previously added composer! Make sure, when overriding, that your composer that is doing the overriding, is 'composing', after the composer has 'composed' the element you wish to override!
{% endhint %}

### Example - Explicitly Registering a new custom OEmbedProvider

This example shows a custom 'Spotify' OEmbed Provider which will allow Spotify URLs to be used via the 'embed' button in the Rich Text Editors. As the collection for OEmbedProviders is not 'typed scanned', we need to explicitly register the provider in the collection of OEmbedProviders. We create a C# class which implements `IComposer` and append our new Spotify OEmbedProvider to the `EmbedProvidersCollection`:

```csharp
using Umbraco.Cms.Core.Media.EmbedProviders;
using Umbraco.Cms.Core.Serialization;

namespace My.Website;

public class SpotifyEmbedProvider : OEmbedProviderBase
{
    public SpotifyEmbedProvider(IJsonSerializer jsonSerializer)
        : base(jsonSerializer)
    {
    }

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
    public override string[] UrlSchemeRegex => new[]
    {
        @".*.spotify.com/.*",
        @"spotify:.*"
    };

    public override Dictionary<string, string> RequestParams => new();

    public override string? GetMarkup(string url, int maxWidth = 0, int maxHeight = 0)
    {
        string requestUrl = base.GetEmbedProviderUrl(url, maxWidth, maxHeight);
        OEmbedResponse? oembed = base.GetJsonResponse<OEmbedResponse>(requestUrl);

        return oembed?.GetHtml();
    }
}
```

```csharp
using Umbraco.Cms.Core.Composing;

namespace My.Website;

public class RegisterEmbedProvidersComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        // Change the EmbedProvidersCollection
        // by adding our new EmbedProvider for Spotify
        builder.EmbedProviders().Append<SpotifyEmbedProvider>();
    }
}
```

See a list of collections below to determine which are 'type scanned' and which require explicit registration.

### ComponentComposer

It's an implementation of `IComposer`, that provides a quicker way to add a custom component to the Component's collection. Creating a C# class that inherits from `ComponentComposer<YourComponentType>` will automatically add `YourComponentType` to the collection of Components. In the example above, the `SubscribeToContentServiceSavingComposer` for the `SubscribeToContentServiceSavingComponent` could have been written more conveniently as:

```csharp
public class SubscribeToContentServiceSavingComposer : ComponentComposer<SubscribeToContentServiceSavingComponent>
{ }
```

## Collections

> "Collections of elements", for example, the ContentFinders collection. - Collections are another concept that Umbraco uses to make things simpler, on top of DI. A collection builder builds a collection, allowing users to add and remove types before anything is registered into DI.

Below is a list of collections with their corresponding 'collection type' and how items for this collection 'out of the box' are registered.

| Collection              | Type     | Registration                                                   |
| ----------------------- | -------- | -------------------------------------------------------------- |
| Actions                 | Lazy     | Type scanned for `IAction`                                     |
| CacheRefreshers         | Lazy     | Type scanned for `ICacheRefresher`                             |
| Components              | Ordered  | Explicit Registration                                          |
| ContentApps             | Ordered  | Package.manifest & Explicit Registration                       |
| ContentFinders          | Ordered  | Explicit Registration                                          |
| Dashboards              | Weighted | Package.manifest & Explicit Registration                       |
| DataEditors             | Lazy     | Type scanned for `IDataEditor`                                 |
| EditorValidators        | Lazy     | Type scanned for `IEditorValidator`                            |
| HealthChecks            | Lazy     | Type scanned for `HealthCheck`                                 |
| ManifestValueValidators | Set      | Explicit Registration                                          |
| OEmbedProviders         | Ordered  | Explicit Registration                                          |
| PropertyValueConverters | Ordered  | Type scanned for `IPropertyValueConverter`                     |
| SearchableTrees         | Lazy     | Type scanned for `ISearchableTree`                             |
| Sections                | Ordered  | Package.manifest & Explicit Registration                       |
| TourFilters             | Base     | Empty collection                                               |
| Trees                   | Base     | Type scanned. Must inherit `TreeControllerBase` & use `[Tree]` |
| UrlProviders            | Ordered  | Explicit Registration                                          |
| UrlSegmentProviders     | Ordered  | Explicit Registration                                          |
| Validators              | Lazy     | Explicit Registration                                          |

### Types of Collections

| Type     | Method                         | Notes                                                                                                                   |
| -------- | ------------------------------ | ----------------------------------------------------------------------------------------------------------------------- |
| Set      | `SetCollectionBuilderBase`     | The base class for collection builders that do not order their items explicitly.                                        |
| Ordered  | `OrderedCollectionBuilderBase` | The base class for collection builders that order their items explicitly.                                               |
| Weighted | `WeightedCollectionBuilder`    | The base class for collection builders that order their items by the `[Weight]` attribute.                              |
| Lazy     | `LazyCollectionBuilderBase`    | The base class for collection builders that resolve the types at the last moment, only when the collection is required. |

### Example - Modifying Collections

This example shows how to control which Healthchecks are available to run in the Umbraco backoffice. Create a C# class which implements IUserComposer, the Compose method gives access to the HealthChecks collection of the Umbraco Composition - first we clear all HealthChecks from the collection, then add back in the ones we want to keep:

```csharp
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.DependencyInjection;
using Umbraco.Cms.Core.HealthChecks.Checks.Permissions;
using Umbraco.Cms.Core.HealthChecks.Checks.Security;

namespace My.Website
{
    public class MyComposer: IComposer
    {
        public void Compose(IUmbracoBuilder builder)
        {
            // Remove all HealthChecks
            builder.HealthChecks().Clear();

            // Explicitly add back the ones we want to use
            builder.HealthChecks().Add<FolderAndFilePermissionsCheck>();
            builder.HealthChecks().Add<ExcessiveHeadersCheck>();
        }
    }
}
```

## Attributes

Umbraco has some useful C# attributes to decorate your composer classes or Types used in collections, to give you further control on how and when your Composers will 'compose'.

### ComposeBefore and ComposeAfter

A finer-grain mechanism can then be used to refine the order of composition. Each composer can specify that it should compose before or after another composer, using the ComposeBefore and ComposeAfter attributes. For instance:

```csharp
[ComposeBefore(typeof(ThatOtherComposer))]
public class ThisComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
    }
}
```

`ThisComposer` will 'compose' before `ThatOtherComposer`.

{% hint style="warning" %}
If you create a circular dependency then Umbraco will fail to boot and will report the conflicting/circular dependency.
{% endhint %}

### Weight

This attribute is used only for `WeightedCollectionBuilders` (see list above). It specifies an integer ordinal value for each item to be added to the weighted collection which controls their sort order. The weighting attribute is not applied to the Composers.

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

### HideFromTypeFinder

This is used to hide a type from being auto-scanned/added to a collection as in some cases certain items/types may need to be added to a collection manually. For example, a Search package may make it optional whether to replace the 'backoffice search' with an ISearchableTree implementation. Type scanning would make this change automatically at start up if the custom implementation was detected via type scanning. This attribute could hide the class from the scanner.

### DisableComposer & Disable

These attributes allow you to disable a particular implementation of a composer or class - Let's say Umbraco ships with two different ways of doing "something" (for instance, two front-end caches). Each way has its own composer, which registers all the relevant elements. Keep in mind that if both composers are detected, there will be some sort of collision. Ideally, we want to disable one of them. That can be achieved with the Disable attribute:

```csharp
[Disable]
public class Way2Composer : IComposer
{
    //...
}
```

When used without arguments, these attributes apply to the composer they are marking. But, and this is where it becomes interesting, they can be used with an argument to act on another component. Therefore, should a user want to replace our "something" with theirs, they would write the following code:

```csharp
[Disable(typeof(Way1Composer))]
public class MyComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        // ...
    }
}
```

But maybe they want to swap our two "something" implementations? In this case, assembly-level attributes can be used:

```csharp
[assembly:DisableComposer(typeof(Way1Composer))]
[assembly:EnableComposer(typeof(Way2Composer))]
```

{% hint style="info" %}
Umbraco also has `[Enable]` & `[EnableComposer]` attributes but all composers are enabled by default.
{% endhint %}

## Runtime Levels

The `Umbraco.Cms.Core.RuntimeLevel` enum contains the following values:

| Level        | Description                                                                                                                   |
| ------------ | ----------------------------------------------------------------------------------------------------------------------------- |
| `BootFailed` | The runtime has failed to boot and cannot run.                                                                                |
| `Unknown`    | The level is unknown.                                                                                                         |
| `Boot`       | The runtime is booting.                                                                                                       |
| `Install`    | The runtime has detected that Umbraco is not installed at all, ie. there is no database, and is currently installing Umbraco. |
| `Upgrade`    | The runtime has detected an Umbraco install which needed to be upgraded, and is currently upgrading Umbraco.                  |
| `Run`        | The runtime has detected an up-to-date Umbraco install and is running.                                                        |

## Example of using Ordered Collections and adding types explicitly

You may wish to create an Umbraco package that allows package consumers to extend and add additional functionality. In this example, we show how you can use the `OrderedCollectionBuilderBase`.

```csharp
using System;
using System.Collections.Generic;
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.DependencyInjection;
using Umbraco.Cms.Web.BackOffice.Controllers;

namespace TestCollections.Code
{
    public interface IMyThing
    {
        string Name { get; }

        string DoSomething(string message);
    }

    public class ExampleThing : IMyThing
    {
        public string Name => "Example";

        public string DoSomething(string message)
        {
            return $"Hello {message}";
        }
    }

    // OrderedCollection - use when order of items is important (You may want to execute them in order)
    // Different types of collections.
    public class MyThingsCollectionBuilder : OrderedCollectionBuilderBase<MyThingsCollectionBuilder, MyThingsCollection, IMyThing>
    {
        protected override MyThingsCollectionBuilder This => this;
    }

    public class MyThingsCollection : BuilderCollectionBase<IMyThing>
    {
        public MyThingsCollection(Func<IEnumerable<IMyThing>> items)
            : base(items)
        {
        }
    }

    public static class WebCompositionExtensions
    {
        public static MyThingsCollectionBuilder MyThings(this IUmbracoBuilder builder)
            => builder.WithCollectionBuilder<MyThingsCollectionBuilder>();
    }

    public class MyThingComposer : IUserComposer
    {
        public void Compose(IUmbracoBuilder builder)
        {
            // Explicitly add to the collection a Type in a specific order
            builder.MyThings().Append<ExampleThing>()
                .Append<AnotherThing>()
                .Append<SomeOtherThing>();
        }
    }

    // An Umbraco Backoffice Web API Controller - Used in a dashboard or Property Editor perhaps?
    public class SomeBackofficeApiController : UmbracoAuthorizedApiController
    {
        private MyThingsCollection _mythings;

        public SomeBackofficeApiController()
        {
        }

        public SomeBackofficeApiController(MyThingsCollection mythings)
        {
            _mythings = mythings;
        }

        public List<string> GetMessages(string message)
        {
            var items = new List<string>();

            foreach (var thing in _mythings)
            {
                items.Add(thing.DoSomething(message));
            }

            return items;
        }
    }
}
```

## Example of using Lazy Collections with Type Scanning

You may wish to create an Umbraco package that allows package consumers to extend and add additional functionality. In this example, we show how you can use the `LazyCollectionBuilderBase` to scan assemblies that implement your interface by using the `TypeLoader`

{% hint style="warning" %}
Add types from assemblies - be conscious of doing type scanning, as this adds time to boot up of Umbraco. If you still need to use type scanning, ensure your Interface implements `IDiscoverable` as this is a type that is scanned once by Umbraco and the results are cached and then filtered. This saves time by re-scanning for types over and over again.
{% endhint %}

```csharp
using System;
using System.Collections.Generic;
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.DependencyInjection;
using Umbraco.Cms.Web.BackOffice.Controllers;

namespace TestCollections.Code
{
    // Implement `IDiscoverable` (To help with typescanning speed/perf)
    public interface IMyThing : IDiscoverable
    {
        string Name { get; }
        string DoSomething(string message);
    }

    public class ExampleThing : IMyThing
    {
        public string Name => "Example";

        public string DoSomething(string message)
        {
            return $"Hello {message}";
        }
    }

    public class MyThingsCollectionBuilder : LazyCollectionBuilderBase<MyThingsCollectionBuilder, MyThingsCollection, IMyThing>
    {
        protected override MyThingsCollectionBuilder This => this;
    }

    public class MyThingsCollection : BuilderCollectionBase<IMyThing>
    {
        public MyThingsCollection(Func<IEnumerable<IMyThing>> items)
            : base(items)
        {
        }
    }

    public static class WebCompositionExtensions
    {
        public static MyThingsCollectionBuilder MyThings(this IUmbracoBuilder builder)
            => builder.WithCollectionBuilder<MyThingsCollectionBuilder>();
    }

    public class MyThingComposer : IUserComposer
    {
        public void Compose(IUmbracoBuilder builder)
        {
            // Add types from assemblies - be conscious of doing type scanning
            // as this adds time to boot up of Umbraco
            // If you still need to use type scanning, ensure your Interface implements `IDiscoverable`
            builder.MyThings().Add(() => builder.TypeLoader.GetTypes<IMyThing>());
        }
    }

    // An Umbraco Backoffice Web API Controller - Used in a dashboard or Property Editor perhaps?
    public class SomeBackofficeApiController : UmbracoAuthorizedApiController
    {
        private MyThingsCollection _mythings;

        public SomeBackofficeApiController()
        {
        }

        public SomeBackofficeApiController(MyThingsCollection mythings)
        {
            _mythings = mythings;
        }

        public List<string> GetMessages(string message)
        {
            var items = new List<string>();

            foreach (var thing in _mythings)
            {
                items.Add(thing.DoSomething(message));
            }

            return items;
        }
    }
}
```
