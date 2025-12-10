---
description: How to apply the Umbraco schema and operation IDs for custom Management APIs
---

# Umbraco schema and operation IDs

All core Management APIs have a custom scheme for their generated OpenAPI schema and operation IDs.

This scheme is strictly opt-in to avoid affecting custom APIs by default. In this article, we'll see how to opt-in to the scheme.

{% hint style="info" %}
If you are happy with your APIs' default schema and operation IDs, nothing is likely gained by using the Umbraco ones.
{% endhint %}

## Schema IDs

Schema IDs are handled by `ISchemaIdHandler` implementations. To opt-in to the Umbraco schema IDs, we base our implementation on the core handler:

{% code title="SampleSchemaIdHandler.cs" %}
```csharp
using Umbraco.Cms.Api.Common.OpenApi;

namespace UmbracoDocs.Samples;

// this schema ID handler extends the Umbraco schema IDs
// to all types in the UmbracoDocs.Samples namespace
public class SampleSchemaIdHandler : SchemaIdHandler
{
    public override bool CanHandle(Type type)
        => type.Namespace == "UmbracoDocs.Samples";
}
```
{% endcode %}

Then, we implement a composer to register the new schema ID handler:

{% code title="SampleSchemaIdComposer.cs" %}
```csharp
using Umbraco.Cms.Api.Common.OpenApi;
using Umbraco.Cms.Core.Composing;

namespace UmbracoDocs.Samples;

public class SampleSchemaIdComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
        =>  builder.Services.AddSingleton<ISchemaIdHandler, SampleSchemaIdHandler>();
}
```
{% endcode %}

## Operation IDs

Operation IDs follow the same pattern as schema IDs. The only difference is that the `IOperationIdHandler` operates at the API level, not at the type level.

Again, to opt-in to the Umbraco operation IDs, we base our implementation on the core handler:

{% code title="SampleOperationIdHandler.cs" %}
```csharp
using Asp.Versioning;
using Microsoft.AspNetCore.Mvc.ApiExplorer;
using Microsoft.AspNetCore.Mvc.Controllers;
using Microsoft.Extensions.Options;
using Umbraco.Cms.Api.Common.OpenApi;

namespace UmbracoDocs.Samples;

// this operation ID handler extends the Umbraco operation IDs
// to all API controllers in the UmbracoDocs.Samples namespace
public class SampleOperationIdHandler : OperationIdHandler
{
    public SampleOperationIdHandler(IOptions<ApiVersioningOptions> apiVersioningOptions)
        : base(apiVersioningOptions)
    {
    }

    protected override bool CanHandle(ApiDescription apiDescription, ControllerActionDescriptor controllerActionDescriptor)
        => controllerActionDescriptor.ControllerTypeInfo.Namespace == "UmbracoDocs.Samples";
}
```
{% endcode %}

Then, we implement a composer to register the new operation ID handler:

{% code title="SampleOperationIdComposer.cs" %}
```csharp
using Umbraco.Cms.Api.Common.OpenApi;
using Umbraco.Cms.Core.Composing;

namespace UmbracoDocs.Samples;

public class SampleOperationIdComposer : IComposer
{
    public void Compose(IUmbracoBuilder builder)
        =>  builder.Services.AddSingleton<IOperationIdHandler, SampleOperationIdHandler>();
}
```
{% endcode %}
