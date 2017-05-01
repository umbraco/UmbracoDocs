#Troubleshooting
Sometimes things don't go perfectly (we know, surprise right?).  Following are some approaches to discover what went wrong and how to resolve the issue so you can get back to work.  

##Deployment issues with Content
Please refer to these two topics for troubleshooting Content deployments (this includes Media as well):

 - [Schema out of sync](Content-Deploy-Schema/)
 - [Errors during Content deployments](Content-Deploy-Error/)

##Deployment/restore issues with structure
Please refer to this topic for troubleshooting structure deploys and restores:

 - [Errors during structure deployment/restore](Structure-Error/)

 ##Automated Minor upgrades##
 Please refer to this topic for troubleshooting when minor upgrades are causing issues:

- [Minor upgrades issues](Minor-Upgrades/)

## Known issues with 3rd party packages / datatypes
Please refer to this topic for troubleshooting specific packages or datatypes that are not built into Umbraco
- [Known issues with 3rd party packages / datatypes](Plugins-Known-Issues)

##Deployment issues
The deployment process is complex, with the addition of your own custom code, various approaches to deployment, and other factors sometimes deployments can go awry.

###First
As a first step, before you launch into any of the below you should check to see if your deployment is still running.  If you've made lots of changes, especially if you've added a large amount of content or media, it can take some time to deploy from one environment to another.

###Second
Next, assuming your deployment is complete and the message from the deployment indicates it did not complete successfully, you can try to deploy a second time.  This might work if you have items that depend on other items that will now be in place.

####I didn’t start out by cloning the Umbraco Cloud site or something else is different from the approach outlined in Getting Started and Deployment

In some cases you may have some special datatypes or may have created custom code outside of the Umbraco Cloud site.  In these cases you’ll need to take a few extra steps to ensure your site is deployed successfully.  Read on to see if any of these apply to you.

####I already have my site created as a standalone site/solution, how do I deploy my changes to Umbraco Cloud?
There are different approaches to this scenario.  The one you’ll use depends on how you created your site.  In most cases, copying your production ready files (including any compiled code you have) into a local clone of your site will be all you need.  Of course, if you have created Umbraco specific items (document types, etc...) in a site that was not originally cloned from Umbraco Cloud, then you’ll also need to update those items.  The most straightforward way is to create the items in the cloned site, but you may also do a database merge, file import, or other method that you are familiar with.  
In any case, the idea is to tell the cloned umbraco site about all your items so umbraco can create the serialized version of these.
Once you have your local site as you like, then the process to deploy to your Umbraco Cloud dev site is identical to the above.  Pretty simple!

