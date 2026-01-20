# Project Settings

When working with an Umbraco Cloud project, you can handle the project configuration directly in the Umbraco Cloud Portal. You can manage the following configurations from the left-side menu:

![Settings menu](images/settings-menu.png)

## Overview

### Environments

The Environments section provides an overview of your project’s environments. Here, you can:

* Access the Website (frontend) and backend,
* Open Kudu, and
* Clone down the environment locally.

![Environments Overview](../../../.gitbook/assets/environments-overview-new.png)

#### Environment error log

Each environment has an error log that appears only if there are any unread errors in that specific environment. You can view the errors by clicking on **Error logs** in the environment menu.

In the Error logs page, you can manually mark each error as read which will move it from the "New" section to the "Read" section. Errors marked as read will be permanently deleted after 30 days.

During development, too many errors can slow down the error page. To fix this, connect to the environment's database locally and delete the errors. Learn how to connect to the database in the [Database on Umbraco Cloud](../databases/cloud-database/) section.

Environment errors are stored in the `UCErrorLog` table.

The query below deletes 90% of the errors. The query always deletes the oldest errors first. You can tweak the query to delete any percentage of errors by changing the number in the first row.

```sql
DELETE TOP(90) PERCENT
  FROM [dbo].[UCErrorLog]
  WHERE [Read] = 0
```

### Team

The Team section allows you to:

* Manage team members and their permissions on different environments.
* Add new team members.
* Manage backoffice user groups and [Technical contacts](../../../begin-your-cloud-journey/project-features/team-members/technical-contact.md) for your project.
* Monitor pending project invitations.

<figure><img src="../../../.gitbook/assets/image (59).png" alt=""><figcaption></figcaption></figure>

### Summary

The **Summary** section displays key information such as the project plan, the region where the project was created, payment status, and more.

![Project Summary](images/summary-details.png)

## Insights

### [Project History](../../../optimize-and-maintain-your-site/monitor-and-troubleshoot/project-history.md)

In the Project History section, you can view a list of high-level activities for your cloud project.

![Project History](images/project-history.png)

### [Availability & Performance](../../../optimize-and-maintain-your-site/monitor-and-troubleshoot/availability-performance.md)

You can see metrics related to the overall health and performance of the Azure app service hosting the different environments of your solution.

![Availability & Performance](images/availability-performance.png)

### [Usage](../../../optimize-and-maintain-your-site/monitor-and-troubleshoot/usage/)

The Usage section allows you to:

* View the usage of Custom Domains, Media Storage, Bandwidth, and Bandwidth History for your project.
* Check whether the project is using above or below the allowed amount for its plan.
* View the top 10 bandwidth usage paths, referrers, and the top 50 media files.

![Usage](images/usage-new.png)

## Configuration

### [Connections](../databases/)

The Connections section provides connection details for your Umbraco Cloud databases. You need to allow your IP to connect to the databases with your local machine.

![Connections](images/connections.png)

### [Automatic Upgrades](../../../optimize-and-maintain-your-site/manage-product-upgrades/product-upgrades/minor-upgrades.md)

The Automatic Upgrades section handles minor upgrades for the Umbraco components used by Umbraco Cloud. By default, new projects are opt-in for these upgrades.

From this page, you can manage whether your site is automatically upgraded to the latest minor version(s) of the Cloud products. To learn more about automatic upgrades, visit the [Upgrades](../../../optimize-and-maintain-your-site/manage-product-upgrades/product-upgrades/) section.

![Automatic Upgrades](images/automatic-upgrades.png)

### [Content Delivery Network (CDN) and Caching](../../../optimize-and-maintain-your-site/optimize-performance/manage-cdn-caching.md)

The CDN and Caching section lets you manage CDN Caching and Optimization settings for your project. You can:

* Modify the default settings that apply to all hostnames added to the project.
* Set specific caching settings per hostname if different configurations are required for certain hostnames.
* Purge Cache for individual hostnames or all of them.

![CDN & Caching](images/cdn-caching.png)

### [Hostnames](../../../go-live/manage-hostnames/)

In the Hostnames section, you can bind hostnames to your Umbraco Cloud project.

![Hostnames](images/hostnames.png)

### [Webhooks](../../handle-deployments-and-environments/deployment/deployment-webhook.md)

You can configure deployment webhooks for your environments in this section. Webhooks are triggered upon successful deployments, and you can specify where the deployment information is sent.

![Webhooks](images/webhooks.png)

### Advanced

The Advanced section provides options for managing advanced settings for your project, including:

