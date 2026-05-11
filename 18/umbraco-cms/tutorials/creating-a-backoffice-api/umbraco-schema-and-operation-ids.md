---
description: How to apply the Umbraco schema and operation IDs for custom Management APIs
---

# Umbraco schema and operation IDs

Umbraco's Management API uses custom naming conventions for its OpenAPI schema and operation IDs.

These conventions are opt-in to avoid affecting custom APIs by default. This article shows how to opt in.

{% hint style="info" %}
If you're happy with the default schema and operation IDs, you don't need the Umbraco conventions.
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

If you need more control, you can create a custom operation transformer. See the [Operation IDs](../../reference/api-versioning-and-openapi.md#operation-ids) section for an example.
