---
versionFrom: 7.0.0
---

# Going Live
When you are about to go live with your website on Umbraco Cloud there are a few things you might want to consider beforehand.

Below are a few suggestions that you might want to look into.

## [SMTP Settings](../SMTP-settings)
While you get a lot of fantastic features with Umbraco Cloud, an SMTP server is not something that is available. There are many reasons for setting up an SMTP service on your Cloud project. An example could be if you are working with Umbraco Forms. 

Working with Umbraco Forms allows you to set up email workflows which will enable you to send emails through Forms - This requires an SMTP service. Another great use of an SMTP service is if you want to add users to your projects Backoffice. The service requires SMTP to be able to send the invitation from the project to the new user. This also applies to send emails to users who have requested a password reset. 

## [Add or Configure Hostnames](../Manage-Hostnames)
When you create a project on Umbraco Cloud we will generate the project URL based on the project's name and that might not be the preferred URL for your website. Therefore, you have the option to add your own hostname.

:::note
Before adding a hostname, you need to update your DNS host domain registrar DNS entries to resolve to umbraco.io. We recommend setting a CNAME record for your site's root domain - YourProject.s1.umbraco.io
:::

## [Deploy to Live](../../Deployment/Cloud-to-Cloud)
The last step before your website is live and accessible to the public is deploying it to the Live environment. When everything has been tested on your development environment or locally you are ready to deploy the site to your live environment and making it public.

:::tip
If you would like to keep track of what goes on with your website after it has gone live you can set up a [deployment webhook](../../Deployment/Deployment-Webhook). This is a great way to keep an eye on your project and it works great with [Slack](https://slack.com/).
:::

:::note
In Trial mode, Public Access is disabled on all environments as a default and cannot be enabled. As soon as a subscription has been purchased, Public Access is enabled on Live with the option to disabled it again.
:::
