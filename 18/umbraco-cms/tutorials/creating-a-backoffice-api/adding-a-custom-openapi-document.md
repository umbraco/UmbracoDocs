---
description: Adding a custom OpenAPI document for a custom Management API
---

# Adding a custom OpenAPI document

By default, all controllers based on ManagementApiControllerBase will be included in the default Management API OpenAPI document.

When building custom Management API controllers, sometimes it's preferable to have a dedicated OpenAPI document for them. Doing so is a three-step process:

1. Register the OpenAPI document with document inclusion logic.
2. Enable Umbraco authentication for the OpenAPI document.
3. Add the document to Swagger UI.

Add the following code to `Program.cs` to register the OpenAPI document. The `ShouldInclude` property determines which API endpoints appear in your document - in this example, we filter by namespace:

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

{% hint style="info" %}
The `ShouldInclude` property accepts a function that receives an `ApiDescription` and returns `true` if the endpoint should be included in the document. You can use any criteria - namespace, controller name, route pattern, or custom attributes.
{% endhint %}

With this in place, ensure your API controllers are in the matching namespace:

{% code title="MyItemApiController.cs" %}
```csharp
namespace My.Custom.ItemApi;

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
