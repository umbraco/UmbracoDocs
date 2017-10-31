# Deploying from one Cloud environment to another

When you are working directly on your Development environment any changes you make through the backoffice will automatically be identified and committed to the site's Git repository. This includes Umbraco specific items like Document types and templates. 

Changes made on your Cloud environments will show up in the Umbraco Cloud portal, where you will be able to see what files has been added / changed and by who the changes where made. 

In order to deploy meta data changes from one Cloud environment to another you simply click the **'Deploy changes to ..'** button on the environment where the changes has been made. The deployment will kick in, and you can follow the process in the *Activity Log' in your browser.

![Deployment in Portal](images/deploy-in-portal.gif)

Once it's done the changes will have been applied to the Cloud environment next in line. If you have more Cloud environment, simply follow the same procedure to deploy the changes all the way up to your Live site.

## Important notes
If you have more than one Umbraco Cloud environment we strongly recommend that you **only make changes to meta data on the Development environment**.

It's not possible to deploy changes to meta data from *right to left*. This means that you will not be able to deploy meta data changes made directly on the Live environment to your Staging or Development environments.

If this is the case, however, and some changes has been made to the meta data on the Live environment, you will need to remove the Development (and Staging) environments and re-add them in order to sync up your environments again.