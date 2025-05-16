---
description: Learn how to create a custom generated client with TypeScript types for your OpenAPI specification.
---

# Custom Generated Client

Umbraco uses `[@hey-api/openapi-ts](https://heyapi.dev/openapi-ts/get-started)` to generate its HTTP client for the OpenAPI specification of the Management API. It is available through the `@umbraco-cms/backoffice/http-client` package.

{% content-ref url="http-client.md" %}
[http-client.md](http-client.md)
{% endcontent-ref %}

The following examples show how to generate a client from an OpenAPI specification and how to use it in the project. Below, the `@hey-api/openapi-ts` library is used, but the same principles apply to any other library that generates a TypeScript client.

## Generate your own client

The generated client provides a convenient way to make requests to the specified API with type-safety without having to manually write the requests yourself. Consider generating a client to save time and reduce effort when working with custom API controllers.

To get started, install the generator using the following command:

```bash
npm install @hey-api/openapi-ts
```

Then, use the `openapi-ts` command to generate a client from your OpenAPI specification:

```bash
npx openapi-ts generate --url https://example.com/openapi.json --output ./my-client
```

This will generate a TypeScript client in the `./my-client` folder. You can then import the client into your project and use it to make requests to the Management API.

To learn more about OpenAPI and how to define your API specification, visit the [OpenAPI Documentation](https://swagger.io/specification/).

## Connecting to the Management API

You will need to set up a few configuration options in order to connect to the Management API. The following options are required:

- `auth`: The authentication method to use. This is typically `Bearer` for the Management API.
- `baseUrl`: The base URL of the Management API. This is typically `https://example.com/umbraco/api/management/v1`.
- `credentials`: The credentials to use for the request. This is typically `same-origin` for the Management API.

You can set these options either directly with the `openapi-ts` command or in a central place in your code. For example, you can create a [BackofficeEntryPoint](../../extending-overview/extension-types/backoffice-entry-point.md) that sets up the configuration options for the HTTP client:

```javascript
import { UMB_AUTH_CONTEXT } from '@umbraco-cms/backoffice/auth';
import { client } from './my-client/client.gen';

export const onInit = (host) => {
    host.consumeContext(UMB_AUTH_CONTEXT, (authContext) => {
        // Get the token info from Umbraco
        const config = authContext?.getOpenApiConfiguration();

        client.setConfig({
          auth: config?.token ?? undefined,
          baseUrl: config?.base ?? "",
          credentials: config?.credentials ?? "same-origin",
        });
    });
};
```

This will set up the HTTP client to use the Management API base URL and authentication method. You can then use the client to make requests to the Management API.

{% hint style="info" %}
You can see the above example in action by looking at the [Umbraco Extension Template](../../development-flow/umbraco-extension-template.md).
{% endhint %}

**Fetch API**

The approach with a Backoffice Entry Point is good if you have a lot of requests to make. However, if you only have a few requests to make, you can use the `fetch` function directly. Read more about that here:

{% content-ref url="fetch-api.md" %}
[fetch-api.md](fetch-api.md)
{% endcontent-ref %}

**Setting the client directly**
You can also set the client directly in your code. This is useful if you only have a few requests to make and don't want to set up a Backoffice Entry Point.

```javascript
import { getMyControllerAction } from './my-client';
import { tryExecute } from '@umbraco-cms/backoffice/resources';
import { umbHttpClient } from '@umbraco-cms/backoffice/http-client';

const { data } = await tryExecute(this, getMyControllerAction({
    client: umbHttpClient, // Use Umbraco's HTTP client
}));

if (data) {
    console.log('Server status:', data);
}
```

The above example shows how to use the `getMyControllerAction` function, which is generated through `openapi-ts`. The `client` parameter is the HTTP client that you want to use. You can use any HTTP client that implements the underlying interface from **@hey-api/openapi-ts**, which the Umbraco HTTP Client does. The `getMyControllerAction` function will then use the Umbraco HTTP client over its own to make the request to the Management API.

## Further reading

- `[@hey-api/openapi-ts](https://heyapi.dev/openapi-ts/get-started)`
- [Creating a Backoffice API](../../../tutorials/creating-a-backoffice-api/README.md)
