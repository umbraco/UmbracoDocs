# Umbraco's request pipeline

Umbraco's request pipeline is the process of building up a URL, resolving the requests, and returning correct content.

## Published Request Preparation

The inbound process is triggered by `UmbracoRouteValueTransformer` and then handled with the Published router. The [Published Content Request Preparation](../../reference/routing/request-pipeline/published-content-request-preparation.md) process kicks in and creates a `PublishedRequestBuilder` which will be used to create a `PublishedContentRequest`.

What it does:

- It ensures Umbraco is ready, and the request is a document request.
- Ensures there's content in the published cache, if there isn't it routes to the `RenderNoContentController` which displays the no content page you see when running a fresh install.
- Creates a published request builder.
- Routes the request with the request builder using the `PublishedRouter.RouteRequestAsync(…)`.
  - This will handle redirects, find domain, template, published content and so on.
  - Build the final `IPublishedRequest`.
- Sets the routed request in the Umbraco context, so it will be available to the controller.
- Create the route values with the `UmbracoRouteValuesFactory`.
  - This is what routes your request to the correct controller and action, and allows you to hijack routes.
- Set the route values to the http context.
- Handles posted form data.
- Returns the route values to netcore so it routes your request correctly.

## Published Content Request Instance

When finding published content the [PublishedRouter](https://apidocs.umbraco.com/v16/csharp/api/Umbraco.Cms.Core.Routing.PublishedRouter.html) will first check if the [PublishedRequestBuilder](https://apidocs.umbraco.com/v16/csharp/api/Umbraco.Cms.Core.Routing.PublishedRequestBuilder.html) already has content, if it doesn't the content finders will kick in. For more information, see the [Find published content](../../reference/routing/request-pipeline/published-content-request-preparation.md#find-published-content) section in the [Published Content Request Preparation](../../reference/routing/request-pipeline/published-content-request-preparation.md) article.

This information is also used during the [Controller & Action selection](controller-selection.md) process.

### Related Information

- [Routing in Umbraco](../../reference/routing/request-pipeline/)
