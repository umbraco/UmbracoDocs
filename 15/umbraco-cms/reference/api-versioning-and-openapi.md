---
description: How to use API versioning and OpenAPI (Swagger) for your own APIs.
---

# API versioning and OpenAPI (Swagger)

Umbraco ships with Swagger to document the Content Delivery API. Swagger and the Swagger UI is available at `{yourdomain}/umbraco/swagger`. For security reasons, both are disabled in production environments.

Due to the way OpenAPI works within ASP.NET Core, we have to apply some configurations in a global scope. If your Umbraco site used Swagger previous to Umbraco 12, these global configurations may interfere with your setup.

In this article we'll explore concrete solutions to overcome challenges with the global configurations.

{% hint style="info" %}
Umbraco uses [Swashbuckle.AspNetCore](https://github.com/domaindrivendev/Swashbuckle.AspNetCore/) to handle Swagger and the Swagger UI.

If you have been using [NSwag](https://github.com/RicoSuter/NSwag) previous to Umbraco 12, chances are your Swagger setup will continue to work in Umbraco 12+ without any changes. Swashbuckle.AspNetCore and NSwag can coexist within the same site, as long as there are no conflicting routes between the two.

That being said, it would be sensible to consider migrating your API documentation to Swashbuckle.AspNetCore. This way you can avoid having multiple dependencies that perform the same tasks.
{% endhint %}

## API versioning

The Umbraco APIs rely on having the requested API version as part of the URL. If you prefer a different versioning for your own APIs, you can setup alternatives while still preserving the functionality of the Umbraco API.

The following code sample illustrates how you can use a custom header to pass the requested API version to your own APIs.

{% code title="MyConfigureApiVersioningOptions.cs" %}

```csharp
using Asp.Versioning;
using Microsoft.Extensions.Options;

namespace My.Custom.Swagger;

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

## Swagger route and/or availability

As mentioned in the beginning of this article, Umbraco exposes Swagger and the Swagger UI at `{yourdomain}/umbraco/swagger`. Both are disabled when the site is in production mode.

The code sample below shows how to change the Swagger route and availability.

{% code title="MySwaggerRouteTemplatePipelineFilter.cs" %}

```csharp
using Umbraco.Cms.Api.Common.OpenApi;
using Umbraco.Cms.Web.Common.ApplicationBuilder;

namespace My.Custom.Swagger;

public class MySwaggerRouteTemplatePipelineFilter : SwaggerRouteTemplatePipelineFilter
{
    public MySwaggerRouteTemplatePipelineFilter(string name) : base(name)
    {
    }

    /// <summary>
    /// This is how you change the route template for the Swagger docs.
    /// </summary>
    protected override string SwaggerRouteTemplate(IApplicationBuilder applicationBuilder) => "swagger/{documentName}/swagger.json";

    /// <summary>
    /// This is how you change the route for the Swagger UI.
    /// </summary>
    protected override string SwaggerUiRoutePrefix(IApplicationBuilder applicationBuilder) => "swagger";

    /// <summary>
    /// This is how you configure Swagger to be available always.
    /// Please note that this is NOT recommended.
    /// </summary>
    protected override bool SwaggerIsEnabled(IApplicationBuilder applicationBuilder) => true;
}

public static class MyConfigureSwaggerRouteUmbracoBuilderExtensions
{
    // call this from Program.cs, i.e.:
    //     CreateUmbracoBuilder()
    //         ...
    //         .ConfigureMySwaggerRoute()
    //         .Build();
    public static IUmbracoBuilder ConfigureMySwaggerRoute(this IUmbracoBuilder builder)
    {
        builder.Services.Configure<UmbracoPipelineOptions>(options =>
        {
            // include this line if you do NOT want the Swagger docs at /umbraco/swagger
            options.PipelineFilters.RemoveAll(filter => filter is SwaggerRouteTemplatePipelineFilter);

            // setup your own Swagger routes
            options.AddFilter(new MySwaggerRouteTemplatePipelineFilter("MyApi"));
        });
        return builder;
    }
}
```

{% endcode %}

## Adding custom operation IDs

Custom operation IDs can be a great way to make your API easier to use. Especially for consumers that generate API contracts from your Swagger documents.

The Umbraco APIs use custom operation IDs for that exact reason. In order to remain as un-intrusive as possible, these custom operation IDs are not applied to your APIs.

If you want to apply custom operation IDs to your APIs, you must ensure that the Umbraco APIs retain their custom operation IDs. The following code sample illustrates how this can be done.

{% code title="MyOperationIdSelector.cs" %}

```csharp
using Asp.Versioning;
using Microsoft.AspNetCore.Mvc.ApiExplorer;
using Microsoft.AspNetCore.Mvc.Controllers;
using Umbraco.Cms.Api.Common.OpenApi;

namespace My.Custom.Swagger;

public class MyOperationIdSelector : OperationIdSelector
{
    public override string? OperationId(ApiDescription apiDescription, ApiVersioningOptions apiVersioningOptions)
    {
        // use this if you want to opt into the default Umbraco operation IDs:
        // return UmbracoOperationId(apiDescription, apiVersioningOptions);

        // only handle your own APIs here - make sure to let the base class handle the Umbraco APIs
        if (apiDescription.ActionDescriptor is not ControllerActionDescriptor controllerActionDescriptor
            || controllerActionDescriptor.ControllerTypeInfo.Namespace?.StartsWith("My.Custom.Api") is false)
        {
            return base.OperationId(apiDescription, apiVersioningOptions);
        }

        // build your own logic to generate operation IDs here
        return apiDescription.RelativePath is null
            ? null
            : string.Join(string.Empty, apiDescription.RelativePath.Split(new[] { '/', '-' }).Select(segment => segment.ToFirstUpperInvariant()));
    }
}

public static class MyOperationIdUmbracoBuilderExtensions
{
    public static IUmbracoBuilder ConfigureMyOperationId(this IUmbracoBuilder builder)
    {
        // call this from Program.cs, i.e.:
        //     CreateUmbracoBuilder()
        //         ...
        //         .ConfigureMyOperationId()
        //         .Build();
        builder.Services.AddSingleton<IOperationIdSelector, MyOperationIdSelector>();
        return builder;
    }
}
```

{% endcode %}

## Adding custom schema IDs

Custom schema IDs can also make it easier for your API consumers to understand and work with your APIs. To that same end, Umbraco applies custom schema IDs to the Umbraco APIs - but not to your APIs.

If you want to create custom schema IDs for your APIs, you must ensure that the Umbraco APIs retain their custom schema IDs. The following code sample illustrates how that can be done.

{% code title="MySchemaIdSelector.cs" %}

```csharp
using Umbraco.Cms.Api.Common.OpenApi;

namespace My.Custom.Swagger;

public class MySchemaIdSelector : SchemaIdSelector
{
    public override string SchemaId(Type type)
    {
        // use this if you want to opt into the default Umbraco schema IDs:
        // return UmbracoSchemaId(type);

        // only handle your own types here - make sure to let the base class handle the Umbraco types
        if (type.Namespace?.StartsWith("My.Custom.Api") is false)
        {
            return base.SchemaId(type);
        }

        // build your own logic to generate schema IDs here
        return string.Join(string.Empty, type.FullName!.Replace("My.Custom.Api", string.Empty).Split('.').Reverse());
    }
}

public static class MySchemaIdUmbracoBuilderExtensions
{
    public static IUmbracoBuilder ConfigureMySchemaId(this IUmbracoBuilder builder)
    {
        // call this from Program.cs, i.e.:
        //     builder.CreateUmbracoBuilder()
        //         ...
        //         .ConfigureMySchemaId()
        //         .Build();
        builder.Services.AddSingleton<ISchemaIdSelector, MySchemaIdSelector>();
        return builder;
    }
}
```

{% endcode %}

## Adding your own Swagger documents

Umbraco automatically adds a "default" Swagger document to contain all APIs that are not explicitly mapped to a named Swagger document. This means that your custom APIs will automatically appear in the "default" Swagger document.

If you want to exercise more control over where your APIs show up in Swagger, you can do so by adding your own Swagger documents.

{% hint style="info" %}
Umbraco imposes no limitations on adding Swagger documents, and the code below is a simplistic example.

In the [Swashbuckle GitHib repository](https://github.com/domaindrivendev/Swashbuckle.AspNetCore/) you will find comprehensive documentation for Swagger documents.
{% endhint %}

A common use case for this is when you maintain multiple versions of the same API. Often you want to have separate Swagger documents for each version. The following code sample creates two Swagger documents - "My API v1" and "My API v2".

{% code title="MyConfigureSwaggerGenOptions.cs" %}

```csharp
using Microsoft.Extensions.Options;
using Microsoft.OpenApi.Models;
using Swashbuckle.AspNetCore.SwaggerGen;

namespace My.Custom.Swagger;

public class MyConfigureSwaggerGenOptions : IConfigureOptions<SwaggerGenOptions>
{
    public void Configure(SwaggerGenOptions options)
    {
        options.SwaggerDoc(
            "my-api-v1",
            new OpenApiInfo
            {
                Title = "My API v1",
                Version = "1.0",
            });

        options.SwaggerDoc(
            "my-api-v2",
            new OpenApiInfo
            {
                Title = "My API v2",
                Version = "2.0",
            });
    }
}

public static class MyConfigureSwaggerGenUmbracoBuilderExtensions
{
    public static IUmbracoBuilder ConfigureMySwaggerGen(this IUmbracoBuilder builder)
    {
        // call this from Program.cs, i.e.:
        //     builder.CreateUmbracoBuilder()
        //         ...
        //         .ConfigureMySwaggerGen()
        //         .Build();
        builder.Services.ConfigureOptions<MyConfigureSwaggerGenOptions>();
        return builder;
    }
}
```

{% endcode %}

With these Swagger documents in place, you can now assign the different versions of your API controllers to their respective documents using the `MapToApi` annotation.

{% code title="MyApiController.cs" %}

```csharp
using Asp.Versioning;
using Microsoft.AspNetCore.Mvc;
using Umbraco.Cms.Api.Common.Attributes;

namespace My.Custom.Api.V1;

[Route("api/v{version:apiVersion}/my")]
[ApiController]
[ApiVersion("1.0")]
[MapToApi("my-api-v1")]
public class MyApiController : Controller
{
    [HttpGet]
    [Route("do-something")]
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

{% code title="MyApiController.cs" %}

```csharp
using Asp.Versioning;
using Microsoft.AspNetCore.Mvc;
using Umbraco.Cms.Api.Common.Attributes;

namespace My.Custom.Api.V2;

[Route("api/v{version:apiVersion}/my")]
[ApiController]
[ApiVersion("2.0")]
[MapToApi("my-api-v2")]
public class MyApiController : Controller
{
    [HttpGet]
    [Route("do-something")]
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
