---
description: How-To Guide to configure SQLite support for Umbraco Commerce.
---

# Configure SQLite support

Out of the box, Umbraco Commerce only supports SQL Server-based databases as this is the recommended database platform for live environments. To aid testing and rapid prototyping, however, Umbraco Commerce can be configured to use an SQLite database.

{% hint style="warning" %}
Whilst Umbraco Commerce does support SQLite for testing, we do not recommend using it in a live environment. Due to the high levels of active connections required to manage concurrent shopping carts, this is not something SQLite handles well at all.
{% endhint %}

## Install SQLite dependencies

To add SQLite support, you will need to install the SQLite persistence layer NuGet package for Umbraco Commerce.

```bash
PM> dotnet add package Umbraco.Commerce.Persistence.Sqlite
```

Once the NuGet package is installed, you need to register SQLite support with Umbraco Commerce via the [`IUmbracoCommerceBuilder`](../key-concepts/umbraco-commerce-builder.md) interface.

Add .`AddUmbracoCommerce()` below `.AddWebsite()` in the `Program.cs` file.

```csharp
.AddUmbracoCommerce(builder => {
    builder.AddSQLite();
})
```

After configuring Umbraco CMS with SQLite, Umbraco Commerce will automatically utilize the same database configuration. If you wish to install Umbraco Commerce into its own SQLite database you can configure its connection string in the `appSettings.json` like so:

```json
{
    ...
    "ConnectionStrings": {
        "umbracoDbDSN": "Data Source=|DataDirectory|/Umbraco.sqlite.db;Foreign Keys=True;Pooling=True",
        "umbracoDbDSN_ProviderName": "Microsoft.Data.Sqlite",
        "umbracoCommerceDbDSN": "Data Source=|DataDirectory|/Umbraco.Commerce.sqlite.db;Mode=ReadWrite;Foreign Keys=True;Pooling=True",
        "umbracoCommerceDbDSN_ProviderName": "Microsoft.Data.Sqlite"
    },
    ...
}

```

{% hint style="warning" %}
Do not use shared cache (`Cache=Shared`) in a SQLite connection string. Umbraco Commerce creates its SQLite databases in [write-ahead logging mode](https://sqlite.org/wal.html), where readers and writers do not block each other. [Shared cache](https://sqlite.org/sharedcache.html) instead uses table-level locking. A connection that cannot get a table lock fails with `database table is locked` instead of waiting.
{% endhint %}
