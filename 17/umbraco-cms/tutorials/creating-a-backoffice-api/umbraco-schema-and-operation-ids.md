---
description: How to apply the Umbraco schema and operation IDs for custom Management APIs
---

# Umbraco schema and operation IDs

All core Management APIs use custom naming conventions for their generated OpenAPI schema and operation IDs.

These conventions are strictly opt-in to avoid affecting custom APIs by default. In this article, we'll see how to opt-in to the scheme.

{% hint style="info" %}
If you are happy with your APIs' default schema and operation IDs, nothing is likely gained by using the Umbraco ones.
{% endhint %}

## Schema IDs

Schema IDs are configured using the `CreateSchemaReferenceId` property when adding your OpenAPI document. You can use the `UmbracoSchemaIdGenerator.Generate()` method to generate schema IDs following Umbraco's naming conventions:

{% code title="Program.cs" %}
```csharp
using Umbraco.Cms.Api.Common.OpenApi;

builder.Services.AddOpenApi("my-item-api", options =>
{
    // ...other configuration

    options.CreateSchemaReferenceId = jsonTypeInfo
        => UmbracoSchemaIdGenerator.Generate(jsonTypeInfo.Type);
});
```
{% endcode %}

## Operation IDs

Operation IDs are configured using operation transformers. You can use the `UmbracoOperationIdTransformer` to generate operation IDs following Umbraco's naming conventions:

{% code title="Program.cs" %}
```csharp
using Umbraco.Cms.Api.Common.OpenApi;

builder.Services.AddOpenApi("my-item-api", options =>
{
    // ...other configuration

    options.AddOperationTransformer<UmbracoOperationIdTransformer>();
});
```
{% endcode %}

If you need more control, you can create a custom operation transformer. See the [API versioning and OpenAPI](../../reference/api-versioning-and-openapi.md#using-a-custom-transformer) article for an example.
