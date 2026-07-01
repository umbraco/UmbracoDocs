---
description: Internal developer reference for custom Umbraco Automate extensions.
---

# Technical Runbook: Extending Automate for Developers

This internal developer reference outlines local conventions, configuration structures, and implementation patterns used to create custom workflow assets.

Prior to building a custom extension, see the [Extension Points Overview](../extending/README.md) article.

## Core Database & Architecture Layout

While workflow flows are designed visually on the backoffice canvas, custom blocks write and query configurations across distinct data layers:

- **Core CMS Content/Media Stores:** Managed via `umbracoDbDSN` inside your main SQLite instance (`Umbraco.sqlite.db`).
- **Automate Schemas & Run Trackers:** All custom workflow definitions, workspace permissions, and step run execution histories run inside a separate database layer mapped via `umbracoAutomateDbDSN` (`Umbraco.Automate.sqlite.db`).

## Implementation Blueprints

{% tabs %}
{% tab title="Custom Action" %}

Actions execute steps in an automation sequence and optionally produce output for downstream steps. They must inherit from `ActionBase<T>` where `T` is a strongly-typed `[DataContract]` model.

### The Configuration Model

{% code title="WebhookActionConfiguration.cs" %}

```csharp
using System.ComponentModel.DataAnnotations;
using System.Runtime.Serialization;

namespace MyCompany.Project.Core.Automate.Actions;

[DataContract]
public class WebhookActionConfiguration
{
    [DataMember]
    [Required]
    public string Url { get; set; } = string.Empty;

    [DataMember]
    public string Method { get; set; } = "POST";
}
```

{% endcode %}

### The Action Implementation

{% code title="WebhookAction.cs" %}

```csharp
using System;
using System.Threading.Tasks;
using Microsoft.Extensions.Logging;
using Umbraco.Cms.Core.Automate;

namespace MyCompany.Project.Core.Automate.Actions;

[Action("myCompany.postToWebhook", "Post to Webhook", Description = "Sends data to an external webhook", Category = "Integrations")]
public class WebhookAction : ActionBase<WebhookActionConfiguration>
{
    private readonly ILogger<WebhookAction> _logger;
    private readonly HttpClient _httpClient;

    public WebhookAction(ILogger<WebhookAction> logger, HttpClient httpClient)
    {
        _logger = logger;
        _httpClient = httpClient;
    }

    public override async Task<ActionResult> ExecuteAsync(ActionContext context, WebhookActionConfiguration configuration)
    {
        if (string.IsNullOrWhiteSpace(configuration.Url))
        {
            return ActionResult.Fail("Webhook URL is required.");
        }

        try
        {
            _logger.LogInformation("Posting automation execution data to {Url}", configuration.Url);
            // Operational execution logic here...

            return ActionResult.Success();
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Webhook request failed");
            throw; // Bubbling up exceptions allows Automate's Circuit Breaker to handle retries safely
        }
    }
}
```

{% endcode %}

{% endtab %}
{% tab title="Custom Trigger" %}

Triggers are entry points that fire automation runs. They inherit from `TriggerBase<TOutput>` where `TOutput` defines the data exposed to downstream steps via bindings.

### The Trigger Output Model

{% code title="OrderCreatedOutput.cs" %}

```csharp
using System;
using System.Runtime.Serialization;

namespace MyCompany.Project.Core.Automate.Triggers;

[DataContract]
public class OrderCreatedOutput
{
    [DataMember]
    public string OrderId { get; set; } = string.Empty;

    [DataMember]
    public string CustomerName { get; set; } = string.Empty;

    [DataMember]
    public decimal Amount { get; set; }

    [DataMember]
    public DateTime CreatedAt { get; set; }
}
```

{% endcode %}

### The Trigger Implementation

{% code title="OrderCreatedTrigger.cs" %}

