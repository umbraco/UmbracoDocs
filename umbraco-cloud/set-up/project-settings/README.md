# Project Settings

When working with an Umbraco Cloud project, you can handle a lot of the project configuration directly in the Umbraco Cloud Portal. You can manage the following configurations from the left-side menu:

<figure><img src="../../.gitbook/assets/image (20).png" alt=""><figcaption><p>Settings menu</p></figcaption></figure>

## Overview

### **Environments**

See an overview of your environments for your project as well as access the frontend, backend, or clone down the environment.

<figure><img src="../../.gitbook/assets/image (58).png" alt=""><figcaption></figcaption></figure>

### **Team**

See who is added to your project, add new Team members, backoffice users and technical contacts, and pending invites.

<figure><img src="../../.gitbook/assets/image (59).png" alt=""><figcaption></figcaption></figure>



### Summary

You can view the **Summary** of your Umbraco Cloud project in the **overview** menu under Summary.

<figure><img src="../../.gitbook/assets/image (21).png" alt="Project Overview"><figcaption><p>Project Summary</p></figcaption></figure>

### [Edit team](team-members/)

Manage the team members and user permissions on your project. You can also view the backoffice user groups for each team member, view pending project invites, and manage [Technical contacts](team-members/technical-contact.md) for your project.

## Insights

### [Project History](project-history.md)

On the project history page, you can see a history of activities that have happened on your projects.

### [Availability & Performance](availability-performance.md)

You can see metrics related to the overall health and performance of the Azure app service hosting the live environment of your solution.

### [Usage](usage.md)

On your Umbraco Cloud project, it is possible to see the usage of Custom Domains, Media Storage, Content Nodes, and Bandwidth for the project. You can also check if it is using above or below the allowed amount for the plan that your project is on.

## Configuration

### [Connection details](../../databases/)

Find connection details to your Umbraco Cloud databases. You need to allow your IP to connect to the databases with your local machine.

### [Automatic Upgrades](../../product-upgrades/minor-upgrades.md)

We handle minor and patch upgrades for the Umbraco components used by Umbraco Cloud, so you don't have to. From the Automatic Upgrades page, you can control if you want to opt in or out of automatic minor upgrades.

New projects are opt-in by default.

### [CDN Caching and Optimization](manage-cdn-caching.md)

Manage CDN Cache settings for your project. You can modify default settings, which apply to all hostnames added to the current Project. Alternatively, you can set up specific settings per hostname, if you want to have different settings for certain hostnames.

### [Hostnames](manage-hostnames/)

Binding hostnames to your Umbraco Cloud project is done from the **Hostnames** section in the **Configuration** menu on the Umbraco Cloud Portal.

### [Management API Security](management-api-security.md)

Securing access to the back-end services of your Umbraco Cloud project can be set up from the **Hostnames** section in the **Configuration** menu on the Umbraco Cloud Portal.

### [Certificates](manage-hostnames/security-certificates.md) (Only available on **Professional** or **Enterprise** plan)

If you have your own custom certificate, you can upload and bind it to your custom hostnames. This can be done instead of using the TLS: Transport Layer Security (HTTPS) certificates provided by the Umbraco Cloud service.

### [Webhooks](../../deployment/deployment-webhook.md)

It is possible to configure a deployment webhook on your environments on Umbraco Cloud projects. This will be triggered upon successful deployments, you can configure where you would like information about the deployment to be posted.

### Advanced

Manage **Advanced** settings for your project from the **Configuration** tab:

* [CI/CD Flow](umbraco-cicd/)
* [Enable static outbound IP addresses](external-services.md#enabling-static-outbound-ip-addresses) for projects on a **Standard**, **Professional**, or **Enterprise** plan.
* Enable IIS logging for each of your environments. The log files can be accessed through kudu in `C:\home\LogFiles\http`. There is a rolling size limit on the log files of 100 MB. Once the limit is reached, the oldest log files will be overwritten by new ones.
* [Enable loading of a client certificate from the file system](application-settings.md#enable-client-certificate-loaded-from-file-system-explained).
* Change .NET framework runtime for your Umbraco installation for each environment of your cloud project.

{% hint style="info" %}
When enabling IIS logging, the site will have to restart. For more information about IIS logging, look at the [Official Microsoft Documentation](https://docs.microsoft.com/en-us/iis/configuration/system.webserver/httplogging).
{% endhint %}

<figure><img src="../../.gitbook/assets/image (18).png" alt=""><figcaption><p>Advanced Settings</p></figcaption></figure>

### [Backups](../../databases/backups.md#backup-on-umbraco-cloud)

With this setting, it is possible to create a database backup of one or more of your cloud environments.

## Security

### [Public access](public-access.md)

{% hint style="info" %}
Public access is by default available for projects created after the 10th of January 2023.

The [Umbraco.Cloud.Cms.PublicAccess](https://www.nuget.org/packages/Umbraco.Cloud.Cms.PublicAccess) package can be installed to enable Public access for projects created before the 10th of January 2023.
{% endhint %}

You can deny access to your project with the Public access setting under the security tab.

Users who are not part of the project or whose IP has not been allowed will not be able to access the project.

You can disable/enable it with one click on the Public access page.

Access to manage Public access requires your project to be on the Standard plan or higher.

### [Transport Security](manage-security.md)

Manage transport security settings for your project. You can configure certain transport security options for all hostnames or specific hostnames within your project.

### [Secrets Management](secrets-management.md)

If your Umbraco Cloud project uses sensitive information such as API keys, encryption keys, and connection strings, it is recommended to store these as secrets.\


## Management

### Upgrade Plan

You can upgrade your project to a **Standard** or a **Professional** plan, from the **Settings** menu, depending on your needs. The option is not available if you are already on the specific plan or if you are running in **Trial** mode.

### Rename project

You can rename your Umbraco Cloud project from the **Management tab** in the menu.

<div align="left">

<figure><img src="../../.gitbook/assets/image (19).png" alt="Rename project"><figcaption><p>Rename project</p></figcaption></figure>

</div>

{% hint style="info" %}
If you are working locally, you need to update the origin of your local git repository to point to the new clone URL. Alternatively, you can make a fresh local clone of the project, once you’ve changed your project name.
{% endhint %}

### [Renaming the Project file and folder](../working-locally.md#renaming-the-project-files-and-folders)

You can rename your project from the **Rename Project** section in the **Management tab** menu on the Umbraco Cloud Portal. When you rename a project, the default hostnames and clone URLs assigned to the project are updated to match the new project name. You can also rename your project files and folders locally.

### [Dedicated Resources](dedicated-resources.md)

You can change your Umbraco Cloud project to run in a dedicated setup with additional computational resources compared to the shared setup. You can choose between the different dedicated options depending on the number of resources you will need for your project.

### Delete Project

You can delete your Umbraco Cloud project from the **Management tab** menu. Deleting your Umbraco Cloud project is permanent - all data, media, databases, configuration, setup, and domain bindings are removed in the process.

{% hint style="info" %}
Deleting your Umbraco Cloud project will also cancel any subscriptions you have set up for the project.
{% endhint %}
