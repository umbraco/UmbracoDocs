---
description: >-
  When using a tool like uMS, security and privacy are important considerations
  due to the involvement of user data.
---

# Security and privacy

Security is a first-class citizen in the uMS. Besides performance and all the features, security is important in all parts of uMS.

uMS is made secure and safe allowing you to have full control of all data of your visitors.

In this section, you can dive deeper into the following aspects.

## Security settings

uMS works in most ways like other Umbraco packages. Read and apply the [security documentation & guidelines](https://our.umbraco.com/Documentation/Reference/Security/) of Umbraco CMS.

When you have [locked down access to your Umbraco folder](https://our.umbraco.com/Documentation/Reference/Security/Security-hardening/#lock-down-access-to-your-umbraco-folders), ensure the `/umbraco/uMarketingSuite/\*` path is allowed for all clients. You should also ensure it is not blocked based on an IP. This is needed to collect [client-side events](../../../the-umarketingsuite-broad-overview/dataflow-pipeline/data-collection/).

## Privacy settings

uMS stores a lot of data, but because it is stored in your database(s) you have full control over this data. The data is never stored in a central datacenter and no visitor data is ever transmitted to Umbraco.

uMS can be [configured](../../../installing-umarketingsuite/configuration-options-2-x/) to store the data in whatever database you specify. This can be the same database as the Umbraco installation, or a different database.

Aside from full control, uMS also gives you tools to anonymize and [fully delete](../../../security-privacy/retention-periods-of-data/) the data.
