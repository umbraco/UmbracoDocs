---
description: Use the `umbraco-extension` .NET template to create a new Umbraco extension.
---

# Umbraco Extension Template

Umbraco provides a .NET template to help you get started with building extensions for the Umbraco backoffice. This template sets up a new project with all the necessary files and configurations to build an extension. The template is called `umbraco-extension` and can be used to create a new Umbraco extension project with a single command.

## Prerequisites

* [.NET SDK](https://dotnet.microsoft.com/download) version 9.0 or later
* [Node.js](https://nodejs.org/en/download/) version 22 or later

## Install the Umbraco Extension Template

To install the Umbraco extension template, run the following command in your terminal:

```bash
dotnet new install Umbraco.Templates@17.7.0
```

{% hint style="info" %}
The numbers at the end, `x.x.x` determines the specific version. It is important to match this with the version of the project you're creating the extension project in.
{% endhint %}

This command installs both the `umbraco` and `umbraco-extension` templates, which you can use to create new Umbraco and Umbraco extension projects. If a new Umbraco project has previously been created using `dotnet new umbraco`, the templates may already be installed.

## Create a New Umbraco Extension

To create a new Umbraco extension project, run the following command in your terminal. It should be executed in a folder where you want to create the new project, for example, in the root of your solution:

```bash
dotnet new umbraco-extension -n MyExtension -ex
```

This command creates a new folder called `MyExtension` with the following files and folders:

* `MyExtension.csproj`: The project file for the extension.
* `Constants.cs`: A file containing constants for the extension.
* `Client`: A folder containing the source code for the extension, a `package.json` file, a `tsconfig.json` file, and the `vite.config.ts` configuration file.
* `README.md`: A readme file with instructions on how to build and run the extension.

The `-ex` flag indicates that you want to include examples of how to use the extension. This flag is optional, but it is recommended to include it if you are new to building extensions for Umbraco. It will additionally give you:

* `Composers`: A folder containing an example composer that registers a custom Swagger API.
* `Controllers`: A folder containing an example API controller for a dashboard.
* `Client/src/api`: A folder containing an example API client that calls the API controller.
* `Client/src/dashboards`: A folder containing an example dashboard Web Component that uses the API client.

After setup, the dashboard appears in the main **Content** section of the Backoffice.

By default, the Umbraco Extensions project references the same Umbraco version as the templates you installed. Templates before version 17.3.0 reference the latest Umbraco version instead, which can be a newer major version. To reference another version, for example the version of an existing Umbraco project, use the `--version` flag:

```bash
dotnet new umbraco-extension --version 17.1.0 -n MyExtension -ex
```

### Add the Extension to an Umbraco Project

To include the extension in your Umbraco project, you need to add a reference to the extension project in your Umbraco project.

#### Option 1: Via Visual Studio

1. Right-click the **Dependencies** node in the Umbraco project.
2. Select **Add Reference**.
3. Choose the `MyExtension` project.
4. Click **OK**.

#### Option 2: Via CLI

Run the following command in the root folder of your Umbraco project:

```bash
dotnet add reference ../MyExtension/MyExtension.csproj
```

This command adds a reference to the `MyExtension` project in your Umbraco project. You can then build your Umbraco project and see the extension in action.

## Build and Run the Extension

To build and run the extension, install the dependencies and start the Vite development server. To do this, run the following commands in the `Client` folder of your extension project:

```bash
npm install
npm run build
```

{% hint style="info" %}
The project also builds automatically when running the Umbraco project. To start the Vite development server in watch mode, run the following command:

```bash
npm run watch
```
{% endhint %}

This command compiles the TypeScript files and copies them over to the `wwwroot` output folder. Once complete, run the Umbraco project to view the extension in action.

### Fix an ERESOLVE Error From npm install

Extensions created using Umbraco 17.0.0 to 17.7.0 templates can fail to install on Umbraco 17.7.0 or later, with an error like this:

```text
npm error ERESOLVE unable to resolve dependency tree
npm error Found: @hey-api/openapi-ts@0.85.2
npm error peer @hey-api/openapi-ts@">=0.99.0 <1.0.0" from @umbraco-cms/backoffice@17.7.0
```

From Umbraco 17.7.0, `@umbraco-cms/backoffice` requires `@hey-api/openapi-ts` 0.99 or later. Update the extension to match by running these steps in the `Client` folder:

1. In `package.json`, change the `@hey-api/openapi-ts` version to `^0.99.0` and run `npm install`.
2. Delete `src/hey-api.ts`. If the project has no such file, skip the remaining steps.
3. In `src/api/client.gen.ts`, remove the `import { createClientConfig } from '../hey-api';` line. Then create the client without `createClientConfig()`, and keep your own `baseUrl`:

    {% code title="src/api/client.gen.ts" %}
    ```typescript
    export const client = createClient(createConfig<ClientOptions2>({
        baseUrl: 'https://localhost:44339'
    }));
    ```
    {% endcode %}

4. In `scripts/generate-openapi.js`, remove the `@hey-api/client-fetch` plugin entry that sets `runtimeConfigPath: '../hey-api'`. The next `npm run generate-client` then creates the client without it.
5. Check that `src/entrypoints/entrypoint.ts` calls `configureClient()` in `onInit`. Extensions created from the 17.3 template need to add the call. Add the two imports, make `onInit` async, and rename its `_host` parameter to `host`:

    {% code title="src/entrypoints/entrypoint.ts" %}
    ```typescript
    import { UMB_AUTH_CONTEXT } from "@umbraco-cms/backoffice/auth";
    import { client } from "../api/client.gen.js";

    export const onInit: UmbEntryPointOnInit = async (host, _extensionRegistry) => {
      const authContext = await host.getContext(UMB_AUTH_CONTEXT);
      authContext?.configureClient(client);

      console.log("Hello from my extension 🎉");
    };
    ```
    {% endcode %}

{% hint style="warning" %}
Do not use `npm install --legacy-peer-deps` to get past the error. It skips all peer dependencies, including `lit`, and the build then fails with errors such as `Module '"@umbraco-cms/backoffice/external/lit"' has no exported member 'LitElement'`.
{% endhint %}

## Publish the Project

The output files are automatically copied to the `wwwroot` folder of your Umbraco project. They are also included in the publishing process when you publish your Umbraco project. You can publish your Umbraco project using the following command:

```bash
dotnet publish --configuration Release
```

## Publish as a Package

To publish your extension as a package, create a NuGet package. Run the following command in the root folder of your extension project:

```bash
dotnet pack --configuration Release
```

This command creates a NuGet package in the `bin/Release` folder of your extension project. You can then publish this package to a NuGet feed or share it with others.

The `umbraco-extension` template is opinionated until a certain point. It is a starting point for building extensions for the Umbraco backoffice. The template includes a basic structure and configuration for building extensions, but you can customize it to fit your needs. You can add additional files, folders, and configurations as needed.

To publish your extension as an Umbraco Package, you need some additional files. For details, see the [Umbraco Package](../umbraco-package.md) article.

### The Opinionated Starter Kit

Another option is to use the [Opinionated Umbraco Package Starter Template](https://github.com/LottePitcher/opinionated-package-starter). This is a template that includes all the files and configurations needed to build an Umbraco package. It builds on top of the `umbraco-extension` template and includes additional files and configurations for building Umbraco packages. This template is a great starting point for building Umbraco packages and includes everything you need to get started.

To install this template, run the following command in your terminal:

```bash
dotnet new install Umbraco.Community.Templates.PackageStarter
```

To create a new package project, run the following command:

```bash
dotnet new umbracopackagestarter -n YourPackageName -an "Your Name" -gu "YourGitHubUsername" -gr "YourGitHubRepoName"
```
