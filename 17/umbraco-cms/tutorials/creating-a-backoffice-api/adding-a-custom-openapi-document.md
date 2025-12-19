---
description: Adding a custom OpenAPI document for a custom Management API
---

# Adding a custom OpenAPI document

By default, all controllers based on ManagementApiControllerBase will be included in the default Management API OpenAPI document.

When building custom Management API controllers, sometimes it's preferable to have a dedicated OpenAPI document for them. Doing so is a two-step process:

1. Register the OpenAPI document and enable Umbraco authentication.
2. Map the controllers to the OpenAPI document.

Add the following code to `Program.cs` to register the OpenAPI document:

{% code title="Program.cs" %}
```csharp
builder.Services.AddOpenApi("my-item-api", options =>
{
    options.AddDocumentTransformer((document, context, cancellationToken) =>
    {
        document.Info.Title = "My item API";
        document.Info.Version = "1.0";
        return Task.CompletedTask;
    });

    // Enable Umbraco authentication for the OpenAPI document
    options.AddBackofficeSecurityRequirements();
});
```
{% endcode %}

With this in place, annotate the relevant API controllers with the `MapToApi` attribute:

{% code title="MyItemApiController.cs" %}
```csharp
[MapToApi("my-item-api")]
public class MyItemApiController : ManagementApiControllerBase
```
{% endcode %}

Now when we visit the Swagger UI, "My item API" has its own OpenAPI document:

![My item API in Swagger UI](../../.gitbook/assets/my-item-api-swagger-ui.png)

{% hint style="info" %}
Swagger UI sometimes has persistent caching, which can prevent the new definition from appearing immediately. If this happens, disable caching in the **Network** tab of your browser's developer tools.
{% endhint %}

{% hint style="info" %}
For more modular configurations, you can use `IConfigureNamedOptions<OpenApiOptions>` with a composer instead of configuring in Program.cs. See the [API versioning and OpenAPI](../../reference/api-versioning-and-openapi.md) article for details.
{% endhint %}