```csharp
using System;
using System.Threading.Tasks;
using Microsoft.Extensions.Logging;
using Umbraco.Cms.Core.Automate;

namespace MyCompany.Project.Core.Automate.Triggers;

[Trigger("myCompany.orderCreated", "Order Created", Description = "Fires when a new order is created in the system", Category = "E-Commerce")]
public class OrderCreatedTrigger : TriggerBase<OrderCreatedOutput>
{
    private readonly ILogger<OrderCreatedTrigger> _logger;
    private readonly IOrderService _orderService;

    public OrderCreatedTrigger(ILogger<OrderCreatedTrigger> logger, IOrderService orderService)
    {
        _logger = logger;
        _orderService = orderService;
    }

    public override async Task<TriggerOutput<OrderCreatedOutput>> ExecuteAsync(TriggerContext context)
    {
        try
        {
            // Retrieve trigger data from context (typically injected from domain events or webhooks)
            var order = context.GetData<Order>("order");

            if (order == null)
            {
                _logger.LogWarning("Order trigger executed but no order data provided");
                return null; // Don't fire if data is missing
            }

            _logger.LogInformation("Order created trigger fired for Order {OrderId}", order.Id);

            return new TriggerOutput<OrderCreatedOutput>
            {
                Output = new OrderCreatedOutput
                {
                    OrderId = order.Id,
                    CustomerName = order.CustomerName,
                    Amount = order.Total,
                    CreatedAt = DateTime.UtcNow
                }
            };
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Order created trigger failed");
            throw;
        }
    }
}
```

{% endcode %}

{% endtab %}
{% tab title="Custom Connection" %}

Connections store reusable credentials for external services. They define which properties appear in the backoffice connection editor.

### The Connection Type Definition

{% code title="ExternalApiConnection.cs" %}

```csharp
using System.Collections.Generic;
using Umbraco.Cms.Core.Automate;

namespace MyCompany.Project.Core.Automate.Connections;

[ConnectionType("myCompany.externalApi", "External API", Description = "Credentials for our third-party API service")]
public class ExternalApiConnection : IConnectionType
{
    public IEnumerable<ConnectionProperty> Properties => new[]
    {
        new ConnectionProperty
        {
            Alias = "baseUrl",
            Name = "Base URL",
            EditorType = "textString",
            IsRequired = true,
            HelpText = "The root URL for the API (e.g., https://api.example.com)"
        },
        new ConnectionProperty
        {
            Alias = "apiKey",
            Name = "API Key",
            EditorType = "secureString", // Encrypted at rest in the database
            IsRequired = true,
            HelpText = "Your API authentication key"
        },
        new ConnectionProperty
        {
            Alias = "timeout",
            Name = "Timeout (seconds)",
            EditorType = "number",
            IsRequired = false,
            HelpText = "Request timeout in seconds (default: 30)"
        }
    };
}
```

{% endcode %}

### Using the Connection in an Action

{% code title="ExternalApiAction.cs" %}

