---
description: >-
  How to Deploy changes between a local machine and an environment in Umbraco
  Deploy using either a Git Gui or without
---

# Deploying Changes

In this article you can learn more about how to deploy your code changes and meta data from a local instance to a remote environment.

## Deploying from local to your environments

When you are working with your Umbraco project locally all changes you make will automatically be identified and picked up by your local Git client.

Here's a quick step-by-step on how you deploy these changes to your environment:

* You've cloned a site to your local machine to work on.
* You've made some changes to a Document Type.
* The corresponding `.uda` file for this Document Type is now updated with the changes - the file is located in the `/umbraco/Deploy/Revision` folder.
* You've also created a new Data Type that's used on the Document Type. This Data Type is stored as a new file in the `/umbraco/Deploy/Revision` folder as well.
* Using Git, commit those two changed files to your local repository and push them to your repository.
* A deployment kicks in and the Document Type is updated and the new Data Type you created locally is now automatically created in the remote environment as well.

## Deploying without using a Git client

If you don't have a Git client installed on your local machine, you can use Git or Git Bash for command-line Git operations. Run the following commands:

```
# Navigate to the repository folder
cd mySite
# Check status of the repository for pending changes
git status
# Add pending changes
git add -A
# Commit staged files
git commit -m "Adding updated schema changed"
# Push to the environment
git push

# If the push is rejected you will need to pull first
git pull
# Try to push again if there were no conflicts
git push
```

When pulling new commits, it is a good idea to see if any of these commits contained changes to the schema (anything in `umbraco/Deploy/Revision/`). To ensure your local schema is up-to-date, you can navigate to the `umbraco/Deploy/` folder and create a deploy marker if it doesn't exist. From a command line type the following command:

`/…mysite/umbraco/Deploy> echo > deploy`

The local site should be running when you do this. The deploy marker will change to `deploy-progress` while updating the site and to `deploy-complete` when done. If there are any conflicts/errors you will see a `deploy-failed` marker instead, which contains an error message with a description of what went wrong.

Another way is to use the Deploy Dashboard in the Settings section of the Umbraco backoffice. Here you can see the status of ongoing or completed deployment processes. The status will show whether an operation has been triggered and whether it is in progress, has completed or has failed. The dashboard will show the status based on the marker files on the disk, eg. `deploy-progress`. From the Deploy Dashboard it is also possible to trigger processes. Learn more about this dashboard in the [Deployment ](../overview.md)article.
