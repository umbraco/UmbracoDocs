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
});

if (data) {
	console.log('Data:', data);
}
```

The above example shows how to use the Umbraco HTTP client to make a GET request. The `umbHttpClient` object provides methods for making requests, including `get`, `post`, `put`, and `delete`. Each method accepts an options object with the URL, headers, and body of the request.

The client sends the backoffice authentication cookie with every request, so the request needs no authentication options. The session lives in an HTTP-only cookie, and there is no token to add to the request.

{% hint style="info" %}
You can also pass `umbHttpClient` as the `client` parameter to any generated SDK function. The generated function then uses the HTTP client of the backoffice instead of its own. See [Custom Generated Client](custom-generated-client.md) for details.
{% endhint %}

## Sending data

To send data, pass it as the `body`. The client serializes the body as JSON and sets the `Content-Type` header for you:

```javascript
import { umbHttpClient } from '@umbraco-cms/backoffice/http-client';

const { data, error } = await umbHttpClient.post({
	url: '/umbraco/myextension/api/v1/items',
	body: { name: 'My item' },
});

if (error) {
	console.error('The item could not be created:', error);
}
```

The same applies to `put` and `patch`.

## Using the Umbraco HTTP Client

The Umbraco HTTP client is a wrapper around the Fetch API that provides a more convenient way to make network requests. It handles request and response parsing, error handling, and retries. The Umbraco HTTP client is available through the `@umbraco-cms/backoffice/http-client` package, which is included in the Umbraco Backoffice. You can use it to make requests to any endpoint in the Management API or to any other API.

The recommended way to use the Umbraco HTTP Client is with the `tryExecute` function. This function handles any errors that occur during the request and shows a notification when a request fails.

If the session has expired, the Umbraco HTTP Client opens the login dialog. Once the user logs in again, the client retries `GET` requests. Other requests fail, and the user gets a notification asking them to try again.

You can read more about the `tryExecute` function in this article:

{% content-ref url="try-execute.md" %}
[try-execute.md](try-execute.md)
{% endcontent-ref %}

## Generating a Custom Client

You can also generate your own client using the `@hey-api/openapi-ts` library. This library allows you to generate a TypeScript client from an OpenAPI specification. Configure the generated client with `configureClient()` to handle authentication and errors the same way as the Umbraco HTTP Client.

Read more about generating your own client here:

{% content-ref url="custom-generated-client.md" %}
[custom-generated-client.md](custom-generated-client.md)
{% endcontent-ref %}

## Further reading

* [@hey-api/openapi-ts](https://heyapi.dev/openapi-ts/get-started)
* [@umbraco-cms/backoffice/http-client](https://apidocs.umbraco.com/v18/ui-api/modules/packages_core_http-client.html)
* [Using the Fetch API](fetch-api.md)
* [Creating a Backoffice Entry Point](../../extending-overview/extension-types/backoffice-entry-point.md)
