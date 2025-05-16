---
description: Learn more about working with the Umbraco HTTP Client.
---

# HTTP Client

The Umbraco Backoffice includes a built-in HTTP client commonly referred to as the Umbraco HTTP Client for making network requests. It is generated using `@hey-api/openapi-ts` around the OpenAPI specification and is available through the `@umbraco-cms/backoffice/http-client` package.

**Example:**

```javascript
import { umbHttpClient } from '@umbraco-cms/backoffice/http-client';

const { data } = await umbHttpClient.get({
	url: '/umbraco/management/api/v1/server/status'
});

if (data) {
	console.log('Server status:', data);
}
```

The above example shows how to use the Umbraco HTTP client to make a GET request to the Management API. The `umbHttpClient` object provides methods for making requests, including `get`, `post`, `put`, and `delete`. Each method accepts an options object with the URL, headers, and body of the request.

The Umbraco HTTP client automatically handles authentication and error handling, so you don't have to worry about those details. It also provides a convenient way to parse the response data as JSON.

## Using the Umbraco HTTP Client

The Umbraco HTTP client is a wrapper around the Fetch API that provides a more convenient way to make network requests. It handles request and response parsing, error handling, and retries. The Umbraco HTTP client is available through the `@umbraco-cms/backoffice/http-client` package, which is included in the Umbraco Backoffice. You can use it to make requests to any endpoint in the Management API or to any other API.

The recommended approach to use the Umbraco HTTP Client is to use the `tryExecute` function. This function will handle any errors that occur during the request and will automatically refresh the token if it is expired. If the session is expired, the function will also make sure the user logs in again.

You can read more about the `tryExecute` function in this article:

{% content-ref url="try-execute.md" %}
[try-execute.md](try-execute.md)
{% endcontent-ref %}

## Generate your own client

You can also generate your own client using the **@hey-api/openapi-ts** library. This library allows you to generate a TypeScript client from an OpenAPI specification. The generated client will handle authentication and error handling for you, so you don't have to worry about those details.

Read more about generating your own client here:

{% content-ref url="custom-generated-client.md" %}
[custom-generated-client.md](custom-generated-client.md)
{% endcontent-ref %}

## Further reading

- [@hey-api/openapi-ts](https://heyapi.dev/openapi-ts/get-started)
- `[@umbraco-cms/backoffice/http-client](https://apidocs.umbraco.com/v16/ui-api/modules/packages_core_http-client.html)`
- [Using the Fetch API](fetch-api.md)
- [Working with Data](../working-with-data/README.md)
- [Creating a Backoffice Entry Point](../../extending-overview/extension-types/backoffice-entry-point.md)
