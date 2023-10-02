---
description: Learn about the recommended development environment to extend Umbraco.
---

# Setup Your Development Environment

{% hint style="warning" %}
This page is a work in progress. It will be updated as the software evolves.
{% endhint %}

## Required Software

Make sure you have the following installed on your machine:

-   **.NET 8**
-   **Node.js 18.16**

{% hint style="info" %}
Tip: use nvm (Node Version Manager for [Windows](https://github.com/coreybutler/nvm-windows) or [Mac/Linux](https://github.com/nvm-sh/nvm)
{% endhint %}

## Package Setup

### App_Plugins

Extensions will go into a folder called `App_Plugins`. If you don't have this folder, you can create it at the root of your Umbraco project.

### Dependencies

Install the NPM package called @umbraco-cms/backoffice by running the command `npm install -D @umbraco-cms/backoffice@14.0.0--preview003`. This will install the relevant packages used for IntelliSense and TypeScript definitions in your IDE. The `--preview003` is the version of the package, which will change as new versions are released.

{% hint style="info" %}
The `--preview003` is required to install the correct version of the package. You have to specify the specific version. Otherwise you will get the latest version of the package, which may not be compatible with the version of Umbraco you are using.
{% endhint %}

It is important that this namespace is ignored in your bundler. If you are using Vite, you can add the following to your `vite.config.ts` file:

```ts
import { defineConfig } from "vite";

export default defineConfig({
    build: {
        rollupOptions: {
            external: [/^@umbraco/],
        },
    },
});
```

This ensures that the Umbraco Backoffice package is not bundled with your package.

## Visual Studio Code

If you're using Visual Studio Code you can install the extension [Lit-Plugin](https://marketplace.visualstudio.com/items?itemName=runem.lit-plugin) to get intellisense for Lit Elements and Umbraco UI Library Components.
