---
versionFrom: 8.0.0
---

# Move your Umbraco Cloud project to dedicated resources

*Dedicated Resources* is a feature on Umbraco Cloud that gives you the option to move your project to a dedicated server. You can choose between a number of *dedicated options* depending on the amount of resources you will need for your project.

In this article, you can read about how you can move your Umbraco Cloud project to dedicated resources and what you need to be aware of before you do so.

## Before you move your project to dedicated resources

Before you decide to move your Umbraco Cloud project, you need to consider a few things:

- Umbraco Cloud offers dedicated resources for Starter, Standard, and Professional plans. You can choose among one dedicated option for projects on a Starter plan, two dedicated options for a Standard plan project, and three dedicated options for a Professional plan project.

- Moving from a shared resource to a dedicated resource will change the outgoing IP of the project. If your solution has an external service that requires whitelisting the outgoing IP, we advise you to enable the static outbound IP feature for your project and share that static outbound IP address with the third party. The static outbound IP address will not change when moving from a shared resource to a dedicated resource. For more info on static lease visit the documentation for [external services](https://our.umbraco.com/documentation/Umbraco-Cloud/Set-Up/External-Services/).


## How to move from shared to dedicated

The first step in moving to a dedicated resource is to access your project in the project overview at [Umbraco.io](https://www.s1.umbraco.io/projects).

- Find and select the project that you want to move to dedicated resources.

- Select *Dedicated Resources* from the *Settings* menu.

![Upgrade plan step 1a](images/Step1a.png)

- There are currently three dedicated options for you to choose from the Professional plan, two dedicated options from the Standard plan, and one dedicated option from the Starter plan. For each of the dedicated options, you will find its name, the memory and CPU cores, and the price per month.

![Upgrade plan step 2a](images/Step2a.png)

- By hitting the "Upgrade" button on your dedicated option of choice and confirming this, you will be redirected to the project page where you will be notified when the move to a dedicated resource has been completed.

:::note 
Dedicated resources are reserved on a per-month basis.
The price of the dedicated resource will take effect from the next period of your subscription.
If you move your Cloud project to a dedicated resource in the middle of the month, the time from that date until the start of the next subscription period, will be added to the next invoice. 
:::

## How to move from dedicated to shared

Moving away from dedicated resources and back to shared can be done from the *Dedicated Resources* page.

![Downgrade](images/DowngradeA.png)

- By hitting "Downgrade to shared" and confirming your choice, you will be redirected to the project page where you will be notified when the move back to a shared resource has been completed.

- Your Cloud project is now back on a shared resource.

If you have any questions regarding dedicated resource, feel free to reach out to [Umbraco Support](mailto:contact@umbraco.com).
