---
versionFrom: 7.0.0
---

# Deploying from Local to Cloud

When you are working with your Umbraco Cloud project locally all changes you make will automatically be identified and picked up by your local Git client.

Here's a quick step-by-step on how you deploy these changes to your Cloud environment:

- You’ve cloned a site to your local machine to work on
- You’ve made some changes to a Document type
- The corresponding `.uda` file for this Document type is now updated with the changes - the file is located in the `/data/revision` folder
- You’ve also created a new data type that’s used on the document type. This data type is stored as a new file in the `/data/revision` folder as well
- Using Git, commit those two changed files to your local repository and push them to the Cloud environment using `git push`
- On the Cloud environment a deployment kicks in and the document type is updated and the new data type you created locally is now automatically created in the Cloud environment as well

![Deploy from Local to Remote](images/stage-commit-deploy.gif)

In the above example, GitKraken is used to stage, commit and deploy changes made to a Document type plus a newly added data type from a local environment to a Cloud Development environment. You are welcome to use any Git client or cli of your choice.

Once you’ve deployed your local changes to your Cloud environment deploying to your remaining Cloud environments (e.g. Staging and/or Live) is done using the **'Deploy changes to ..'** button in the Umbraco Cloud portal. Learn more about how this is done in our section about [deploying between two Cloud environments](../Cloud-to-Cloud).

## Deploying without using a Git client

If you don't have a Git client installed on your local machine, or prefer to work with Git through command line, you can use eg. Git Bash and the following commands:

    # Navigate to the repository folder
    cd mySite
    # Check status of the repository for pending changes
    git status
    # Add pending changes
    git add -A
    # Commit staged files
    git commit -m "Adding updated schema changed"
    # Push to the remote Development environment
    git push origin master

    # If the push is rejected you will need to pull first
    git pull origin master
    # Try to push again if there were no conflicts
    git push origin master

If you had to pull down new commits, it is a good idea to see if any of these commits contained changes to the schema (anything in `/Data/Revision/`). In order to ensure that your local site is up-to-date, and your changes work with the updated schema, you can navigate to the `/data/` folder and create a deploy marker if one doesn't already exist. From a command line type the following command:

`/…mysite/data> echo > deploy`

The local site should be running when you do this. The deploy marker will change to `deploy-progress` while updating the site and `deploy-complete` when done. If there are any conflicts/errors you will see a `deploy-failed` marker instead, which contains an error message with a description of what went wrong.

**Pro Tip:** Check the timestamp on the `deploy-complete` marker to see if it has been updated.
