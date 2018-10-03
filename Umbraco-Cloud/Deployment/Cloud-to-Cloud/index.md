# Deploying from one Cloud environment to another

When you are working directly on your Development environment any changes you make through the backoffice will automatically be identified and committed to the site's Git repository. This includes Umbraco specific items like Document types and templates. 

Changes made on your Cloud environments will show up in the Umbraco Cloud portal, where you will be able to see what files has been added / changed and by who the changes where made. 

In order to deploy meta data changes from one Cloud environment to another you simply click the **'Deploy changes to ..'** button on the environment where the changes has been made. The deployment will kick in, and you can follow the process in the 'Activity Log' in your browser by clicking on 'View Details'.

![Deployment in Portal](images/deploy-in-portal.gif)

Once it's done the changes will have been applied to the Cloud environment next in line. If you have more Cloud environment, simply follow the same procedure to deploy the changes all the way up to your Live site.

## Important notes
When you deploy from i.e. your Development environment to your Live environment, any changes made on the Live environment will be merged back into the Development environment. 

Here are the auto-magical steps Umbraco Cloud goes through when you hit the *"Deploy changes to .."* button:

* Before pushing your changes from the source environment, the engine running Umbraco Cloud - **Umbraco Deploy** - looks for changes in the repository on the target environment
* If changes are found, Umbraco Deploy *merges* the changes from the target environment into the repository on the source environment
* After the merge, the changes from the source environment are pushed to the repository on the target environment
* Finally the changes pushed to the source repository is extracted to the site, and you will now see your changes reflected in the backoffice and on the frontend

If you have more than one Umbraco Cloud environment we strongly recommend that you **only make changes to meta data on the Development environment**. Making changes directly on your Staging and/or Live environments can cause merge-conflicts when you deploy from your Development environment. 

Refer to our troubleshooting documentation about [how to resolve structure errors](https://our.umbraco.com/documentation/Umbraco-Cloud/Troubleshooting/Structure-Error/), if you should run into issues while deploying between your Umbraco Cloud environments.
