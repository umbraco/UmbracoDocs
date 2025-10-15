---
description: >-
  This guide will show you how to migrate the content from your Umbraco 7 site
  to a site running Umbraco 8.
---

# Migrate content to Umbraco 8

Umbraco 8 contains a lot of breaking changes and a lot of code has been cleaned up compared to Umbraco 7. Due to this, it will not be possible to do a direct upgrade from Umbraco 7 to Umbraco 8. You need to **migrate your content** from your Umbraco 7 site into your Umbraco 8 site and then recreate the rest in the new version.

A content migration tool has been implemented in Umbraco 8.1.0, to help you with the transition.

In this guide you can read more about the tool, its limitations, and how to use it in practice.

{% hint style="info" %}
**Migrating Umbraco Cloud sites**

Follow the [steps outlined in the Umbraco Cloud documentation](../../../../../umbraco-cloud/upgrades/migrate-from-umbraco-7-to-8.md) to upgrade your Umbraco 7 site on Cloud.
{% endhint %}

## What are the limitations?

In the following section, you can learn more about the limitations of migrating content from Umbraco 7 to Umbraco 8.

### Versions supported

The content migration tool is a database migration, which is made for the database schema of Umbraco 7.14+. This means that in order to do the migration you need to ensure your Umbraco 7 site is running at least Umbraco 7.14.

### Database types supported

Umbraco 8 does not support MySQL databases. This means that the migration will not work when moving from an Umbraco 7 site using MySQL to Umbraco 8 on SQL Server

The database types that are supported are SQL Server and SQL CE.

### Known issues

Feedback from user testing has shown that some databases are harder to migrate than others.

