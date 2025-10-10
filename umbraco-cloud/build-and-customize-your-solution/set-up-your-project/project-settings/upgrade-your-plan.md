# Upgrade your Plan

This article discusses how to upgrade your Umbraco Cloud plan and important considerations to keep in mind.

## Before you upgrade your plan

Before you decide to upgrade your Umbraco Cloud plan, you need to consider a few things:

* Changing a plan for a project will change the outgoing IP of the project. If your solution has an external service that requires whitelisting the outgoing IP of the project, please visit the documentation for [external services](../../../expand-your-projects-capabilities/external-services/) prior to the upgrade.
* If you are on the Starter plan, you can either upgrade your plan to a Standard or a Professional plan.
* On the Standard plan, you have the option to upgrade to a professional plan.
* Before upgrading, make sure to check the [price difference](https://umbraco.com/umbraco-cloud-pricing) and the features you get on the new plan.

{% hint style="warning" %}

When upgrading your plan (for example, from Starter to Standard), log files such as trace logs will not be transferred to the new environment.

If you need to retain log history, make sure to download and back up the log files before upgrading. For more information on accessing the logs, see the [Log files](../../../optimize-and-maintain-your-site/monitor-and-troubleshoot/resolve-issues-quickly-and-efficiently/log-files.md) article.

{% endhint %}

## How to upgrade your plan

The first step to upgrading your Umbraco Cloud plan is to access your project in the project overview at [Umbraco.io](https://www.s1.umbraco.io/projects).

* In the project overview, you can find all the projects that you have been invited to or have created.
* From here you need to find the project that you want to upgrade the plan.

Under the project on the right side, you have a dropdown menu called settings:

<figure><img src="../../../.gitbook/assets/image (25).png" alt="Upgrade plan menu tab"><figcaption><p>Upgrade plan menu tab</p></figcaption></figure>

In the menu, you can find a tab called _"Upgrade plan"_.

* Clicking on the tab will direct you to the overview of the plans that you can upgrade to.
* From here you can see the different plans, the price per month, and the limitations between each of the plans.

![Upgrade plane step2](images/umbraco-cloud-plans-new.png)

* If you are on a Starter plan you can upgrade to the Standard and the Professional plan.
* If you are on the Standard plan you can upgrade to the Professional plan.

Follow the below steps to upgrade your plan:

1. Click on the **Select Plan** button to choose the plan you want to upgrade to.
2. _[Optional]_ Choose to upgrade to a **dedicated option** in the next step.

    <div align="left"><figure><img src="images/dedicated-option.png" alt=""><figcaption><p>Dedicated option on Cloud</p></figcaption></figure></div>
3. Review the **Summary** to make sure that everything selected is correct in the last step.

    <figure><img src="images/upgrade-summary.png" alt=""><figcaption><p>Summary of project upgrade.</p></figcaption></figure>

Once you click the **Upgrade Project** button, the project will be upgraded to the new plan and if selected to a dedicated server.

{% hint style="info" %}
The change in price will take effect from the next period of your subscription.

Are you changing the plan in the middle of the month? The time from that date until the start of the next subscription period will be added to the next invoice.
{% endhint %}

{% hint style="info" %}
When upgrading or downgrading the plan, the ID of your project will be appended with a `-1`. If there is already a `-1`, it will be removed. If you use this ID anywhere, you might need to change the ID in that location.
{% endhint %}

## Automatic plan upgrades

If your project exceeds usage limits, you'll be automatically upgraded to a suitable plan to keep your website running smoothly.

We will send an email to the project owner and the technical contact(s) to inform them about this update. The upgrade to a new plan will be reflected in your next bill and will take effect from the date of the upgrade.

Once you are upgraded to a new plan, you also get access to all the features that are included in that plan. [Check out the list of features for the Umbraco Cloud plans](https://umbraco.com/umbraco-cloud-pricing/).

## Downgrade your plan

If you would like to downgrade your plan, you can do so by first lowering your data usage limit to match the desired plan.

Once you have adjusted your data usage, contact Umbraco Support for assistance with the downgrade. Keep in mind that when you downgrade to a lower plan, the changes will take effect immediately. This means your usage limits will be reduced, and any extra features associated with your previous plan will be deactivated. You will continue to be billed for the old plan until your next scheduled billing date.

If you have any questions regarding this process, feel free to reach out to [Umbraco Support](mailto:contact@umbraco.com).
