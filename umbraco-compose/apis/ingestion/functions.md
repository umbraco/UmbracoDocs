---
description: >-
  Use ingestion functions to transform webhook payloads into Umbraco Compose’s
  ingestion format, with examples, creation or invocation steps, and runtime
  limits.
---

# Functions

The primary ingestion endpoint accepts content with a standardized payload. To call this, your application or middleware must be capable of matching the Umbraco Compose schema.

For applications that support firing webhooks, there is another option. Ingestion functions allow you to define how an incoming webhook request should be transformed to something Umbraco Compose can store.

Ingestion functions are JavaScript snippets that have access to the request body and headers of the webhook from your source application.

## Function Basics

Your function should be defined as the default export of a JavaScript module. It should return an array of objects containing the mapped content and the ingestion actions that Umbraco Compose should take on the content.

An empty map function that will take no actions looks like the following:

```javascript
export default function(body) {
  // Map content from `body` here...
  return [];
}
```

Returned objects in the array should match the [Ingestion Structure](ingestion-structure.md).

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
                sku: product.sku,
                description: product.description
            }
        }));
}
```

## Accessing Request Headers

The default export receives the headers of the incoming request as its second parameter. Use them to read information that the source system sends outside the request body.

```js
export default function(body, headers) {
    if (headers.get('content-language') !== 'en-GB') {
        return [];
    }

    return body.map(product => ({
        action: 'upsert',
        id: product.productKey,
        type: 'product',
        data: {
            name: product.name,
            sku: product.sku,
            description: product.description
        }
    }));
}
```

Header names are case-insensitive. When a header is sent more than once, `get()` returns the values joined by a comma and a space.

The headers object supports the following methods:

| Method       | Description                                                        |
| ------------ | ------------------------------------------------------------------ |
| `get(name)`  | Returns the value of the header, or `null` if it is not present    |
| `has(name)`  | Returns `true` when the header is present                          |
| `keys()`     | Returns the names of all available headers                         |
| `values()`   | Returns the values of all available headers                        |
| `entries()`  | Returns all available headers as name and value pairs              |

### Unavailable Headers

Some headers are removed before your function runs and are never available:

* `Accept`
* `Accept-Encoding`
* `Authorization`
* `Connection`
* `Host`
* Various routing and proxy control-related headers.

## Making HTTP Requests

Functions can call external services using `fetch`, a minimal implementation of the [Fetch API](https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API). Use it to enrich an incoming payload with data that the source system does not include.

`fetch` returns a promise, so your function must be declared as `async`.

```js
export default async function(body) {
    const response = await fetch(`https://api.example.org/products/${body.productKey}`);

    if (!response.ok) {
        return [];
    }

    const product = await response.json();

    return [{
        action: 'upsert',
        id: product.id,
        type: 'product',
        data: {
            name: product.name,
            sku: product.sku,
            description: product.description
        }
    }];
}
```

Only `http` and `https` URLs are supported.

### Request Options

The second argument to `fetch` configures the request. The following options are supported:

| Option     | Description                                                                                            |
| ---------- | ------------------------------------------------------------------------------------------------------ |
| `method`   | The HTTP method to use. Defaults to `GET`                                                              |
| `body`     | The request body, as a string                                                                          |
| `headers`  | The headers to send with the request                                                                   |
| `redirect` | Set to `follow` to follow redirects, or `manual` to return the redirect response. Defaults to `follow` |

Headers can be given as an object, as an array of name and value pairs, or as a `Headers` object:

```js
export default async function(body) {
    const headers = new Headers();
    headers.append('Api-Key', 'your-api-key');

    const response = await fetch('https://api.example.org/products',
        headers,
        body: JSON.stringify({ skus: body.map(product => product.sku) }));

    // Map response & return here...
}
```

### Working With the Response

The response returned by `fetch` supports the following properties and methods:

| Member         | Description                                                             |
| -------------- | ----------------------------------------------------------------------- |
| `ok`           | `true` when the response has a success status code                      |
| `status`       | The HTTP status code                                                    |
| `statusText`   | The reason phrase of the response                                       |
| `url`          | The URL that was requested                                              |
| `headers`      | The response headers, which support the same methods as request headers |
| `json()`       | Returns a promise resolving to the body parsed as JSON                  |
| `text()`       | Returns a promise resolving to the body as a string                     |

The body can only be read once. Calling `json()` or `text()` a second time throws an error. Response headers are read-only.

Methods not listed here are not implemented and will throw an error when called.

## Creating a Function

Ingestion functions are scoped to a specific environment on a project.

You therefore need a project with an [Environment](../../content-orchestration/environments.md) to create a function.

To create a new function, you need to send a `POST` request to an endpoint on the Management API.

The endpoint looks like the one below, where you've replaced `{projectAlias}` and `{environmentAlias}` with values matching your project.

```http
https://management.umbracocompose.com/v1/projects/{projectAlias}/environments/{environmentAlias}/functions/ingestion
```

{% hint style="info" %}
Ingestion functions can be managed using the [Management Api](https://apidocs.umbracocompose.com#tag/ingestionfunctions).
{% endhint %}

```json
{
    "ingestionFunctionAlias": "products-from-webshop",
    "description": "maps products from webshop",
    "script": "export default function(body){if(!Array.isArray(body)){return[]}return body.filter(product=>product.tags.includes('public')).map(product=>({action:'upsert',id:product.productKey,type:'product',data:{name:product.name,sku:product.sku,description:product.description}}));}"
}
```

## Invoking a Function

Functions can be invoked by sending an [Ingestion request](./#ingesting-data) to your ingestion function URL. The URL can be constructed by using your project region and the aliases of your project, environment, collection, and function using this scheme:

```http
https://ingest.{region}.umbracocompose.com/v1/{projectAlias}/{environmentAlias}/{collectionAlias}/{ingestionFunctionAlias}
```

### Example

Your project in the `germanywestcentral` region contains the following aliases:

* Project name: `considerate-cute-otter`
* Environment alias: `production`
* Collection alias: `products`
* Ingestion function alias: `products-from-webshop`

Your Ingestion Function URL will look like this:

```http
https://ingest.germanywestcentral.umbracocompose.com/v1/considerate-cute-otter/production/products/products-from-webshop
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