* [Umbraco CI/CD Flow](../../handle-deployments-and-environments/umbraco-cicd/)
* [Enable static outbound IP addresses](../../../expand-your-projects-capabilities/external-services/#enabling-static-outbound-ip-addresses) for projects on **Standard**, **Professional**, or **Enterprise** plans.
* Enable IIS logging for each environment. The log files can be accessed in Kudu at `C:\home\LogFiles\http`. IIS logs have a rolling size limit of 100 MB, overwriting the oldest files once the limit is reached.
* [Enable loading of a client certificate from the file system](application-settings.md#enable-client-certificate-loaded-from-file-system-explained).
* Change the .NET framework runtime for each environment of your Umbraco Cloud project.
* Change the value of the `DOTNET_ENVIRONMENT` environment variable for each environment of your Umbraco Cloud project. To learn more about working with multiple environments in ASP.NET Core, refer to the [Microsoft Documentation](https://learn.microsoft.com/en-us/aspnet/core/fundamentals/environments?view=aspnetcore-9.0).

{% hint style="info" %}
Enabling IIS logging will cause the site to restart. For additional information, refer to the [Microsoft Documentation](https://docs.microsoft.com/en-us/iis/configuration/system.webserver/httplogging).
{% endhint %}

{% hint style="info" %}
Changing the .NET framework runtime or the `DOTNET_ENVIRONMENT` environment variable will also cause your website to restart.
{% endhint %}

{% hint style="info" %}
When using `WebApplication`, `DOTNET_ENVIRONMENT` takes precedence over `ASPNETCORE_ENVIRONMENT`. When using the legacy `WebHost`, `ASPNETCORE_ENVIRONMENT` takes precedence instead.

You can also override the environment value by setting the `ASPNETCORE_ENVIRONMENT` variable in your `web.config` file.
{% endhint %}

![Advanced Settings](images/advanced-settings.png)

![Advanced Settings continued](images/advanced-settings-continued.png)

### [Backups](../databases/backups.md#backup-on-umbraco-cloud)

The Backups section enables you to create database backups for one or more of your cloud environments.

![Backups](images/backups.png)

## Security

### [Public Access](public-access.md)

{% hint style="info" %}
By default, Public access is available for projects created after the 10th of January 2023.

The [Umbraco.Cloud.Cms.PublicAccess](https://www.nuget.org/packages/Umbraco.Cloud.Cms.PublicAccess) package can be installed to enable Public access for projects created before the 10th of January 2023.
{% endhint %}

The Public access setting, found under the Security tab, allows you to deny access to your project. Users who are not part of the project or whose IP addresses have not been allowed will not be able to access the project.

You can enable or disable this setting on the Public access page. Access to manage Public access requires your project to be on the Standard plan or higher.

![Public Access](images/public-access.png)

### [Transport Security](../security/managing-transport-security.md)

The Transport Security section enables you to manage transport security settings for your project. You can configure specific transport security options for all hostnames or individual hostnames within your project.

![Transport Security](images/transport-security.png)

### [Management API Security](../../../optimize-and-maintain-your-site/monitor-and-troubleshoot/management-api-security.md)

The Management API Security section allows you to secure access to the backend services of your project. This can be managed from the Security menu on the Umbraco Cloud Portal.

![Management API Security](images/management-api-security.png)

### [Certificates](../../../go-live/manage-hostnames/security-certificates.md)

{% hint style="info" %}
This feature is only available on **Professional** or **Enterprise** plan.
{% endhint %}

If you have a custom certificate, you can upload and bind it to your custom hostnames. This can be done instead of using the TLS: Transport Layer Security (HTTPS) certificates provided by the Umbraco Cloud service.

![Certificates](images/certificates.png)

### [Secrets](../../../begin-your-cloud-journey/project-features/secrets-management.md)

The Secrets Management section is used for storing sensitive information such as API keys, encryption keys, and connection strings used by your Umbraco Cloud project.

![Secrets](images/secrets.png)

## Management

### [Dedicated Resources](dedicated-resources.md)

You can change your Umbraco Cloud project to run in a dedicated setup with additional computational resources compared to the shared setup. You can choose between different dedicated options depending on the number of resources you will need for your project.

![Dedicated Resources](images/dedicated-resources.png)

### Upgrade Project

You can upgrade your project to a **Standard** or a **Professional** plan from the **Management** menu, depending on your needs. The option is not available if you are already on a specific plan or if you are running in **Trial** mode.

![Upgrade Project](images/upgrade-project.png)

### Rename Project

You can rename your Umbraco Cloud project from the **Management** menu.

{% hint style="info" %}

If you are working locally, you need to update the origin of your local git repository to point to the new clone URL. Alternatively, you can make a fresh local clone of the project once you’ve changed your project name.

{% endhint %}

![Rename Project](images/rename-project.png)

#### [Renaming the Project file and folder](../../handle-deployments-and-environments/working-locally/#renaming-the-project-files-and-folders)

You can rename your project from the **Rename Project** section in the **Management** menu on the Umbraco Cloud Portal. When you rename a project, the default hostnames and clone URLs assigned to the project are updated to match the new project name. You can also rename your project files and folders locally.

### Delete Project

You can delete your Umbraco Cloud project from the **Management** menu. Deleting your Umbraco Cloud project is permanent - all data, media, databases, configuration, setup, and domain bindings are removed in the process.

{% hint style="info" %}
Deleting your Umbraco Cloud project will also cancel any subscriptions you have set up for the project.
{% endhint %}

![Delete Project](images/delete-project.png)
