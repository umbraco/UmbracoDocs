---
description: How to use API versioning and OpenAPI for your own APIs.
---

# API versioning and OpenAPI

Umbraco uses [Microsoft.AspNetCore.OpenApi](https://learn.microsoft.com/en-us/aspnet/core/fundamentals/openapi/overview) to document the Management and Content Delivery APIs. The OpenAPI documents and Swagger UI are available at `{yourdomain}/umbraco/swagger`. Both are disabled in production environments by default to avoid exposing API structure on public-facing websites.

## Adding your own OpenAPI documents

Umbraco automatically adds a "default" OpenAPI document to contain all APIs that are not explicitly mapped to a named document. This means that your custom APIs will automatically appear in the "default" OpenAPI document.

If you want to exercise more control over where your APIs show up, you can do so by adding your own OpenAPI documents.

{% hint style="info" %}
Umbraco imposes no limitations on adding OpenAPI documents, and the code below is a simplistic example.

In the [ASP.NET Core OpenAPI documentation](https://learn.microsoft.com/en-us/aspnet/core/fundamentals/openapi/overview) you will find comprehensive documentation for OpenAPI configuration.
{% endhint %}

To add a custom OpenAPI document, use `AddOpenApi` in `Program.cs`. The `ShouldInclude` property determines which API endpoints appear in your document. You also need to configure `SwaggerUIOptions` to add the document to the Swagger UI dropdown.

The following code sample creates an OpenAPI document called "My API v1" that includes only controllers from a specific namespace:

{% code title="Program.cs" %}

```csharp
using Microsoft.AspNetCore.Mvc.Controllers;
using Swashbuckle.AspNetCore.SwaggerUI;

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

// Add the document to Swagger UI
builder.Services.Configure<SwaggerUIOptions>(options =>
{
    options.SwaggerEndpoint("/umbraco/swagger/my-api-v1/swagger.json", "My API v1");
});
```

{% endcode %}

{% hint style="info" %}
The `ShouldInclude` property accepts a function that receives an `ApiDescription` and returns `true` if the endpoint should be included in the document. You can use any criteria - namespace, controller name, route pattern, or custom attributes.
{% endhint %}

With this OpenAPI document in place, ensure your API controllers are in the matching namespace:

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

### Excluding from the default OpenAPI document

When you create a custom OpenAPI document, your controllers may still appear in the "default" document. To exclude them, add the `[ExcludeFromDefaultOpenApiDocument]` attribute to your controllers:

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

## Customizing your OpenAPI document

### Adding custom operation IDs

Custom operation IDs can be a great way to make your API easier to use. Especially for consumers that generate API contracts from your OpenAPI documents.

#### Using Umbraco's operation IDs

Umbraco provides `UmbracoOperationIdTransformer` which generates operation IDs following Umbraco's naming conventions. You can use this transformer for your own APIs:

```csharp
using Umbraco.Cms.Api.Common.OpenApi;

options.AddOperationTransformer<UmbracoOperationIdTransformer>();
```

#### Using explicit operation IDs

The simplest way to define custom operation IDs for specific endpoints is to use the `Name` property on the route attribute:

{% code title="MyApiController.cs" %}

```csharp
[HttpGet("do-something", Name = "DoSomething")]
public IActionResult DoSomething(string value)
    => Ok(new MyDoSomethingViewModel(value));
```

{% endcode %}

#### Using a custom transformer

If you need complete control over operation ID generation, you can create a custom operation transformer. The following code sample shows how to create a transformer that generates operation IDs for your APIs:

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

To apply this transformer to your OpenAPI document:

```csharp
builder.Services.AddOpenApi("my-api", options =>
{
    options.AddOperationTransformer<MyOperationIdTransformer>();
});
```

### Adding custom schema IDs

Custom schema IDs can make it easier for your API consumers to understand and work with your APIs. Umbraco applies custom schema IDs to the Umbraco APIs.

If you want to create custom schema IDs for your APIs, you can do so by setting the `CreateSchemaReferenceId` property when adding your OpenAPI document. The following code sample illustrates how that can be done:

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
Returning `null` from `CreateSchemaReferenceId` will inline the schema instead of creating a reference. This can be useful for simple types that don't need to be reused.
{% endhint %}

## Multiple API versions

A common use case for custom OpenAPI documents is when you maintain multiple versions of the same API. Often you want to have separate OpenAPI documents for each version.

The following code sample creates two OpenAPI documents - "My API v1" and "My API v2". Each document uses `ShouldInclude` to filter controllers by their namespace:

{% code title="Program.cs" %}

```csharp
using Microsoft.AspNetCore.Mvc.Controllers;
using Swashbuckle.AspNetCore.SwaggerUI;

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

// Add both documents to Swagger UI
builder.Services.Configure<SwaggerUIOptions>(options =>
{
    options.SwaggerEndpoint("/umbraco/swagger/my-api-v1/swagger.json", "My API v1");
    options.SwaggerEndpoint("/umbraco/swagger/my-api-v2/swagger.json", "My API v2");
});
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

## Advanced configuration

### OpenAPI route and/or availability

Umbraco exposes OpenAPI and Swagger UI at `{yourdomain}/umbraco/swagger`. Both are disabled in production mode by default to avoid exposing API structure on public-facing websites.

You can customize these settings using `UmbracoOpenApiOptions` in `Program.cs`. Use `PostConfigure` to override the defaults:

{% code title="Program.cs" %}

```csharp
using Umbraco.Cms.Api.Common.OpenApi;

builder.Services.PostConfigure<UmbracoOpenApiOptions>(options =>
{
    // Always enable OpenAPI regardless of environment (see warning below)
    options.Enabled = true;

    // Change the route template for OpenAPI documents
    options.RouteTemplate = "swagger/{documentName}/swagger.json";

    // Change the route prefix for Swagger UI
    options.UiRoutePrefix = "swagger";
});
```

{% endcode %}

{% hint style="warning" %}
On public-facing websites, enabling OpenAPI in production exposes your API structure publicly. For internal or authenticated APIs, enabling OpenAPI in production may be acceptable.
{% endhint %}

### API versioning

The Umbraco APIs rely on having the requested API version as part of the URL. If you prefer a different versioning for your own APIs, you can setup alternatives while still preserving the functionality of the Umbraco API.

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
