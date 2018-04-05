# Published Content Request

The `PublishedContentRequest` object represents the request which Umbraco must handle.  
It contains everything that will be needed to render it.  
All this happens when the Umbraco modules thinks it's a document to render. 

    public class PublishedContentRequest
    {
      public Uri Uri { get; }
      …
    }

There are 4 important properties, which contains all the information to find back a node:
  
    public bool HasDomain { get; }
    public Domain Domain { get; }
    public Uri DomainUri { get; }
    public CultureInfo Culture { get; }

Domain contains: "example.com", while Uri is "http://example.com".

It contains also the content to render:

    public bool HasPublishedContent { get; }
    public IPublishedContent PublishedContent { get; set; }
    public bool IsInitialPublishedContent { get; }
    public IPublishedContent InitialPublishedContent { get; }
    public void SetIsInitialPublishedContent();
    public void SetInternalRedirectPublishedContent(IPublishedContent content);
    public bool IsInternalRedirectPublishedContent { get; }

Contains template information and the corresponding rendering engine:

    public bool HasTemplate { get; }
    public string TemplateAlias { get; }
    public RenderingEngine RenderingEngine { get; }
    public bool TrySetTemplate(string alias);
    public void SetTemplate(ITemplate template);