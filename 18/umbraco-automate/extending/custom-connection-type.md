---
description: >-
  Add a new connection type so actions can talk to an external service with
  reusable, encrypted credentials.
---

# Create a Custom Connection Type

A custom connection type lets actions in your project share reusable credentials for an external service. Each connection type defines:

* A **settings model** — the credential fields shown in the UI.
* A **validation method** — how to verify the credentials work.

## Settings Model

Mark sensitive fields with `IsSensitive = true` so the value is encrypted at rest and masked in run logs.

{% code title="MyServiceConnectionSettings.cs" %}
```csharp
using Umbraco.Automate.Core.Settings;

namespace MyProject.Automate;

public sealed class MyServiceConnectionSettings
{
    [Field(
        Label = "API endpoint",
        Description = "The base URL for the API.")]
    public string Endpoint { get; set; } = string.Empty;

    [Field(
        Label = "API key",
        Description = "The API key issued by the service.",
        IsSensitive = true)]
    public string ApiKey { get; set; } = string.Empty;
}
```
{% endcode %}

## Connection Type Class

Inherit from `ConnectionTypeBase<TSettings>` and override `ValidateAsync` to test the credentials.

{% code title="MyServiceConnectionType.cs" %}
```csharp
using Umbraco.Automate.Core.Connections;

namespace MyProject.Automate;

[ConnectionType("myService", "My Service",
    Description = "Connect to My Service",
    Group = "Custom",
    Icon = "icon-plug")]
public sealed class MyServiceConnectionType : ConnectionTypeBase<MyServiceConnectionSettings>
{
    private readonly IHttpClientFactory _httpClientFactory;

    public MyServiceConnectionType(
        ConnectionTypeInfrastructure infrastructure,
        IHttpClientFactory httpClientFactory)
        : base(infrastructure)
    {
        _httpClientFactory = httpClientFactory;
    }

    public override async Task<ConnectionValidationResult> ValidateAsync(
        object? settings,
        CancellationToken cancellationToken)
    {
        if (settings is not MyServiceConnectionSettings typed)
        {
            return ConnectionValidationResult.Failure("Connection settings are missing.");
        }

        using var client = _httpClientFactory.CreateClient();
        client.DefaultRequestHeaders.Add("Authorization", $"Bearer {typed.ApiKey}");

        try
        {
            using var response = await client.GetAsync($"{typed.Endpoint}/ping", cancellationToken);
            return response.IsSuccessStatusCode
                ? ConnectionValidationResult.Success("Connected to My Service.")
                : ConnectionValidationResult.Failure($"My Service rejected the credentials: {response.ReasonPhrase}");
        }
        catch (Exception ex)
        {
            return ConnectionValidationResult.Failure("Could not reach My Service.", [ex.Message]);
        }
    }
}
```
{% endcode %}

## Registration

No manual registration is required. The connection type is discovered at startup by its `[ConnectionType]` attribute and the base class.

## Verify

Restart your Umbraco site. The new connection type appears in the connection type picker under the **Custom** group. Create a connection, click **Test connection**, and confirm the credentials work.

## See Also

* [Connections](../concepts/connections.md)
* [Create a Custom Action](custom-action.md)
