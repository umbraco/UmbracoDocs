# Launching Your Site

When you are about to go live with your website on Umbraco Cloud, there are a few things you might want to consider beforehand.

Below are a few suggestions that you might want to look into:

## [SMTP Settings on Umbraco Cloud](../build-and-customize-your-solution/set-up-your-project/project-settings/smtp-settings.md)

While you get a lot of fantastic features with Umbraco Cloud, SMTP server is not something that is available. There are many reasons for setting up an SMTP service on your Cloud project. For example, if you are working with Umbraco Forms.

Working with Umbraco Forms, allows you to set up email workflows that enable you to send emails through Forms - This requires an SMTP service. Another great use of SMTP service is if you want to add users to your project's Backoffice. The service requires SMTP to send the invitation from the project to the new user. This also applies to sending emails to users who have requested a password reset.

## [Manage Hostnames](manage-hostnames/)

When you create a project on Umbraco Cloud, the generated project URL is based on the project's name. You have the option to a custom hostname.

{% hint style="info" %}
Before adding a hostname, you need to update your DNS host domain registrar DNS entries to resolve to `umbraco.io`. We recommend setting a CNAME record for your site using the `dns.umbraco.io` Umbraco Cloud DNS record. You can read more about how to do this under [Manage Hostnames](manage-hostnames/).
{% endhint %}

## [Deploy to Live](../build-and-customize-your-solution/handle-deployments-and-environments/deployment/cloud-to-cloud.md)

The last step before your website goes live and is accessible to the public is to deploy it to the Live environment. When everything has been tested in the left-most mainline environment or locally, you are ready to deploy the site to your live environment and make it public.

{% hint style="info" %}

If you want to keep track of what goes on with your website after publishing, you can set up a [Deployment Webhook](../build-and-customize-your-solution/handle-deployments-and-environments/deployment/deployment-webhook.md). This is a great way to keep an eye on your project and it works great with [Slack](https://slack.com/).

{% endhint %}

{% hint style="info" %}
In Trial mode, by default, Public Access is disabled on all environments and cannot be enabled. As soon as a subscription is purchased, Public Access is enabled on the Live environment with the option to disable it again.
{% endhint %}
