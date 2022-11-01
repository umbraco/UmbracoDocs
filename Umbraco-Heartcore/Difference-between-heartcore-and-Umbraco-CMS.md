# What is the difference between Umbraco Heartcore and the Umbraco CMS

In this, article we are going to have a look at the differences between Umbraco Heartcore and Umbraco CMS.

Since Umbraco Heartcore is a software As A Service (SaaS) there is a couple of differences between it and the Umbraco CMS.

## Differences between Heartcore and Umbraco CMS

Two things that are missing in Umbraco Heartcore that are available in the CMS are the package section and the template section.

Also, some special property aliases available in the CMS are not available in Umbraco Heartcore.

### Package Section

As a SaaS, it is not possible to install packages in Umbraco Heartcore as the code base is Closed source.

Instead, other features like **GraphQL**, an out-of-the-box **Content Delivery Network** (CDN) by Cloudflare and a **Preview API** are available in Umbraco Heartcore.

### Template section

Since Umbraco Heartcore is a headless offering, meaning the frontend is decoupled from the backend.
Therefore it is not possible to create templates in Umbraco Heartcore and the section is not available.

### Special property aliases

In the Umbraco CMS, some [**special property aliases**](/Reference/Routing/Routing-Properties/index.md) can manipulate the standard Umbraco routing pipeline.

Since the frontend and backend of Umbraco Heartcore are decoupled it's not possible to use these aliases in Umbraco Heartcore.
