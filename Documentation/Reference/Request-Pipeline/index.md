#Request pipeline

**Applies to: Umbraco 6.0+**

_This section explains how umbraco builds it's urls and how the urls are mapped back to nodes_

 
##Introduction

The request pipeline was rewritten by Stéphane Gay and explained at “codegarden 13” on 2013/06/13.  This documentation is based on the slides which he made public using this [tweet](https://twitter.com/zpqrtbnk/status/345125834434158592).

![zpqrtbnk tweet](images/zpqrtbnk-status-345125834434158592.png)

##What is the pipeline
The request pipeline is the process of building up the URL for a node, resolving a request to a specified node and making sure that the right content is send back.

Stephan make it pretty clear with a very basic image:
![what is the pipeline](images/what-is-the-pipeline.png)

##Outbound vs inbound
The pipeline works bidirectional: [inbound](inbound-pipeline.md) and [outbound](outbound-pipeline.md).

[Outbound](outbound-pipeline.md) is the process of building up a URL for a requested node.  [Inbound](inbound-pipeline.md) is every request received by the webserver and handled by umbraco.

##Works by default
You don't need to do anything for the pipeline to work.    However, if you want to adapt it to your needs, you will need knowledge of the following topics:

- [Published content](../../Reference/Templating/Mvc/querying.md)
- [Resolvers](../../Reference/Plugins/index.md)   
