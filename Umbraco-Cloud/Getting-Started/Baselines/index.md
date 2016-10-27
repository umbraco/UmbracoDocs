#Baselines
A Baseline project is very similar to a Fork (forked repository) on github in that we create a clone of an existing project while maintaining a connection between the two projects. The connection exists between the _Live_ environment of the existing project (often referred to as the “master”) and the _Development_ environment of the newly created project - the Baseline “child”.

Any project can act as the Master for new projects.

The basic idea is that you have a Project that contains all your standard Umbraco packages/components, maybe even configured with some default Document Types, which you want to use as the baseline for future projects. When you need to make changes to your baseline you can then push these changes out to all the “child” projects with a click of a button.

##High-level Overview
Using the “Create Project” option from the Umbraco Cloud portal you’ll have the option to create a new project based on an existing project (Agency plans). When you click create you’ll be redirected to the project page for the newly created project, which shows the creation progress. The two environments (Development and Live) are hidden by default, and won’t be available until the Development environment is ready. The Staging and Live environments will remain unavailable until the corresponding Sql Azure databases are ready - which can take several minutes.

The creation process involves a lot of different parts, which are outlined below. Keep in mind that we are creating a new and empty project, which consists of three environments and that the Development environment will be a clone of the Live repository from the existing project (the Baseline “master”).

When the Project is created the project's identity will be added to an index of Baseline (child) projects for the master/existing project. This will ensure that the master is aware of its children and can use that list later on, to push updates to all the children. Whoa!

###Steps
The process of creating a Baseline project is rather involved. While you don't have to worry about this (that's what Umbraco Cloud is for), it can be helpful to understand the parts that make up a baseline master-child relationship:

* The Development site is created along with a new Sql Azure database

* The Staging and Live sites are created with Sql Azure credentials, but no database as we’ll make a copy of the Development database when its ready. We’ll use these pre-defined credentials later on.

* A ConnectionString is configured for each site (umbracoDbDsn)

* Once the three environments are created the project is updated (in the portal) with the name and endpoint of the repository for each of the new sites.

* The git config file is updated in the Development repository.

* The Development repository is then configured with an Upstream (remote tracking branch) for the Live repository from the Baseline “master”.

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

The project should now be up and running, but both Staging and Live will be empty so the owner will have to deploy from Development to Staging and then from Staging to Live. This will push (and deploy of course) the content of the git repository to the other environments and everything will be up to date, and the Baseline “child” project is ready for business.

##Updating a Baseline "Child"
When a project has one or more Baseline “children” it will appear on the Project page, and the user can click to get an overview of all the (Baseline) projects based on the current project.
Clicking "update" on the overview page will trigger the update of all the projects listed on that page.  Make sure this is what you intend to do as the process will do what it says - that is, push the current Master branch to all the configured children.

###Steps

* For the Development repository we fetch and merge from the upstream branch, which was configured upon creation.

* If the merge results in a merge conflict we reset the repository, so its not in a “merging state”.

* If the merge was successful we continue to deploy the updated repository. Using Kudu’s Rest endpoints we trigger a deployment of the current state of the git repository (the HEAD).

* When that is done we create a Courier “deploy” marker file in the wwwroot, which tells Courier to run when the application starts.

* Finally we make a request to the website, which just had its changes deployed.

Between the steps listed above, when handling a queued message, we post updates back to the Portal. Some of these updates will also be posted to the stream of the project that is being updated.

It is worth noting that at the time of this writing (August 2015) - when a merge conflict occurs while trying to do “git fetch + merge” the merge will be abandoned by doing a “git reset --hard”. This means that the repository will have an upstream branch that is not merged into master, and it will not be possible to merge future updates until a merge has been done manually. If its done through the Kudu DebugConsole it should be possible to choose whether to select Ours or Theirs when merging and thus resolving the conflict.

##Merge Conflicts
As with any git repository-based development it is not uncommon to have merge conflicts as the various repositories begin to differ. For more on the merge strategy we use and how to approach resolving these conflicts read the [Resolving Baseline Merge Conflicts section](../Baseline-Merge-Conflicts/).
