#Routing in Umbraco

This section describes what the Umbraco Request Pipeline is, how you can use your own MVC Controllers instead of the default ones and how you can define your own Umbraco integrated ASP.Net routes.

## Request pipeline

###What is the pipeline

The request pipeline is the process of building up the URL for a node, resolving a request to a specified node and making sure that the right content is sent back.

![what is the pipeline](images/what-is-the-pipeline.png)

For a detailed description see [Stephan's slide deck for his presentation on the Umbraco Pipeline](document/TheUmbraco6RequestPipeline.pdf).

###Outbound vs Inbound

The pipeline works bidirectional: [inbound](inbound-pipeline.md) and [outbound](outbound-pipeline.md).

[Outbound](outbound-pipeline.md) is the process of building up a URL for a requested node.  [Inbound](inbound-pipeline.md) is every request received by the web server and handled by Umbraco.

###Customizing the pipeline

*Coming soon....*

This section will describe the components that you can use to modify Umbraco's request pipeline: [IContentFinder](IContentFinder.md) & `IUrlProvider`

## Custom MVC Controllers

For more control over the rendering process once the Umbraco Request Pipeline executes, you can tell Umbraco to execute your own custom MVC controllers instead of the default ones. For full details see: ['Hijacking Umbraco routes'](../Templating/Mvc/custom-controllers.md)

## Custom ASP.Net routes

It is possible to create your own ASP.Net routes and have Umbraco data integrated into those requests. For full details see: [Custom routes](../Templating/Mvc/custom-routes.md)
