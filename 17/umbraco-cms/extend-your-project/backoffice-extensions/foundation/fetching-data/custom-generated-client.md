---
description: Learn how to create a custom-generated client with TypeScript types for your OpenAPI specification.
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

Your generated client needs the correct base URL, credentials, and authentication to talk to the Management API. The recommended approach uses hey-api's `runtimeConfigPath` to inherit these settings automatically from the built-in backoffice HTTP client (`umbHttpClient`).

{% hint style="info" %}
The [Umbraco Extension Template](../../development-flow/umbraco-extension-template.md) already includes this setup. If you scaffolded your extension with `dotnet new umbraco-extension`, authentication works out of the box — no additional configuration needed.
{% endhint %}

### Using `runtimeConfigPath` (Recommended)

To pass plugin options like `runtimeConfigPath`, create a config file instead of using CLI flags.

1. Create `openapi-ts.config.ts` in your project root:

```typescript
import { defineConfig } from '@hey-api/openapi-ts';

export default defineConfig({
    input: 'https://localhost:44339/umbraco/swagger/myextension/swagger.json',
    output: 'src/api',
    plugins: [
        {
            name: '@hey-api/client-fetch',
            runtimeConfigPath: './src/hey-api.ts',
        },
        {
            name: '@hey-api/sdk',
            asClass: true,
        },
    ],
});
```

2. Run the generator, which will pick up the config file automatically:

```bash
npx openapi-ts
```

3. Create a `src/hey-api.ts` file and add the following:

```typescript
import type { CreateClientConfig } from './api/client.gen';
import { umbHttpClient } from '@umbraco-cms/backoffice/http-client';

export const createClientConfig: CreateClientConfig = (config) => ({
    ...config,
    ...umbHttpClient.getConfig(),
});
```

This copies `baseUrl`, `credentials`, `auth`, and `headers` from the backoffice HTTP client into your generated client at initialization time. Extensions load after the backoffice is fully configured, so all values are available.

When the generator runs, the generated `client.gen.ts` will automatically import `createClientConfig` and apply it during client creation. Your SDK functions will be authenticated without any entrypoint setup.

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
    console.log('Data:', data);
}
```

The example above uses the backoffice HTTP client directly instead of the generated client. The `umbHttpClient` already has authentication and the correct base URL configured.

## How security metadata works

The `auth` callback on `umbHttpClient` only fires when a request carries `security` metadata. Here is how that metadata flows from your API to the generated client:

1. Each operation in your OpenAPI spec has an optional `security` field listing the security schemes it requires. Example: `[{ "Backoffice-User": [] }]`.
2. Those scheme names are defined in `components.securitySchemes`, where their type (OAuth2, HTTP Bearer, and so on) is declared.
3. When hey-api generates your client, it reads both and resolves them into its own runtime shape - `security: [{ type: 'http', scheme: 'bearer' }]` - emitted directly into each generated SDK function.

The resolved shape is what `umbHttpClient` checks before invoking the `auth` callback.

### Management API (automatic)

If your controllers are part of the Umbraco Management API — tagged with `[MapToApi("management")]` — Umbraco writes the `operation.security` requirement into the OpenAPI spec automatically. This is done by `BackOfficeSecurityRequirementsOperationFilter`, a Swashbuckle operation filter registered as part of the Management API configuration. It inspects each operation at startup. If neither the controller class nor the action method carries `[AllowAnonymous]`, it adds a security requirement referencing the globally registered `"Backoffice-User"` scheme.

When hey-api generates your client from that spec, it resolves the scheme and emits the runtime security metadata into each SDK function. No extra setup needed.

### Custom separate API

If you expose a separate API with its own Swagger document, security requirements are not added automatically. You must apply them to each operation in your OpenAPI specification, for example via an operation filter. Umbraco provides `BackOfficeSecurityRequirementsOperationFilterBase` as a public base class you can subclass:

```csharp
using Umbraco.Cms.Api.Management.OpenApi;

internal sealed class MyExtensionSecurityRequirementsOperationFilter : BackOfficeSecurityRequirementsOperationFilterBase
{
    // Must match the [MapToApi("...")] attribute on your controllers
    protected override string ApiName => "myextension";
}
```

Register it in your SwaggerGen configuration:

```csharp
swaggerGenOptions.OperationFilter<MyExtensionSecurityRequirementsOperationFilter>();
```

No `AddSecurityDefinition` call is needed — Umbraco already registers the required Bearer security scheme globally, and the base filter references it automatically. Once in place, hey-api will generate SDK functions with the correct `security` metadata.

For a full walkthrough of setting up a custom API, see [Creating a Backoffice API](../../../tutorials/creating-a-backoffice-api/README.md).

### Direct calls without a generated client

When calling `umbHttpClient` directly — without a generated SDK function — there is no spec to derive security metadata from. Pass it explicitly on each call:

```typescript
const { data } = await umbHttpClient.get({
    url: '/umbraco/myextension/api/v1/endpoint',
    security: [{ type: 'http', scheme: 'bearer' }],
});
```

See [Umbraco HTTP Client](http-client.md) for more details.

## Fetch API

If you only have a few requests, you can also use the `fetch` function directly. Read more about that here:

{% content-ref url="fetch-api.md" %}
[fetch-api.md](fetch-api.md)
{% endcontent-ref %}

## Further reading

- [@hey-api/openapi-ts](https://heyapi.dev/openapi-ts/get-started)
- [Creating a Backoffice API](../../../tutorials/creating-a-backoffice-api/README.md)
