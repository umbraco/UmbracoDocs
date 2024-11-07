---
description: >-
  This guide provides a step-by-step approach to migrating a default
  uMarketingSuite solution to Umbraco Engage.
---

# Migrate from uMarketingSuite

{% hint style="warning" %}
Upgrade to the latest version of uMarketingSuite before continuing with the migration.

You can upgrade your installation by installing the [latest version](https://www.nuget.org/packages/uMarketingSuite/) on top of the existing one.
{% endhint %}

## Tutorial Content

* [Step 1: Set up a local environment](migrate-from-umarketingsuite.md#step-1-set-up-a-local-environment)
* [Step 2: Prerequisites Check](migrate-from-umarketingsuite.md#step-2-prerequisites-check)
* [Step 3: Replace NuGet packages and dependencies](migrate-from-umarketingsuite.md#step-3-replace-nuget-packages-and-dependencies)
* [Step 4: Update analytics scripts, cockpit, and custom code ](migrate-from-umarketingsuite.md#step-4-update-analytics-scripts-cockpit-and-custom-code)
* [Step 5: Update the database](migrate-from-umarketingsuite.md#step-5-update-the-database)&#x20;
* [Step 6: Finalizing the migration](migrate-from-umarketingsuite.md#step-6-finalize-the-migration)
* [Step 7: Validate the migration](migrate-from-umarketingsuite.md#step-7-validate-the-migration)
* [Step 8: Upgrade additional environments](migrate-from-umarketingsuite.md#step-8-upgrade-additional-environments)
* [Overview of the key changes in paths, scripts, namespaces, etc.](migrate-from-umarketingsuite.md#key-changes)

## **Step 1: Set up a local environment**

The first step is to migrate from uMarketingSuite to Umbraco Engage in a local environment. This will be done using a copy of your production environment.

1. Backup your database from the production environment.
2. Restore the database locally.

## Step 2: Prerequisites Check

In this step, you need to check the Database state to see if the existing data can be migrated to Umbraco Engage.

{% hint style="info" %}
Are you using separate databases for uMarketingSuite and Umbraco? In that case, run the first group of checks on the Umbraco database and the second group of checks on the uMarketingSuite database.
{% endhint %}

1. Execute the prerequisites check using the following query:

{% file src="../.gitbook/assets/Prerequisites-Checks.sql" %}
Run this script on your locally restored database to prepare for the migration.
{% endfile %}

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

## Step 3: Replace NuGet packages and dependencies

In this second step, you will replace all existing uMarketingSuite dependencies with Umbraco Engage dependencies.

1. Make a backup of any custom implementation of uMarketingSuite-specific files you want to reuse.
2. Remove the installed uMarketingSuite package from your project

```
dotnet remove package uMarketingSuite
```

3. Remove the other uMarketingSuite packages (if applicable) from your project:

```bash
dotnet remove package uMarketingSuite.Headless
dotnet remove package uMarketingSuite.UmbracoForms
dotnet remove package uMarketingSuite.Commerce
```

4. Delete the `App_Plugins\*` folder for uMarketingSuite (and if applicable `uMarketingSuite.UmbracoForms`):

```bash
rmdir /s App_Plugins\uMarketingSuite
rmdir /s App_Plugins\uMarketingSuite.UmbracoForms
```

5. Delete the `Assets\uMarketingSuite` folder.

```bash
rmdir /s Assets\uMarketingSuite
```

6. Delete the `Partials\uMarketingSuite` folder.

```bash
rmdir /s Views\Partials\uMarketingSuite
```

7. Delete the existing license file in the `config\uMarketingSuite` folder.
8. Delete the existing `appsettings-schema.uMarketingSuite.json` file from the root of the project (if exists).
9. Install `Umbraco.Engage`:

```bash
dotnet add package Umbraco.Engage
```

10. Install any Umbraco Engage add-on packages that were previously removed.

```bash
dotnet add package Umbraco.Engage.Headless
dotnet add package Umbraco.Engage.Forms
dotnet add package Umbraco.Engage.Commerce
```

## Step 4: Update analytics scripts, cockpit, and custom code

Based on the [Key Changes](migrate-from-umarketingsuite.md#key-changes) below update all uMarketingSuite references to the new Umbraco Engage alternatives. Ensure you update any Views/Partials that also reference these. This includes the different uMarketingSuite clientside scripts (like the analytics & ga4-bridge) and the Cockpit.&#x20;

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

### **Custom code**

Did you build custom segments, add custom goal triggering, change the module permissions (cookie consent), or something similar? Check which namespaces, classes, and entities have been changed in the Key Changes section below.

### Key changes

Below you will find the key changes to be aware of.&#x20;

You can find additional information on migrating the add-on packages for UmbracoForms, Commerce & Headless in the [Further Migrations section](migrate-from-umarketingsuite.md#further-migrations) of this article.

#### Project, Package, and Namespace changes

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



## Step 5: Update the database

{% hint style="warning" %}
Only proceed if all the prerequisites checks in [Step 2](migrate-from-umarketingsuite.md#step-2-prerequisites-check) have passed.
{% endhint %}

In this step, you will update the database for Umbraco Engage.

1. Back up your database(s).
2. Rename the uMarketingSuite database tables, keys, constraints, and indexes using the following query:

{% file src="../.gitbook/assets/Migrate-uMS-Tables.sql" %}
Run this script on the database to rename all uMarketingSuite tables to Umbraco Engage.
{% endfile %}

{% hint style="info" %}
These database changes should be executed in < 10 seconds as [sp\_rename](https://learn.microsoft.com/en-us/sql/relational-databases/system-stored-procedures/sp-rename-transact-sql) is used and no existing data is touched.
{% endhint %}

3. Update the Umbraco database tables with the script below to rename the following uMarketingSuite properties:
   * The `uMarketingSuite` Media folder,
   * The `uMarketingSuite` Data Types & Data Type Folder,
   * The `uMarketingSuite` User Group Permissions,
   * The Migration State KeyValue State for `uMarketingSuite`, `uMarketingSuite.UmbracoForms`, and `uMarketingSuite.UmbracoCommerce`.

{% file src="../.gitbook/assets/Migrate-Umbraco-Data.sql" %}
Run this script to migrate all the Umbraco data.
{% endfile %}

4. Validate that no errors occurred and all tables were updated successfully. No queries should return that 0 rows were updated.

## Step 6: Finalize the migration

1. Delete any `obj`/`bin` folders in your projects to ensure a clean build.
2. Recompile all projects and ensure all dependencies are restored correctly.
3. Contact Umbraco Support for a license key.
   1. Look for the speech bubble in the bottom right corner of your screen at [umbraco.com](https://umbraco.com).
   2. Click it, and you can open a new support request.
4. Add your new Umbraco Engage [license](../installation/licensing.md) key to the `appSettings.json` file:

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

It is required to enable the `UseLegacySegmentNames` setting on all environments to maintain compatibility with existing segments. Without it, any personalization or A/B test created using uMarketingSuite will fail to work and become inaccessible and incompatible with the new naming scheme.
{% endhint %}

5. \[Optional] Set the `Engage:Analytics:VisitorCookie:LegacyCookieName` configuration if uMarketingSuite was using a different visitor cookie name setting than the default `uMarketingSuiteAnalyticsVisitorId`:

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
Umbraco Engage will automatically convert cookies previously set by uMarketingSuite to the new cookie name. This setting is only required if you have a custom cookie name set in uMarketingSuite. It will ensure a smooth transition in tracking existing visitors.
{% endhint %}

6. Run the project.

## **Step 7: Validate the migration**

With the migration complete, there are a few more steps to ensure everything continues to work as expected.

1. Validate the new license:
   * Go to Settings -> Licenses in the backoffice and click **Validate**.
2. Generate the reporting data:
   * Go to Engage -> Settings -> Configuration in the backoffice and click the Regenerate button. Depending on the number of page views in the database this could take a while.
3. Use the [Troubleshooting Installs](../installation/troubleshooting-installs.md) guide to verify that everything works as expected.

## Step 8: Upgrade additional environments

You have now verified that everything works as expected in the local environment. It is time to upgrade the production environment and any additional environments.

Repeat the steps below for each environment that needs to be migrated.

1. Stop the site.
2. Run the [Prerequisites Check](migrate-from-umarketingsuite.md#step-2-prerequisites-check) on the database.
3. Execute [Step 5 ](migrate-from-umarketingsuite.md#step-5-update-the-database)on the database
4. Create a backup of the website.
5. Deploy the updated code from the migrated local environment.
6. Start the site.
7. Validate the new license, if this has not happened already:
   * Go to Settings -> Licenses in the backoffice and click **Validate**.
8. Generate the reporting data
   * Go to Engage -> Settings -> Configuration in the backoffice and click the Regenerate button. Depending on the number of page views in the database this could take a while.
9. Use the [Troubleshooting Installs](../installation/troubleshooting-installs.md) guide to verify that everything works as expected.

### **Custom firewall changes**

If the `/umbraco/umarketingsuite/` path was previously allowed, this needs to change to `/umbraco/engage/`.

{% hint style="info" %}
Are you having issues updating? Contact the support team via the chat on [umbraco.com](https://umbraco.com).
{% endhint %}

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

The uMarketingSuite.ContentBlocks add-on package has been deprecated since version 2.0.0 of uMarketingSuite and is unavailable for Umbraco Engage.
