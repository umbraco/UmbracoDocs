---
meta.Title: "Migrating Users to Umbraco Cloud"
meta.Description: "In this guide we show you how you can migrate users from your existing on-premise site to Umbraco Cloud and Umbraco ID."
versionFrom: 8.0.0
---

# Migrating Users to Umbraco Cloud

In this guide, we show you how you can migrate users from your on-premises site to Umbraco Cloud and Umbraco ID.

We will use SQL Server Management Studio to generate a script of the user tables in your SQL Database.

## Prerequisites

* SQL database used on your on-prem site.
* SQL Server Management Studio.
* A cloud site that you are migrating to.

## Migrating a User

To migrate users to Umbraco Cloud, we need to copy the tables beginning with `umbracoUser` to the Cloud site from your on-premises database.

This is done by generating a script using SQL Server Management Studio that we can run on our Umbraco Cloud Database.

### Generate SQL Script

Below are the steps to generate a script with the `umbracoUser` database tables.

1. Go to **SQL Server Management Studio** and connect to the database from which you want to migrate the users.
2. Right-click on it and go to **Tasks > Generate script**.
3. Follow the Wizard.
4. Choose **Select specific tables** when prompted to **Select the database object to script**.
5. Choose the following tables:

  ```SQL
  dbo.umbracoUser
  dbo.umbracoUser2NodeNotify
  dbo.umbracoUser2UserGroup
  dbo.umbracoUserGroup
  dbo.umbracoUserGroup2App
  dbo.umbracoUserGroup2NodePermission
  dbo.umbracoUserLogin
  dbo.umbracoUserStartNode
  dbo.umbracoUserGroup2Node
  dbo.umbracoUserGroup2Language
  ```

6. Click **Next** and then click **Advanced**
7. Find **Type of data to script** and choose **Data only**.
8. Choose where to save the script and save it.
9. Connect to your [Umbraco Cloud Database](/Umbraco-Cloud/Databases/Cloud-Database/index.md).
10. Run the script on your Umbraco Cloud Database.
11. Restart your Umbraco Cloud environment.

### Finishing the Migration

Once the script has been run on your Umbraco Cloud Database, it is time for the users to log in to the Cloud backoffice.

The user will be prompted to log in and they should use the password they used on-premises installation.

Once the user logs in they will be asked to enter their email to receive a token and verify their user in Umbraco ID.

Enter the code to verify the user with Umbraco ID.

Once the user has been verified, they will be redirected to the backoffice and their user has been migrated to Umbraco ID and Umbraco Cloud.
