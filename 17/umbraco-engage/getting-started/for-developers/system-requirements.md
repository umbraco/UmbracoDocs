---
description: Learn about the system requirements before installing Umbraco Engage.
---

# System Requirements

Umbraco Engage has the following requirements:

* Umbraco version 17
* .NET 10.0
* SQL Server 2014+, LocalDB, or Azure SQL
  * **SQL CE & SQLite are not supported.**

{% hint style="info" %}
It is recommended to upgrade your Umbraco installation to the latest version of Umbraco 17.
{% endhint %}

## Database Requirements

Umbraco Engage uses **columnstore indexes** for optimal query performance on analytics data. This has implications for your database choice:

### SQL Server (On-Premises / Self-Hosted)

* **SQL Server 2014 or higher** is required
* Columnstore index support varies by edition - Enterprise Edition is recommended for older SQL Server versions

### Azure SQL

* **S3 tier (100 DTUs) or higher** is required to **create** columnstore indexes during installation
* Lower tiers (S0, S1, S2) can **query** existing columnstore indexes but cannot create them
* See [Infrastructure Sizing](infrastructure-sizing.md) for detailed Azure SQL recommendations

{% hint style="warning" %}
If you attempt to install Umbraco Engage on an Azure SQL tier lower than S3, the initial migration will fail. See [Troubleshooting Installations](troubleshooting-installations.md) for workarounds.
{% endhint %}

### LocalDB

LocalDB supports columnstore indexes and can be used for local development.

See the [Troubleshooting](../../installation/troubleshooting-installs.md) section if you need to upgrade from SQL CE to SQL Server.

## Umbraco Cloud Compatibility

Umbraco Engage is compatible with Umbraco Cloud (Standard, Professional, and Enterprise plans).

{% hint style="info" %}
If you want to run an Umbraco Cloud site locally, point the connection string to a (local) SQL Server database. SQLite is not supported.
{% endhint %}

Umbraco Deploy is currently not supported for the Umbraco Engage features.

## Frontend Development Requirements

If you are developing custom extensions for Umbraco Engage (such as custom segment parameters or external profile data components), the following additional requirements apply:

* `Node.js 22+`
* `npm 10.9+`

These are only required for developers building custom frontend components, not for standard Umbraco Engage usage.
