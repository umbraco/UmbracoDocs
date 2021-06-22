---
versionFrom: 9.0.0
meta.Title: "Umbraco Connection Strings Settings"
meta.Description: "Information on the connection strings settings section"
state: complete
verified-against: beta-3
update-links: true
---

# Connection strings settings

The connection strings settings section contains the connection string to the database Umbraco will connect to. This section is very similar to what's used by default in .Netcore, the important thing though is that the key for the connection string umbraco will use is `"umbracoDbDSN"`. It is also important to note that this section is outside the `Umbraco.CMS` section, and is therefore in the root of the config.

An connection strings config can look like this: 

```json
"ConnectionStrings": {
  "umbracoDbDSN": "Server=.;Database=DocsSite;Integrated Security=true"
}
```

The connection string used here is an SQL Server 2019 connection string, that will connect to `DocsSite` database running on the locally hosted SQL Server using integrated security.

Umbraco currently supports using either a Microsoft SQL Server, or a SQL Server Compact database, both of these will look different for more information about the specific connection strings see:

* [SQL Server 2019 connection strings](https://www.connectionstrings.com/sql-server-2019/)
* [SQL Server Compact connection strings](https://www.connectionstrings.com/sql-server-compact/)