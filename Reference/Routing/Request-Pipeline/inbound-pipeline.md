---
versionFrom: 8.0.0
---

# Inbound request pipeline

The inbound process is triggered by the Umbraco (http) Module.  The **[published content request preparation](published-content-request-preparation.md)** process kicks in and creates a `PublishedRequest`.

The `PublishedRequest` object represents the request which Umbraco must handle.  It contains everything that will be needed to render it.  All this occurs when the Umbraco modules consider that an incoming request maps to a document that can be rendered.

```csharp
public class PublishedContentRequest
{
  public Uri Uri { get; }
  …
}
```

There are 4 important properties, which contains all the information to find back a node:

```csharp
public bool HasDomain { get; }
public DomainAndUri Domain { get; }
public CultureInfo Culture { get; }
```
Domain is a DomainAndUri object ie a standard Domain plus the fully qualified uri. For example, the Domain may contain "example.com" whereas the Uri will be fully qualified eg "https://example.com/".

It contains the content to render:

```csharp
public bool HasPublishedContent { get; }
public IPublishedContent PublishedContent { get; set; }
public bool IsInitialPublishedContent { get; }
public IPublishedContent InitialPublishedContent { get; }
public void SetIsInitialPublishedContent();
public void SetInternalRedirectPublishedContent(IPublishedContent content);
public bool IsInternalRedirectPublishedContent { get; }
```

Contains template information and the corresponding rendering engine:

```csharp
public bool HasTemplate { get; }
public string TemplateAlias { get; }
public bool TrySetTemplate(string alias);
public void SetTemplate(ITemplate template);
```

You can subscribe to the 'Prepared' event which is triggered right after the point when the`PublishedRequest` is prepared - (but before it is ready to be processed).  Here modify anything in the request before it is processed!  eg. content, template, etc:

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
