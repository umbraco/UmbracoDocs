---
description: Learn about the recommended development environment to extend Umbraco.
---

# Setup Your Development Environment

## Required Software

Make sure you have the following installed on your machine:

* **.NET 8**
* [**Node.js version 20.11.0 (LTS)**](https://nodejs.org/en/download/)

{% hint style="info" %}
Tip: use NVM (Node Version Manager) for [Windows](https://github.com/coreybutler/nvm-windows) or [Mac/Linux](https://github.com/nvm-sh/nvm) to manage the Node.js versions.
{% endhint %}

## Package Setup

### App\_Plugins

Extensions will go into a folder called `App_Plugins`. If you don't have this folder, you can create it at the root of your Umbraco project.

### Source Code

Source code for your extensions should ideally be placed in a different project. This will make it easier to maintain and test your code. You can create a new project in the root of your Umbraco project, or you can create a new project in a separate folder. If you are using a bundler like Vite, you can configure it to copy over the files to the `App_Plugins` folder when you build your project.

### Dependencies

You can use any package manager you like to install dependencies. We recommend using NPM or Yarn. You can install packages by running the command `npm install --registry https://www.myget.org/F/umbracoprereleases/npm/ -D <package-name>`. This will install the package and save it to your `package.json` file. You need to setup a `package.json` file if you don't have one already. You can do this by running the command `npm init -y`.

### Umbraco Backoffice

Umbraco publishes an NPM package called "@umbraco-cms/backoffice" that holds typings and other niceties to build extensions. You can install this package by running the command `npm install --registry https://www.myget.org/F/umbracoprereleases/npm/ -D @umbraco-cms/backoffice@14.0.0-beta001`. This will install the relevant packages used for IntelliSense and TypeScript definitions in your IDE. The `-beta001` is the version of the package, which will change as new versions are released.

It is important that this namespace is ignored in your bundler. If you are using Vite, you can add the following to your `vite.config.ts` file:

```ts
import { defineConfig } from "vite";

export default defineConfig({
    // other config
    // ...
    // add this to your config
    build: {
        rollupOptions: {
            external: [/^@umbraco/],
        },
    }
});
```

This ensures that the Umbraco Backoffice package is not bundled with your package.

Read more about using Vite with Umbraco in the [Vite Package Setup](vite-package-setup.md) article.

## Visual Studio Code

If you're using Visual Studio Code we recommend the extension called [Lit-Plugin](https://marketplace.visualstudio.com/items?itemName=runem.lit-plugin) to get intellisense for Lit Elements and Umbraco UI Library Components.
