# Routing

Get an overview of how the Umbraco pipeline is structured. See what happens from user request to content delivery.

## Request Pipeline

### [Inbound request pipeline](inbound-pipeline.md)

Matching a URL to a content item & determining the rendering engine (MVC or Webforms).

### [Controller selection](controller-selection.md)

Match an MVC Controller and Action to handle the request.

## [Execute request](execute-request.md)

The MVC Action and View are executed. During this execution you can query for published data to be displayed/rendered.

### [IPublishedContent](../../reference/querying/ipublishedcontent)

IPublishedContent is a strongly typed underlying model used in all Umbraco views.

### [UmbracoHelper](../../reference/querying/umbracohelper.md)

Use UmbracoHelper to query published media and content.

### [Members](../../reference/querying/imembermanager.md)

This section covers the IMemberManager.
