---
description: >-
  Configure the database connection string and review the optional Umbraco
  Automate settings.
---

# Configuration

Umbraco Automate stores its data (automations, runs, connections, workspaces) in a database. By default the package looks for a dedicated connection string, but you can point it at the main Umbraco database instead.

## Configure the Database Connection

Add a connection string named `umbracoAutomateDbDSN` to your `appsettings.json`:

{% code title="appsettings.json" %}
```json
{
  "ConnectionStrings": {
    "umbracoAutomateDbDSN": "Server=(LocalDb)\\MSSQLLocalDB;Database=UmbracoAutomate;Integrated Security=true",
    "umbracoAutomateDbDSN_ProviderName": "Microsoft.Data.SqlClient"
  }
}
```
{% endcode %}

Both SQL Server and SQLite are supported, matching Umbraco CMS itself.

### Sharing the Umbraco Database

If you cannot edit the connection string (for example on Umbraco Cloud), tell Automate to reuse the main Umbraco connection string by setting `UseNamedConnectionString`:

{% code title="appsettings.json" %}
```json
{
  "Umbraco": {
    "Automate": {
      "UseNamedConnectionString": "umbracoDbDSN"
    }
  }
}
```
{% endcode %}

{% hint style="info" %}
On Umbraco Cloud you will not find a `umbracoDbDSN` entry in `appsettings.json`. Umbraco generates the CMS connection string at runtime. Set `UseNamedConnectionString` to `umbracoDbDSN` and Automate resolves the generated connection string by name.
{% endhint %}

{% hint style="warning" %}
Sharing the Umbraco database adds outbox, run history, and engine traffic to that database. Use a dedicated database where possible.
{% endhint %}

## Optional Settings

All optional settings live under `Umbraco:Automate` in `appsettings.json`.

The defaults are suitable for most sites:

{% code title="appsettings.json" %}
```json
{
  "Umbraco": {
    "Automate": {
      "Enabled": true,
      "Webhook": {
        "MaxPayloadBytes": 1048576,
        "RateLimitPerMinute": 100
      },
      "Execution": {
        "DefaultTimeout": "00:05:00",
        "MaxConcurrentRuns": 10,
        "MaxChainDepth": 5,
        "MaxHttpResponseBodyBytes": 10485760
      },
      "Governance": {
        "AuditLogEnabled": true,
        "AuditLogRetentionDays": 90,
        "SensitiveDataMasking": true
      }
    }
  }
}
```
{% endcode %}

| Section      | Purpose                                                                         |
| ------------ | ------------------------------------------------------------------------------- |
| `Enabled`    | Master switch for the automation engine.                                        |
| `Webhook`    | Maximum payload size and per-automation rate limit for incoming webhooks.       |
| `Execution`  | Default step timeout, concurrent run limit, maximum automation chain depth, and maximum HTTP response body size. |
| `Governance` | Audit log retention and sensitive data masking.                                 |

## Next Steps

{% content-ref url="first-automation.md" %}
[first-automation.md](first-automation.md)
{% endcontent-ref %}