We are collecting [a list of these known issues on our GitHub Issue Tracker](https://github.com/umbraco/Umbraco-CMS/issues?utf8=%E2%9C%93\&q=label%3Acategory%2Fcontent-migration+). There is a community package: [Pre-migration health checks](https://our.umbraco.com/packages/developer-tools/pre-migration-health-checks/) that you can install on your Umbraco 7 site before migration. This will help identify and resolve some of these common issues before triggering the migration steps detailed below.

{% hint style="info" %}
A migration was introduced in Umbraco 8.6 which can break the migration process. See [Issue #7914](https://github.com/umbraco/Umbraco-CMS/issues/7914) for more details.

There are two ways to work around this issue:

* Migrate to version 8.5 as a first step and then post-migration, carry out a normal Umbraco upgrade to the latest version of Umbraco 8, or
* Install the following community Nuget Package: [ProWorks Umbraco 8 Migrations](https://www.nuget.org/packages/ProWorks.Umbraco8.Migrations) into your Umbraco 8 project before running the migration (no configuration required). This package was created by Umbraco Gold Partner [ProWorks](https://www.proworks.com/) and patches the migration process so you can migrate directly from the latest Umbraco 7 to Umbraco 8.6+ without encountering the above issue. [Learn more about the package and the migration process on Prowork's blog](https://www.proworks.com/blog/archive/how-to-upgrade-umbraco-version-7-to-version-8).
{% endhint %}

### Third party property editors

The migration will transform the data stored in third party editors as well. However, it will be stored as it was in Umbraco 7. If the structure has changed or the property editor doesn't exist, you will still be able to find the data in the database. It will, however, not be available in the backoffice.

<details>

<summary>Learn more about that in the Data Types Migrations</summary>

**Migrating data types**

When migrating content from Umbraco 7 to Umbraco 8, the Data Type 'pre-value' structure has changed. In Umbraco 8, the term 'pre-values' no longer exists and is instead referred to as `property editor configuration`.

In Umbraco 8, property editor configuration is a strongly typed object. There are plenty of examples in the [Umbraco-CMS codebase](https://github.com/umbraco/Umbraco-CMS/blob/v8/dev/src/Umbraco.Web/PropertyEditors/ContentPickerConfiguration.cs).

This configuration is stored differently in Umbraco 8 than it was in Umbraco 7. In Umbraco 7, each pre-value property was stored as a different row in a different database table. In Umbraco 8 this is simplified and property editor configuration is stored as the JSON serialized version of the strongly typed configuration object.

When upgrading from Umbraco 7 to Umbraco 8, Umbraco has no way of knowing how custom property editors have intended to structure their configuration data. During the upgrade, Umbraco will convert the key/value pairs from the old pre-value database table into a serialized JSON version of those values. There is a reasonable chance that the end result of this data conversion is not compatible with the custom property editor.

There are 3 options that a developer can choose to do to work around this automatic data conversion:

**1: Implement a custom `IPreValueMigrator`**

This option requires you to create a custom C# migrator for each of your custom property editors that store custom configuration data. It will also require that you implement these migrators before you run the Umbraco 8 content migration.

To do this, you will create an implementation of `IPreValueMigrator` or inherit from the base class [`DefaultPreValueMigrator`](https://github.com/umbraco/Umbraco-CMS/blob/v8/dev/src/Umbraco.Core/Migrations/Upgrade/V_8_0_0/DataTypes/DefaultPreValueMigrator.cs).

There are plenty of examples of this in the [Umbraco-CMS codebase](https://github.com/umbraco/Umbraco-CMS/tree/v8/dev/src/Umbraco.Core/Migrations/Upgrade/V_8_0_0/DataTypes).

You will then need to register them in a composer:

```csharp
[RuntimeLevel(MinLevel = RuntimeLevel.Upgrade, MaxLevel = RuntimeLevel.Upgrade)] // only on upgrades
public class PreValueMigratorComposer : IUserComposer
{
    public void Compose(Composition composition)
    {
        composition.WithCollectionBuilder<PreValueMigratorCollectionBuilder>()
            // Append all of the migrators required
            .Append<MyCustomPreValueMigrator>()
            .Append<AnotherPreValueMigrator>();
    }
}
```

When running the migrations and encountering a custom configuration, Umbraco will utilize the `PreValueMigrator` when converting the old pre-values into the new JSON format.

**2: Update your Angular configuration (pre-value) and property editor**

This option means that you will choose to use the automatically converted JSON data format. In this case, it will mean updating your pre-value and property editors to use the new JSON configuration data. The converted data won't be much different than the original/intended data format so this might not be too much work.

**3: Update the Angular configuration (pre-value) editor**

With this option the configuration/pre-value editor needs to be updated to transform the JSON converted data into the data structure you want. When this is done and when the Data Type is saved again, the JSON data structure will be saved back to the database. Your property editor will then continue to work.

This will require you to update and save all custom pre-value editors to transform the converted structures back to your intended data structure.

</details>

## What will happen

When the migrations are running, Umbraco will go through your entire Umbraco 7 database and update it to the format required for Umbraco 8. The schema will be remodeled and transformed into the correct format and your existing compatible data will be transformed to fit with Umbraco 8.

These migrations will be running directly on your database. They are transforming schema and data - not transferring. Therefore always ensure that you have a backup before attempting to do this. In case something goes wrong, you will be able to rollback and try again.

It is highly recommended to clean up your site before running this as it will be quicker.

* Empty Content recycle bin
* Empty Media recycle bin
* Clean up the database version history (can be done with a script or a package like [Unversion](https://our.umbraco.com/packages/website-utilities/unversion/))

## How it works

In the following guide we will migrate the content of an Umbraco 7.13.1 site to Umbraco 8.1.0.

### Step 1: Upgrading to 7.14+

Before the content migration can start the site has to run Umbraco 7.14+. Make sure to **always take a backup of the database** before doing an upgrade, and then check the [version specific upgrade instructions](./).

The site in this example is an Umbraco 7.13.1 site, and we will use Nuget to update it.

![v7 site with content](<../images/v7-content (1) (1) (1).png>)

Following the [general upgrade instructions](../) we will now upgrade via Nuget until we get to this point:

![Upgrading to v7.14](<../images/upgrading-7_14 (1) (1) (1) (1).png>)

{% hint style="warning" %}
When upgrading an old website, check if you are using obsolete properties in your Data Types. These should be changed to their updated counterparts. The migration **will fail if you are still using obsolete properties.**

The updated properties are:

* Content Picker
* Media Picker
* Member Picker
* Multinode TreePicker
* Folder Browser
* Related Links

You can see if your site is using the obsolete properties from the `(Obsolete)` prefix in their name.
{% endhint %}

Install the [Pre-migration health checks plugin](https://our.umbraco.com/packages/developer-tools/pre-migration-health-checks/), and run it health check from the Developer section of the backoffice. This is done to identify and resolve some common database schema issues before migration.

Once it is upgraded and you have verified everything is working, move on to the next step.

### Step 2: Migrating content to Umbraco 8

The first thing to do is to spin up a fresh new Umbraco 8.1+ site. Make sure everything works and that no content is there.

![Fresh 8.1 site](<../images/fresh-8_1-site (1) (1) (1).png>)

{% hint style="warning" %}
If you have customized the `UsersMembershipProvider` on your Umbraco 7 site you need to copy that over to the 8.1 `web.config` as well. Additionally you need to update the `type` attribute to be `type="Umbraco.Web.Security.Providers.UsersMembershipProvider, Umbraco.Web"`.

This also includes the attribute `useLegacyEncoding` value. Make sure that this setting is copied into your new Umbraco 8 site, as it is needed in order to log in.
{% endhint %}

Take a backup of your database from the **Umbraco 7.14 site**. Take the information for the backup database and add that to the connectionstring for the **Umbraco 8.1 site**. If you are running SQL CE, you will have to copy the database over to the new site as well.

Once the connectionstring is set, the final step is to change the Umbraco version number in the `web.config` on the **Umbraco 8.1 site**. Chang it to `7.14.0`. This will indicate that there is an upgrade pending and it needs to run the migration.

![Set Umbraco version in the web.config](<../images/set-umbraco-version (1) (1) (1).png>)

The version will be set to 8.1.0, and you need to change it to the version you are currently migrating from.

When you start the site it will ask you to login and then show you this screen:

![Upgrade database to 8.1](<../images/upgrade-to-8_1 (1) (1) (1).png>)

From here, the automatic migration will take over, and after a little bit you can log in and see your content:

![Content is on 8.1](<../images/content-on-8_1 (1) (1) (1).png>)

{% hint style="info" %}
Please be aware that this is a **content migration**. If you go to the frontend after following these steps, it will throw errors.

At this point you will have the content but nothing else.
{% endhint %}

## Step 3: Files migration

Before moving on to this step, make sure that the Umbraco 8 project is no longer running.

The following files/folders need to be copied into the Umbraco 8 project:

* `~/Views` - do **not** overwrite the default Macro and Partial View Macro files, unless changes have been made to these.
* `~/Media`
* Any files/folders related to Stylesheets and JavaScripts.
* Any custom files/folders the Umbraco 7 project uses, that aren't in the `~/Config` or `~/bin`.
* `~/App_Data/UmbracoForms` - in the case Umbraco Forms was used on the Umbraco 7 site.

**Merge the configuration files carefully** to ensure any custom settings are migrated while none of the default configurations for Umbraco 8 is overwritten.

You'll have to revisit all templates and custom implementations to get the site up and running, as all markup is still Umbraco 7-specific.

{% hint style="info" %}
Are you planning on continuing the migration to the latest version on Umbraco CMS?

Then you can skip the step to revisit the template files and custom implementation. We highly recommend waiting with this step until you've reached the latest version.

If you're stopping at Umbraco 8, you can learn more about [rendering content on the Legacy Docs site](https://our.umbraco.com/Documentation/Fundamentals/Design/Rendering-Content/).
{% endhint %}

### Step 4: Post-migration checks

As you are updating your template files and custom implementation, you should also verify your configuration files and settings.

Umbraco 8 contains a few changes regarding the Sections in the Umbraco Backoffice. Because of this, you should also check your User Groups and make sure they have access to the appropriate sections.

Learn more about the Section in the [Sections article](../../../backoffice/sections.md)