```csharp
using System;
using System.Net.Http;
using System.Text;
using System.Text.Json;
using System.Threading.Tasks;
using Microsoft.Extensions.Logging;
using Umbraco.Cms.Core.Automate;

namespace MyCompany.Project.Core.Automate.Actions;

[Action("myCompany.postToExternalApi", "Call External API", Description = "Sends automation data to an external REST API")]
public class ExternalApiAction : ActionBase<ExternalApiActionConfiguration>
{
    private readonly ILogger<ExternalApiAction> _logger;
    private readonly IConnectionService _connectionService;
    private readonly HttpClient _httpClient;

    public ExternalApiAction(ILogger<ExternalApiAction> logger, IConnectionService connectionService, HttpClient httpClient)
    {
        _logger = logger;
        _connectionService = connectionService;
        _httpClient = httpClient;
    }

    public override async Task<ActionResult> ExecuteAsync(ActionContext context, ExternalApiActionConfiguration configuration)
    {
        try
        {
            // Retrieve the connection by its ID (configured in the canvas UI)
            var connection = await _connectionService.GetAsync(
                context.WorkspaceId,
                configuration.ConnectionId,
                default
            );

            if (connection == null)
            {
                return ActionResult.Fail("Connection not found or has been deleted.");
            }

            // Decrypt secure properties automatically
            var baseUrl = connection.GetPropertyValue("baseUrl");
            var apiKey = connection.GetPropertyValue("apiKey");
            var timeout = connection.GetPropertyValue("timeout");

            if (string.IsNullOrWhiteSpace(baseUrl) || string.IsNullOrWhiteSpace(apiKey))
            {
                return ActionResult.Fail("Connection is missing required credentials.");
            }

            var url = $"{baseUrl.TrimEnd('/')}{configuration.Endpoint}";
            var timeoutSeconds = int.TryParse(timeout, out var ts) ? ts : 30;

            _logger.LogInformation("Calling external API at {Url}", url);

            using var cts = new System.Threading.CancellationTokenSource(TimeSpan.FromSeconds(timeoutSeconds));
            var request = new HttpRequestMessage(HttpMethod.Post, url)
            {
                Content = new StringContent(
                    JsonSerializer.Serialize(context.ExecutionData),
                    Encoding.UTF8,
                    "application/json"
                )
            };
            request.Headers.Add("Authorization", $"Bearer {apiKey}");

            var response = await _httpClient.SendAsync(request, cts.Token);
            response.EnsureSuccessStatusCode();

            _logger.LogInformation("External API call succeeded");
            return ActionResult.Success();
        }
        catch (OperationCanceledException)
        {
            return ActionResult.Fail("Request timeout exceeded.");
        }
        catch (HttpRequestException ex)
        {
            _logger.LogError(ex, "External API request failed");
            throw; // Allow Circuit Breaker to handle retry logic
        }
    }
}

public class ExternalApiActionConfiguration
{
    public Guid ConnectionId { get; set; }
    public string Endpoint { get; set; } = "/webhook";
}
```

{% endcode %}
{% endtab %}
{% tab title="Registration" %}

Unlike generic .NET libraries, Umbraco Automate does not run unconstrained assembly scanning for attributes. You must explicitly register your extensions using an `IComposer`:

{% hint style="info" %}
Connection types are auto-discovered by default. Use explicit registration in the composer only if your connection type is not being picked up.
{% endhint %}

{% code title="AutomateRegistrationComposer.cs" %}

```csharp
using Umbraco.Cms.Core.Composing;
using Umbraco.Cms.Core.DependencyInjection;

namespace MyCompany.Project.Core.Automate.Composers;

public class AutomateRegistrationComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
    {
        // Explicitly register custom triggers
        builder.AutomateTriggers().Add<Triggers.OrderCreatedTrigger>();

        // Explicitly register custom actions
        builder.AutomateActions()
            .Add<Actions.WebhookAction>()
            .Add<Actions.ExternalApiAction>();

        // Connection types are typically auto-discovered, but you can explicitly register if needed
        builder.AutomateConnectionTypes().Add<Connections.ExternalApiConnection>();
    }
}
```

{% endcode %}

{% endtab %}
{% endtabs %}

## Testing Custom Extensions Locally

### 1. Build & Clean

After adding or modifying `[DataContract]` configuration structures, always clean the build artifacts before testing:

{% code title="Terminal" %}

```bash
dotnet clean
dotnet build
```

{% endcode %}

{% hint style="warning" %}
Hot-reloading does not always pick up serialization attribute changes. Run `dotnet clean` before testing after any `[DataContract]` modification.
{% endhint %}

### 2. Test in the Backoffice

1. Navigate to **Automation** in the backoffice.
2. Create a new automation in your workspace.
3. Add your custom action as a step. Your custom trigger should appear in the trigger catalogue picker.
4. Click **Save**.
5. Click **Save and publish**.

### 3. Verify in Runs History

1. Click **Run Now** (for manual triggers) or trigger the condition naturally.
2. Navigate to **Automation** > **Runs**.
3. Click the run to open the detail view.
4. Expand each step to see:
    1. Input parameters (configuration values you set).
    2. Output data (what the step produced).
    3. Execution time (per step duration).
    4. Errors (if the step failed).

