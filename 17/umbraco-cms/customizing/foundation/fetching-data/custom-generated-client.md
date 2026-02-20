---
description: Learn how to create a custom generated client with TypeScript types for your OpenAPI specification.
---

# Custom Generated Client

Umbraco uses [@hey-api/openapi-ts](https://heyapi.dev/openapi-ts/get-started) to generate its HTTP client for the OpenAPI specification of the Management API. It is available through the `@umbraco-cms/backoffice/http-client` package.

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
npx openapi-ts --input https://example.com/openapi.json --output ./my-client
```

This will generate a TypeScript client in the `./my-client` folder. Import the generated client into your project to make requests to the Management API.

To learn more about OpenAPI and how to define your API specification, visit the [OpenAPI Documentation](https://swagger.io/specification/).

## Connecting to the Management API

Your generated client needs the correct base URL, credentials, and authentication to talk to the Management API. The recommended approach uses hey-api's `runtimeConfigPath` to inherit these settings automatically from the backoffice's built-in HTTP client (`umbHttpClient`).

{% hint style="info" %}
The [Umbraco Extension Template](../../development-flow/umbraco-extension-template.md) already includes this setup. If you scaffolded your extension with `dotnet new umbraco-extension`, authentication works out of the box — no additional configuration needed.
{% endhint %}

### Using `runtimeConfigPath` (Recommended)

Add the `runtimeConfigPath` option to the `@hey-api/client-fetch` plugin in your generation config:

```javascript
await createClient({
    input: swaggerUrl,
    output: 'src/api',
    plugins: [
      ...defaultPlugins,
      {
        name: '@hey-api/client-fetch',
        runtimeConfigPath: './src/hey-api.ts',
      },
      {
        name: '@hey-api/sdk',
        asClass: true,
        classNameBuilder: '{{name}}Service',
      }
    ],
});
```

Then create `src/hey-api.ts`:

```typescript
import type { CreateClientConfig } from './api/client.gen';
import { umbHttpClient } from '@umbraco-cms/backoffice/http-client';

export const createClientConfig: CreateClientConfig = (config) => ({
    ...config,
    ...umbHttpClient.getConfig(),
});
```

This copies `baseUrl`, `credentials`, `auth`, and `headers` from the backoffice's HTTP client into your generated client at initialization time. Extensions load after the backoffice is fully configured, so all values are available.

When you regenerate the client (`npm run generate-client`), the generated `client.gen.ts` will automatically import `createClientConfig` and apply it during client creation. Your SDK functions will be authenticated without any entrypoint setup.

### Passing `umbHttpClient` directly

If you only have a few requests, you can skip client configuration entirely and pass `umbHttpClient` as the `client` parameter on each call:

```javascript
import { getMyControllerAction } from './my-client';
import { tryExecute } from '@umbraco-cms/backoffice/resources';
import { umbHttpClient } from '@umbraco-cms/backoffice/http-client';

const { data } = await tryExecute(this, getMyControllerAction({
    client: umbHttpClient,
}));

if (data) {
    console.log('Server status:', data);
}
```

This uses the backoffice's HTTP client directly for that request instead of the generated client. The `umbHttpClient` already has authentication and the correct base URL configured.

{% hint style="warning" %}
The `auth` callback on `umbHttpClient` only fires for SDK functions that have `security` metadata. This metadata is generated automatically when your OpenAPI specification includes a security scheme (for example, Bearer authentication). If your spec does not include a security scheme, the generated functions will not send an `Authorization` header. For direct `.get()` / `.post()` calls (without a generated client), see [Calling custom API endpoints](http-client.md#calling-custom-api-endpoints).
{% endhint %}

### Fetch API

If you only have a few requests, you can also use the `fetch` function directly. Read more about that here:

{% content-ref url="fetch-api.md" %}
[fetch-api.md](fetch-api.md)
{% endcontent-ref %}

## Further reading

- [@hey-api/openapi-ts](https://heyapi.dev/openapi-ts/get-started)
- [Creating a Backoffice API](../../../tutorials/creating-a-backoffice-api/README.md)
