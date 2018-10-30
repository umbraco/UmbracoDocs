# Umbraco's request pipeline

_The process of Umbraco accepting a request, how it matches a URL to a content item and executes the ASP.NET handler._

## Published Content Request Preparation

The inbound process is triggered by the Umbraco (http) Module.  
The published content request preparation process kicks in to create an `PublishedContentRequest` instance.

It is called in `UmbracoModule.ProcessRequest(…)`

What it does:

* It ensures Umbraco is ready, and the request is a document request.
* Creates a PublishedContentRequest instance
* Runs PublishedContentRequestEngine.PrepareRequest() for that instance
* Handles redirects and status
* Forwards missing content to 404
* Forwards to either MVC or WebForms handlers

## Published Content Request Instance

Once the request is prepared, an instance of `PublishedContentRequest` is available which represents the request that Umbraco must handle.  
It contains everything that will be needed to render it including domain information, the content model to be rendered and the template to use.
This information is also used during the [MVC Controller/Action selection process](../Controller-Selection/).

## Determining rendering engine

 Umbraco supports both MVC and Webforms, though MVC is certainly the preferred and default engine that is used.
 Determining the rendering engine to use occurs once the published content request has been prepared and a template alias is known.
 The selection process is fairly simple:

 * Check for a matching MVC template in the default MVC views location
 	* Choose MVC
 * Else if there is an MVC Controller/Action that is being used to perform 'Route Hijacking'
 	* Choose MVC
 * Else if there is a template assigned to the Published Content Request and a file matches the template alias in the default Webforms master pages folder
 	* Choose Webforms
 * Else
 	* Choose MVC

### More information
- [Umbraco Request Pipeline](../../../Reference/Routing/Request-Pipeline/)
