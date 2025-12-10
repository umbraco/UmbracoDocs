# TypeScript setup

Make sure to configure your TypeScript compiler so it includes the Global Types from the Backoffice. This enables you to utilize the declared Extension Types. If your project is using other Packages that provides their Extension Types, kindly list them as well.

In your `tsconfig.json` file. Add the array `types` inside `compilerOptions`, with the entry of `@umbraco-cms/backoffice/extension-types`:

```json
{
    "compilerOptions": {
        ...
        "types": [
            "@umbraco-cms/backoffice/extension-types"
        ]
    }
}
```