### 4. Debugging Tips

<details>
<summary>My action doesn't appear in the canvas picker</summary>

1. Verify the `[Action]` attribute is present on your class.
2. Verify your `IComposer.Compose()` calls `builder.AutomateActions().Add<YourAction>()`.
3. Check that the project builds without errors.

</details>

<details>
<summary>Configuration values aren't persisting</summary>

1. Ensure all settable properties have `[DataMember]` attributes.
2. Use `[Required]` for mandatory fields.
3. Run `dotnet clean` before retesting.

</details>

<details>
<summary>Email sender is not configured</summary>

Check that SMTP is configured in your `appsettings.json` file. This is a known gotcha when core services handle email operations.

</details>

<details>
<summary>Step fails silently</summary>

1. Review the **Runs** tab for the actual exception message.
2. Check application logs (**Settings** > **Log Viewer**) for structured error details.
3. Ensure you're throwing exceptions (not swallowing them) so the Circuit Breaker can retry.

</details>

## Common Pitfalls

### Binding Names Are Case-Insensitive

When exposing output properties from a step to be used downstream via bindings (`${trigger.propertyName}`), the standard convention maps C# PascalCase properties directly to CamelCase string keys.

- C# Property: `public string OrderId { get; set; }`
- UI Canvas Binding: `${trigger.orderId}`

### AppSettings Casing for SMTP Operations

If your custom action routes or triggers email notifications via the core infrastructure services, the runner relies on the core CMS settings dictionary.

{% hint style="warning" %}
SMTP credential settings are case-sensitive. Use `"Username"` (lowercase **n**), not `"UserName"`. The wrong casing causes the background worker to throw an `"Email sender is not configured"` exception immediately.
{% endhint %}

- Fails: `"Credentials": { "UserName": "..." }`
- Succeeds: `"Credentials": { "Username": "..." }` (Note the lowercase **n**)

### Array Bindings Don't Work as Direct Canvas Conditions

You cannot execute a direct equality condition on an array field inside the backoffice canvas rules manager.

- Fails: `${trigger.cultures} equals en-US`
- Workaround: Expose a helper property on your payload model explicitly for routing rules:
`public string PrimaryCulture => Cultures?.FirstOrDefault() ?? "en-US";`

### Exception Handling & Retry Logic

- Silent failure (no retry): `return ActionResult.Fail("Error message");`
- Retry again (Circuit Breaker handles it): `throw new InvalidOperationException("Error message");`

{% hint style="warning" %}
Do not return `ActionResult.Fail()` for transient errors. It marks the step as permanently failed and skips retry. Throw an exception instead to let the Circuit Breaker handle retries.
{% endhint %}

## Best Practices Checklist

| Do | Don't |
| --- | --- |
| **Prefix aliases** with your company domain (for example, `myCompany.postToWebhook`). | **Use generic names** that could conflict with future core updates (`postToWebhook`). |
| **Log extensively** — structural runtime logs appear cleanly inside the Backoffice **Runs** tab. | **Swallow exceptions silently** — this breaks the built-in *Circuit Breaker* loop protections. |
| Execute a **`dotnet clean`** after updating config structures before launching your local testing instance. | Rely entirely on hot-reloading when structurally altering serialized `[DataContract]` fields. |
| Use `editorType: "secureString"` for **API keys and passwords** in connection properties. | Store credentials in plain text — they are visible in the database and logs. |
| Return `null` from triggers if conditions aren't met (skip firing). | Throw exceptions for logic errors that should never happen. |
| Document binding names and output properties for your trigger/action. | Assume developers will discover output properties through trial and error. |

## Resources

- [Core Concepts](../concepts/README.md)
- [Extension Points Overview](../extending/README.md)
- [Review Runs](../backoffice/runs.md)
- [GitHub Repository](https://github.com/umbraco/Umbraco.Automate)
