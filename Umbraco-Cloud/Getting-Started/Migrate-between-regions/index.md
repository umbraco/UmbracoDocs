---
versionFrom: 8.0.0
---

# Migrate between regions

When you create an project on Umbraco Cloud, you can decide to host the project in one of two regions: EU or US.

In some cases, you might want to migrate your project(s) from one region to another. This article will outline the steps to do this.

The guide will use an example where a Cloud project is moved from the EU region to the US region.

## Prepare your projects

The first step in this process, is to create a new Umbraco Cloud project on the region where you want to move your existing project to. In this case that will be the US region.

This is done by selecting **East US** from the **Region** dropdown when setting up the Cloud project.

INSERT IMAGE HERE!

The new project on the US region will run the latest version of Umbraco CMS, Umbraco Forms and Umbraco Deploy. You will need to ensure that the project you are migrating is running the exact same version of each product before initiating the migration process.

Find more details on how to upgrade your project in the [Upgrades](../../Upgrades/) documentation.

## Migrate the project

The following steps will guide you through the migration process.

:::warning
Make sure that your projects are [prepared for the migration](#prepare-your-projects) before continuing the process.
:::

1. Clone down the Cloud project that you want to migrate - the *EU project*.
2. Restore content and media through the Umbraco backoffice.
3. Clone down the new Cloud project created on the US region - the *US project*.
4. Replace the `src/UmbracoProject/umbraco-cloud.json` file on the *EU project* with the one from the *US project*.
5. Commit the change through git, but do not push it yet.
6. Use the following git commands:

   ```none
   git remote rm origin

   git remote add origin https://scm.umbraco.io/useast01/name-of-us-live-site.git

   git fetch

   git branch --set-upstream-to=origin/master

   git push origin master -f
   ```

7. Check the *US project* [Why?]
8. Transfer content and media from the local *EU project* to the *US project*.
