# Custom routing in Umbraco

_There are a couple of ways of controlling the routing behavior in Umbraco: customizing how the inbound request pipeline
finds content & creating custom MVC routes that integrate within the Umbraco pipeline_

## Customizing the inbound pipeline

Below lists the ways in which you can customize the inbound request pipeline, this is done by using native Umbraco plugin classes, events or defining your own routes.

### IContentFinder

All Umbraco content is looked up based on the URL in the current request using an `IContentFinder`. IContentFinder's are quite easily to create and implement on your own which will allow you to map any URL to an Umbraco content item.

See: [IContentFinder documentation](../../Reference/Routing/Request-Pipeline/IContentFinder)  

### Last Chance IContentFinder

A 'Last Chance' `IContentFinder` is a special implementation of an `IContentFinder` for use with handling 404's. You can implement one of these plugins to decide which Umbraco content page you would like to show when the URL hasn't matched an Umbraco content node.

To set your own 404 finder create an IContentFinder and set it as the ContentLastChanceFinder.  A ContentLastChanceFinder will always return a 404 status code. Example:

    ContentLastChanceFinderResolver.Current.SetFinder(new My404ContentFinder());

## Custom MVC routes

You can specify your own custom MVC routes to work within the Umbraco pipeline. This requires you to use an implementation of `Umbraco.Web.Mvc.UmbracoVirtualNodeRouteHandler` with your custom route.

As an example:

```csharp
//custom route to MyProductController which will use a node with ID 1234 as the
// IPublishedContent for the current rendering page
routes.MapUmbracoRoute(
    "test",
    "Products/{action}/{sku}",
    new
    {
        controller = "MyProduct",
        sku = UrlParameter.Optional
    },
    new UmbracoVirtualNodeByIdRouteHandler(1234));
```

See: [Custom routing documentation](../../Reference/Routing/custom-routes)

### PublishedContentRequest.Prepared event

You can subscribe to an event to know when the `PublishedContentRequest` is ready to be processed.  It's up to you to change anything (content, template, ...):

```csharp
    // public static event EventHandler<EventArgs> Prepared;
    PublishedContentRequest.Prepared += (sender, args) =>
    {
      var request = sender as PublishedContentRequest;
      // do something…
    }
```