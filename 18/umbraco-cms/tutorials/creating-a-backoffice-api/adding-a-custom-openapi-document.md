---
description: Adding a dedicated OpenAPI document for custom Management API controllers
---

# Adding a custom OpenAPI document

By default, all controllers based on `ManagementApiControllerBase` are included in the default Management API OpenAPI document. To put them in a dedicated document instead, register an OpenAPI document and filter your controllers into it.

Add the following code to `Program.cs`:

{% code title="Program.cs" %}
```csharp
using Microsoft.AspNetCore.Mvc.Controllers;
using Umbraco.Cms.Api.Common.DependencyInjection;
using Umbraco.Cms.Api.Management.OpenApi;

builder.Services.AddOpenApi("my-item-api", options =>
{
    options.AddDocumentTransformer((document, context, cancellationToken) =>
    {
        document.Info.Title = "My item API";
        document.Info.Version = "1.0";
        return Task.CompletedTask;
    });

    // Include only controllers from your namespace
    options.ShouldInclude = apiDescription =>
        apiDescription.ActionDescriptor is ControllerActionDescriptor controllerActionDescriptor
        && controllerActionDescriptor.ControllerTypeInfo.Namespace?.StartsWith("My.Custom.ItemApi") is true;

    // Enable Umbraco authentication for the OpenAPI document
    options.AddBackofficeSecurityRequirements();
});

// Add the document to OpenAPI UI
builder.Services.AddOpenApiDocumentToUi("my-item-api", "My item API");
```
{% endcode %}

This uses `ShouldInclude` to filter by namespace and `AddBackofficeSecurityRequirements()` to wire up backoffice authentication. See [API versioning and OpenAPI](../../reference/api-versioning-and-openapi.md) for other filtering approaches and configuration options.

Ensure your API controllers are in the matching namespace:

{% code title="MyItemApiController.cs" %}
```csharp
namespace My.Custom.ItemApi;

public class MyItemApiController : ManagementApiControllerBase
{
    // your endpoints here
}
```
{% endcode %}

When you visit the Swagger UI, "My item API" has its own OpenAPI document:

![My item API in Swagger UI](../../.gitbook/assets/my-item-api-swagger-ui.png)

{% hint style="info" %}
Swagger UI sometimes has persistent caching, which can prevent the new definition from appearing immediately. If this happens, enable **Disable cache** in the **Network** tab of your browser's developer tools.
{% endhint %}
