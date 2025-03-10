---
description: Step-by-step guide to migrating a Konstrukt solution to Umbraco UI Builder.
---

# Migrate from Konstrukt to Umbraco UI Builder

This guide walks you through migrating a default Konstrukt solution to Umbraco UI Builder.

## Key Changes

Before starting, review these key changes that impact the migration process.

### Project, Package, and Namespace changes

| Konstrukt                       | Umbraco UI Builder                      |
| ------------------------------- | --------------------------------------- |
| Konstrukt.Core                  | Umbraco.UIBuilder.Core                  |
| Konstrukt.Infrastructure        | Umbraco.UIBuilder.Infrastructure        |
| Konstrukt.Web                   | Umbraco.UIBuilder.Web                   |
| Konstrukt.Web.UI                | Umbraco.UIBuilder.Web.StaticAssets      |
| Konstrukt.Startup               | Umbraco.UIBuilder.Startup               |
| Konstrukt                       | Umbraco.UIBuilder                       |

### Code and UI Changes

<details>

<summary>C# Class Changes</summary>

* Namespace changes as mentioned above.
* Most `Konstrukt`-prefixed classes have had the prefix removed.
  * Examples: `IKonstruktRepository` -> `IRepository`
  * Exceptions:
      * `KonstruktConfig` and `KonstruktConfigBuilder` now use a `UIBuilder` prefix.
      * `AddKonstrukt` extension for `IUmbracoBuilder` is now `AddUIBuilder`

</details>

<details>

<summary>JavaScript Changes</summary>

* All `Konstrukt` controllers are now under the `Umbraco.UIBuilder` namespace.
* All `Konstrukt` prefixed directives, services, and resources now use `uibuilder`.

</details>

<details>

<summary>UI Changes</summary>

* All static UI assets are now served via a Razor Compiled Library (RCL) instead of being stored in the `App_Plugins` folder.
* The `App_Plugins/Konstrukt` folder is now `App_Plugins/UmbracoUIBuilder`.

</details>

## Step 1: Replace Dependencies

Replace all existing Konstrukt dependencies with Umbraco UI Builder dependencies.

1. Remove existing Konstrukt packages:

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

## Step 2: Update Namespaces and Entity Names

Update all Konstrukt references to their Umbraco UI Builder alternatives. Ensure you update any Views/Partials that also reference these. See the [Key Changes](./#key-changes) section for reference.

## Step 3: Update Configuration

If your configuration is in a single statement, replace `AddKonstrukt` with `AddUIBuilder`.

For multi-step configurations using `Action` or `Card` classes, update the **config builders** and **base classes** to their UI Builder alternatives as described in [Key Changes](./#key-changes).

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

## Step 4: Finalize the Migration

1. Delete `obj/bin` folders for a clean build.
2. Recompile all projects and ensure all dependencies are restored correctly.
3. Remove existing **Konstrukt** license files from `umbraco\Licenses` folder.
4. Add your **Umbraco.UIBuilder** license key to the `appSettings.json` file:

```json
"Umbraco": {
  "Licenses": {
    "Umbraco.UIBuilder": "YOUR_LICENSE_KEY"
  }
}
```

5. Run the project.
