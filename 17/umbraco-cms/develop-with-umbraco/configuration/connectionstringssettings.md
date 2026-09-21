---
description: "Information on the connection strings settings section"
---

# Connection strings settings

The connection strings settings section contains the connection string to the database Umbraco will connect to. This section is similar to what is used by default in .NET Core. The important thing is that the key for the connection string Umbraco will use is `"umbracoDbDSN"`. It is also important to know that this section is outside the `Umbraco.CMS` section, and is therefore in the root of the config.

The connection strings config can look like this:

```json
{
  "ConnectionStrings": {
    "umbracoDbDSN": "Data Source=|DataDirectory|/Umbraco.sqlite.db;Foreign Keys=True;Pooling=True",
    "umbracoDbDSN_ProviderName": "Microsoft.Data.Sqlite"
  }
}
```

{% hint style="warning" %}
Do not use shared cache (`Cache=Shared`) in a SQLite connection string. Umbraco creates its SQLite databases in [write-ahead logging mode](https://sqlite.org/wal.html), where readers and writers do not block each other. [Shared cache](https://sqlite.org/sharedcache.html) instead uses table-level locking. A connection that cannot get a table lock fails with `database table is locked` instead of waiting.

From Umbraco 17.8, `Cache=Shared` is removed from the connection string on startup and the removal is logged. Remove the keyword from `appsettings.json` to stop this correction from running on every startup.
{% endhint %}

The connection string used here is an SQLite connection string, that will connect to a data in the file `Umbraco.sqlite.db`  located in `/umbraco/Data` .

Umbraco currently supports using either a Microsoft SQL Server or a SQLite database. Both of these options will have different connection strings. For more information about the specific connection strings, see:

* [SQL Server 2019 connection strings](https://www.connectionstrings.com/sql-server-2019/)
* [SQLite connection strings](https://www.connectionstrings.com/sqlite/)

{% hint style="info" %}
If you're using Umbraco 9 [SQL Server Compact database](https://www.connectionstrings.com/sql-server-compact/) is supported instead of SQLite.
{% endhint %}

## Provider name
Because Umbraco cannot determine the provider name from the connection string in all cases. Umbraco follows [Microsoft's convention](https://learn.microsoft.com/en-us/aspnet/core/fundamentals/configuration/?view=aspnetcore-8.0#connection-string-prefixes-1) for provider names, which involves specifying it as a postfix in the connection string name.

