---
description: Generate per-content-type OpenAPI schemas for the Delivery API.
---

# Content type schemas in OpenAPI

By default, the Delivery API OpenAPI document describes content responses with generic interface schemas. Content type properties are typed as free-form objects, with no relation to the actual content types defined in Umbraco.

The Delivery API offers an opt-in feature to expose your content types directly in the OpenAPI document. Enabling it adds a dedicated schema for each Document Type, Element Type, and Media Type. Each schema replaces the free-form object with the type's own properties.

The interface schemas (`IApiContentResponseModel`, `IApiContentModel`, `IApiMediaWithCropsResponseModel`, `IApiMediaWithCropsModel`) then become discriminated unions keyed on `contentType` or `mediaType`. Consumers can narrow each response to a concrete content type.

{% hint style="info" %}
This feature only affects the OpenAPI document. The Delivery API responses themselves are unchanged. The JSON returned from the endpoints has the same shape whether content type schemas are enabled or not. What changes is how the spec describes that shape, and what a generated client can infer from it.
{% endhint %}

## When to enable content type schemas

Enable the feature when you want the OpenAPI document to serve as a complete reference of your content types. The document then describes each content type exposed through the Delivery API and its properties. Consumers without Backoffice access can see which types exist and what shapes the Delivery API returns.

Enabling the feature also lets you generate strongly-typed clients from the spec. The discriminated unions let the generated client identify each content type and expose its properties as concrete fields.

Leave the feature disabled if your consumers neither generate clients from the spec nor rely on it as a content-model reference. The default OpenAPI document is smaller and loads faster.

## Enabling content type schemas

Add the `OpenApi` section to the `DeliveryApi` configuration in `appsettings.json` and set `GenerateContentTypeSchemas` to `true`:

{% code title="appsettings.json" %}
```json
{
  "Umbraco": {
    "CMS": {
      "DeliveryApi": {
        "Enabled": true,
        "OpenApi": {
          "GenerateContentTypeSchemas": true
        }
      }
    }
  }
}
```
{% endcode %}

## Example

Umbraco uses [hey-api](https://heyapi.dev) (the `@hey-api/openapi-ts` package) internally for its TypeScript clients. This is one of multiple compatible generators. See the [Custom Generated Client](../../../extend-your-project/backoffice-extensions/foundation/fetching-data/custom-generated-client.md) article for general setup, or [Client generator compatibility](#client-generator-compatibility) for notes on using a different generator.

When you fetch a content item, the response is typed as `IApiContentResponseModel`, the discriminated union over your document types. Narrow on `contentType` to access the type-specific `properties`:

{% code title="app.ts" %}
```typescript
const { data } = await getContentItemByPath20({
    path: { path: '/articles/getting-started' },
});

if (data?.contentType === 'articlePage') {
    // data is now typed as ArticlePageContentResponseModel
    console.log(data.properties?.headline);
}
```
{% endcode %}

## Client generator compatibility

The content type schemas use OpenAPI 3.1 polymorphism (`oneOf` with `discriminator`) and `allOf` for compositions. Support for these patterns varies between OpenAPI client generators. The result depends on the target language and on how the generator handles discriminated unions and schema composition. Verify the generated client against your chosen generator before relying on it.
