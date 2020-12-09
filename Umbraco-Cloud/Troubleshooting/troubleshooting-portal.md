---
versionFrom: 7.0.0
---

## The Umbraco Cloud Portal

An error in the Cloud Portal often looks like this:
![Portal error](images/portal-error.png)

Errors in the Cloud Portal are shown as a colored indicator on an environment. An environment can have three colors:
* __Green__ - this is the "healthy" state where everything is fine
* __Yellow__ - this is the "busy" state that normally occurs when a deployment is in process or an environment is being added
* __Red__ - this is the "error" state which normally has information about what went wrong

:::note
When your environment has an error and you try to deploy again it will not be able to. The error will **always** need to be resolved before another deployment can be started.
:::

### My environment is red. What do I do?
The first thing to check is what type of error it is, you can do so by clicking the __**More info**__ button on the state:
![Portal error](images/portal-error2.png)

We have some guides on how to fix the most common errors below:
* [Some artifacts collide on unique identifiers](Deployments/Structure-Error)
* [Duplicate dictionary](Deployments/Duplicate-Dictionary-Items)
* [Baseline merge issues](../Getting-Started/Baselines/Baseline-Merge-Conflicts)
* [Colliding Data Types](Deployments/Colliding-Datatypes)
* [Type not found](Deployments/Type-Not-Found)

If your issue is not covered above here are some general guidelines on what you should do when you have error states on Cloud environments:

The reason an environment is in an error state is that the Umbraco Deploy engine sets markers on the environment, the green one sets a `deploy` marker, the yellow one a `deploy-progress` marker and the red one a `deploy-failed` marker.

Sometimes a deployment will fail due to another deployment in progress. This means that you'll need to wait a bit before you can kick in another deployment. Doing this, the deployment will go from failed to complete without needing to do anything extra - read more about [manual data extractions](../Set-Up/Power-Tools/Manual-extractions).

Often the deployment fails because of an error that won't be fixed by re-deploying. In these cases you will need to have a look at the log files.

You can check both the regular [umbracoTraceLogs](Log-Files/#umbraco-logs) and the [deploy logs](Log-Files/#deploy-logs).
