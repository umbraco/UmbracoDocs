# Deploying from Local to Cloud

When you are working with your Umbraco Cloud project locally all changes you make will automatically be identified and picked up by your local Git client. 

Here's a quick step-by-step on how you deploy these changes to your Cloud environment:

  - You’ve cloned a site to your local machine to work on
  - You’ve made some changes to a Document type
  - The corresponding `.uda` file for this Document type is now updated with the changes - the file is located in the `/data/revision` folder
  - You’ve also created a new datatype that’s used on the document type. This datatype is stored as a new file in the `/data/revision` folder as well
  - Using Git, commit those two changed files to your local repository and push them to the Cloud environment using `git push`
  - On the Cloud environment a deployment kicks in and the document type is updated and the new datatype you created locally is now automatically created on the Cloud environment as well

![Deploy from Local to Remote](images/stage-commit-deploy.gif)

In the above example, GitKraken is used to stage, commit and deploy changes made to a Document type plus a newly added Datatype from a local environment to a Cloud Development environment.

Once you’ve deployed your local changes to your Cloud environment deploying to your remaining Cloud environments (e.g. Staging and/or Live) is literally as simple a pressing the **'Deploy changes to ..'** button in the Umbraco Cloud portal. Learn more about how this is done in our section about [deploying between two Cloud environments](../Cloud-to-Cloud).