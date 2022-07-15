---
versionFrom: 7.0.0
versionTo: 8.0.0
meta.Title: "Deploying changes from a local machine to Umbraco Cloud"
meta.Description: "How to Deploy changes between a local machine and an environment with Umbraco Deploy using either a Git GUI or CLI"
---

# Deploying changes with Umbraco Deploy

In this article, you can learn more about how to deploy your code changes and metadata from a local instance to your Cloud environment.

## Deploying from local to your Cloud environments

When you are working with your Umbraco Cloud project locally, all changes you make will automatically be identified and picked up by your local Git client.

Here's a quick step-by-step on how you deploy these changes to your Cloud environment:

- You've cloned a site to your local machine to work on.
- You've made some changes to a Document Type.
- The corresponding `.uda` file for this Document Type is now updated with the changes. The file is located in the `/data/revision` folder.
- You've also created a new data type that's used on the Document Type. This data type is also stored as a new file in the `/data/revision` folder.
- Using Git, commit those two changed files to your local repository and push them to your Cloud repository.
- A deployment kicks in and the Document Type is updated and the new Data Type you created locally is now automatically created on the remote environment as well.

![Deploy from Local to Remote](images/stage-commit-deploy.gif)

In the above example, GitKraken is used to stage, commit, and deploy changes made to a Document type plus a newly added data type from a local environment to a Cloud Development environment. You are welcome to use any Git client or or command line interface of your choice.

Once you've deployed your local changes to your Cloud environment deploying to your remaining Cloud environments (e.g. Staging and/or Live) is done using the **'Deploy changes to ..'** button in the Umbraco Cloud portal. For more information, see the [Deploying between Cloud environments](../Cloud-to-Cloud) article.

## Deploying without using a Git client

If you don't have a Git client installed on your local machine, or prefer to work with Git through the command line, you can use eg. [Git for Windows](https://gitforwindows.org/) and the following commands:

```cs
# Navigate to the repository folder
cd mySite
# Check the status of the repository for pending changes
git status
# Add pending changes
git add -A
# Commit staged files
git commit -m "Adding updated schema changes"
# Push to the environment
git push origin master

# If the push is rejected you will need to pull first
git pull origin master
# Try to push again if there were no conflicts
git push origin master
```

If you have to pull down new commits, it is a good idea to see if any of these commits contained changes to the schema (anything in `/Data/Revision/`). To ensure that your local site is up-to-date, and your changes work with the updated schema, you can navigate to the `/data/` folder and create a deploy marker if one doesn't already exist. From a command line type the following command:

```cs
/…mysite/data> echo > deploy`
```

The local site should be running when you do this. The deploy marker will change to `deploy-progress` while updating the site and to `deploy-complete` when done. If there are any conflicts/errors, you will see a `deploy-failed` marker instead, which contains an error message with a description of what went wrong.

:::tip
Check the timestamp on the `deploy-complete` marker to see if it has been updated.
:::
