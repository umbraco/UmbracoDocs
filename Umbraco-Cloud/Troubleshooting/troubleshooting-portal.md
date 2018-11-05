## The Umbraco Cloud Portal

An error in the Cloud Portal often looks like this:
![Portal error](images/portal-error.png)

Errors in the Cloud Portal are shown as a colored indicator on an environment. An environment can have three colors:
* __Green__ - this is the "healthy" state where everything is fine
* __Yellow__ - this is the "busy" state that normally occurs when a deployment is in process or an environment is being added
* __Red__ - this is the "error" state which normally has information about what went wrong

**Note:** If an environment is busy or has an error and you try to deploy again it will not be able to, the error will always need to be resolved before another deployment can be started.

What is interesting for Troubleshooting is the Red and Yellow states, Yellow normally doesn't mean an error occurred, but sometimes a deployment will get stuck and just keep spinning for a long time without ever finishing - often a browser refresh will reveal this yellow state has switched to red.

#### If you have a red environment what do you do?
The first thing to check is what type of error it is, you can do so by clicking the __**More info**__ button on the state:
![Portal error](images/portal-error2.png)

We have some guides on how to fix the most common errors below:
* [Collision error](Deployments/Structure-Error)
* [Duplicate dictionary](Deployments/Duplicate-Dictionary-Items)
* [Baseline merge issues](../Getting-Started/Baselines/Baseline-Merge-Conflicts)
* [Colliding Data Types](Deployments/Colliding-Datatypes)

If your issue is not covered above here are some general guidelines on what you should do when you have error states on Cloud environments:

The reason an environment is in an error state is that the Umbraco Deploy engine sets markers on the environment, the green one sets a `deploy` marker, the yellow one a `deploy-progress` marker and the red one a `deploy-failed` marker.

Sometimes a deployment will fail due to another deployment in progress, this means you can kick in another deployment later and the deployment will go from failed to complete without needing to do anything extra - read more about [manual data extractions](../Set-Up/Power-Tools/Manual-extractions)!

Often the deployment fails because of an error that won't be fixed simply by redoing it, for that you will need to have a look at the log files - you can check both the regular [umbracoTraceLogs](Log-Files/#umbraco-logs) and the [deploy logs](Log-Files/#deploy-logs).
