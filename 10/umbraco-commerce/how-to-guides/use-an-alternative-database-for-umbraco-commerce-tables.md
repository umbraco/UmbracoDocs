---
description: >-
  How-To Guide to configure using an alternative database for the tables of
  Umbraco Commerce.
---

# Use an Alternative Database for Umbraco Commerce Tables

By default, Umbraco Commerce will use the same database as Umbraco to store its data. As e-commerce and content management have different database needs, it may be beneficial to house the Umbraco Commerce database tables in an alternative database.

To do this, you can configure a Umbraco Commerce-specific connection string in your app settings `ConnectionStrings` section using the `umbracoCommerceDbDSN` prefix.

```json
{
    ...
    "ConnectionStrings": {
        "umbracoDbDSN": "Server=umbracoServerAddress;Database=myUmbracoDb;User Id=myUsername;Password=myPassword;",
        "umbracoDbDSN_ProviderName": "Microsoft.Data.SqlClient",
        "umbracoCommerceDbDSN": "Server=umbracoCommerceServerAddress;Database=myUmbracoCommerceDb;User Id=myUsername;Password=myPassword;",
        "umbracoCommerceDbDSN_ProviderName": "Microsoft.Data.SqlClient"
    },
    ...
}
```

When Umbraco Commerce runs, it will perform all of its migrations and operations against this database instead of the default Umbraco database.
