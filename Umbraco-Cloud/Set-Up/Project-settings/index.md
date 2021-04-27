---
versionFrom: 7.0.0
---

# Project settings

When working with an Umbraco Cloud project you can handle a lot of the project configuration directly in the Umbraco Cloud Portal.

The things you can configure include hostnames / domains, SSL certificates, database connections and deployment webhooks.

![settings](images/project-settings.png)

## [Edit team](../Team-Members)

From this page you can manage the team members on your project.

This is also where you need to go, to add a [Technical contact](../Team-Members/Technical-Contact.md) to your project.

## [Connection details](../../Databases)

This is where you go to find connection details to your Umbraco Cloud databases.

You will need to allow your IP in order to connect to the databases with your local machine - this can also be done from this page.

## [Hostnames](../Manage-Hostnames)

Binding hostnames to your Umbraco Cloud project is done from the Umbraco Cloud Portal - the page is called **Hostnames**.

## [Certificates](../Manage-Hostnames/Security-Certificates)

Sometimes you might want to upload and bind your own custom security certificate to your hostnames instead of using the TLS (HTTPS) certificates provided by the Umbraco Cloud service. This can be done from the **Certificates** page.

## Public access

All Staging and Development environments on Umbraco Cloud projects are by default protected by *basic authentication* which require you to enter your Cloud credentials in order to view the frontend. You can disable / enable this authentication with one click on the **Public access** page.

:::note
Access to disabling/enabling basic authentication requires your project to be on the Standard plan or higher.

On **Trial** projects, the basic authentication is enabled on the Live environment and cannot be removed unless the project is upgraded to a paid plan.

Should you for some reason still have basic authentication enabled on your Live environment after upgrading your Trial, please reach out to our friendly support team, who will be able to help you move forward.
:::

On the **Public access** page you can also allow IPs which will allow for viewing the frontend of the Staging and/or Development environments when accessed from the allowed IPs.

## [Webhooks](../../Deployment/Deployment-webhook)

On Umbraco Cloud projects we've made it possible to configure a deployment webhook on your environments. This will be triggered upon successful deployments, you can configure where you would like information about the deployment to be posted.

## Upgrade to a standard or professional plan

From the *Settings* menu you can upgrade your project to a standard or a Professional plan, depending on your needs.

The option will not be available if you are already on the specific plan or if you are running in Trial mode.

## Payment

From here you can see the payment history for your roject, change the credit card, as well as download the latest invoices or for a specific month.

:::note
This only applies to new customers on Umbraco Cloud, for old projects, the invoices and payment history is still available from the [Umbraco Shop](https://shop.umbraco.com/profile/sign-in).
:::

## [Usage](../Usage/)

On your Umbraco Cloud project, we've made it possible to see the usage of content nodes, custom hostnames and media storage for your project. You are also able to check if it is using above or below the allowed amount for the plan that your project is on.

## Advanced settings

In the *Settings* menu you have the option to enable advanced settings for your project.

You can enable IIS logging for each of your environments through here.

The log files can be accessed through kudu in `C:\home\LogFiles\http`

There is a rolling size limit on the log files of 100 MB. This means that once the limit is reached, the oldest log files will be overwritten by new ones.

Be aware when enabeling IIS logging the site will have to restart.

For more information about IIS logging look at the [Official Microsoft Documentation](https://docs.microsoft.com/en-us/iis/configuration/system.webserver/httplogging).

## Renaming and deleting

You might need to rename your Umbraco Cloud project - find the option to do that from the *Settings* menu.

:::note
If you are working locally you need to update the origin of your local git repository to point to the new clone url. Alternatively you can make a fresh local clone of the project, once you’ve changed your project name.
:::

If you want to delete your Umbraco Cloud project you can find the option to do this from the *Settings* menu as well. Deleting your Umbraco Cloud project is permanent - all data, media, databases, configuration, setup, and domain bindings are removed in the process.

:::note
Deleting your Umbraco Cloud project will also cancel any subscriptions you have set up for the project.
:::
