---
versionFrom: 7.0.0
---

# Routing in Umbraco

_This section describes what the Umbraco Request Pipeline is, how Umbraco matches a document to a given request and how it generates a URL for a document._

## Request pipeline

### What is the pipeline

The request pipeline is the process of building up the URL for a node, resolving a request to a specified node and making sure that the right content is sent back.

![what is the pipeline](images/what-is-the-pipeline.png)

### Outbound vs Inbound

The pipeline works bidirectional: **[inbound](inbound-pipeline-v8.md)** and **[outbound](outbound-pipeline-v8.1.md)**.

**[Outbound](outbound-pipeline-v8.1.md)** is the process of building up a URL for a requested node. **[Inbound](inbound-pipeline-v8.md)** is every request received by the web server and handled by Umbraco.

### Customizing the pipeline

This section will describe the components that you can use to modify Umbraco's request pipeline: **[IContentFinder](IContentFinder-v8.md)** & `IUrlProvider`
