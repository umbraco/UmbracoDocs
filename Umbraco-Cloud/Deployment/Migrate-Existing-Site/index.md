#Migrating an Existing Site to Umbraco Cloud
Sometimes you may already have an umbraco site built that did not start with a clone of an Umbraco Cloud site. Or perhaps you have decided to move a site that's already live to Umbraco Cloud. In any case, migrating an existing site is not difficult, but it does require some specific steps, and an understanding of how Umbraco Cloud deployments work can be very helpful.

With that in mind, here are the steps to take.

##Understanding what you have
Prior to undertaking a migration you'll want to make sure you know the packages, add-ons, and custom code your site is using.  This is especially important if you are using custom property editors that will require data resolvers in order to work properly with the Umbraco Cloud deployment engine. Some common property editors that will require a data resolver are; [Archetype](https://github.com/leekelleher/Archetype.Courier), [Mortar](https://github.com/leekelleher/umbraco-mortar/tree/develop/Src/Our.Umbraco.Mortar.Courier), and [Nested Content](https://github.com/leekelleher/umbraco-nested-content) which do not currently contain a data resolver and will not deploy properly. There are certainly other property editors that will require a custom data resolver but, for the most part, property editors that store data as umbraco data will deploy without requiring any special attention.

If you have used Courier with your site previously and deployments work as expected, then you can be relatively certain it will also deploy properly with Umbraco Cloud.

##Step-by-step
1. Make sure your existing site is upgraded to the latest released version of umbraco. You can find detailed information about upgrading your site [here](https://our.umbraco.org/documentation/Getting-Started/Setup/Upgrading/). You'll also want to make sure the Umbraco Cloud site you create and the clone in step 5 are the same version.
2. Verify your site runs without errors.  
    * Hint: check the umbracoTraceLog.txt log file.
    * Ideally your site will run locally using the SqlCe database as this will make content migration easier. Don't worry if that's not possible, you can still complete the migration.
3. With the site running, empty the Content and Media Recycle bins.
4. Shut down the site and delete the following files and folders:
    * `/app_data/TEMP`
    * `/app_data/logs`
    * `/app_data/cache`
    * `/app_data/preview`
    * `/app_data/umbraco.config`
    * `/data/[*]` **except** for `/data/backoffice`
5. Create a new Umbraco Cloud project and clone the Dev site to your local machine.
6. Verify the existing site and the cloned Umbraco Cloud site are the same umbraco version.
7. Copy all folders from the existing site to the Umbraco Cloud site. Make sure you do not overwrite any Umbraco Cloud site files in the following folders:
    * `/bin/`
    * `/data/backoffice/users/`
    * `/umbraco/`
    * `/umbraco_client/`
8. Merge the config files as needed paying special attention to:
    * `web.config`
    * `/config/courier.config`
    * `/config/dashboard.config`
    * `/config/umbracodeploy.config`
9. If using SqlCe then also make sure the SqlCe database from your existing site replaces the current SqlCe file - `/app_data/umbraco.sdf`
    * If using a local Sql Server make sure the connection string in web.config is set correctly.
    * If you have a backoffice user that has the exact same email address as the user for Umbraco Cloud you will need to change that user's email address in the database at this time before deploying via the backoffice.
    * In the `/data/backoffice/users/` folder you will have user files that correspond to each user that has been created via the Umbraco Cloud portal.  To add any of these users to the site simply rename the files by removing the leading underscore.
10. Open a command prompt, cd to the `/data/` folder and add a deploy marker by typing `echo > deploy`.
11. Now run the local Umbraco Cloud site with the updated files and database. The deploy engine will start when the deploy marker is detected.  This will likely complete relatively quickly. This  adds the users created by Umbraco Cloud to your existing database.
12. Once complete verify your site has all meta data, content, and media as expected.
13. Delete the folder `/data/Revision/` from the file system.  
14. In the same browser session as the logged in umbraco user open a new tab at the address:  
    * `http://localhost:port/umbraco/backoffice/api/CourierAdmin/Rebuild`
    * That will create a serialized version of all your site's meta data and will display the following in the browser:
    * `<string xmlns="http://schemas.microsoft.com/2003/10/Serialization/">Rebuilding</string>`
15. At this point you are ready to deploy your site to Umbraco Cloud - Yay!
16. Make sure you git add and commit all the files you added to the site including the serialized files in `/data/Revison/` but excluding `/media/`.  This should be set correctly by the included .gitignore file.
17. Git push your commit to your Umbraco Cloud dev site checking that the "Deployment Complete" message is displayed.
    * If you have a very large commit to push, you may need to configure your git client for this.  
    * Use: git config `http.postBuffer 524288000`
18. Verify all meta data is in place as expected in your Umbraco Cloud dev site
    * `http://dev-your-project-name.s1.umbraco.io/umbraco/`
19. Once the meta data is in place, you can use the standard Umbraco Cloud content deployment approach to deploy your content and media from local to Dev.  Using the "Queue for Transfer" and the Deploy Dashboard.

    * Note: if you have a very large amount of content and or media you may have the best result in deploying content and media independently.
