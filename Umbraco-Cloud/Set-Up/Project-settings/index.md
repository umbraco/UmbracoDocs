---
versionFrom: 9.0.0
versionTo: 10.0.0
---

# Project Settings

When working with a Umbraco Cloud project, you can handle a lot of the project configuration directly in the Umbraco Cloud Portal. You can manage the following configurations from the **Settings** dropdown:

- View Project Overview
- Team Members
- Database Connection Details
- Hostnames/Domains
- Security Settings
- Content Delivery Network (CDN) Caching and Optimizations
- Deployment Webhooks
- Secure Sockets Layer (SSL) certificates
- Upgrade Plan
- Rename Project
- Advanced Settings
- Project Usage
- Dedicated Resources
- Delete the project.

![settings](images/project-settings-v10.png)

## Overview

You can view the **Overview** of your Umbraco Cloud project from the **Settings** menu.

![Project Overview](images/project-overview-1.png)

## [Edit team](../Team-Members)

Manage the team members and user permissions on your project. You can also view the backoffice user groups for each team member, view pending project invites, and manage [Technical contacts](../Team-Members/Technical-Contact.md) for your project.

## [Connection details](../../Databases)

Find connection details to your Umbraco Cloud databases. You need to allow your IP to connect to the databases with your local machine.

## [Hostnames](../Manage-Hostnames)

Binding hostnames to your Umbraco Cloud project is done from the **Hostnames** section in the **Settings** menu on the Umbraco Cloud Portal.

## [Security](../Manage-Security)

Manage transport security settings for your project. You can configure certain transport security options for all hostnames or specific hostnames within your project.

## [CDN Caching and Optimization](../Manage-CDN-Caching/index.md)

Manage CDN Cache settings for your project. You can modify default settings, which apply to all hostnames added to the current Project. Alternatively, you can setup specific settings per hostname, if you want to have different settings for certain hostnames.

## [Certificates](../Manage-Hostnames/Security-Certificates) (Only available on **Professional** or **Enterprise** plan)

If you have your own custom certificate, you can upload and bind it to your custom hostnames. Instead of using the Transport Layer Security (TLS)/HTTPS certificates provided by the Umbraco Cloud service.

## Public access

Staging and Development environments on Umbraco Cloud projects can be protected by basic authentication. It requires you to enter your Cloud credentials in order to view the frontend.

You can disable/enable it with one click on the Public access page.

Access to manage the basic authentication requires your project to be on the Standard plan or higher.

## [Webhooks](../../Deployment/Deployment-webhook)

It is possible to configure a deployment webhook on your environments on Umbraco Cloud projects. This will be triggered upon successful deployments, you can configure where you would like information about the deployment to be posted.

## Upgrade Plan

You can upgrade your project to a **Standard** or a **Professional** plan, from the **Settings** menu, depending on your needs. The option is not available if you are already on the specific plan or if you are running in **Trial** mode.

## Rename project

### Renaming the Cloud Project

You can rename your Umbraco Cloud project from the **Settings** menu.
![settings](images/renaming-project-v10.png)

:::note
If you are working locally, you need to update the origin of your local git repository to point to the new clone URL. Alternatively, you can make a fresh local clone of the project, once you’ve changed your project name.
:::

### [Renaming the Project file and folder](https://our.umbraco.com/documentation/Umbraco-Cloud/Set-Up/Working-Locally/#renaming-the-project-files-and-folders)

You can rename your project from the **Rename Project** section in the **Settings** menu on the Umbraco Cloud Portal. When you rename a project, the default hostnames and clone URLs assigned to the project are updated to match the new project name. You can also rename your project files and folders locally.

## Advanced

Manage **Advanced** settings for your project from the **Settings** menu:

- [Enable static outbound IP addresses](../External-Services) for projects on a **Standard**, **Professional**, or **Enterprise** plan.
- Enable IIS logging for each of your environments. The log files can be accessed through kudu in `C:\home\LogFiles\http`. There is a rolling size limit on the log files of 100 MB. Once the limit is reached, the oldest log files will be overwritten by new ones.

    :::note
    When enabling IIS logging, the site will have to restart. For more information about IIS logging, look at the [Official Microsoft Documentation](https://docs.microsoft.com/en-us/iis/configuration/system.webserver/httplogging).
    :::

- [Enable loading of a client certificate from the file system](../Application-Settings/index.md#enable-client-certificate-loaded-from-file-system-explained).
- Change .NET framework runtime for your Umbraco installation for each environment of your cloud project.

![Advanced Settings](images/Advanced-Settings.png)

## [Dedicated Resources](../Dedicated-Resources/index.md)

You can change your Umbraco Cloud project to run in a dedicated setup with additional computational resources compared to the shared setup. You can choose between the different dedicated options depending on the number of resources you will need for your project.

## [Usage](../Usage/)

On your Umbraco Cloud project, it is possible to see the usage of Custom Domains, Media Storage, Content Nodes, and Bandwidth for your project. You can also check if it is using above or below the allowed amount for the plan that your project is on.

## [Payment](../Manage-Subscriptions/new-shop.md)

From here, you can see the payment history for your project, change the credit card, as well as download the latest invoices for your project.

:::note
This only applies to new customers on Umbraco Cloud after the 28th of April, 2021. For old projects, the invoices and payment history are still available from the [Umbraco Shop](https://shop.umbraco.com/profile/sign-in).
:::

### Delete Project

You can delete your Umbraco Cloud project from the **Settings** menu. Deleting your Umbraco Cloud project is permanent - all data, media, databases, configuration, setup, and domain bindings are removed in the process.

:::note
Deleting your Umbraco Cloud project will also cancel any subscriptions you have set up for the project.
:::
