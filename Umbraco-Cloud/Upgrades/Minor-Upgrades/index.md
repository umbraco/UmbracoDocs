# Troubleshooting Automated minor upgrades

Umbraco Cloud supports doing the minor upgrades of your projects in an automated manner. The feature is available when a new minor version of Umbraco is released (i.e. 7.5.0 or 7.6.0).

The upgrade will cover most issues it encounters, but at certain Umbraco configurations, it needs some manual intervention. This is usually related to custom code being dependent on some API's that have either changed or been removed for the new minor upgrade.

In general, if anything should fail during this process, you can reach out for support, using the in-app chat in the bottom right corner. We will help you though the upgrade process, should anything happen.

## Courier dependencies
Symptoms, feedback given from the upgrade process: **Unable to upgrade as the site has custom Courier dependencies**

Along with the upgrade to 7.6 we will replace the old deployment engine Umbraco Courier, and replace it with the new one called Umbraco Deploy. This means that if your code is dependent on Umbraco Courier to run, you will need to remove the dependencies on Umbraco Courier. 
This will be things like custom Umbraco Courier resolvers. In Umbraco Deploy, resolvers will be ValueConnectors and it will have these things built in for the most popular packages, and will have a generic connector for the remaining types.
If you need to create your own specialized ValueConnector, take a look at the  [ValueConnectors example repository](https://github.com/umbraco/Umbraco.Deploy.ValueConnectors). We are shipping with the [Umbraco.Deploy.Contrib](https://github.com/umbraco/Umbraco.Deploy.Contrib) dll, which contains common ValueConnectors for popular community packags.

Your code will need to be updated and built without Umbraco Courier in order to go through the Upgrade process. 

## Database upgrade failing
Symptoms, feedback given from the upgrade process: **Unable to run the Umbraco installer**

The first step in the process, after having updated all the files, is to call the Umbraco install engine in order to get its  database updated to support the new version. As this step is the first time the site gets requested after the updated files is run, it may fail. The reason is often code that is incompatible with the upgraded files.

It can be code that references APIs that has been deprecated, or simply code that has some strong references to specific versions.
If the error is clear, then it will be shown on the screen, as it will be a typical ASP.NET error message (YSOD). You should request the site, and check the error it shows.
If the error isn't descriptive, then it is time to clone the repository to your local machine, and fix the issue. The usual suspects would be:
 - The code you have running is referencing an API that has been changed, that being modified, obsoleted or removed.
 - The `web.config` had assembly bindings for a specific dll version that doesn't exist anymore. During the upgrade process, we do update the references we are shipping, but there might be something missing.

Once you have the site running locally, you should push your changes to the repository. This will update the site, and it should now be in a running state. 

The upgrade process left off when it was needing three more steps. These three steps now need to be done manually. 

1. Complete the installer
    
    To complete the installer, you should simply visit the site on its url. it will be like `https://dev-mysite.s1.umbraco.io. This will show you the installer screen, where you should insert your backoffice credentials, and follow the process. It will run through a few steps, and afterwards, Umbraco will be updated to the latest version.
2. Export the metadata files.

    The second thing you need to do, is to regenerate the metadata files used for transferring items like document types, data types and media types. This is done by accessing the Power tools(Kudu) on the project, open the cmd prompt and browse to the wwwroot/data folder. 
    Once there, you need to enter `echo > deploy-export`. This will generate the needed files for the upgraded site to work with Umbraco Deploy.
3. The last thing to do is to go to the `/site/locks` folder (still through Kudu) and rename the file called `upgrading` to `upgraded-minor` - rename the file by typing `ren upgrading upgraded-minor`. This will indicate to Umbraco Cloud, that the development environment is now ready to deploy all its changes to the next environment.

Before deploying the upgrade to the next environment, you should verify that everything looks as expected on the development environment. 

# Upgrading Baselines
Currently the way to get children of a baseline upgraded, is a bit hacky. The reason is that there's no automation involved in running the upgrade process on the children of the baseline. The baseline itself should just be upgraded like any other project on Umbraco Cloud. 
Click the Upgrade button, and follow the guide. Once it's done, and you are ready to update the children, there's a few steps involved.

The first step is to push the changes to the child projects. Once that is done, the files on the child is now up to date.

*If all config files has been handed via the method mentioned in [Handling configuration files](../../Getting-Started/Baselines/#handling-configuration-files), then you should be good to go, else you need to make sure that the config files on the child projects has been proper updated, and have the same changes that the upgrade added for the baseline project it self.*

Next step is to manually run the installer on the project. This is simply done by making a request for the site. This will automatically start the install process. The process should be a simple follow through guide. Once it is done, the child project is done.

If the child only contains one environment, you are now done. 

If the child contains two or more environments, a little post processing is needed, to deploy the upgrade to the next environments.
These steps will be automated in the future, but for now it's a manual process.

You need to access Kudu for the child project, on the dev environment. Use the cmd part, and go to the /site/locks folder. This folder needs to contain two files, indication to the Cloud, that it is in a upgrading state. Create the files `upgrading` and `upgraded-minor`

To create them, type `echo > upgrading` and `echo > upgraded-minor`

That's it. Now the upgrade is ready to be deployed to the next environments, and it will automatically run the upgrade on those environments.

## Errors while upgrading children from baseline
If for some reason the update of a child fail, or the child is left in a weird state, where it has some wrong configuration files, it is most likely because the child was unable to be merged properly. When updating children from a baseline, a configuration file will be preferred from the child over the one from the baseline. This means that when the update from the baseline to the child runs, the configuration file sometimes won’t be changed. 

To fix this, it is important to follow the flow shown in [Handling configuration files](../../Getting-Started/Baselines/#handling-configuration-files). It prevents that the child will update configuration files, and will ensure the best flow between the baseline and the child.

If the flow isn't used, then the repository will be in a state where the code has been updated, but the configuration files hasn’t been updated. The solution is to manually fix the configuration files on the child project. Do a compare of the configuration files on the baseline and the child, and make sure that all changes has been added to the child’s configuration files.
