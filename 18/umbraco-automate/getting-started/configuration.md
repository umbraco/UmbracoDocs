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
      "Webhook": {
        "MaxPayloadBytes": 1048576,
        "RateLimitPerMinute": 100
      },
      "Execution": {
        "Mode": "SchedulerOnly",
        "DefaultTimeout": "00:05:00",
        "MaxConcurrentRuns": 0,
        "PollInterval": "00:00:10",
        "MaxChainDepth": 5,
        "MaxHttpResponseBodyBytes": 10485760,
        "MaxMediaFileBytes": 10485760,
        "AllowOutboundHttpProxy": true,
        "MinimumLogLevel": "Info",
        "MaxLogEntriesPerStep": 200
      },
      "RateLimiting": {
        "Enabled": true,
        "MaxRunsPerAutomationPerMinute": 60,
        "MaxConcurrentRunsPerAutomation": 10
      },
      "WorkflowLock": {
        "LeaseDuration": "00:00:30",
        "RenewalInterval": "00:00:10"
      }
    }
  }
}
```
{% endcode %}

| Section      | Purpose                                                                         |
| ------------ | ------------------------------------------------------------------------------- |
| `Webhook`    | Maximum payload size and per-automation rate limit for incoming webhooks.       |
| `Execution`  | Which nodes run automations, default step timeout, concurrent run limit and poll interval (see [Engine Concurrency and Polling](#engine-concurrency-and-polling)), maximum automation chain depth (also enforced by the **Start Automation** action), maximum HTTP response body size, maximum media file download size, and outbound proxy use. Also the lowest level of step log entry recorded (`Debug`, `Info`, `Warning`, or `Error`) and how many entries each step keeps. See [Outbound Requests](#outbound-requests). See [Load Balancing](../run-in-production/load-balancing.md) for `Mode`. |
| `RateLimiting` | How many runs each automation can start per minute, and how many can run at once. When a trigger fires for an automation that is over a limit, Automate skips that automation and logs a warning. Other automations on the same event still run. Suspended runs, such as runs waiting for an approval, don't count towards the limit on runs at once. |
| `WorkflowLock` | How long a node holds the lock on a run it is executing, and how often it renews it. See [Load Balancing](../run-in-production/load-balancing.md#restarting-a-node). |
| `Scripting`, `RunCleanup`, `VersionCleanup`, `ScheduledTrigger`, `CircuitBreaker`, `Outbox` | Described in their own sections below. |

{% hint style="info" %}

`Umbraco:Automate:Enabled` and the `Umbraco:Automate:Governance` section are obsolete. They never had any effect, and are scheduled for removal in Umbraco Automate 19. Remove them from your configuration:

* To control who can use automations, grant or remove access to the **Automation** section.
* Sensitive values are always masked, and runs are always recorded.
* Run retention is set with `RunCleanup:RetentionDays`. See [Run Cleanup](#run-cleanup).
* Notifications are set per automation, with notification channels.

{% endhint %}

### Engine Concurrency and Polling

`Execution:MaxConcurrentRuns` limits how many runs each node executes at the same time. Runs waiting on a **Delay** or an approval don't count. Work over the limit waits in the queue rather than being rejected. The default of `0` uses the engine's own limit: the number of processors, with a minimum of 4. For a limit per automation, use `RateLimiting:MaxConcurrentRunsPerAutomation`.

`Execution:PollInterval` sets how often the engine checks for runs that are ready to continue, such as a run whose delay has elapsed. The default is 10 seconds.

Automate reads both settings once at startup, so restart the site after changing them.

{% hint style="warning" %}

Earlier versions of this page showed `"MaxConcurrentRuns": 10` in the example, but the setting had no effect. If your configuration still sets it to `10`, each node is now limited to 10 concurrent runs. Set it to `0` to use the engine default.

{% endhint %}

### Outbound Requests

Automations send outbound HTTP requests from the **HTTP Request** action, Run Script `fetch` calls, media file downloads, and webhook notification channels. Automate only sends these requests to public destinations. It refuses requests to the following address categories:

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

### Run Script Settings

The `Scripting` section controls the sandbox the **Run Script** action runs in:

{% code title="appsettings.json" %}
```json
{
  "Umbraco": {
    "Automate": {
      "Scripting": {
        "Enabled": true,
        "FetchEnabled": true,
        "FetchAllowedHosts": [],
        "MaxMemoryBytes": 5242880,
        "MaxRecursionDepth": 64,
        "MaxArraySize": 1000,
        "MaxStatements": 10000,
        "StatementTimeout": "00:00:03",
        "TotalExecutionTimeout": "00:00:15",
        "HttpRequestTimeout": "00:00:05",
        "MaxResponseBodyBytes": 10485760
      }
    }
  }
}
```
{% endcode %}

Set `Enabled` to `false` to turn off **Run Script** for the whole site. Existing Run Script steps then fail, and saving a script is rejected. `TotalExecutionTimeout` is also capped by the step timeout. See [Actions](../concepts/actions.md) for how `FetchEnabled` and `FetchAllowedHosts` work with each step's **Allow fetch** setting.

### Run Cleanup

The `RunCleanup` section controls how long Automate keeps run history:

{% code title="appsettings.json" %}
```json
{
  "Umbraco": {
    "Automate": {
      "RunCleanup": {
        "Enabled": true,
        "RetentionDays": 90,
        "MaxRunsPerAutomation": 1000
      }
    }
  }
}
```
{% endcode %}

Automate deletes runs older than `RetentionDays`, and keeps at most `MaxRunsPerAutomation` runs for each automation. Set either value to `0` to turn off that limit. Cleanup also removes the workflow engine's data for finished runs older than `RetentionDays`. With `RetentionDays` set to `0`, that engine data is kept.

### Version Cleanup

The `VersionCleanup` section controls how much version history Automate keeps for automations and connections:

{% code title="appsettings.json" %}
```json
{
  "Umbraco": {
    "Automate": {
      "VersionCleanup": {
        "Enabled": true,
        "MaxVersionsPerEntity": 50,
        "RetentionDays": 90
      }
    }
  }
}
```
{% endcode %}

A version is kept only while it is within both limits. Set either value to `0` to turn off that limit. See [Versioning](../concepts/versioning.md).

### Step Retries and Output Size

These `Execution` settings apply to every step unless the step sets its own value:

| Setting                | Default    | Description                                                                                                  |
| ---------------------- | ---------- | ------------------------------------------------------------------------------------------------------------ |
| `DefaultMaxRetries`    | `10`       | How many times a failing step with the **Retry** error behavior retries when **Max retries** is empty.         |
| `DefaultRetryInterval` | `00:00:30` | How long a step waits between retries when **Retry interval** is empty.                                      |
| `MaxInlineOutputBytes` | `16384`    | Step outputs larger than this are stored with the step run, and read back when a later binding needs them. |

See [Step Behaviour](../concepts/actions.md#step-behaviour) for the per-step settings.

### Scheduled Triggers

The `ScheduledTrigger` section controls how Automate checks for scheduled triggers that are due:

{% code title="appsettings.json" %}
```json
{
  "Umbraco": {
    "Automate": {
      "ScheduledTrigger": {
        "PollInterval": "00:01:00",
        "StartupDelay": "00:02:00",
        "MaxJitter": "00:05:00"
      }
    }
  }
}
```
{% endcode %}

* `PollInterval` sets how often Automate checks for due schedules.
* `StartupDelay` sets how long Automate waits after startup before the first check.
* `MaxJitter` spreads out schedules that use flexible timing. Each automation gets a fixed offset of up to this amount, so many automations on the same schedule don't all start at once. Set it to `00:00:00` to turn off jitter.

### Circuit Breaker

The circuit breaker turns off an automation that keeps failing, for example because of a configuration mistake. First, the automation is marked as degraded, and a banner warns about the high error rate. If failures continue after the grace period, Automate turns the automation off. Fix the problem, then select **Re-enable** on the automation.

{% code title="appsettings.json" %}
```json
{
  "Umbraco": {
    "Automate": {
      "CircuitBreaker": {
        "Enabled": true,
        "ConsecutiveWarningThreshold": 5,
        "ConsecutiveFailureThreshold": 10,
        "WarningErrorRate": 0.5,
        "DisableErrorRate": 0.7,
        "EvaluationWindowSize": 20,
        "GracePeriodAfterWarning": "1.00:00:00",
        "AllowManualRunWhileDisabled": true
      }
    }
  }
}
```
{% endcode %}

| Setting                       | Description                                                                                              |
| ----------------------------- | -------------------------------------------------------------------------------------------------------- |
| `ConsecutiveWarningThreshold` | Consecutive failed runs before the automation is marked as degraded.                                     |
| `ConsecutiveFailureThreshold` | Consecutive failed runs before the automation is turned off.                                             |
| `WarningErrorRate`            | Share of failed runs, from `0` to `1`, that marks the automation as degraded.                            |
| `DisableErrorRate`            | Share of failed runs, from `0` to `1`, that turns the automation off.                                    |
| `EvaluationWindowSize`        | How many recent finished runs the error rates are calculated over. The rates only apply once this many runs exist. |
| `GracePeriodAfterWarning`     | How long after the warning Automate waits before it can turn the automation off.                        |
| `AllowManualRunWhileDisabled` | Whether **Run now** and **Replay** still work on a turned-off automation, so you can test a fix. A successful test run does not turn the automation back on. |

Notification channels can notify you when an automation is degraded, turned off, or re-enabled.

### Outbox

Automate queues trigger events in an outbox table before it starts runs. The `Outbox` section controls how that queue is processed:

{% code title="appsettings.json" %}
```json
{
  "Umbraco": {
    "Automate": {
      "Outbox": {
        "PollInterval": "00:00:00.500",
        "MaxRetries": 3,
        "BaseRetryDelay": "00:00:05",
        "StaleClaimThreshold": "00:05:00",
        "CompletedRetention": "1.00:00:00",
        "DrainTimeout": "00:00:30",
        "MaxPendingMessages": 10000
      }
    }
  }
}
```
{% endcode %}

| Setting               | Description                                                                                                    |
| --------------------- | -------------------------------------------------------------------------------------------------------------- |
| `PollInterval`        | How often the dispatcher checks for new messages.                                                              |
| `MaxRetries`          | How many times a message is delivered before it is moved to the dead-letter state.                             |
| `BaseRetryDelay`      | The first delay between retries. Each later retry waits twice as long.                                         |
| `StaleClaimThreshold` | How long a node can hold a message before another node may take it over, for example after a crash.           |
| `CompletedRetention`  | How long processed messages are kept before cleanup removes them.                                              |
| `DrainTimeout`        | On shutdown, how long Automate waits for messages that are already being processed.                            |
| `MaxPendingMessages`  | How many unprocessed messages the outbox can hold. New events are rejected at the limit. Set it to `0` for no limit. |

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
