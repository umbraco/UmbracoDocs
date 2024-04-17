# Manage Environments

When working with an Umbraco Cloud project, you can add or remove extra environments depending on the plan you are in:

* For the Starter plan, you can add a Development environment for an additional price per month.
* For the Standard plan, you get the Development environment for free and can add a Staging environment for an additional price per month.
* For the Professional plan, you get the Development and Staging environment for free. Additionally, you can add and remove environments whenever you like without any additional cost.

[Learn more about the additional prices on Umbraco Cloud](https://umbraco.com/cloud-pricing/).

{% embed url="https://www.youtube.com/watch?v=avzRNFR-FSY" %}
Adding an additional environment to a Cloud project
{% endembed %}

## Adding or Removing Environments

**Important:** _Before_ adding an environment, you should consider if you have any changes locally that are not on Live yet. If you do, you should make sure to push it as adding another environment will also push it into the deployment chain.

**Important:** _After_ adding a Development environment, you need to do a fresh clone of the site. The local version you have will be set up to push directly to Live, a fresh clone will push to Development.

You can add environments from your project overview here:

<figure><img src="../.gitbook/assets/image (16).png" alt="Adding environments"><figcaption><p>Adding environments</p></figcaption></figure>

To remove an environment, go to the environment you want to delete click on the three dots, and click delete:

<figure><img src="../.gitbook/assets/image (17).png" alt=""><figcaption></figcaption></figure>

{% hint style="info" %}
There is a specific order that the environments are being added. You will need to have a Development environment before you can have a Staging environment.
{% endhint %}

Suppose you have both a Development and a Staging environment and need to remove the Development environment. In that case, you will first need to remove the Staging environment before you can remove the Development environment.

Once you have added or removed an environment, it will take a couple of minutes for Cloud to set it all up, and then you will be ready to use it.
