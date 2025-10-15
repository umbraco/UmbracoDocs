---


meta.Title: "Inbound request pipeline"
description: "How the Umbraco inbound request pipeline works"
---

# Inbound request pipeline

The inbound process is triggered by `UmbracoRouteValueTransformer` and then handled with the Published router. The **[published content request preparation](published-content-request-preparation.md)** process kicks in and creates a `PublishedRequestBuilder` which will be used to create a `PublishedContentRequest`.

The `PublishedContentRequest` object represents the request which Umbraco must handle. It contains everything that will be needed to render it. All this occurs when the Umbraco modules knows that an incoming request maps to a document that can be rendered.

```csharp
public class PublishedContentRequest
{
  public Uri Uri { get; }
  …
}
```

There are 3 important properties, which contains all the information to find a node:

```csharp
public bool HasDomain { get; }
public DomainAndUri Domain { get; }
public CultureInfo Culture { get; }
```
Domain is a DomainAndUri object that is a standard Domain plus the fully qualified uri. For example, the Domain may contain "example.com" whereas the Uri will be fully qualified for example "https://example.com/".

It contains the content to render:

```csharp
public bool HasPublishedContent { get; }
public IPublishedContent PublishedContent { get; set; }
public bool IsInternalRedirect { get; }
public bool IsRedirect {get; }
```

Contains template information:

```csharp
public bool HasTemplate { get; }
public string GetTemplateAlias { get; }
public ITemplate Template {get; }
```

The published request is created using the `PublishedRequestBuilder`, which implements `IPublishedRequestBuilder`. It's only in this builder that it's possible to set values, such as domain, culture, published content, redirects, and so on.

You can subscribe to the 'routing request' notification, which is published right after the `PublishedRequestBuilder` has been prepared, but before the request is built, and processed. Here you can modify anything in the request before it is built and processed! For example content, template, etc:

```C#
using Umbraco.Cms.Core.Events;
using Umbraco.Cms.Core.Notifications;

namespace Umbraco9.NotificationHandlers
{
    public class PublishedRequestHandler : INotificationHandler<RoutingRequestNotification>
    {
        public void Handle(RoutingRequestNotification notification)
        {
            var requestBuilder = notification.RequestBuilder;
            // Do something with the IPublishedRequestBuilder here 
        }
    }
}
```