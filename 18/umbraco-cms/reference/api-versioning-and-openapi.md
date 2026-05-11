---
description: How to use API versioning and OpenAPI for your own APIs.
---

# API versioning and OpenAPI

Umbraco uses [Microsoft.AspNetCore.OpenApi](https://learn.microsoft.com/en-us/aspnet/core/fundamentals/openapi/overview) to document its APIs. Out of the box you get the following OpenAPI documents:

- **Management** — the backoffice Management API.
- **Delivery** — the Content Delivery API. Only present when the Delivery API is enabled.
- **Default** — a catch-all containing every API endpoint not mapped to a named document.

All documents and the Swagger UI are served from `{yourdomain}/umbraco/openapi`.

{% hint style="info" %}
OpenAPI documents and the Swagger UI are disabled in production environments by default to avoid exposing API structure on public-facing websites. See [Route and availability](#route-and-availability) to override this.
{% endhint %}

## Adding your own OpenAPI documents

Your custom APIs will appear in the default document unless you register them elsewhere or [exclude them explicitly](#excluding-endpoints-from-the-default-document). If you want more control over where your APIs show up, you can add your own OpenAPI documents.

{% hint style="info" %}
The [ASP.NET Core OpenAPI documentation](https://learn.microsoft.com/en-us/aspnet/core/fundamentals/openapi/overview) covers OpenAPI configuration in depth.
{% endhint %}

To add a custom OpenAPI document, use `AddOpenApi` in `Program.cs` or a composer, then `AddOpenApiDocumentToUi` to add it to the OpenAPI UI dropdown.

The following code sample creates an OpenAPI document called "My API v1" that includes only controllers from a specific namespace:

{% code title="Program.cs" %}

```csharp
using Microsoft.AspNetCore.Mvc.Controllers;
using Umbraco.Cms.Api.Common.DependencyInjection;

builder.Services.AddOpenApi("my-api-v1", options =>
{
    options.AddDocumentTransformer((document, context, cancellationToken) =>
    {
        document.Info.Title = "My API v1";
        document.Info.Version = "1.0";
        document.Info.Description = "My custom API description";
        return Task.CompletedTask;
    });

    // Include only controllers from your namespace
    options.ShouldInclude = apiDescription =>
        apiDescription.ActionDescriptor is ControllerActionDescriptor controllerActionDescriptor
        && controllerActionDescriptor.ControllerTypeInfo.Namespace?.StartsWith("My.Custom.Api.V1") is true;
});

// Add the document to OpenAPI UI
builder.Services.AddOpenApiDocumentToUi("my-api-v1", "My API v1");
```

{% endcode %}

The `ShouldInclude` predicate above filters by namespace. See [Controlling which endpoints appear in your document](#controlling-which-endpoints-appear-in-your-document) for other approaches.

Ensure your API controllers are in the matching namespace:

{% code title="MyApiController.cs" %}

```csharp
using Asp.Versioning;
using Microsoft.AspNetCore.Mvc;

namespace My.Custom.Api.V1;

[Route("api/v{version:apiVersion}/my")]
[ApiController]
[ApiVersion("1.0")]
public class MyApiController : Controller
{
    [HttpGet("do-something")]
    [ProducesResponseType(typeof(MyDoSomethingViewModel), StatusCodes.Status200OK)]
    public IActionResult DoSomething(string value)
        => Ok(new MyDoSomethingViewModel(value));
}

public class MyDoSomethingViewModel
{
    public MyDoSomethingViewModel(string value)
        => Value = value;

    public string Value { get; }
}
```

{% endcode %}

### Controlling which endpoints appear in your document

Set `ShouldInclude` on your document to control which endpoints appear in it. The example above filters by namespace. You can also filter by the `[MapToApi]` attribute, as used by the [Umbraco extension template](../customizing/development-flow/umbraco-extension-template.md):

```csharp
using Umbraco.Cms.Api.Common.Attributes;

options.ShouldInclude = apiDescription =>
    apiDescription.ActionDescriptor.EndpointMetadata
        .OfType<MapToApiAttribute>()
        .Any(attribute => attribute.ApiName == "my-api-v1");
```

### Excluding endpoints from the default document

When you create a custom OpenAPI document, your controllers may still appear in the default document. There are two ways to exclude them:

- **Apply `[MapToApi("your-document-name")]`** to the controller. This both maps the controller to your named document (when your `ShouldInclude` filters by `[MapToApi]`) and removes it from the default.
- **Apply `[ExcludeFromDefaultOpenApiDocument]`** to the controller. Use this when your custom document does not filter by `[MapToApi]`:

{% code title="MyApiController.cs" %}

```csharp
using Umbraco.Cms.Api.Common.OpenApi;

namespace My.Custom.Api.V1;

[ApiController]
[ExcludeFromDefaultOpenApiDocument]
public class MyApiController : Controller
{
    // ...
}
```

{% endcode %}

## Customizing operation and schema IDs

Operation and schema IDs control how endpoints and types are named in your OpenAPI document. Custom IDs can make consumers' generated code more readable, especially when those consumers generate API contracts from your OpenAPI documents.

### Operation IDs

There are three ways to customize operation IDs:

**Use Umbraco's transformer.** `UmbracoOperationIdTransformer` generates operation IDs following Umbraco's naming conventions:

```csharp
using Umbraco.Cms.Api.Common.OpenApi;

builder.Services.AddOpenApi("my-api", options =>
{
    options.AddOperationTransformer<UmbracoOperationIdTransformer>();
});
```

**Use the `Name` property on the route attribute.** The most direct way to set an explicit ID for a specific endpoint:

{% code title="MyApiController.cs" %}

```csharp
[HttpGet("do-something", Name = "DoSomething")]
public IActionResult DoSomething(string value)
    => Ok(new MyDoSomethingViewModel(value));
```

{% endcode %}

**Write a custom transformer.** For complete control over generation:

{% code title="MyOperationIdTransformer.cs" %}

```csharp
using Microsoft.AspNetCore.OpenApi;
using Microsoft.OpenApi;

namespace My.Custom.OpenApi;

public class MyOperationIdTransformer : IOpenApiOperationTransformer
{
    public Task TransformAsync(
        OpenApiOperation operation,
        OpenApiOperationTransformerContext context,
        CancellationToken cancellationToken)
    {
        var relativePath = context.Description.RelativePath;
        if (relativePath is null)
        {
            return Task.CompletedTask;
        }

        // build your own logic to generate operation IDs here
        operation.OperationId = string.Join(
            string.Empty,
            relativePath.Split(['/', '-']).Select(segment => segment.ToFirstUpperInvariant()));

        return Task.CompletedTask;
    }
}
```

{% endcode %}

Apply the custom transformer when registering the document:

```csharp
builder.Services.AddOpenApi("my-api", options =>
{
    options.AddOperationTransformer<MyOperationIdTransformer>();
});
```

### Schema IDs

Schema IDs are configured via the `CreateSchemaReferenceId` property when adding your OpenAPI document. Umbraco applies custom schema IDs to its own APIs; the same pattern works for yours:

{% code title="Program.cs" %}

```csharp
builder.Services.AddOpenApi("my-api", options =>
{
    // capture the existing schema reference ID generator to use as fallback
    var existingCreateSchemaReferenceId = options.CreateSchemaReferenceId
        ?? OpenApiOptions.CreateDefaultSchemaReferenceId;

    options.CreateSchemaReferenceId = jsonTypeInfo =>
    {
        // use the existing schema reference ID for non-custom types
        if (jsonTypeInfo.Type.Namespace?.StartsWith("My.Custom.Api") is not true)
        {
            return existingCreateSchemaReferenceId(jsonTypeInfo);
        }

        // build your own logic to generate schema IDs here
        return jsonTypeInfo.Type.Name;
    };
});
```

{% endcode %}

{% hint style="info" %}
`CreateSchemaReferenceId` is called for all types in the document - including .NET framework types. The namespace check ensures you only customize schema IDs for your own types. The fallback uses ASP.NET Core's default schema ID generator. If you want to use Umbraco's naming conventions (which adds a "Model" suffix), you can use `UmbracoSchemaIdGenerator.Generate(jsonTypeInfo.Type)` from the `Umbraco.Cms.Api.Common.OpenApi` namespace.
{% endhint %}

{% hint style="info" %}
Returning `null` from `CreateSchemaReferenceId` will inline the schema instead of creating a reference. This can be useful for types that don't need to be reused.
{% endhint %}

## Versioning your APIs

### Separate OpenAPI documents per version

A common use case for custom OpenAPI documents is maintaining multiple versions of the same API, with one OpenAPI document per version.

The following code sample creates two OpenAPI documents - "My API v1" and "My API v2". Each document uses `ShouldInclude` to filter controllers by their namespace:

{% code title="Program.cs" %}

```csharp
using Microsoft.AspNetCore.Mvc.Controllers;
using Umbraco.Cms.Api.Common.DependencyInjection;

builder.Services.AddOpenApi("my-api-v1", options =>
{
    options.AddDocumentTransformer((document, context, cancellationToken) =>
    {
        document.Info.Title = "My API v1";
        document.Info.Version = "1.0";
        return Task.CompletedTask;
    });

    // Include only V1 controllers
    options.ShouldInclude = apiDescription =>
        apiDescription.ActionDescriptor is ControllerActionDescriptor controllerActionDescriptor
        && controllerActionDescriptor.ControllerTypeInfo.Namespace?.StartsWith("My.Custom.Api.V1") is true;
});

builder.Services.AddOpenApi("my-api-v2", options =>
{
    options.AddDocumentTransformer((document, context, cancellationToken) =>
    {
        document.Info.Title = "My API v2";
        document.Info.Version = "2.0";
        return Task.CompletedTask;
    });

    // Include only V2 controllers
    options.ShouldInclude = apiDescription =>
        apiDescription.ActionDescriptor is ControllerActionDescriptor controllerActionDescriptor
        && controllerActionDescriptor.ControllerTypeInfo.Namespace?.StartsWith("My.Custom.Api.V2") is true;
});

// Add both documents to OpenAPI UI
builder.Services.AddOpenApiDocumentToUi("my-api-v1", "My API v1");
builder.Services.AddOpenApiDocumentToUi("my-api-v2", "My API v2");
```

{% endcode %}

With these OpenAPI documents in place, ensure your API controllers are in their respective namespaces:

{% code title="MyApiV1Controller.cs" %}

```csharp
using Asp.Versioning;
using Microsoft.AspNetCore.Mvc;

namespace My.Custom.Api.V1;

[Route("api/v{version:apiVersion}/my")]
[ApiController]
[ApiVersion("1.0")]
public class MyApiController : Controller
{
    [HttpGet("do-something")]
    [ProducesResponseType(typeof(MyDoSomethingViewModel), StatusCodes.Status200OK)]
    public IActionResult DoSomething(string value)
        => Ok(new MyDoSomethingViewModel(value));
}

public class MyDoSomethingViewModel
{
    public MyDoSomethingViewModel(string value)
        => Value = value;

    public string Value { get; }
}
```

{% endcode %}

<details>

<summary>See the V2 controller example</summary>

The V2 controller is in a separate namespace (`My.Custom.Api.V2`) and uses `ApiVersion("2.0")`. You can also extend the view model with additional properties:

{% code title="MyApiV2Controller.cs" %}

```csharp
using Asp.Versioning;
using Microsoft.AspNetCore.Mvc;

namespace My.Custom.Api.V2;

[Route("api/v{version:apiVersion}/my")]
[ApiController]
[ApiVersion("2.0")]
public class MyApiController : Controller
{
    [HttpGet("do-something")]
    [ProducesResponseType(typeof(MyDoSomethingViewModel), StatusCodes.Status200OK)]
    public IActionResult DoSomething(string value, int otherValue)
        => Ok(new MyDoSomethingViewModel(value, otherValue));
}

public class MyDoSomethingViewModel
{
    public MyDoSomethingViewModel(string value, int otherValue)
    {
        Value = value;
        OtherValue = otherValue;
    }

    public string Value { get; }

    public int OtherValue { get; }
}
```

{% endcode %}

</details>

### Reading the requested version

The Umbraco APIs rely on having the requested API version as part of the URL. If you prefer a different versioning scheme for your own APIs, you can set up alternatives while still preserving the functionality of the Umbraco API.

The following code sample illustrates how you can use a custom header to pass the requested API version to your own APIs.

{% code title="MyConfigureApiVersioningOptions.cs" %}

```csharp
using Asp.Versioning;
using Microsoft.Extensions.Options;

namespace My.Custom.OpenApi;

public class MyConfigureApiVersioningOptions : IConfigureOptions<ApiVersioningOptions>
{
    public void Configure(ApiVersioningOptions options)
        => options.ApiVersionReader = ApiVersionReader.Combine(
            // the URL segment version reader is required for the Umbraco APIs
            new UrlSegmentApiVersionReader(),
            // here you can add additional version readers to suit your needs
            new HeaderApiVersionReader("my-api-version"));
}

public static class MyConfigureApiVersioningUmbracoBuilderExtensions
{
    // call this from Program.cs, i.e.:
    //     builder.CreateUmbracoBuilder()
    //         ...
    //         .ConfigureMyApiVersioning()
    //         .Build();
    public static IUmbracoBuilder ConfigureMyApiVersioning(this IUmbracoBuilder builder)
    {
        builder.Services.ConfigureOptions<MyConfigureApiVersioningOptions>();
        return builder;
    }
}
```

{% endcode %}

## Route and UI configuration

### Route and availability

You can customize the OpenAPI route, UI prefix, and production availability using `UmbracoOpenApiOptions` in `Program.cs`. Use `PostConfigure` to override the defaults:

{% code title="Program.cs" %}

```csharp
using Umbraco.Cms.Api.Common.OpenApi;

builder.Services.PostConfigure<UmbracoOpenApiOptions>(options =>
{
    // Always enable OpenAPI regardless of environment (see warning below)
    options.Enabled = true;

    // Change the route template for OpenAPI documents
    options.RouteTemplate = "openapi/{documentName}.json";

    // Change the route prefix for OpenAPI UI
    options.UiRoutePrefix = "openapi";
});
```

{% endcode %}

{% hint style="warning" %}
On public-facing websites, enabling OpenAPI in production exposes your API structure publicly. For internal or authenticated APIs, enabling OpenAPI in production may be acceptable.
{% endhint %}

### Using an alternative UI

The built-in UI is based on Swagger UI. If you prefer an alternative UI, you can disable the default UI while keeping the OpenAPI documents available:

{% code title="Program.cs" %}

```csharp
using Umbraco.Cms.Api.Common.OpenApi;

builder.Services.PostConfigure<UmbracoOpenApiOptions>(options =>
{
    // Disable the default UI (OpenAPI documents remain available)
    options.DefaultUiEnabled = false;
});
```

{% endcode %}

With the default UI disabled, you can register your preferred UI yourself. Refer to the UI's documentation for setup details.
