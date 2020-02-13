---
versionFrom: 8.0.0
---

# Umbraco's request pipeline

_The process of Umbraco accepting a request, how it matches a URL to a content item and executes the ASP.NET handler._

## Published Request Preparation

The inbound process is triggered by the Umbraco (http) Module.
The published request preparation process kicks in to create a `PublishedRequest` instance.

It is called in `UmbracoInjectedModule.ProcessRequest(…)`

What it does:

* It ensures Umbraco is ready, and the request is a document request.
* Creates a PublishedRequest instance
* Runs IPublishedRouter.PrepareRequest() for that instance
* Handles redirects and status
* Forwards missing content to 404

## Published Content Request Instance

Once the request is prepared, an instance of [`PublishedRequest`](/apidocs/v8/csharp/api/Umbraco.Web.Routing.PublishedRequest.html) is available which represents the request that Umbraco must handle.
It contains everything that will be needed to render it including domain information, the content model to be rendered and the template to use.
This information is also used during the [MVC Controller/Action selection process](../Controller-Selection/).

## Rendering engine

Umbraco 8 only supports MVC.
Umbraco 7 was the last major version of Umbraco to support both Webforms and MVC
	
### More information
- [Umbraco Request Pipeline](../../../Reference/Routing/Request-Pipeline/)
