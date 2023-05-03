---
title: Configuring SQLite support
description: How-To Guide to configure SQLite support for Vendr, the eCommerce solution for Umbraco
---

Out of the box Vendr v3+ only supports SQL Server based databases as this is the recomended database platform for live environments. To aid testing and rapid prototyping however, Vendr can be configured to use a SQLite database.

<message-box type="warning" heading="A note about SQLite">

Whilst Vendr does support SQLite for testing, we do not recommend using it in a live environment. Due to the high levels of active connections required to manage concurrent shopping carts, this is not something SQLite handles well at all.

</message-box>


## Installing the SQLite dependencies

To add SQLite support, you'll need to install the SQLite persistence layer NuGet package for Vendr.

```bash
PM> dotnet add package Vendr.Persistence.Sqlite
```

Once the NuGet package is installed, you'll then need to register SQLite support with Vendr via the [`IVendrBuilder`](../key-concepts/vendr-builder/#registering-dependencies) interface.

````csharp
...
.AddVendr(vendrBuilder => {
    vendrBuilder.AddSQLite();
})
...

````

If you have setup Umbraco to use SQLite, this should be all you need to do as Vendr will use the same database connection string as Umbraco, but if you wish to install Vendr into it's own SQLite database you can configure it's own connection string like so.

````json
{
    ...
    "ConnectionStrings": {
        "umbracoDbDSN": "Data Source=|DataDirectory|/Umbraco.sqlite.db;Cache=Shared;Foreign Keys=True;Pooling=True",
        "umbracoDbDSN_ProviderName": "Microsoft.Data.SQLite",
        "vendrDbDSN": "Data Source=|DataDirectory|/Vendr.sqlite.db;Mode=ReadWrite;Foreign Keys=True;Pooling=True;Cache=Shared",
        "vendrDbDSN_ProviderName": "Microsoft.Data.SQLite"
    },
    ...
}

````