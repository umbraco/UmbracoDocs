---
description: >-
  This guide provides a step-by-step approach to migrating a default
  uMarketingSuite solution to Umbraco Engage.
---

# Migrate from uMarketingSuite

{% hint style="info" %}
This document is a work in progress.

The final version will be available with the release of Umbraco Engage.
{% endhint %}

{% hint style="warning" %}
Upgrade to the latest version of uMarketingSuite before continuing with the migration.

You can upgrade your installation by installing the [latest version](https://www.nuget.org/packages/uMarketingSuite/) on top of the existing one.
{% endhint %}

## Tutorial Content

* [Upgrade process locally and live](migrate-from-umarketingsuite.md#upgrade-process)
* [Step 1: Prerequisites Check](migrate-from-umarketingsuite.md#step-1-prerequisites-check)
* [Step 2: Replace NuGet packages and dependencies](migrate-from-umarketingsuite.md#step-2-replace-nuget-packages-and-dependencies)
* [Step 3: Update analytics scripts, cockpit, and custom code ](migrate-from-umarketingsuite.md#step-3-update-analytics-scripts-cockpit-and-custom-code)
* [Step 4: Update the database](migrate-from-umarketingsuite.md#step-4-update-the-database)&#x20;
* [Step 5: Finalizing the migration](migrate-from-umarketingsuite.md#step-5-finalizing-the-migration)&#x20;
* [Overview of the key changes in paths, scripts, namespaces, etc.](migrate-from-umarketingsuite.md#key-changes)

## **Upgrade process**

### Perform the upgrade locally

* Backup your database from the production environment and restore it locally.
* Apply [Step 1 to Step 5](migrate-from-umarketingsuite.md#step-1-prerequisites-check) as outlined below.
* Validate the new license:
  * Go to Settings -> Licenses in the backoffice and click **Validate**.
* Generate the reporting data:
  * Go to Engage -> Settings -> Configuration in the backoffice and hit the Regenerate button. This could take a while depending on the number of page views in the database.
* Test locally if everything works as expected. Use the [Troubleshooting Installs](../installation/troubleshooting-installs.md) guide if needed.

### Apply the upgrade to the other environments incl. the live environment

* The local upgrade should have been completed successfully
* Stop the site(s)&#x20;
* Run the Prerequisites Check on the database as described in [Step ](migrate-from-umarketingsuite.md#step-4-update-the-database)[1](migrate-from-umarketingsuite.md#step-1-prerequisites-check)&#x20;
* Execute [Step 4](migrate-from-umarketingsuite.md#step-4-update-the-database) on the database
* Backup the website
* Deploy the updated code to the environment(s) (as earlier applied in Step 2 and Step 3)
* Start the site(s) (if needed)
* Validate the new license (if not validated):
  * Go to Settings -> Licenses and click Validate
* Generate the reporting data
  * Go to Engage -> Settings -> Configuration and hit the button Regenerate (this could take a while depending on the number of page views in the database)
* Verify that everything works as expected, you can use [this](https://docs.umbraco.com/umbraco-engage/installation/troubleshooting-installs) guide if needed.

### **Any custom firewall changes?**

If the `/umbraco/umarketingsuite/` path was previously allowed, this needs to change to `/umbraco/engage/`.

{% hint style="info" %}
Are you having issues updating? Contact the support team via the chat on [umbraco.com](https://umbraco.com).
{% endhint %}

## Step 1: Prerequisites Check

In this first step, you need to check the Database state to see if the existing data can be migrated to Umbraco Engage.

{% hint style="info" %}
Are you using separate databases for uMarketingSuite and Umbraco? In that case, run the first group of checks on the Umbraco database and the second group of checks on the uMarketingSuite database.
{% endhint %}

1. Execute the prerequisites check using the following query: `LINK TO Step-1-Prerequisites.sql file`
2. Verify that uMarketingSuite & uMarketingSuite addon version checks return the expected results.
3. Verify that the uMarketingSuite table integrity check returns the expected results.

The result should look like this:

```
---Running Version Pre-Requisite Checks for uMarketingSuite to Umbraco Engage Migration---
✔️ Detected uMarketingSuite version 2.6.1 or higher
✔️ Detected uMarketingSuite.UmbracoCommerce version 2.0.0 or higher
✔️ Detected uMarketingSuite.UmbracoForms version 2.0.0 or higher
---Running Integrity Pre-Requisite Checks for uMarketingSuite to Umbraco Engage Migration---
✔️ The [uMarketingSuiteAnalyticsGoalCompletion] table is in a valid state to be upgraded.
✔️ The [uMarketingSuiteAnalyticsPageEvent] table is in a valid state to be upgraded.
---Finished running Pre-Requisite Checks. Please verify if all 5 checks succeeded before proceeding---
```

If any of these checks return a failure, please resolve the issue before proceeding with the migration.

## Step 2: Replace NuGet packages and dependencies

In this second step, you will replace all existing uMarketingSuite dependencies with Umbraco Engage dependencies.

1. (If applicable) Take a backup of any custom implementation of uMarketingSuite-specific files you want to reuse.
2. Remove the installed uMarketingSuite package from your project

```
dotnet remove package uMarketingSuite
```

1. Remove the other uMarketingSuite packages (if applicable) from your project:

```bash
dotnet remove package uMarketingSuite.Headless
dotnet remove package uMarketingSuite.UmbracoForms
dotnet remove package uMarketingSuite.Commerce
```

3. Delete the `App_Plugins\*` folder for uMarketingSuite (and if applicable `uMarketingSuite.UmbracoForms`):

```bash
rmdir /s App_Plugins\uMarketingSuite
rmdir /s App_Plugins\uMarketingSuite.UmbracoForms
```

4. Delete the `Assets\uMarketingSuite` folder.

```bash
rmdir /s Assets\uMarketingSuite
```

5. Delete the `Partials\uMarketingSuite` folder.

```bash
rmdir /s Views\Partials\uMarketingSuite
```

6. Delete the existing license file in the `config\uMarketingSuite` folder.
7. Delete the existing `appsettings-schema.uMarketingSuite.json` file from the root of the project (if exists).
8. Install `Umbraco.Engage`:

```bash
dotnet add package Umbraco.Engage
```

9. Install Umbraco Engage add-on packages that were previously removed (if applicable).

```bash
dotnet add package Umbraco.Engage.Headless
dotnet add package Umbraco.Engage.Forms
dotnet add package Umbraco.Engage.Commerce
```

## Step 3: Update analytics scripts, cockpit, and custom code

Based on the [Key Changes](migrate-from-umarketingsuite.md#key-changes) outlined below update all uMarketingSuite references to the new Umbraco Engage alternatives. Ensure you update any Views/Partials that also reference these. This includes the different uMarketingSuite clientside scripts (like the analytics & ga4-bridge) and the Cockpit.&#x20;

Please find below an overview of the changes to the default scripts in a uMarketingSuite installation:

* All scripts & Asset Paths containing the `uMarketingSuite` keyword are renamed to:
  * `Assets/Umbraco.Engage/Scripts/umbracoEngage.analytics.js`
  * `Assets/Umbraco.Engage/Scripts/umbracoEngage.ga4-bridge.js`
  * `Assets/Umbraco.Engage/Scripts/umbracoEngage.blockerdetection.js`
* The Cockpit Partial View has been moved to:
  * &#x20;`Partials/Umbraco.Engage/Cockpit`
* If you are tracking custom events please make sure to update the calls to the send event method:
  *   `ums("send", "event", "<Category name>", "<Action>", "<Label>")`

      is now:

      `umbEngage("send", "event", "<Category name>", "<Action>", "<Label>")`

#### **Any custom code?**

Did you build custom segments, add custom goal triggering, change the module permissions (cookie consent), or something similar? Check which namespaces, classes, and entities have been changed in the [Key Changes](migrate-from-umarketingsuite.md#key-changes) section.

## Step 4: Update the database

{% hint style="warning" %}
Only proceed if all the prerequisites checks in Step 1 have passed.
{% endhint %}

In this step, you will update the database for Umbraco Engage.

1. Back up your database(s).
2. Rename the uMarketingSuite database tables, keys, constraints, and indexes using the following query:

`LINK TO Step-2-Migrate-UMS-Tables.sql file`

{% hint style="info" %}
These database changes should be executed in < 10 sec. because we are using [sp\_rename](https://learn.microsoft.com/en-us/sql/relational-databases/system-stored-procedures/sp-rename-transact-sql) and are not touching the existing data.
{% endhint %}

3. Update the Umbraco database tables to rename the following uMarketingSuite properties:
   * The `uMarketingSuite` Media folder,
   * The `uMarketingSuite` Data Types & Data Type Folder,
   * The `uMarketingSuite` User Group Permissions,
   * The Migration State KeyValue State for `uMarketingSuite`, `uMarketingSuite.UmbracoForms`, and `uMarketingSuite.UmbracoCommerce`.

`LINK TO Step-3-Migrate-Umbraco-Data.sql file`

4. Validate that no errors occurred and all tables were updated successfully. No queries should return that 0 rows were updated.

## Step 5: Finalizing the migration

1. Delete any `obj`/`bin` folders in your projects to ensure a clean build.
2. Recompile all projects and ensure all dependencies are restored correctly.
3. Add your new Umbraco.Engage license key to the `appSettings.json` file:

```json
"Umbraco": {
  "Licenses": {
    "Umbraco.Engage": "YOUR_LICENSE_KEY"
  }
}
```

4. Configure Umbraco Engage to use the legacy segment naming scheme:

```json
"Engage": {
  "Settings": {
    "UseLegacySegmentNames": true
  }
}
```

{% hint style="warning" %}
The naming scheme for segments within content variations has changed from `umarketingsuite` to `engage`.

It is required to enable the `UseLegacySegmentNames` setting on all environments to maintain compatibility with existing segments. Without it, any personalization or A/B test created using uMarketingSuite will fail to work and becomes inaccessible and incompatible with the new naming scheme.
{% endhint %}

5. (Optional) Set the `Engage:Analytics:VisitorCookie:LegacyCookieName` configuration if uMarketingSuite was using a different visitor cookie name setting than the default `uMarketingSuiteAnalyticsVisitorId`:

```json
"Engage": {
  "Analytics": {
    "VisitorCookie": {
      "LegacyCookieName": "<Your-Custom-uMarketingSuite-Visitor-Cookie>"
    }
  }
}
```

{% hint style="info" %}
Umbraco Engage will automatically convert cookies previously set by uMarketingSuite to the new cookie name. This setting is only required if you have a custom cookie name set in uMarketingSuite. It will ensure a smooth transition in tracking of existing visitors.
{% endhint %}

6. Run the project.

## Key changes

Below you will find the key changes to be aware of.&#x20;

You can find additional information on migrating the add-on packages for UmbracoForms, Commerce & Headless in the [Further Migrations section](./#further-migrations) of this article.

### Project, Package, and Namespace changes

| uMarketingSuite              | Umbraco Engage                |
| ---------------------------- | ----------------------------- |
| uMarketingSuite.Core         | Umbraco.Engage.Core           |
| uMarketingSuite.Web          | Umbraco.Engage.Web            |
| uMarketingSuite.Business     | Umbraco.Engage.Infrastructure |
| uMarketingSuite.Data         | Umbraco.Engage.Data           |
| uMarketingSuite.Common       | Umbraco.Engage.Common         |
| uMarketingSuite.UmbracoForms | Umbraco.Engage.Forms          |
| uMarketingSuite.Headless     | Umbraco.Engage.Headless       |
| uMarketingSuite.Commerce     | Umbraco.Engage.Commerce       |
| uMarketingSuite              | Umbraco.Engage                |

<details>

<summary>JavaScript changes</summary>

* The Asset Paths containing the `uMarketingSuite` keyword have renamed to `Umbraco.Engage`.
* The scripts containing the `uMarketingSuite` keyword have renamed to `umbracoEngage`.
  * Example: `/Assets/uMarketingSuite/Scripts/uMarketingSuite.analytics.js` is now `/Assets/Umbraco.Engage/Scripts/umbracoEngage.analytics.js`
* All script extension points containing the `ums` keyword have been renamed to `umbEngage`.
  * Example: Custom client-side events like \
    `ums("send", "event", "<Category name>", "<Action>", "<Label>")` \
    are now \
    `umbEngage("send", "event", "<Category name>", "<Action>", "<Label>")`

</details>

<details>

<summary>UI Changes</summary>

* The uMarketingSuite folder within `App_Plugins` has been renamed from `uMarketingSuite` to `Umbraco.Engage`.
* The Umbraco Forms addon folder within `App_Plugins` has been renamed from `uMarketingSuite.UmbracoForms` to `Umbraco.Engage.Forms`.
* The Cockpit Partial View has been moved from `Partials/uMarketingSuite/Cockpit` to `Partials/Umbraco.Engage/Cockpit`.

</details>

<details>

<summary>Umbraco &#x26; Configuration Changes</summary>

* The Section and corresponding user permission `uMarketingSuite` has been renamed to `Engage`.
* The Media Folder `uMarketingSuite` has been renamed to `Engage`.
* The Data Types and corresponding Data Type Folder with the `uMarketingSuite` keyword have been renamed to `Engage`.
* The Segments for Content Variations (Personalization & A/B Testing) have been renamed from `umarketingsuite` to `engage`.
  * Using a new `appsettings.json` key existing installations can enable the legacy naming scheme to maintain compatibility with existing segments.
* The `appsettings.json` key `uMarketingSuite` has been renamed to `Engage`.
  * Example: `uMarketingSuite:Settings:Enabled` is now `Engage:Settings:Enabled`

</details>

<details>

<summary>C# Class changes</summary>

* Namespace changes as documented above.
* All classes containing the `uMarketingSuite` keyword are now updated to `UmbracoEngage`.
  * Examples: `UMarketingSuiteApplicationComposer` is now `UmbracoEngageApplicationComposer`, and `AddMarketingApiDocumentation` is now `AddEngageApiDocumentation`

</details>

<details>

<summary>Database changes</summary>

* All Database tables, keys, constraints and indexes containing the `uMarketingSuite` keyword are now updated to `umbracoEngage`.
  * Example: `uMarketingSuiteAnalyticsPageview` is now `umbracoEngageAnalyticsPageview`

</details>

## Further Migrations

### uMarketingSuite.UmbracoForms

If you are using the uMarketingSuite.UmbracoForms package, all the submissions linked to visitors have been migrated using the scripts in Step 4.

Existing Forms, including those that use the uMarketingSuite-provided VisitorId field, do not require additional action.

You can install the Umbraco Engage UmbracoForms add-on package using the following command:

```bash
dotnet add package Umbraco.Engage.Forms
```

### uMarketingSuite.Headless

If you are using the uMarketingSuite.Headless package, applications that use the uMarketingSuite API will need to be updated. This needs to happen to be able to use the new Umbraco Engage API, accessible via the `/umbraco/engage/api/` routes.

The v1 Engage APIs (v13.0.0 of Umbraco Engage) maintain the same functionality as the v1 uMarketingSuite APIs. For more details on the API, please refer to the Swagger documentation provided by Umbraco Engage.

You can install the Umbraco Engage Headless add-on package using the following command:

```bash
dotnet add package Umbraco.Engage.Headless
```

### uMarketingSuite.Commerce

If you are using the uMarketingSuite.Commerce package, all the commerce data has been migrated to Umbraco Engage using the scripts in Step 4.

You can install the Umbraco Engage Commerce addon package using the following command:

```bash
dotnet add package Umbraco.Engage.Commerce
```

### uMarketingSuite.ContentBlocks

The uMarketingSuite.ContentBlocks add-on package has been deprecated since version 2.0.0 of uMarketingSuite and is not available for Umbraco Engage.
