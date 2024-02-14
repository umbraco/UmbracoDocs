---
description: Get started with a Vite Package, setup with TypeScript and Lit
---

# Vite Package Setup

Umbraco recommends building extensions with a setup using TypeScript and a build tool such as Vite. Umbraco uses the library Lit for building web components which we will be using throughout this guide.

### Getting Started With Vite

Vite comes with a set of really good presets to get you quickly up and running with libraries and languages. For example: Lit, Svelte, and Vanilla Web Components with both JavaScript and TypeScript.

Create an `/App_Plugins` folder if it doesn't exist yet and run the following command.

```bash
npm create vite@latest
```

This Guide will help you set up your new package, asking you to pick a framework and a compiler. We recommend **Lit** and **TypeScript**.

To follow this tutorial, we recommend you enter `my-dashboard` as the Project Name when prompted, although you can choose any other you like.

This creates a new folder, sets up our new project, and creates a `package.json` file, which includes the necessary packages.

Navigate to the new project folder and install the packages using:

```bash
npm install
```

The last thing we need to install now is our Backoffice package. You can install the package using the following command:

{% hint style="warning" %}
The Backoffice package currently relies on the older Lit 2.8 and the Vite template uses Lit 3. Because of this mismatch, you need to override the Lit version in the Backoffice package by installing with the `--force` option. This will be fixed in a future version when the Backoffice has been upgraded to Lit 3.
{% endhint %}

```bash
npm install --force --registry https://www.myget.org/F/umbracoprereleases/npm/ -D @umbraco-cms/backoffice@14.0.0--preview006
```

This will add a package to your devDependencies containing the TypeScript definitions for the Umbraco Backoffice. The `--preview004` is the version of the package, which will change as new versions are released.

{% hint style="warning" %}
If you see any errors during this process, make sure that you have the right tools installed (Node, .NET, and so on). Also, make sure you have followed the steps on how to [Setup Your Development Environment](./).
{% endhint %}

Next, in your project folder, create a new file called `vite.config.ts` and insert the following code:

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

The source code that is compiled lives in the `src` folder of your package folder and that is where you can see a `my-element.js` file. You can confirm that this file is the one specified as our entry on the Vite config file that we recently created.

{% hint style="info" %}
The `build:lib:entry` parameter can accept an array which will allow you to export multiple files during the build. You can read more about [Vite's build options here](https://vitejs.dev/config/build-options.html#build-lib).
{% endhint %}

#### Build Package

Next, we are going to build the `ts` file so we can use it in our package:

```bash
npm run build
```

### Watch for changes and build

If you like to continuously work on the package and have each change built, you can change the `dev` script of your `package.json` to `vite build --watch`. The example below indicates where in the structure this change should be implemented:

{% code title="package.json" lineNumbers="true" %}
```json
{
  "name": "my-package",
  ...
  "scripts": {
    "dev": "vite build --watch",
    ...
  },
  ...
```
{% endcode %}

### Umbraco Package declaration

Declare your package to Umbraco via a file called `umbraco-package.json.` This should be added at the root of your package.

This example declares a Dashboard as part of your Package, using the Vite example element.

[Learn about the abilities of the Umbraco Package here.](../package-manifest.md)

{% code title="umbraco-package.json" lineNumbers="true" %}
```json
{
    "$schema": "../../umbraco-package-schema.json",
    "name": "My Package",
    "version": "0.1.0",
    "extensions": [
        {
            "type": "dashboard",
            "alias": "My.Dashboard.MyExtension",
            "name": "My Dashboard",
            "js": "/App_Plugins/my-dashboard/dist/my-dashboard.js",
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
Umbraco needs the name of the element that will render as default when our dashboard loads. This is specified in the manifest as the `elementName`. Another approach would be to define your default element in the TS code.

To do this, you should add `default` to your `MyElement` class in the `my-element.js` file like so

```ts
export default class MyElement extends LitElement {
```
{% endhint %}

### Testing your package

In order to be able to test your package, you will need to run your site. Before you do this, you will need to include all the files in the `src` folder and the `umbraco-package.json` file into your project.

If you try to include these resources via Visual Studio, be careful to include only the `dist` folder. Otherwise, VS will try include a few lines on your csproj file to compile the TypeScript code that exists in your project folder. When you run your website, VS will try to compile these files and will fail.

### Summary

With this, you have set up your Package and created an Extension for the Backoffice.

This Dashboard will appear on all sections, so please continue by following the tutorial on [Creating A Custom Dashboard](../../tutorials/creating-a-custom-dashboard.md)
