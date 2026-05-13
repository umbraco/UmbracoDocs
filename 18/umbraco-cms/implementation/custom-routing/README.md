---
description: Learn everything you need to know about custom routing in Umbraco CMS.
---

# Custom Routing

_There are a couple of ways of controlling the routing behavior in Umbraco: customizing how the inbound request pipeline finds content & creating custom MVC routes that integrate within the Umbraco pipeline_.

## Customizing the inbound pipeline

Below lists the ways in which you can customize the inbound request pipeline, this is done by using native Umbraco plugin classes, notifications, or defining your own routes.

### IContentFinder

All Umbraco content is looked up based on the URL in the current request using an `IContentFinder`. IContentFinder's you can create and implement on your own which will allow you to map any URL to a Umbraco content item.

See: [IContentFinder documentation](../../reference/routing/request-pipeline/icontentfinder.md)

### Last Chance IContentFinder

A `IContentLastChanceFinder` is a special implementation of an `IContentFinder` for use with handling 404's. You can implement one of these plugins to decide which Umbraco content page you would like to show when the URL hasn't matched a Umbraco content node.

{% hint style="info" %}
When creating packages or using class libraries, the `SetContentLastChanceFinder` is a part of the `Umbraco.Cms.Web.Website` NuGet package.
{% endhint %}

To set your own 404 finder create a `IContentLastChanceFinder` and set it as the `ContentLastChanceFinder`. A `ContentLastChanceFinder` will always return a 404 status code. Example:

```csharp
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.DependencyInjection;
using Umbraco.Extensions;

namespace My.Website;

public class UpdateContentFindersComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        //set the last chance content finder
        builder.SetContentLastChanceFinder<My404ContentFinder>();
    }
}
```

For more detailed information see: [IContentFinder documentation](../../reference/routing/request-pipeline/icontentfinder.md)

## Custom MVC routes

You can specify your own custom MVC routes to work within the Umbraco pipeline. It requires your controller to inherit from `UmbracoPageController` and either implement `IVirtualPageController` or use `.ForUmbracoPage` when registering your route, for more information and a complete example of both approaches see [Custom routing documentation](https://docs.umbraco.com/umbraco-cms/reference/routing/custom-routes#custom-routes-within-the-umbraco-pipeline)

An example of registering a `UmbracoPageController` using `.ForUmbracoPage`:

```csharp
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Mvc.Filters;
using Microsoft.Extensions.DependencyInjection;
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.DependencyInjection;
using Umbraco.Cms.Core.Models.PublishedContent;
using Umbraco.Cms.Core.Web;
using Umbraco.Cms.Web.Common.ApplicationBuilder;
using Umbraco.Extensions;

namespace CustomRoutes;

public class MyCustomRouteComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        builder.Services.Configure<UmbracoPipelineOptions>(options =>
        {
            options.AddFilter(new UmbracoPipelineFilter(nameof(MyController))
            {
                Endpoints = app => app.UseEndpoints(endpoints =>
                {
                    endpoints.MapControllerRoute(
                        "My custom controller",
                        "/custom/{action}",
                        new {Controller = "My", Action = "Index"})
                        .ForUmbracoPage(FindContent);
                })
            });
        });
    }

    private IPublishedContent FindContent(ActionExecutingContext actionExecutingContext)
    {
        var umbracoContextAccessor = actionExecutingContext.HttpContext.RequestServices
            .GetRequiredService<IUmbracoContextAccessor>();
        var umbracoContext = umbracoContextAccessor.GetRequiredUmbracoContext();

        return umbracoContext.Content.GetById(1064);
    }
}
```

{% hint style="info" %}
This is an approach for mapping a custom route to a custom MVC controller. For creating routes for existing content pages you can use a custom MVC controller to handle the request by naming convention: see [Custom Controllers - Route Hijacking](../../reference/routing/custom-controllers.md).
{% endhint %}

### RoutingRequestNotification

You can subscribe to the `RoutingRequestNotification` which is published right after the point when the `PublishedRequestBuilder` is prepared - (but before it is ready to be processed). Here you can modify anything in the request before it is processed, eg. content, template, etc:

```csharp
using Umbraco.Cms.Core.Events;
using Umbraco.Cms.Core.Notifications;

namespace CustomRoutes;

public class PublishedRequestHandler : INotificationHandler<RoutingRequestNotification>
{
    public void Handle(RoutingRequestNotification notification)
    {
        var requestBuilder = notification.RequestBuilder;
        // Do something with the IPublishedRequestBuilder here
    }
}
```

For more information on how to register and use notification handlers see [Notifications documentation](../../reference/notifications/)

### Related articles

* [Find out how to add your own hub(s) with SignalR to the existing setup](signalR.md))
