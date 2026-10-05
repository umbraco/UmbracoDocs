---
description: >-
  Configure the database connection string and review the optional Umbraco
  Automate settings.
---

# Configuration

Umbraco Automate stores its data (automations, runs, connections, workspaces) in a database. By default, the package looks for a dedicated connection string, but you can point it at the main Umbraco database instead.

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
        "Mode": "SchedulerOnly",
        "DefaultTimeout": "00:05:00",
        "MaxConcurrentRuns": 10,
        "MaxChainDepth": 5,
        "MaxHttpResponseBodyBytes": 10485760,
        "AllowOutboundHttpProxy": true
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
| `Execution`  | Which nodes run automations, default step timeout, concurrent run limit, maximum automation chain depth, maximum HTTP response body size, and outbound proxy use. See [Outbound Requests](#outbound-requests). See [Load Balancing](../run-in-production/load-balancing.md) for `Mode`. |
| `Governance` | Audit log retention and sensitive data masking.                                 |

### Outbound Requests

Automations send outbound HTTP requests from the **HTTP Request** action, Run Script `fetch` calls, media file downloads, and webhook failure notifications. Automate only sends these requests to public destinations. It refuses requests to the following address categories:

* Localhost, private, link-local, and unique local addresses.
* Shared address space used by internet service providers.
* Reserved, benchmarking, documentation, broadcast, and group (`multicast`) ranges.
* Cloud platform and metadata service addresses.
* The IPv6 equivalents of these categories.

Automate checks an IPv4 address embedded in an IPv6 address against the IPv4 rules. Public destinations reached that way keep working.

By default, outbound requests use the proxy configured for the system or environment, for example through `HTTP_PROXY` or `HTTPS_PROXY`. When a request goes through a proxy, Automate resolves the destination host and checks it before sending the request. It repeats the check for every redirect.

To ignore any proxy and always connect directly, set `Execution:AllowOutboundHttpProxy` to `false`:

{% code title="appsettings.json" %}
```json
{
  "Umbraco": {
    "Automate": {
      "Execution": {
        "AllowOutboundHttpProxy": false
      }
    }
  }
}
```
{% endcode %}

{% hint style="info" %}

A proxy looks up the destination host again on its own. Configure the proxy to deny access to internal networks as well.

{% endhint %}

## Configuration References

A settings field can reference a configuration value at run time with a `$Key:Path` syntax, instead of storing the value directly:

```
$Umbraco:Automate:Secrets:SlackToken
```

A reference can also be embedded inside a larger string, for example in an HTTP header value:

```
Bearer $Umbraco:Automate:Secrets:ApiToken
```

This lets administrators keep credentials and per-environment values in configuration — `appsettings.json`, environment variables, Azure Key Vault, and so on — rather than in the automation database.

### Allowed Key Prefixes

Automations run under an elevated service account, so configuration resolution is **default-deny**: a key only resolves when it falls under one of `AllowedConfigurationKeyPrefixes`. Any other key fails to resolve.

Two prefixes are allowed by default:

| Prefix                        | Intended for                                                          |
| ------------------------------ | ---------------------------------------------------------------------- |
| `Umbraco:Automate:Secrets`    | Sensitive values, such as API tokens.                                 |
| `Umbraco:Automate:Variables`  | Non-sensitive per-environment values, such as base URLs or feature flags. |

{% code title="appsettings.json" %}
```json
{
  "Umbraco": {
    "Automate": {
      "Secrets": {
        "SlackToken": "xoxb-..."
      },
      "Variables": {
        "BaseUrl": "https://example.com"
      }
    }
  }
}
```
{% endcode %}

Reference these values from a setting field with `$Umbraco:Automate:Secrets:SlackToken` or `$Umbraco:Automate:Variables:BaseUrl`.

To expose an existing configuration section to automations without copying its values, add its prefix to `AllowedConfigurationKeyPrefixes`:

{% code title="appsettings.json" %}
```json
{
  "Umbraco": {
    "Automate": {
      "AllowedConfigurationKeyPrefixes": [
        "Umbraco:Automate:Secrets",
        "Umbraco:Automate:Variables",
        "MyApp:ThirdPartyApi"
      ]
    }
  }
}
```
{% endcode %}

{% hint style="warning" %}
Everything under an added prefix becomes readable by anyone who can configure automation settings. Only add a prefix you are comfortable exposing to automation authors.
{% endhint %}

### Secret Key Prefixes

Values under a prefix listed in `SecretConfigurationKeyPrefixes` (`Umbraco:Automate:Secrets` by default) can only be referenced from a settings field marked sensitive. See [Create a Custom Connection Type](../extending/custom-connection-type.md) for `IsSensitive`. Referencing a secret key from a non-sensitive field fails. A resolved secret can only land in a field the system already encrypts at rest and masks in run logs.

`Umbraco:Automate:Variables` is deliberately left off `SecretConfigurationKeyPrefixes`, so non-secret values can be referenced from any field.

Matching for both lists is segment-aware and case-insensitive: the prefix `Umbraco:Automate:Secrets` matches `Umbraco:Automate:Secrets:SlackToken` but not `Umbraco:Automate:SecretsBackup:X`.

{% hint style="info" %}
`AllowedConfigurationKeyPrefixes` and `SecretConfigurationKeyPrefixes` are configured in `appsettings.json` only — they are not editable from the backoffice.
{% endhint %}

## Next Steps

{% content-ref url="first-automation.md" %}
[first-automation.md](first-automation.md)
{% endcontent-ref %}
