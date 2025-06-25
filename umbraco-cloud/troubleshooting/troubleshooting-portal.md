# The Umbraco Cloud Portal

An error in the Cloud Portal often looks like this:

<figure><img src="../.gitbook/assets/image (51).png" alt="Error on cloud"><figcaption><p>Error on cloud</p></figcaption></figure>

Errors in the Cloud Portal are shown as a colored indicator of an environment. An environment can have three colors:

* **Green** - this is the "healthy" state where everything is fine
* **Yellow** - this is the "busy" state that normally occurs when a deployment is in process or an environment is being added
* **Red** - this is the "error" state which normally has information about what went wrong

{% hint style="info" %}
When your environment has an error and you try to deploy again it will not be able to. The error will **always** need to be resolved before another deployment can be started.
{% endhint %}

## My environment is red. What do I do?

The first thing to check is what type of error it is, you can do so by clicking the **More info** button on the state:

![Portal error](images/portal-error2.png)

We have some guides on how to fix the most common errors below:

* [Some artifacts collide on unique identifiers](deployments/structure-error.md)
* [Duplicate dictionary](deployments/duplicate-dictionary-items.md)
* [Baseline merge issues](../baseline-merge-conflicts.md)
* [Colliding Data Types](deployments/colliding-datatypes.md)
* [Type not found](deployments/type-not-found.md)
* [Deployment fails instantly with no message](deployments/deployment-failed.md)

If your issue is not covered above here are some general guidelines on what you should do when you have error states on Cloud environments:

An environment is in an error state because the Umbraco Deploy engine sets markers on the environment. The green one sets a `deploy` marker, the yellow one a `deploy-progress` marker, and the red one a `deploy-failed` marker.

Sometimes a deployment will fail due to another deployment in progress. You'll need to wait a bit before you can kick in another deployment. By doing this, the deployment will go from failure to complete without needing to do anything extra - read more about [manual data extractions](../power-tools/manual-extractions.md).

Often the deployment fails because of an error that won't be fixed by re-deploying. In these cases, you will need to have a look at the log files.

You can check both the regular [umbracoTraceLogs](log-files.md#umbraco-logs) and the [deploy logs](log-files.md#deploy-logs).
