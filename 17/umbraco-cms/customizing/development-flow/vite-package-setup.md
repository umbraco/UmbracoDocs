---
description: Get started with a Vite Package, setup with TypeScript and Lit
---

# Vite Package Setup

Umbraco recommends building extensions with a setup using TypeScript and a build tool such as Vite. Umbraco uses the library Lit for building web components which we will use throughout this guide.

{% hint style="info" %}
These are general recommendations for working with and building extensions for the Umbraco backoffice. You can use any framework or library of your choice. For Umbraco's recommended approach, see the [Umbraco Extension Template](./umbraco-extension-template.md).
{% endhint %}

## Before You Begin

Make sure to read the [Setup Your Development Environment](./) article before continuing.

## Create a Vite Package

Vite comes with a set of good presets to get you quickly up and running with libraries and languages. For example: Lit, Svelte, and Vanilla Web Components with both JavaScript and TypeScript.

1. Open your terminal and navigate to the folder where you want to create the new Vite package.
2. Run the following command:

```bash
npm create vite@latest
```

This command starts a setup prompt.

For this tutorial, it is recommended to use the names given below. However, feel free to choose other names if preferred.

3. When prompted:
    * Enter **client** as the **Project Name**.
    * Select **Lit** as the framework.
    * Select **TypeScript** as the variant.

    This creates a new folder called **client** with your project files.

{% hint style="info" %}

For Windows environments the command should be slightly different::

```typescript
npm create vite@latest client --- --template lit-ts
```

or you will still see the interactive prompts, especially when using PowerShell.

{% endhint %}

4. Navigate into the new **client** folder and install the packages:

```bash
cd client
npm install
```

{% hint style="warning" %}
Before proceeding, ensure that you install the version of the Backoffice package compatible with your Umbraco installation. You can find the appropriate version on the [@umbraco-cms/backoffice npm page](https://www.npmjs.com/package/@umbraco-cms/backoffice).
{% endhint %}

5. Install the Backoffice package using the following command, where `x.x.x` should be replaced with your Umbraco version:

```bash
npm install -D @umbraco-cms/backoffice@x.x.x
```

6. To avoid installing Umbraco’s sub-dependencies such as the entire Monaco Editor, use the `--legacy-peer-deps` flag:

 ```bash
npm install --legacy-peer-deps -D @umbraco-cms/backoffice@x.x.x
 ```

This disables IntelliSense for external references but keeps the install lean.

7. Open the `tsconfig.json` file.
8. Add the array `types` inside `compilerOptions`, with the entry of `@umbraco-cms/backoffice/extension-types`:

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

9. Create a new `vite.config.ts` file in the **client** folder:

{% code title="vite.config.ts" lineNumbers="true" %}
```ts
import { defineConfig } from "vite";

export default defineConfig({
    build: {
        lib: {
            entry: "src/my-element.ts", // your web component source file
            formats: ["es"],
        },
        outDir: "../App_Plugins/client", // all compiled files will be placed here
        emptyOutDir: true,
        sourcemap: true,
        rollupOptions: {
            external: [/^@umbraco/], // ignore the Umbraco Backoffice package in the build
        },
    },
    base: "/App_Plugins/client/", // the base path of the app in the browser (used for assets)
});
```
{% endcode %}

The `outDir` parameter specifies where the compiled files are placed. In this example, they are stored in the `App_Plugins/client` folder. If you are working with a different structure, such as a Razor Class Library (RCL) project, update this path to `wwwroot`.

This alters the Vite default output into a **library mode**, where the output is a JavaScript file with the same name as the `name` attribute in `package.json`. The name is `client.js` if you followed this tutorial with no changes.

The source code that is compiled lives in the `src` folder of your package folder and that is where you can see a `my-element.ts` file. You can confirm that this file is the one specified as our entry on the Vite config file that we recently created.

The `build:lib:entry` parameter can accept an array which will allow you to export multiple files during the build. You can read more about [Vite's build options here](https://vitejs.dev/config/build-options.html#build-lib).

10. Build the `ts` file in the **client** folder:

```bash
npm run build
```

## Watch for changes and build

To continuously work on the package and have each change built, add a `watch`script in your `package.json` with `vite build --watch`.

The example below indicates where in the structure this change should be implemented:

{% code title="package.json" lineNumbers="true" %}
```json
{
  "name": "client",
  ...
  "scripts": {
    "watch": "vite build --watch"
    ...
  },
  ...
```
{% endcode %}

Run `npm run watch` in the terminal.

## Umbraco Package declaration

Declare your package to Umbraco via a file called `umbraco-package.json`. This should be added in the `public` folder under the root of your package. Once built the `umbraco-package.json` file should be located at `/App_Plugins/` or `/App_Plugins/{YourPackageName}` for Umbraco to detect it.

This example declares a Dashboard as part of your Package, using the Vite example element.

{% code title="client/public/umbraco-package.json" lineNumbers="true" %}
```json
{
    "$schema": "../../umbraco-package-schema.json",
    "name": "My Dashboard",
    "version": "0.1.0",
    "extensions": [
        {
            "type": "dashboard",
            "alias": "My.Dashboard.MyExtension",
            "name": "My Dashboard",
            "element": "/App_Plugins/client/client.js",
            "elementName": "my-element",
            "meta": {
                "label": "My Dashboard",
                "pathname": "my-dashboard"
            }
        }
    ]
}
```
{% endcode %}

{% hint style="info" %}
Umbraco needs the name of the element that will render as default when our dashboard loads.

* This is specified in the **manifest** as the `elementName`.
* Another approach would be to define your default element in the TS code. To do this, in the `src/my-element.ts` add **`default`** to your `MyElement` class in the file like so:

```ts
export default class MyElement extends LitElement {
```
{% endhint %}

Learn more about the abilities of the manifest file in the [Umbraco Package Manifest](../umbraco-package.md) article.

#### Testing your package

To test your package, run your site.

Before doing this, make sure to run `npm run build` to compile your TypeScript files and copy them to the `App_Plugins/client` folder.

{% hint style="warning" %}
If you try to include some of these resources via Visual Studio (VS), then make sure not to include TypeScript files. Otherwise, VS will try to include a few lines on your `.csproj` file to compile the TypeScript code that exists in your project folder. When you run your website, VS will try to compile these files and fail.
{% endhint %}

The final result looks like this:

<figure><img src="../../.gitbook/assets/Vite_Package_Setup_Dashboard (1).png" alt=""><figcaption><p>My dashboard</p></figcaption></figure>

In the `src/my-element.ts` file, update the `styles` property to make any styling changes. You can change the `background-color` of the `button` to white so it is more visible:

```css
button {
    background-color: white;
}
```

## Summary

With this, you have set up your Package and created an Extension for the Backoffice.

In more advanced cases, you can add more elements to your package and create more complex extensions. In that case, you can benefit greatly from creating another project in your solution to hold the files. This way, you can keep your solution clean and organized. We recommend creating a [Razor Class Library (RCL)](https://learn.microsoft.com/en-us/aspnet/core/razor-pages/ui-class?view=aspnetcore-8.0\&tabs=visual-studio#create-an-rcl-with-static-assets) for this purpose. You can read more about this in the [Development Flow](./#source-code) article.

This Dashboard appears in all sections and does not do much. To extend it to interact with the Umbraco Backoffice, follow the tutorial on [Creating Your First Extension](../../tutorials/creating-your-first-extension.md).
