# Apply hotfix by manually moving files

In this article you'll find a step-by-step guide on how to apply a hotfix to a Live environment by manually moving the changes, updated and/or new files from one local clone to another.

The following tools have been used to create this guide:

* Visual Studio Code
* GitKraken

## The Scenario

You have an Umbraco Cloud project with two environments, Development and Live. 

You have been working on building the site on a local clone of the Development environment, and now you want to send some but not all changes to the Live environment.

Three commits have been pushed from your local clone to the Development environment. Out of these three commits, you only need some of the changes on the Live environment.

![Commits](images/commits.png)

## Apply selected changes to the Live environment

Here are the steps to follow in order to apply selected changes to the Live environment without deploying from Development to Live.

For the sake of simplicity here's an explanation of the names I'll be using in this guide:

* The cloned Development environment: **Development repository**
* The cloned Live environment: **Live repository**

### Move the files

1. Clone down the Live environment
    * The _clone URL_ for the Live environment can be found in the Umbraco Cloud Portal:

    ![Live Clone URL](images/live-clone-url.png)

2. Locate the files from the Development reposiroty that you want to move to Live
    * Check the commits in the Git history for the Development repository to verify which files you need

    ![Files changes or added](images/commit-files-changed.png)

    * The _new files_ can simply be moved from the Development repository to the Live repository
    * The same goes for _changed files_. You can also edit the files, and only move the code snippets you need on the Live environment

3. Copy and paste the new and / or updated files from you Development repository to your Live repository
4. You can now _Stage_ and _Commit_ these changes to the Live repository in Git

One of the benefits of having the Live environment cloned down, is that you can test the new changes locally before sending it to the Live environment.

### Test changes locally

5. Run the Live repository through IIS
6. Open _CMD_ and nagivate to the `/data/revision` folder in your Live repository
7. Create a _deploy_ marker by typing the following: `echo > deploy` - learn more about this command in the [Power Tools]() articles
8. The changes will now be reflected in the backoffice of your local Live environment

Once you've checked that everything works locally, you are ready to push to the Live environment

### Push to Live

9. Push the committed changes to the Live environment using Git
10. **Note** that when changes are pushing directly to a Live environment and you have more than one environment, the changes are not automatically extracted into the site
11. Access KUDU on the Live environment
12. Navigate to `site/wwwroot/data` in the _CMD Console_
13. Create a _deploy_ marker by typing the following: `echo > deploy`
14. Once this is complete and you see a `deploy-complete` marker, you will see the changes reflected on the Live environment

## Important notes

* Make sure that the changes you push directly to your Live environment is also pushed to the Development environment. This will ensure that your environments are kept in sync.
* This guide can also be used for applying a hotfix to a _Staging_ environment.