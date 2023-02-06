---
description: "Learn aboute the steps involved with migrating your Umbraco 7 site to the latest version of Umbraco CMS."
---

# Migrate from Umbraco 7 to Umbraco latest

The End Of Life (EOL) date for Umbraco 7 is coming up and we highly recommend moving your projects to the latest version.

## Existing resources

* [Migration content to Umbraco 8](https://our.umbraco.com/documentation/Fundamentals/Setup/Upgrading/migrating-to-v8)
* [Migrating Data Types: No more Pre-values](https://our.umbraco.com/documentation/Fundamentals/Setup/Upgrading/7-8-migration-dataTypes)
* [Migrate Umbraco 8 project to Umbraco 10 (docs)](https://docs.umbraco.com/v/10.x-lts/umbraco-cloud/upgrades/migrating-from-8-10)
* [Migrate from Umbraco 8 to Umbraco 9 (umbraco.com)](https://umbraco.com/products/umbraco-cms/umbraco-9/migrating-from-umbraco-8-to-umbraco-9/)
* [Umbraco 7 EOL (umbraco.com)](https://umbraco.com/products/knowledge-center/long-term-support-and-end-of-life/umbraco-7-end-of-life-eol/)
* [Migrating from Umbraco 7 to Umbraco 8 (umbraco.com)](https://umbraco.com/products/umbraco-cms/umbraco-8/migrating-from-umbraco-7-to-umbraco-8/)

## Unanswered questions

* Do you upgrade packages at the end of the migration, or do you do that during the migration?
  * When migrating to the next major, do you then also upgrade the packages to match that major?

## Examples

* A view (.cshtml) file before and after migration <-- highlight significant changes
* A controller (.cs) file before and after migration <-- highlight significant changes

## Structure

* Multiple subpages - one per migration, incl. pre- and post-checks, and custom code rewrites.
* Video covering each step of the migration

## Contents (based on [community article](https://skrift.io/issues/how-i-upgraded-my-umbraco-v7-project-to-umbraco-v11/))

* Pre migration considerations
* Before migrating
* Step 1: Migrate to 8.5.5
* Step 2: Migrate to 10.0.1
* Step 3: Upgrade to latest CMS version
* Step 4: Update packages
* Step 5: Update custom code
* Post migration checks

## Pre migration considerations

* Packages
  * Are the ones currently used compatible with the latest version?
* Obsolete/legacy property editors (some have been updated throughout the years)
  * Updated to a new version:
    * Content Picker (8+)
    * Media Picker (8+)
    * Member Picker (8+)
    * Multinode Treepicker (8+)
    * Nested Content (8+)
    * Folder Browser (8+)
    * Related Links (8+)
  * Nested Content (11+)  - replaced by a different property editor: Block List
  * Grid Editor (12+) - replaced by a different property editor: Block Grid
* Database type: MySQL not supported
* Data Types using pre-values
  * These have been redefined in Umbraco 8+

## Before migrating

* Create backups!
* Upgrade to the latest version of Umbraco 7 CMS.
* Empty recycle bin and remove temporary files.
* Cleanup other unused code, content, Data Types, etc.
* Run pre-migration health checks.

## Step 1: Migrate to Umbraco 8

* Spin up a new 8.5.5 site.
* Build and run the site with the connectionstring (web.config) pointing to the v7 site.
* Upgrade to the latest version of Umbraco 8.

## Step 2: Migrate to Umbraco 10

* Spin up a new 10.0.1 site.
* Build and run the site with the connectionstring (appSettings.json) pointing to the v8 site.
* Upgrade to the latest version of 10.

## Step 3: Upgrade to the latest CMS version

## Step 4: Update packages

* Umbraco packages - Deploy, Forms, Workflow...

## Step 5: Update custom code

* Views
* Controllers and Models
* Packages

## Post migration checks

* Verify backoffice User permissions ([Updates to Sections between 7 and 8](https://our.umbraco.com/documentation/Fundamentals/Setup/Upgrading/migrating-to-v8#step-3-post-migration-checks))
