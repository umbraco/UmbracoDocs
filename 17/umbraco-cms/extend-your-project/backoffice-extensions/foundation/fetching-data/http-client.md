---
description: Learn more about working with the Umbraco HTTP Client.
---

# Umbraco HTTP Client

The Umbraco Backoffice includes a built-in HTTP client commonly referred to as the Umbraco HTTP Client for making network requests. It is generated using `@hey-api/openapi-ts` around the OpenAPI specification and is available through the `@umbraco-cms/backoffice/http-client` package.

**Example:**

```javascript
import { umbHttpClient } from '@umbraco-cms/backoffice/http-client';

const { data } = await umbHttpClient.get({
	url: '/umbraco/myextension/api/v1/endpoint',
	security: [{ scheme: 'bearer', type: 'http' }],
});

if (data) {
	console.log('Data:', data);
}
```

The above example shows how to use the Umbraco HTTP client to make a GET request. The `umbHttpClient` object provides methods for making requests, including `get`, `post`, `put`, and `delete`. Each method accepts an options object with the URL, headers, and body of the request.

The `security` array tells the client to invoke the `auth` callback, which provides the Bearer token for the request. Generated SDK functions include this metadata automatically from the OpenAPI specification — but when calling endpoints directly with `.get()` or `.post()`, you must pass it yourself.

{% hint style="info" %}
You can also pass `umbHttpClient` as the `client` parameter to any generated SDK function. This lets the generated function use the backoffice's HTTP client (with its authentication) instead of its own. See [Custom Generated Client](custom-generated-client.md) for details.
{% endhint %}

## Using the Umbraco HTTP Client

The Umbraco HTTP client is a wrapper around the Fetch API that provides a more convenient way to make network requests. It handles request and response parsing, error handling, and retries. The Umbraco HTTP client is available through the `@umbraco-cms/backoffice/http-client` package, which is included in the Umbraco Backoffice. You can use it to make requests to any endpoint in the Management API or to any other API.

The recommended way to use the Umbraco HTTP Client is with the `tryExecute` function. This function handles any errors that occur during the request and automatically refreshes the token if it has expired. If the session has expired, it prompts the user to log in again.

You can read more about the `tryExecute` function in this article:

{% content-ref url="try-execute.md" %}
[try-execute.md](try-execute.md)
{% endcontent-ref %}

## Generating a Custom Client

You can also generate your own client using the `@hey-api/openapi-ts` library. This library allows you to generate a TypeScript client from an OpenAPI specification. The generated client will handle authentication and error handling for you, so you don't have to worry about those details.

Read more about generating your own client here:

{% content-ref url="custom-generated-client.md" %}
[custom-generated-client.md](custom-generated-client.md)
{% endcontent-ref %}

## Further reading

* [@hey-api/openapi-ts](https://heyapi.dev/openapi-ts/get-started)
* [@umbraco-cms/backoffice/http-client](https://apidocs.umbraco.com/v17/ui-api/modules/packages_core_http-client.html)
* [Using the Fetch API](fetch-api.md)
* [Creating a Backoffice Entry Point](../../extending-overview/extension-types/backoffice-entry-point.md)
