---
versionFrom: 7.0.0
---

# High-level Overview

The creation process involves a lot of different parts, which are outlined below. Keep in mind that we are creating a new and empty project, which consists of one or two environments, depending on the Plan your are on. Both environments will be a clone of the Live repository from the Baseline project.

When the Child project is created the project's identity will be added to an index of Child projects for the Baseline project. This will ensure that the Baseline project is aware of its *children* and can use that list later on, to push updates to all the children. Whoa!

**Note:** Since the following steps were outlined we've made quite a few improvements to the Baseline workflow. For the most part the steps are still relevant and we are working on getting them updated with the latest details.

## Technical Steps

In the following sections we've outlined the technical steps happening when a Child project is created and when a Child project is upgraded.

### Creating a Child project

The process of creating a Child Project is rather involved. While you don't have to worry about this (that's what Umbraco Cloud is for), it can be helpful to understand the parts that make up the connection between a Baseline Project and its Child Projects:

* The Development site is created along with a new Sql Azure database

* The Staging and Live sites are created with Sql Azure credentials, but no database as we’ll make a copy of the Development database when it's ready. We’ll use these pre-defined credentials later on.

* A ConnectionString is configured for each site (umbracoDbDsn)

* Once the three environments are created the project is updated (in the portal) with the name and endpoint of the repository for each of the new sites.

* The Git config file is updated in the Development repository.

* The Development repository is then configured with an Upstream (remote tracking branch) for the Live repository from the Baseline project.

* Now that the Development repository is configured we fetch from the remote (being the upstream branch). The changes are merged into the master branch.

* Note: The master branch is empty so it should not be possible to encounter merge conflicts at this point

* The Development repository is deployed by making a rest call to Kudu, which deploys the HEAD of the repository to wwwroot.

* We create a “pushinfo”-file, which is used by kudu when changes are pushed to the repository

* We create a Sql Azure marker file called “install-sqlazure”, which contains the connection string for the Development Sql Azure database

* Note: This is used by Courier to install the Umbraco database schema upon app-startup

* The Development site is pinged in order to trigger Courier into running and thus creating the database schema and installing all the data, which is part of the site (in the /wwwroot/data folder).

* The initial creation is now done and the environments will appear on the Project page in the Portal. At this point the Staging and Live environments will remain dimmed.

* Now that the Development site is ready - a database copy is begun. First we make a copy of the Development database in order to create the Staging database using the credentials and database name which was already defined for this environment

* When the Staging database is ready we use that to make a new copy, which will be the database for the Live environment. Again, we use the predefined credentials and database name, so we don’t have to do anything beyond copying the database.

* Note: throttling in Sql Azure limits the amount of concurrent operations, which is why we create copies one at a time using the previously created database.

* These last two environments will be activated / un-dimmed as the databases become available on the Project page in the Portal (when the copy process is done).

Between most of these steps we send updates to the Project page in the Portal, so the progress bar, progress updates and the Activity Stream are updated.

The project should now be up and running, but both Staging and Live will be empty so the owner will have to deploy from Development to Staging and then from Staging to Live. This will push (and deploy) the content of the Git repository to the other environments and everything will be up to date, and the Child project is ready for business.

### Upgrading Child projects

* For the Development repository we fetch and merge from the upstream branch, which was configured upon creation.

* If the merge results in a merge conflict we reset the repository, so its not in a “merging state”.

* If the merge was successful we continue to deploy the updated repository. Using Kudu’s Rest endpoints we trigger a deployment of the current state of the Git repository (the HEAD).

* When that is done we create a “deploy” marker file in the wwwroot, which tells Umbraco Deploy to run when the application starts.

* Finally we make a request to the website, which had its changes deployed.

Between the steps listed above, when handling a queued message, we post updates back to the Portal. Some of these updates will also be posted to the stream of the project that is being updated.

It is worth noting that at the time of this writing (August 2015) - when a merge conflict occurs while trying to do “git fetch + merge” the merge will be abandoned by doing a “git reset --hard”. This means that the repository will have an upstream branch that is not merged into master, and it will not be possible to merge future updates until a merge has been done manually. If its done through the Kudu DebugConsole it should be possible to choose whether to select Ours or Theirs when merging and thus resolving the conflict.
