# Prepare your site for migration

After making sure that your project(s) meets all the [requirements](index.md) for being migrated to Umbraco Cloud, you are now ready to get started!

## Upgrade to latest Umbraco version
First order of business is to upgrade your own project to the latest Umbraco version. Why? Because Umbraco Cloud always runs the latest version and you need to make sure your project runs the same Umbraco version as Umbraco Cloud.
You can download the latest version of Umbraco from [Our](https://our.umbraco.com/download/).
If you need help upgrading your project, we have some excellent [Upgrade instructions](https://our.umbraco.com/documentation/Getting-Started/Setup/Upgrading/general) you can follow. Be thorough when upgrading, as the latest upgrade might contain breaking changes and/or updated configuration.

If you have been using Umbraco Forms on your own project, you will also need to upgrade this to the latest version. You can find and download the latest version of Umbraco Forms under [Projects on Our](https://our.umbraco.com/projects/developer-tools/umbraco-forms/). As with Umbraco CMS we also have documentation on how to [Upgrade Umbraco Forms](https://our.umbraco.com/documentation/Add-ons/UmbracoForms/Installation/ManualUpgrade).

After upgrading your project make sure it runs without any errors. *Hint: Check the umbracoTraceLog.txt log file.*  
Ideally your site will run locally using the SQL CE database as this will make content migration easier. Don't worry - if that's not possible you will still be able to complete the migration.

## Cleaning your project
Now you're almost ready to start the actual migrating! The only thing left to is to clean up the your project a bit.

While the project is still running you need to:

  * Go the backoffice of your project
  * Empty the recycle bins from both Content and Media

Shut down the project, and delete the following files and folders from `/App_Data`

  * `/TEMP`
  * `/Logs`
  * `/cache`
  * `/preview`
  * `umbraco.config`

![delete-from-app-data](images/App_Data-DELETE.png)

That was it! Now you are ready to start the actual migration process, or in other words: **now the real fun begins!**

[Up next: Merge with your Cloud project](part-2.md)
