---
versionFrom: 8.0.0
product: "CMS"
meta.Title: "Custom routing in Umbraco"
meta.Description: "There are a couple of ways of controlling the routing behavior in Umbraco: customizing how the inbound request pipeline finds content & creating custom MVC routes that integrate within the Umbraco pipeline"

---

# Custom routing in Umbraco

_There are a couple of ways of controlling the routing behavior in Umbraco: customizing how the inbound request pipeline finds content & creating custom MVC routes that integrate within the Umbraco pipeline_.

## Customizing the inbound pipeline

Below lists the ways in which you can customize the inbound request pipeline, this is done by using native Umbraco plugin classes, events or defining your own routes.

### IContentFinder

All Umbraco content is looked up based on the URL in the current request using an `IContentFinder`. IContentFinder's you can create and implement on your own which will allow you to map any URL to an Umbraco content item.

See: [IContentFinder documentation](../../Reference/Routing/Request-Pipeline/IContentFinder)

### Last Chance IContentFinder

A `IContentLastChanceFinder` is a special implementation of an `IContentFinder` for use with handling 404's. You can implement one of these plugins to decide which Umbraco content page you would like to show when the URL hasn't matched an Umbraco content node.

To set your own 404 finder create a `IContentLastChanceFinder` and set it as the `ContentLastChanceFinder`. A `ContentLastChanceFinder` will always return a 404 status code. Example:


```csharp
using Umbraco.Core;
using Umbraco.Core.Composing;
using Umbraco.Web;

namespace My.Website
{
    [RuntimeLevel(MinLevel = RuntimeLevel.Run)]
    public class SetLastChanceContentFindersComposer : IUserComposer
    {
        public void Compose(Composition composition)
        {
            //set the last chance content finder
            composition.SetContentLastChanceFinder<My404ContentFinder>();
        }
    }
}

```

For more detailed information see: [IContentFinder documentation](../../Reference/Routing/Request-Pipeline/IContentFinder#notfoundhandlers)

## Custom MVC routes

You can specify your own custom MVC routes to work within the Umbraco pipeline. This requires you to use an implementation of `Umbraco.Web.Mvc.UmbracoVirtualNodeRouteHandler` with your custom route.

As an example:

```csharp
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using Umbraco.Core.Composing;
using Umbraco.Web;
using Umbraco.Web.Mvc;

namespace Umbraco8.Components
{

    public class RegisterCustomRouteComposer : ComponentComposer<RegisterCustomRouteComponent>
    { }

    public class RegisterCustomRouteComponent : IComponent
    {
        public void Initialize()
        {
            // Custom route to MyProductController which will use a node with ID 1234 as the
            // IPublishedContent for the current rendering page
            RouteTable.Routes.MapUmbracoRoute(
			"test", 
			"Products/{action}/{sku}",
			new
            {
                controller = "MyProduct",
                sku = UrlParameter.Optional
            },
			new UmbracoVirtualNodeByIdRouteHandler(1234));
        }

        public void Terminate()
        {
            // Nothing to terminate
        }
    }
}
```

See: [Custom routing documentation](../../Reference/Routing/custom-routes)

:::note
This is an approach for mapping a custom route to a custom MVC controller. For creating routes for existing content pages you can use a custom MVC controller to handle the request by naming convention: see [Custom Controllers - Route Hijacking](../../Reference/Routing/custom-controllers). 
:::

### PublishedRequest.Prepared event

You can subscribe to the 'Prepared' event which is triggered right after the point when the `PublishedRequest` is prepared - (but before it is ready to be processed). Here modify anything in the request before it is processed, eg. content, template, etc: 

```csharp
using Umbraco.Core.Composing;
using Umbraco.Web.Routing;

namespace Umbraco8.Components
{
    public class PublishedRequestComponent : IComponent
    {
        public void Initialize()
        {
            PublishedRequest.Prepared += PublishedRequest_Prepared;
        }

        private void PublishedRequest_Prepared(object sender, EventArgs e)
        {
             var request = sender as PublishedRequest;
             // do something…
        }

        public void Terminate() {
            //unsubscribe during shutdown
            PublishedRequest.Prepared -= PublishedRequest_Prepared;
}
    }
}
```
