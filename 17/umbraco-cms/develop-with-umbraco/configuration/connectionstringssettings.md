---
description: "Information on the connection strings settings section"
---

# Connection strings settings

The connection strings settings section contains the connection string to the database Umbraco will connect to. This section is similar to what is used by default in .NET Core. The important thing is that the key for the connection string Umbraco will use is `"umbracoDbDSN"`. It is also important to know that this section is outside the `Umbraco.CMS` section, and is therefore in the root of the config.

The connection strings config can look like this:

```json
{
  "ConnectionStrings": {
    "umbracoDbDSN": "Data Source=|DataDirectory|/Umbraco.sqlite.db;Cache=Shared;Foreign Keys=True;Pooling=True",
    "umbracoDbDSN_ProviderName": "Microsoft.Data.Sqlite"
  }
}
```

{% hint style="info" %}
It is recommended to use shared cache for SQLite when using Umbraco. It provides better performance and consistency when multiple connections may access the database simultaneously.
{% endhint %}

The connection string used here is an SQLite connection string, that will connect to a data in the file `Umbraco.sqlite.db`  located in `/umbraco/Data` .

Umbraco currently supports using either a Microsoft SQL Server or a SQLite database. Both of these options will have different connection strings. For more information about the specific connection strings, see:

* [SQL Server 2019 connection strings](https://www.connectionstrings.com/sql-server-2019/)
* [SQLite connection strings](https://www.connectionstrings.com/sqlite/)

{% hint style="info" %}
If you're using Umbraco 9 [SQL Server Compact database](https://www.connectionstrings.com/sql-server-compact/) is supported instead of SQLite.
{% endhint %}

## Database timeouts

Two separate timeouts apply to the database connection:

* The **command timeout** is the maximum time a single database command can run before it is canceled.
* The **connect timeout** is the maximum time to wait when opening a connection to the database.

You can set both in the connection string, or with the [Database command timeout](globalsettings.md#database-command-timeout) and [Database connect timeout](globalsettings.md#database-connect-timeout) global settings.

The keywords used in the connection string depend on the database provider:

| Provider | Command timeout | Connect timeout |
| --- | --- | --- |
| SQL Server | `Command Timeout` | `Connect Timeout` or `Connection Timeout` |
| SQLite | `Default Timeout` | Not supported |

The following connection string gives commands five minutes to complete, while a connection attempt is abandoned after 30 seconds:

```json
{
  "ConnectionStrings": {
    "umbracoDbDSN": "Server=.;Database=Umbraco;Integrated Security=true;TrustServerCertificate=true;Connect Timeout=30;Command Timeout=300",
    "umbracoDbDSN_ProviderName": "Microsoft.Data.SqlClient"
  }
}
```

### How the command timeout is resolved

Umbraco uses the first of the following that applies:

1. A timeout set in code for a single command.
2. A timeout set in code on the database instance, for example by a package.
3. The `Umbraco:CMS:Global:DatabaseCommandTimeout` setting.
4. The command timeout in the connection string.
5. The connect timeout in the connection string. This step is deprecated. See [Deprecated: connect timeout used as the command timeout](#deprecated-connect-timeout-used-as-the-command-timeout).
6. The database provider's default, which is 30 seconds for both SQL Server and SQLite.

The connect timeout is resolved the same way, without the deprecated step: the `DatabaseConnectTimeout` setting first, then the connection string, then the provider default.

{% hint style="info" %}
The global settings are applied by rewriting the connection string. Every consumer of the connection string sees the configured values, not only Umbraco's own data access.
{% endhint %}

### Deprecated: connect timeout used as the command timeout

Where the connection string sets a connect timeout and no command timeout, Umbraco also uses the connect timeout as the command timeout. This behavior is deprecated. Where it applies, Umbraco logs a warning once at startup.

{% hint style="warning" %}
This fallback is removed in Umbraco 19. A site that relies on it then gets the provider default of 30 seconds instead.
{% endhint %}

To prepare, do one of the following:

* Add `Command Timeout` to the connection string.
* Configure the `Umbraco:CMS:Global:DatabaseCommandTimeout` setting.

## Provider name
Because Umbraco cannot determine the provider name from the connection string in all cases. Umbraco follows [Microsoft's convention](https://learn.microsoft.com/en-us/aspnet/core/fundamentals/configuration/?view=aspnetcore-8.0#connection-string-prefixes-1) for provider names, which involves specifying it as a postfix in the connection string name.

