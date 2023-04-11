# Migrate between regions

When creating a project on Umbraco Cloud, you can choose to host the project in different regions: East US, EU West, or South UK.

In some cases, you might want to migrate your project(s) from one region to another. This article will outline the steps to do this.

The East US and West EU regions will be used as examples in this article.

## Prerequisites

* Admin access and deployment rights on the project that is to be migrated.
* Git is installed locally as well as a Git client like _Git Bash_.
* A local setup that can run an Umbraco instance. Learn more about this in the [Requirements](https://docs.umbraco.com/umbraco-cms/fundamentals/setup/requirements) article.

{% hint style="info" %}
To follow this guide, it is highly recommended that you have experience with Git and running git commands through a command line tool.
{% endhint %}

## Prepare your projects

The first step in this process is to create a new Umbraco Cloud project in the region you want to migrate your existing project to. In this case that will be the East US region.

This is done by selecting **East US** from the **Region** dropdown when creating the Cloud project.

![Select the East US region](images/creationflow-chooseRegion.png)

The new project in the US region will run the latest version of Umbraco CMS, Umbraco Forms, and Umbraco Deploy. You will need to ensure that the project you are migrating is running the exact same version of each product before initiating the migration process.

Find more details on how to upgrade your project in the [Upgrades](../product-upgrades/) documentation.

## Migrate the project

The following steps will guide you through the migration process.

{% hint style="warning" %}
Make sure that your projects are [prepared for migration](migrate-between-regions.md#prepare-your-projects) before continuing the process.
{% endhint %}

1. Clone down the project that you want to migrate - the _EU project_.
2. Restore content and media through the Umbraco backoffice.
3. Clone down the new Cloud project created in the US region - the _US project_.
4. Replace the `src/UmbracoProject/umbraco-cloud.json` file in the _EU project_ with the one from the _US project_.

{% hint style="info" %}
The `umbraco-cloud.json` file contains details about each environment on the Cloud project.

By replacing the one on the _EU project_ with the one from the _US project_, content and media transfers will point to the environments on the _US project_ instead of the _EU project_.
{% endhint %}

1. Commit the change through git, but do not push it yet.
2.  Use the following git commands to connect your local _EU project_ to the live environment on the _US project_:

    ```
    git remote rm origin

    git remote add origin https://scm.umbraco.io/useast01/name-of-us-live-site.git

    git fetch

    git branch --set-upstream-to=origin/master
    ```
3.  Push the schema and files from the _EU project_ to the _US project_ using the following git command:

    ```
    git push origin master -f
    ```
4. Verify that the schema and files have been merged into the live environment on the _US project_.
5. Transfer content and media from the local _EU project_ to the _US project_.
6. Verify that all the content and media have been transferred to the _US project_.

Once you have verified that all schema and files as well as content and media have successfully been deployed and transferred to your new _US project_ the migration process is complete.

It is highly recommended to thoroughly go through everything on the migrated site to ensure that everything works as expected.

## Post migration tasks

By following the steps above you have migrated your Umbraco project from one Cloud environment to another.

The following will need to be reconfigured on the new project after the initial migration:

* All **Team Members** added through the Cloud Portal on the _EU project_ also need to be invited to the _migrated project_
* **Hostnames**, **certificates,** and other related settings need to be re-added and reconfigured on the _migrated project_.

Once everything has been configured and set up you can safely delete the _EU project_ which will also cancel the running subscription on the project.

Do you need help or have any questions regarding this process, please reach out to our support using [contact@umbraco.com](mailto:contact@umbraco.com).

## Related articles

* [Manage hostnames](../set-up/project-settings/manage-hostnames/)
* [Team Members](../set-up/project-settings/team-members/)
* [Certificates](../set-up/project-settings/manage-hostnames/security-certificates.md)
