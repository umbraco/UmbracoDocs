# Environments

In this article, you can learn more about how to work with environments on your Umbraco Heartcore project.

Having multiple environments means that you have a place to test both your content and the content structure before deploying it to the production environments, from where the content is served to your application.

## What is an environment?

An environment on a Heartcore project can be defined as a _workspace_ and is at the same time a Git repository. When you have more than one environment on your project, these environments will act as branches of the main repository.

Umbraco Heartcore uses a deployment model that relies on Git and other core technology, which gives you an option to move both content and structure files from one environment to another.

Learn more about the deployment model in the[ Deployment workflow article](deployment-workflow/).

## Video tutorial

{% embed url="https://www.youtube.com/watch?t=&v=6MXuDqEMM70" %}

## Manage environments

How many environments you can work with depends on [the plan your Umbraco Heartcore project is running](https://umbraco.com/umbraco-heartcore-pricing/).

* Starter: 1 environment (Live)
* Standard: 2 environments (Development and Live)
* Professional: 3 environments (Development, Staging, and Live)
* Enterprise: Flexible number of environments. You can contact us by [using the Umbraco Heartcore Enterprise form](https://umbraco.com/umbraco-heartcore-pricing/buy-umbraco-heartcore-enterprise/) if you're interested in more information about the Enterprise plan.

When you upgrade your Heartcore project from the Starter to the Standard plan, the Development environment will be added automatically. Once you've upgraded to the Professional plan, you will be able to add the Staging environment as well.

You can add and remove the environments any time you want, as long as you have multiple environments enabled.

Adding and removing environments is done from the Project page in the Cloud Portal.

{% hint style="info" %}
Please note you will need to restart environments after they have been set up or removed from your project. In order to update the configuration of Umbraco Deploy
{% endhint %}

![Manage environments from here](images/button-to-manage.png)

This will open an overlay, where you can manage the environments on your Heartcore project.

Below is a screenshot of how that overlay looks on the Professional plan when only the Development environment is added. There's an option to delete the current Development environment and an option to create a Staging environment. How this overlay looks is dependant on the plan your project is on.

![Manage environments overlay](images/manage-environments.png)
