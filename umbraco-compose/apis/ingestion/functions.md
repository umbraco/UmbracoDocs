---
description: >-
  Use ingestion functions to transform webhook payloads into Umbraco Compose’s
  ingestion format, with examples, creation or invocation steps, and runtime
  limits.
---

# Functions

The primary ingestion endpoint accepts content with a standardized payload. To call this, your application or middleware must be capable of matching the Umbraco Compose schema.

For applications that support firing webhooks, there is another option. Ingestion functions allow you to define how an incoming webhook request should be transformed to something Umbraco Compose can store.

Ingestion functions are JavaScript snippets that have access to the request body of the webhook from your source application.

## Function Basics

Your function should be defined as the default export of a JavaScript module. It should return an array of objects containing the mapped content and the ingestion actions that Umbraco Compose should take on the content.

An empty map function that will take no actions looks like the following:

```javascript
export default function(body) {
  // Map content from `body` here...
  return [];
}
```

Returned objects in the array should have the following properties:

| Property  | Type              | Description                                                                                                                                             |
| --------- | ----------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `action`  | String            | Should be set to `'upsert'` to insert or update content in the platform, or `'delete'` to remove an existing item with matching id from the collection. |
| `id`      | String            | Canonical identifier for the content.                                                                                                                   |
| `variant` | String (optional) | Variant key for the content.                                                                                                                            |
| `type`    | String            | Type schema alias for the desired type.                                                                                                                 |
| `data`    | Object            | Body of the content.                                                                                                                                    |

## Example Function

A source system provides information about products that you need in Umbraco Compose to display them on your website. The source system is capable of firing a webhook whenever products are updated.

The following adjustments are needed for successful ingestion into Compose:

1. Ensure that only products tagged with `'public'` are stored by Umbraco Compose for display on the website.
2. Map the main identifier for a product, `productKey`, to the Umbraco compose `id`.
3. Store only the product name, sku, and description in Umbraco Compose.

Your function for handling this webhook might look like the following:

```js
export default function(body) {
    if (!Array.isArray(body)) {
        return [];
    }

    return body
        .filter(product => product.tags.includes('public')) // 1. Exclude non-public products.
        .map(product => ({
            action: 'upsert',
            id: product.productKey, // 2. Map productKey from source to id.
            type: 'product',
            data: {
                // 3. Only store relevant props.
                name: product.name,
                sku: product.sku
                description: product.description
            }
        }));
}
```

## Creating a Function

Ingestion functions are scoped to a specific environment on a project.

You therefore need a project with an [Environment](../../content-orchestration/environments.md) to create a function.

To create a new function, you need to send a `POST` request to an endpoint on the Management API.

The endpoint looks like the one below, where you've replaced `{projectAlias}` and `{environmentAlias}` with values matching your project.

```http
[https://management.umbracocompose.com/v1/projects/{projectAlias}/environments/{environmentAlias}/functions/ingestion
```

{% hint style="info" %}
Ingestion functions can be managed using the [Management Api](https://apidocs.umbracocompose.com#tag/ingestionfunctions).
{% endhint %}

```json
{
    "ingestionFunctionAlias": "products-from-webshop",
    "description": "maps products from webshop",
    "script": "export default function(body){if(!Array.isArray(body)){return[]}return body.filter(product=>product.tags.includes('public')).map(product=>({action:'upsert',id:product.productKey,type:'product',data:{name:product.name,sku:product.sku description:product.description}}));"
}
```

## Invoking a Function

Functions can be invoked by sending an [Ingestion request](./#ingesting-data) to your ingestion function URL. The URL can be constructed by using your `project alias`, `environment alias`, `collection alias`, and `ingestion function alias` using this scheme:

```http
https://ingest.umbracocompose.com/v1/:projectAlias/:environmentAlias/:collectionAlias/:ingestionFunctionAlias
```

### Example

Your project contains the following aliases:

* Project name: `considerate-cute-otter`
* Environment alias: `production`
* Collection alias: `products`
* Ingestion function alias: `products-from-webshop`

Your Ingestion Function URL will look like this:

```http
https://ingest.umbracocompose.com/v1/considerate-cute-otter/production/products/products-from-webshop
```

{% hint style="warning" %}
While it is possible to ingest any valid JSON data, Umbraco Compose will only expose the fields that correspond to the specified type schema. It is best practice to only ingest data that will be used.

Following this best practice also helps ensure your function stays within the function limitations described below.
{% endhint %}

## Limitations

Functions are intended to be small snippets that execute quickly. As such, they have some limitations.

* **Run time:** The function may not run for more than 15 seconds of real time from start to finish.
* **HTTP Request time:** Any single HTTP request cannot take longer than 5 seconds to resolve.
* **Recursion:** The function or any child functions may not recurse deeper than 64 stack frames.
* **Array size:** The function may not allocate any arrays greater than 1000 in length.
* **Statements:** The function will terminate execution after 10,000 statements.
* **Memory:** The function may not consume more than 5MB of RAM at one time.

When any of these limitations are exceeded, your content will not be successfully ingested.

## Outbound IP Addresses

See [Outbound Traffic](../../content-orchestration/outbound-traffic.md) for a list of IP addresses from which function HTTP calls will originate.
