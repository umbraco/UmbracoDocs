---
keywords: customizing external source integration
versionFrom: 7.3.0
---
    
# Custom MVC Routes

**This feature was introduced in Umbraco 7.3.0+**

_Documentation about how to setup your own custom controllers and routes that need to exist alongside of the Umbraco pipeline_

## Where to put your routing logic?

In Umbraco the best place to put your routing logic is in a custom `Umbraco.Core.ApplicationEventHandler` class and override the `ApplicationStarted` method. There you can add any custom routing logic you like and you can be sure that the Umbraco application has completed its booting sequence.

## User defined routes

Umbraco doesn't interfere with any user defined routes that you wish to have. Your custom routes to your own custom controllers will work perfectly and seamlessly alongside of Umbraco.

## Custom routes within the Umbraco pipeline

You can specify your own custom MVC routes to work within the Umbraco pipeline. This requires you to use an implementation of `Umbraco.Web.Mvc.UmbracoVirtualNodeRouteHandler` with your custom route.

As an example:

    protected override void ApplicationStarted(UmbracoApplicationBase umbracoApplication, ApplicationContext applicationContext)
    {
        // Custom route to MyProductController which will use a node with a specific ID as the
        // IPublishedContent for the current rendering page
        RouteTable.Routes.MapUmbracoRoute(
            "ProductCustomRoute",
            "Products/{action}/{sku}",
            new
            {
                controller = "MyProduct",
                sku = UrlParameter.Optional
            },
            new ProductsRouteHandler(_productsNodeId));
    }

This is using a extension method: `MapUmbracoRoute` which takes in the normal routing parameters (you can also include constraints, namespaces, etc….) but also takes in an instance of `UmbracoVirtualNodeRouteHandler`.

The instance of `UmbracoVirtualNodeRouteHandler` is responsible for associating an `IPublishedContent` with this route. It has one abstract method which must be implemented:

    IPublishedContent FindContent(RequestContext requestContext, UmbracoContext umbracoContext)

It has another virtual method that can be overridden which will allow you to manipulate the PublishedContentRequest however you’d like:

    PreparePublishedContentRequest(PublishedContentRequest publishedContentRequest)

So how do you find content to associate with the route? Well that’s up to you, one way (as seen above) would be to specify a node Id. In the example `ProductsRouteHandler` is inheriting from `UmbracoVirtualNodeByIdRouteHandler` which has an abstract method:

    IPublishedContent FindContent(RequestContext requestContext, UmbracoContext umbracoContext, IPublishedContent baseContent);

So based on all this information provided in these methods, you can associate whatever IPublishedContent item you want to the request.

## Virtual Content
This implementation expects **any** instance of `IPublishedContent`, so this means you can create your own virtual nodes with any custom properties you want. Generally speaking you’ll probably have a real Umbraco `IPublishedContent` instance as a reference point, so you could create your own virtual `IPublishedContent` item based on `PublishedContentWrapped`, pass in this real node and then just override whatever properties you want, like the page Name, etc..

Whatever instance of `IPublishedContent` returned in the `FindContent` method will be converted to a `RenderModel` for use in your controllers.

## Controllers
Controllers are straight forward and work like any other routed controller except that the Action will have an instance of RenderModel mapped to it’s parameter.

    public class MyProductController : RenderMvcController
    {
        public ActionResult Product(RenderModel model, string sku)
        {
            // in my case, the IPublishedContent attached to this
            // model will be my products node in Umbraco which i
            // can now use to traverse to display the product list
            // or lookup the product by sku

            if (string.IsNullOrEmpty(sku))
            {
                // render the products list if no sku
                return RenderProductsList(model);
            }
            else
            {
                return RenderProduct(model, sku);
            }
        }
    }
