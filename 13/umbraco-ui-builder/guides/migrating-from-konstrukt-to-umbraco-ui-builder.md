---
description: Learn how to migrate a Konstrukt solution to Umbraco UI Builder.
---

# Migrate from Konstrukt to Umbraco UI Builder

This guide provides a step-by-step approach to migrating a default Konstrukt solution to Umbraco UI Builder.

## Key changes

Before outlining the exact steps, there are a few key changes to be aware of.

These changes will dictate the steps to take in the process of migrating to Umbraco UI Builder.

### Project, Package, and Namespace changes

| Konstrukt                       | Umbraco UI Builder                      |
| ------------------------------- | --------------------------------------- |
| Konstrukt.Core                  | Umbraco.UIBuilder.Core                  |
| Konstrukt.Infrastructure        | Umbraco.UIBuilder.Infrastructure        |
| Konstrukt.Web                   | Umbraco.UIBuilder.Web                   |
| Konstrukt.Web.UI                | Umbraco.UIBuilder.Web.StaticAssets      |
| Konstrukt.Startup               | Umbraco.UIBuilder.Startup               |
| Konstrukt                       | Umbraco.UIBuilder                       |

<details>

<summary>C# Class changes</summary>

* Namespace changes as documented above.
* Most classes prefixed with the `Konstrukt` keyword have had this prefix removed.
  * Examples: `IKonstruktRepository` is now `IRepository`
  * Exclusions: The root level `KonstruktConfig` and `KonstruktConfigBuilder` have a `UIBuilder` prefix instead, and the `AddKonstrukt` extension for `IUmbracoBuilder` has been replaced by `AddUIBuilder`

</details>

<details>

<summary>JavaScript changes</summary>

* All `Konstrukt` controllers have changed namespace to `Umbraco.UIBuilder`.
* All `Konstrukt` prefixed directives, services, and resources are now prefixed with `uibuilder`.

</details>

<details>

<summary>UI Changes</summary>

* All static UI assets are served via a Razor Compiled Library (RCL) and are no longer found in the `App_Plugins` folder.
* The folder with `App_Plugins` has been renamed from `Konstrukt` to `UmbracoUIBuilder`.

</details>

## Step 1: Replace dependencies

In this first step, we will be replacing all existing Konstrukt dependencies with Umbraco UI Builder dependencies.

1. Remove any installed Konstrukt packages:

```bash
dotnet remove package Konstrukt
```

2. Delete the Konstrukt `App_Plugins` folder:

```bash
rmdir App_Plugins\Konstrukt
```

3. Install `Umbraco.UIBuilder`:

```bash
dotnet add package Umbraco.UIBuilder
```

4. Compile your project against .NET 7.0.

## Step 2: Update namespaces and entity names

Based on the [Key Changes](./#key-changes) outlined above update all Konstrukt references to the new Umbraco UI Builder alternatives. Ensure you update any Views/Partials that also reference these.

## Step 3: Update your configuration

If all your configuration is in a single statement, it would be a case of swapping `AddKonstrukt` to `AddUIBuilder`. If you broke your configuration into multiple steps, or are using `Action` or `Card` classes, you will need to update the config builder/base classes. Those classes need to be updated to their UI Builder alternative names as detailed in [Key Changes](./#key-changes).


```csharp
builder.CreateUmbracoBuilder()
    .AddBackOffice()
    .AddWebsite()
    .AddDeliveryApi()
    .AddComposers()
    .AddUIBuilder(cfg => {
        // The rest of your configuration
    })
    .Build();
```

## Step 4: Finalizing the migration

1. Delete any obj/bin folders in your projects to ensure a clean build.
2. Recompile all projects and ensure all dependencies are restored correctly
3. Delete the existing Konstrukt license files in the `umbraco\Licenses` folder.
4. Add your new Umbraco.UIBuilder license key to the `appSettings.json` file:

```json
"Umbraco": {
  "Licenses": {
    "Umbraco.UIBuilder": "YOUR_LICENSE_KEY"
  }
}
```

5. Run the project.