####I’m using Archetype, do I need to do anything special?
Yes, as Archetype is third-party created datatype you’ll need to include the appropriate data resolver.  You simply include the data resolver in your site’s /bin/ folder and make sure you commit and push the file when you deploy your site.  You can find the data resolver for Archetype here:  [https://github.com/leekelleher/Archetype.Courier](https://github.com/leekelleher/Archetype.Courier)

####I’m using BuzzHybrid / DonutCaching / LatestHotStuff / other custom add-ins or I’ve created my own datatypes - do I need to do anything special?
Probably not!  In most cases simply including the custom files (and configuration) is enough for Umbraco Cloud to understand how to deploy your site.  In some cases, namely where you’ve created a data type that serializes data or otherwise stores property data in a non-standard format, you’ll need to also create a corresponding data resolver.  Fortunately these are easily created using the guide and samples [here](https://github.com/umbraco/Courier/blob/master/Documentation/Developer%20Documentation/Data%20Resolvers.md)

####I press the “Deploy to Staging/Live” button, then nothing happens.  What’s going on?
Umbraco Cloud uses web sockets to communicate between your browser session and the remote environment.  If your connection to the internet doesn’t support web sockets, you are behind a proxy server or firewall that blocks web sockets, or if the web socket connection is in any other way not supported then you may find that deployments (and other operations) may not complete successfully.  At this time there is not a workaround to this requirement.

####I have a package.json file in the root of my website and my deploys keep failing
With the package.json file in place, our service will take that to mean: "look, I'm a node.js project, don't treat me as a ASP.NET site!". In order to remedy this you can go into your local clone of the website and find the `.deployment` file and make it look like this:

    [config]
    SCM_SCRIPT_GENERATOR_ARGS = --basic
    POST_DEPLOYMENT_ACTIONS_DIR = C:\KuduService\artifacts\

So the addition here is the line that says `SCM_SCRIPT_GENERATOR_ARGS = --basic`.   
Rest assured: this problem is on our list to fix as soon as possible but for now you can use this workaround.

####Some or all of my static assets (css, js, images) are not loading on my development environemt
Symptom: When you try to go to the URL of your static assets (`https://mysite.s1.umbraco.io/assets/css/app.css` for example) you get a login prompt, upon completing that, you get redirected to something like `https://mysite.s1.umbraco.io/login.aspx?ReturnUrl=%2fassets%2fcss%2fapp.css`.

This issue is under investigation and seems to occur rather randomdly; it works fine for most people but for some it just starts failing for no good reason (that we've found yet). For now what you can do to fix the problem is:

1. Copy the Url from your site’s HTTPS Clone Url in the portal 
2. Using the Url without the actual repository name, the GUID part, open a new browser tab and login. Just the Url like `https://dev-mysite.scm.s1.umbraco.io/`
3. You’ll see the Kudu site
4. Go to the "Site Extensions" menu item and click the "Restart site" button

This will recycle the application pool for your site and should allow you to load your assets again.

####I have an error saying:
`User: username@domain.net could not be authenticated at...`

This usually mean that the user's account does not have the same user name and password on the environment you're deploying to. So when that user is deploying from development to staging they will get this error if they either don't exist on the staging environment or if their password is different between the dev and staging environment.

####My deployment did not complete successfully.  How do I find what went wrong and what needs to change?
On rare occasions you may find that a deployment fails and there is no useful information in the error message.  In most cases you should try the deployment a second time, but if that also fails you will need to dig a little deeper.

##It’s time to get your Git on!  

The first step is to find out what state the site’s Git repository is in (for the source site, usually dev but could also be stage).  In order to do this we’ll use the Kudu console that is available for every site in Umbraco Cloud.  Here are the steps to find out what state your repository is in:

1. Copy the Url from your site’s HTTPS Clone Url in the portal

2. Using the Url without the actual repository name, the GUID part, open a new browser tab and login.  Just the Url like `https://dev-mysite.scm.s1.umbraco.io/`

3. You’ll see the Kudu site, which includes your site’s Git repository

4. From the menu select Debug Console > Powershell

5. In the file explorer navigate to site > repository

6. Now in the Powershell console enter
  `PS> git status`

7. The status of your repository will be displayed. If you see output similar to the following, you’re getting somewhere:

    `. # On branch master  # Your branch and 'origin/master' have diverged`

8. Now you just need to resolve any merge conflicts and commit any outstanding unmerged paths.  In most cases, you can use the following Git command to commit the outstanding paths (it may take a minute or two for Git to process the commit):

    `PS> git commit -m “Latest merged files here”`

9. If the git commit didn’t work for you, you’ll need to go even a little deeper.  There are a few options here; 1) if the files marked as “Unmerged paths” have a name like ‘03dbdfb1-7780-4368-8f1e-2bc2a18012ec.courier’ you can remove them using the git command:

    `PS> git rm <full path from console>/03dbdfb1-8f1e-2bc2a18012ec.courier`

10. And 2) If the files listed in “Unmerged paths” are files your site is using, you’ll need to manually edit these files to resolve the merge conflict and then add the back to your repository using the git command:

    `PS> git add myfilename`

11. Once you have resolved any conflicts you need to commit any outstanding changes:

    `PS> git commit -m “Manually resolved merge conflicts, yay!”``

12. Now check the status of the repository to make sure it’s clean:

    `PS> git status`

13. Whew!  Just imagine having to do this without Git!

14. Now you can return to the Umbraco Cloud portal and again deploy your site

##Logfiles
Still nothing? Time to check the logs, of which there are several. Remember that the timestamps in all logs are in UTC so they might be a few or many hours off from the time your actual problem occurred.

###First - Umbraco Logs
If there's something wrong with you site that you can't directly see the cause of, check the logs for Umbraco first. In your backoffice you can go to the Developer section and open up the "Trace Logs" tree. From there you can pick the date on which you're seeing problems and peruse the logs for suspicious entries.

###Second - Other logs
These can all be accessed through Kudu:
1. Copy the Url from your site’s HTTPS Clone Url in the portal

2. Using the Url without the actual repository name, the GUID part, open a new browser tab and login.  Just the Url like `https://stage-mysite.scm.s1.umbraco.io/`

3. You’ll see the Kudu site, which includes your site’s Git repository

4. From the menu select Debug Console > Powershell

5. In the file explorer navigate to site

####Courier logs
When your site structure doesn't deploy as you expected, there may be errors in the Courier logs, from the site folder navigate to wwwroot > App_Data > Logs which is where both the Umbraco and Courier log files can be found. If you find something suspicious, that's where you can look next.

####Git deploy logs
Whenever you push from local to staging or when you deploy using the Umbraco Cloud portal, you're deploying your site using git. This works as follows: you commit changes to git and push them to development, these changes are then stored in the site > repository folder. Then the state of the newest commit gets copied into the wwwroot folder, which is where your website lives.

When you're in Kudu, you can go up to your `site` folder as described in the 5 steps above and then jump into the deployments folder. The `active` file has the identifier of the currently active deployment in it. If you go into the folder that has the same name as that identifier you can see a few files: `log.log`, `manifest` and `status.xml`.

- `status.xml` shows you detailed information of which commit was deployed to the `wwwroot` folder

- `manifest` is used to track which files are in the currently active deploy so that additions, renames and deletions can be detected easily for the next deploy (this is an internal file which you should not touch)

- `log.log` shows you the same output you will have seen when pushing your changes using git, it will show you what happened during the push and if any errors occurred. This file is especially useful when trying to find errors for deploys using the portal (so from dev > live or from dev > staging > live). Even though the last line may end with "Deployment successful" it is possible that there were errors or suspicious messages before that so make sure to give them a read.

It is possible that a deployment failed so that it is not the active deployment at the moment, there could be valueable information in the logs of this deployment. You can find out what the last attempted deploy was by going to your Kudu url and adding `/api/deployments` to the url (so for example: `https://stage-mysite.scm.s1.umbraco.io/api/deployments`. This will give you some JSON data and the first entry in here is the newest attempted deploy, again the id corresponds to a folder name which has the log.log file in it.
