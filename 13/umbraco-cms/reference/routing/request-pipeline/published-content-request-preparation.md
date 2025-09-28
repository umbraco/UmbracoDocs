---
description: How Umbraco prepares content requests
---

# Published Content Request Preparation

Is started in `UmbracoRouteValueTransformer` where it gets the `HttpContext` and `RouteValueDictionary` from the netcore framework:

```
 async ValueTask<RouteValueDictionary> TransformAsync(…)
```

What it does:

* It ensures Umbraco is ready, and the request is a document request.
* Ensures there's content in the published cache, if there isn't it routes to the `RenderNoContentController` which displays the no content page you see when running a fresh install.
* Creates a published request builder.
* Routes the request with the request builder using the `PublishedRouter.RouteRequestAsync(…)`.
  * This will handle redirects, find domain, template, published content and so on.
  * Build the final `IPublishedRequest`.
* Sets the routed request in the Umbraco context, so it will be available to the controller.
* Create the route values with the `UmbracoRouteValuesFactory`.
  * This is what actually routes your request to the correct controller and action, and allows you to hijack routes.
* Set the route values to the http context.
* Handles posted form data.
* Returns the route values to netcore so it routes your request correctly.

## RouteRequestAsync

When the `RouteRequestAsync` method is invoked on the `PublishedRouter` it will:

* FindDomain().
* Handle redirects.
* Set culture.
* Find the published content.
  * Only if it doesn't exist, allowing you to handle it in a custom way with a custom router handler.
* Find the template.
* Set the culture (again, in case it was changed).
* Publish `RoutingRequestNotification`.
* Handle redirects and missing content.
* Initialize a few internal stuff.

We will discuss a few of these steps below.

### FindDomain()

The FindDomain method looks for a domain matching the request Uri

* Using a greedy match: “domain.com/foo” takes over “domain.com”.
* Sets published content request’s domain.
* If a domain was found.
  * Sets published content request’s culture accordingly.
  * Computes domain Uri based upon the current request ("domain.com" for `http://domain.com` or `https://domain.com`).
* Else.
  * Sets published content request’s culture by default (first language, else system).

### Find published content

When finding published content the `PublishedRouter` will first check if the `PublishedRequestBuilder` already has content, if it doesn't the content finders will kick in. There a many different types of content finders, such as find by url, by id path, and more. If none of the content finders manages to find any content, the request will be set as 404, and the `ContentLastChanceFinder` will run, this will try to find a page to handle a 404, if it can't find one, the ugly 404 will be used.

You can also implement your own content finders and last chance finder, for more information, see [IContentFinder](icontentfinder.md)

The `PublishedRouter` will also follow any internal redirects, but it is limited to avoid spiraling out of control due to an infinite redirect loop.

### Find template

Once the content has been found, the `PublishedRouter` moves on to finding the template.

First off it checks if any content was found, if it wasn't it sets the template to null, since there can't be a template without content.

Next it checks to see if there is an alternative template which should be used. An alternative template will be used if the router can find a value with the key "altTemplate", in either the querystring, form, or cookie, and there is content found by the contentfinders, so not the 404 page, or it's an internal redirect and the web routing setting has `InternalRedirectPreservesTemplate`.

If no alternative template is found the router will get the template with the file service, using the ID specified on the published content, and then assign the template to the request.

If an alternative template is specified, the router will check if it's an allowed template for the content, if the template is not allowed on that specific piece of content it will revert to using the default template. If the template is allowed it will then use the file service to get the specified alternative template and assign the template to the request.

### Redirects

The router will pick up the redirect and redirect. There is no need to write your own redirects:

```csharp
public class PublishedRequestHandler : INotificationHandler<RoutingRequestNotification>
{
    public void Handle(RoutingRequestNotification notification)
    {
        var requestBuilder = notification.RequestBuilder;
        var content = requestBuilder.PublishedContent;
        var redirect = content.Value<string>("myRedirect");
        if (!string.IsNullOrWhiteSpace(redirect))
        {
            requestBuilder.SetRedirect(redirect);
        }
    }
}
```

## Missing template?

In case the router can't find a template, it will try and verify if there's route hijacking in place, if there is, it will run the hijacked route. If route hijacking is not in place, the router will set the content to null, and run through the routing of the request again, in order for the last chance finder to find a 404.
