---
meta.Title: Packages on Umbraco Cloud
v9-equivalent: >-
  https://github.com/umbraco/UmbracoCMSDocs/blob/main/Articles/Packages/packages-on-Umbraco-Cloud.md
needsv9Update: 'true'
description: Things to consider for package development and usage in Umbraco Cloud
---

# Packages on Umbraco Cloud

If you want to use or develop packages for Umbraco Cloud there are a few things to consider and be aware of. The two most important things to know about are

* [How you should store data on Cloud](packages-on-umbraco-cloud.md#storing-data)
* [Using custom property editors with Deploy](packages-on-umbraco-cloud.md#valueconnectors)

## Storing data

When developing a package you will sometimes store data, this can be data in many forms - Umbraco schema / content, package settings, etc.

When you develop a package for Umbraco Cloud there are a few things to be aware of when storing data, mainly whether you want that data to be specific to 1 environment or more.

Let's take a look at the most common ways of storing data in packages - and what to watch out for on Cloud.

### Migrations

A [migration](../database.md) is some code that you run as part of a migration plan. That migration plan has an ID that is stored in the database (in the KeyValue table). This means that when you add new migrations Umbraco will only execute the ones that came after the one with the stored ID. The most important difference between a migration and a package action is when they are initialized. A package action runs on package install and uninstall, whereas a migration will run whenever you want it to run, see below for common examples.

As migration runs are stored in the database of the site it also means that they will run on each environment you trigger them on. The most common way to trigger a migration is to include them in a [composer](../../implementation/composing.md), which will ensure they run on site startup. This means any commands you have in your migration will automatically run when the site starts up. When your package code is pushed to a new environment it will run them from the beginning on that environment as no ID is saved in the database.

This is normally a good thing. However if you generate any Umbraco schema then Umbraco Deploy will automatically create [UDA files](https://docs.umbraco.com/umbraco-cloud/set-up/power-tools/generating-uda-files#generate-uda-files-manually) based on that schema, and commit them to source control. This means that when you deploy all your files to the next environment the migration will run again, create duplicates and generate duplicate UDA files, which could end up causing a lot of issues.

You could consider creating Umbraco schema only during a package action, and then running things like creating database tables in migrations. Another good workaround could be to not run the migrations in a composer, but rather create a dashboard for the package where the user can choose which migrations to run themselves. The [Articulate package](https://github.com/Shazwazza/Articulate/blob/master/build/packageManifest.xml#L613) has an example of this.

### Creating files

You may sometimes choose to save data in a file. Could be a separate config file for your package or a [config transform file](https://docs.umbraco.com/umbraco-cloud/set-up/config-transforms) to add an app setting to the web.config. If you do this be aware of two things:

1. If these files are generated on a Cloud environment they will not be stored in source control, and will be overwritten on next deployment. They need to be installed locally, committed to source control and then pushed up to the Cloud environments. We have an [existing feature request](https://github.com/umbraco/Umbraco.Cloud.Issues/issues/33) on allowing package creators to commit their files directly on Cloud, and it is possible to do so currently but not in a supported way, and it may change suddenly.
2. If you need the content of the files to be different on the different environments you will need to use environment specific [config transforms](https://docs.umbraco.com/umbraco-cloud/set-up/config-transforms).

## Value connectors

A value connector is an extension to Umbraco Deploy that allows you to transform data when you deploy content of any kind between environments. When it comes to packages, one reason you need to consider these if you are supporting deploying content properties that rely on integer IDs. Content and other Umbraco data has two identifiers - an integer and a GUID. The GUID is consistent between environments but the integer ID is not. As such, if transferring content between environments and relying on integer IDs, you'll need to include a value connector to transform the value.

They also manage dependencies for property data. If you save an ID of an image in your property editor, you can make sure the related image media item is transferred too.

You can read more about value connectors and other extensions to Umbraco Deploy [here](https://docs.umbraco.com/umbraco-deploy/v/10.deploy.latest/getting-started/extending).