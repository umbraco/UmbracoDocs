# Merge with your Umbraco Cloud project

In this part you are going to setup your Umbraco Cloud project, clone it down to your local machine and start merging the files from your own project into the new Cloud project.

## Setup your Umbraco Cloud project
Before the migration process can start, you will need to have an Umbraco Cloud project you can migrate your own project into.

![How to start an Umbraco Cloud trial](images/start-trial.gif)

1. The best way to get started with Umbraco Cloud is to start a trial. You can do this, by visiting [umbraco.com](https://umbraco.com).
2. When your project is starting choose to start with a *clean slate* - you need to have an empty Cloud project for the migration to be successful.
3. We recommend that you setup your project with at least two environments.

![Manage environments](images/setup-dev-env.png)


Before you clone down the Umbraco Cloud project to your local machine, login to the backoffices of your Umbraco Cloud environments and delete the default Media types (*File*, *Folder* and *Image*) from the *Settings* section. You need to do the same for the default Membertype, *Member*, found in the *Member* section. If you have two or more environments, it's important that you remember to do this, on all the environments.

![Default media types](images/media-types.png)

## Clone down your Umbraco Cloud project

Now it's time to clone down your Umbraco Cloud project to your local machine. You can read more about how this is done, in the ['Working Locally'](https://our.umbraco.com/documentation/Umbraco-Cloud/Set-Up/Working-Locally/) chapter.  If you have a Visual Studio solution with different projects, read first about the [Visual Studio Setup](../Set-Up/Visual-Studio/).

Run the site locally and verify your own project and the cloned Umbraco Cloud project are using the same Umbraco version. After you've verified this, shut down the site, and it's now time to start merging the two projects.

## Move / Merge
1. Copy and replace all folders from your own project to the Umbraco Cloud project
    * Excluding the following folders:
        * `/Config`
        * `/App_Data`
2. Merge the config files. Pay special attention to the following files:
    * `/web.config` - in the `web.config` file for the Umbraco Cloud project you will see some new configuration related to Umbraco Deploy, Licenses and Forms. Make sure you do not overwrite these when you merge the files.
    * `/Config/dashboard.config` - make sure to keep the *Deploy dashboard*!
    * `/Config/UmbracoDeploy.config` - *only relevant if you are migrating a Cloud project*
3. Copy the rest of the files in the `/Config` folder from your own project to the Cloud project
4. If you are using SQL CE
    * Make sure the SQL CE database from your own project replaces the one provided with your Umbraco Cloud project.
    * You can find it in `App_Data/umbraco.sdf`
5. If you are using a local SQL server make sure to update the connection string in the `web.config` for the Umbraco Cloud project.
6. Copy the rest of the files / folder in the `/App_Data` folder from your own project to the Cloud project

Phew! That was a lot of merging and moving around, but don't worry! You are almost done with this part of the migration.
The last thing to do before moving on, is to make sure your Umbraco Cloud user will be added to the new database you've just merged into the project.

* Go to the `data/backoffice/users` folder in your Umbraco Cloud project files
* Rename your user file by removing the leading underscore
![Update user-file](images/update-user-file.png)

That's it! Now you are ready to move on to the next part.

[Previous chapter: Prepare your site for migration](part-1.md) -- [Up next: Generating metadata](part-3.md)
