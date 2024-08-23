# Environments

In this article, you can learn more about how to work with environments on your Umbraco Heartcore project.

Having multiple environments means that you have a place to test both your content and the content structure before deploying it to the production environments, from where the content is served to your application.

## What is an environment?

An environment on a Heartcore project can be defined as a _workspace_ and is at the same time a Git repository. When you have more than one environment on your project, these environments will act as branches of the main repository.

Umbraco Heartcore uses a deployment model that relies on Git and other core technology, which gives you the option to move both content and structure files from one environment to another.

Learn more about the deployment model in the[ Deployment workflow article](deployment-workflow/).

## Manage environments

How many environments you can work with depends on the [plan](https://umbraco.com/products/umbraco-heartcore/pricing/) your Umbraco Heartcore project is running.

When you upgrade your Heartcore project from the Starter to the Standard plan, it will be possible to add a Development environment. Once you've upgraded to the Professional plan, you will be able to add the Staging environment as well.

You can add and remove the environments any time you want, as long as you have multiple environments enabled.

Adding and removing environments is done from the Project page in the Cloud Portal.

{% hint style="info" %}
Please note you will need to restart environments after they have been set up or removed from your project. This is to ensure that the Umbraco Deploy configuration is updated.
{% endhint %}

Below is a screenshot of how the project page looks on the standard plan with only the Live environment. There's an option to add a Development environment. How this page looks is dependent on the plan your project is using.

<figure><img src="../.gitbook/assets/image (6).png" alt="Add new environment on Heartcore project."><figcaption><p>Add new environment on Heartcore project.</p></figcaption></figure>
