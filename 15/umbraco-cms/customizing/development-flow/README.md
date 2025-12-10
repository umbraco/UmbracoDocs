---
description: Learn about the recommended development environment to extend Umbraco
---

# Setup Your Development Environment

This article will take you through setting up everything you need to start building extensions and packages for Umbraco.

## Required Software

Make sure you have followed the [requirements](../../fundamentals/setup/requirements.md) article, especially having installed the following on your machine:
* [Node.js version 20.15.0 (LTS)](https://nodejs.org/en) and higher

{% hint style="info" %}
Use Node Version Manager (NVM) for [Windows](https://github.com/coreybutler/nvm-windows) or [Mac/Linux](https://github.com/nvm-sh/nvm) to manage the Node.js versions.
{% endhint %}

## Package Setup

### App_Plugins

Extensions such as JavaScript, CSS, and manifests, will go into a folder called `App_Plugins`. If you do not have this folder, you can create it at the root of your Umbraco project.

### Source Code

The source code for your extensions should ideally be placed in a different project. You can make great use of a [Razor Class Library (RCL) with static assets](https://learn.microsoft.com/en-us/aspnet/core/razor-pages/ui-class?view=aspnetcore-8.0\&tabs=visual-studio#create-an-rcl-with-static-assets) for this purpose. This will make it easier to maintain and test your code. You can create a new project in the root of your Umbraco project, or you can create a new project in a separate folder.

### Bundling

If you are using a bundler like Webpack or Vite, you can configure it to output its files to a folder that Umbraco can see. If you have put your files directly in Umbraco project, you need to copy the compiled files over to the `App_Plugins` folder.

With a Razor Class Library (RCL) project, you should instead configure your bundler to copy the files over to the `wwwroot` folder. You can then map your RCL project back to the `App_Plugins` web path, so Umbraco can read your files. You can do this by setting the `StaticWebAssetBasePath` in your `csproj` file:

{% code title="MyExtension.csproj" lineNumbers="true" %}
```xml
<Project Sdk="Microsoft.NET.Sdk.Razor">

  <PropertyGroup>
    <StaticWebAssetBasePath>App_Plugins/MyExtension</StaticWebAssetBasePath>
  </PropertyGroup>

</Project>
```
{% endcode %}

### Dependencies

You can use any package manager you like to install dependencies. We recommend using NPM or Yarn. You can install packages by running the command:

```bash
npm install -D <package-name>
```

This will install the package and save it to your `package.json` file.

You need to setup a `package.json` file if you don't have one already. You can do this by running the command:

```bash
npm init -y
```

{% hint style="warning" %}
Make sure that you do not install any NPM dependencies directly into the `App_Plugins` folder. This can cause issues with Build and Publish processes in MSBuild. Always install dependencies in a separate folder and use a bundler to copy the compiled files over to the `App_Plugins` folder.
{% endhint %}

### Umbraco Backoffice

Umbraco publishes an NPM package called `@umbraco-cms/backoffice` that holds typings and other niceties to build extensions.

{% hint style="warning" %}
Ensure that you install the version of the Backoffice package compatible with your Umbraco installation. You can find the appropriate version on the [@umbraco-cms/backoffice npm page](https://www.npmjs.com/package/@umbraco-cms/backoffice).
{% endhint %}

You can install this package by running the command:

```bash
npm install -D @umbraco-cms/backoffice@x.x.x
```

This will add a package to your devDependencies containing the TypeScript definitions for the Umbraco Backoffice.

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

If you're using Visual Studio Code we recommend the extension called [Lit-Plugin](https://marketplace.visualstudio.com/items?itemName=runem.lit-plugin) to get IntelliSense for Lit Elements and Umbraco UI Library Components.

## What's Next?

Now that you have your development environment set up, you can start building your Umbraco extensions. Read more about [our recommended setup with Vite](vite-package-setup.md) to get started.
