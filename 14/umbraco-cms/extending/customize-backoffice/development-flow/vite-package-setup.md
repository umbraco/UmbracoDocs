---
description: Get started with a Vite Package, setup with TypeScript and Lit
---

# Vite Package Setup

## Overview

Umbraco recommends building extensions with a setup using TypeScript and a build tool such as Vite. Umbraco uses the library Lit for building web components which we will use throughout this guide.

## Getting Started With Vite

Vite comes with a set of good presets to get you quickly up and running with libraries and languages. For example: Lit, Svelte, and Vanilla Web Components with both JavaScript and TypeScript.

{% hint style="info" %}
Before following this guide, read the [Setup Your Development Environment](./) article.
{% endhint %}

1. Run the following command in the `App_Plugins` which is found (or needs to be created) at the root of your project:

```bash
npm create vite@latest
```

This command will help you set up your new package, asking you to pick a framework and a compiler.

2. To follow this tutorial, we recommend you enter `my-dashboard` as the **Project Name** when prompted, although you can choose any other you like. Then choose **Lit** and **TypeScript**.

{% hint style="warning" %}
When you follow other guides, make sure to **replace** `my-dashboard`with the suggested name from the other guides.
{% endhint %}

<figure><img src="../../../.gitbook/assets/Vite_Package_Setup_Image_Install (1).png" alt=""><figcaption><p>Create vite command choices</p></figcaption></figure>

This creates a new folder, sets up our new project, and creates a `package.json` file, which includes the necessary packages.

{% hint style="info" %}
Alternatively of the two steps above, you can type the following:

```typescript
npm create vite@latest my-dashboard -- --template lit-ts
```

This will create a Vite Package with Lit and TypeScript in a folder called **my-dashboard**.
{% endhint %}

3. Navigate to the new project folder **my-dashboard** and install the packages using:

```bash
npm install
```

4. Install the Backoffice package. You can install the package using the following command:

```bash
npm install -D @umbraco-cms/backoffice
```

{% hint style="info" %}
Optionally you can use `--legacy-peer-deps` in the installation command to avoid installing Umbraco´s sub-dependencies like TinyMCE and Monaco Editor:\
`npm install --legacy-peer-deps -D @umbraco-cms/backoffice`

If this is used the Intellisense to those external references will not be available.
{% endhint %}

5. Create a new file called `vite.config.ts` in `my-dashboard` folder and insert the following code:

```ts
import { defineConfig } from "vite";

export default defineConfig({
    build: {
        lib: {
            entry: "src/my-element.ts", // your web component source file
            formats: ["es"],
        },
        outDir: "dist", // your web component will be saved in this location
        sourcemap: true,
        rollupOptions: {
            external: [/^@umbraco/],
        },
    },
});
```

This alters the Vite default output into a **library mode**, where the output is a JavaScript file with the same name as the `name` attribute in `package.json`. The name is `my-dashboard` if you followed this tutorial with no changes.

The source code that is compiled lives in the `src` folder of your package folder and that is where you can see a `my-element.ts` file. You can confirm that this file is the one specified as our entry on the Vite config file that we recently created.

{% hint style="info" %}
The `build:lib:entry` parameter can accept an array which will allow you to export multiple files during the build. You can read more about [Vite's build options here](https://vitejs.dev/config/build-options.html#build-lib).
{% endhint %}

**Build Package**

Build the `ts` file in the `my-dashboard` folder so we can use it in our package:

```bash
npm run build
```

## Watch for changes and build

If you like to continuously work on the package and have each change built, you can add a `watch`script in your `package.json` with `vite build --watch`. The example below indicates where in the structure this change should be implemented:

{% code title="package.json" lineNumbers="true" %}

```json
{
  "name": "my-dashboard",
  ...
  "scripts": {
    "watch": "vite build --watch"
    ...
  },
  ...
```

{% endcode %}

Then in the terminal, you can run `npm run watch`.

## Umbraco Package declaration

Declare your package to Umbraco via a file called `umbraco-package.json`. This should be added at the root of your package. In this guide, it is inside the `my-dashboard` folder.

This example declares a Dashboard as part of your Package, using the Vite example element.

{% code title="umbraco-package.json" lineNumbers="true" %}

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
            "element": "/App_Plugins/my-dashboard/dist/my-dashboard.js",
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

Learn more about the abilities of the manifest file in the [Umbraco Package Manifest](../../property-editors/package-manifest.md) article.

#### Testing your package

To be able to test your package, you will need to run your site.

Before you do this, you need to include all the files in the `src` folder and the `umbraco-package.json` file in your project.

If you try to include these resources via Visual Studio (VS), then only the `dist` folder needs to be included. Otherwise, VS will try to include a few lines on your `.csproj` file to compile the TypeScript code that exists in your project folder. When you run your website, VS will try to compile these files and fail.

**Result**

The final result looks like this:

<figure><img src="../../../.gitbook/assets/Vite_Package_Setup_Dashboard (1).png" alt=""><figcaption><p>My dashboard</p></figcaption></figure>

If the Vite logo is not found, the path to its location needs to be changed. Update the `my-element.ts` file in the `src` folder accordingly:

```typescript
import viteLogo from '../dist/vite.svg'
```

In the same file, you will need to change the `background-color` of the `button` to white so it is visible:

```css
 button {
      background-color: white;
      }
```

## Summary

With this, you have set up your Package and created an Extension for the Backoffice.

This Dashboard will appear on all sections, so continue the following tutorial on [Creating A Custom Dashboard](../../tutorials/creating-a-custom-dashboard.md).
