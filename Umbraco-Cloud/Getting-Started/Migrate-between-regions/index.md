---
versionFrom: 8.0.0
---

# Migrate between regions

When you create an project on Umbraco Cloud, you can decide to host the project in one of two regions: EU or US.

In some cases, you might want to migrate your project(s) from one region to another. This article will outline the steps to do just that.

The guide will use an example where a Cloud project is moved from the EU region to the US region.

## Prepare your projects

The very first step in this process, is to create a new Umbraco Cloud project on the region where you want to move your existing project to. In this case that will be the US region.

This is done by selecting **East US** from the **Region** dropdown when setting up the Cloud project.

INSERT IMAGE HERE!

The new project on the US region will run the latest version of Umbraco CMS, Umbraco Forms and Umbraco Deploy. You will need to ensure that the project you are migrating, are running the exact same versions of each product before initiating the migration process.

1. In order to migrate a EU Cloud environment to a US Cloud environment, first of all you need to make sure that you are on the same versions (cms, deploy, forms) as the US env.
2. Then clone the EU Cloud environment and restore content/media
3. Replace the umbraco-cloud.json file (from the src -> UmbracoProject) with the one from the new US project.
4. Commit the change (do not push)
5. git remote rm origin
6. git remote add origin https://scm.umbraco.io/useast01/name-of-us-live-site.git
7. git fetch
8. git branch --set-upstream-to=origin/master
9. git push origin master -f
10. then check the US Cloud environment and then from local EU Cloud environment queue for transfer the content/restore the content on US Cloud environment

