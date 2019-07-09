# Migrate Umbraco 7 Cloud project to Umbraco 8

This article will provide detailed steps on how to migrate an Umbraco 7 Cloud project to Umbraco 8.

## Prerequisites

* An Umbraco 7 Cloud project running **at least Umbraco 7.14.**
* A clean Umbraco 8.1+ Cloud project with **at least 2 environments**

:::note
We strongly recommend having at least 2 environments on the Umbraco 8.1+ Cloud project.

Should something fail during the migration, the Development environment can always be removed and re-added in order to start over on a clean slate.
:::

## Step 1: Content migration

* Clone down the Umbraco 7 Cloud site
* Run the project locally and **restore** Content and Media

* Clone down the Umbraco 8 Cloud site

* Copy `~/App_Data/Umbraco.sdf` / `~/App_Data/Umbraco.mdf` from the cloned Umbraco 7 Cloud site
* Paste the file into `~/App_Data` on the Umbraco 8 Cloud site
* Open `web.config` from the Umbraco 8 Cloud site
* Locate the `Umbraco.Core.ConfigurationStatus` key
* Replace the value `8.1.x` with the version your Umbraco 7 Cloud site is running - eg. `7.15.0`

* Run the Umbraco 8 Cloud site locally
* The migration will need to be authorized - Cloud credentials is used for this

![Authorize upgrade](images/upgrade-to-8_1.png)

* Click **Continue** to start the migration
* When the migration is done, login to the backoffice and verify that everything is there

:::note
The frontend will **not** work at this point, as none of the Templates have been updated to match Umbraco 8 yet.
:::

