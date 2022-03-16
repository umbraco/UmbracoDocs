---
versionFrom: 9.0.0
---

# Project Settings

When working with an Umbraco Cloud project, you can handle a lot of the project configuration directly in the Umbraco Cloud Portal. You can manage team members, database connections, hostnames/domains, security settings, SSL certificates, deployment webhooks, upgrade plan, project usage, advanced settings, rename, or delete the project.

![settings](images/project-settings-v9.png)

## Overview

You can view the **Overview** of your Umbraco Cloud project from the **Settings** menu.

![Project Overview](images/project-overview.png)

## [Edit team](../Team-Members)

Manage the team members on your project. You can also view the backoffice user groups for each team member, add a [Technical contact](../Team-Members/Technical-Contact.md), or add an [Account contacts](../Team-Members/Accounts-Contact.md) for your project.

## [Connection details](../../Databases)

Find connection details to your Umbraco Cloud databases. You need to allow your IP in order to connect to the databases with your local machine.

## [Hostnames](../Manage-Hostnames)

Binding hostnames to your Umbraco Cloud project is done from the **Hostnames** section in the **Settings** menu on the Umbraco Cloud Portal.

## [Security](../Manage-Security)

Manage transport security settings for your project. You can configure certain transport security options for all hostnames or for specific hostnames within your project.

## [Certificates](../Manage-Hostnames/Security-Certificates) (Only available on **Professional** or **Enterprise** plan)

Used to upload and bind your own custom security certificate to your hostnames instead of using the TLS (HTTPS) certificates provided by the Umbraco Cloud service.

## [Webhooks](../../Deployment/Deployment-webhook)

On Umbraco Cloud projects, it is possible to configure a deployment webhook on your environments. This will be triggered upon successful deployments, you can configure where you would like information about the deployment to be posted.

## Upgrade Plan

You can upgrade your project to a **Standard** or a **Professional** plan, from the **Settings** menu, depending on your needs. The option is not available if you are already on the specific plan or if you are running in **Trial** mode.

## Rename project

### Renaming the Cloud Project

You can rename your Umbraco Cloud project from the **Settings** menu.
![settings](images/renaming-project.png)

:::note
If you are working locally, you need to update the origin of your local git repository to point to the new clone url. Alternatively, you can make a fresh local clone of the project, once you’ve changed your project name.
:::

### Renaming the Project file and folder

To rename your Umbraco Cloud project files and folder, do the following:

1. Navigate to the `.umbraco` file at the root of the project and view the following:

    ```csharp
    [project]
    base = "src/UmbracoProject"
    csproj = "UmbracoProject.csproj"
    ```

    The `base` property provides the folder location which contains the application and the `csproj` property is the name of the .csproj file.

2. Rename the `UmbracoProject` directory and `.csproj` file.

3. Update the `.umbraco` file with the new name and any C# code namespaces reflecting the name of your project.

4. Additionally, if you prefer to organise your code, you can add additional Class Library projects that are referenced by the Umbraco application .csproj file.

   For example: Rename `UmbracoProject.csproj` to `MyAwesomeProject.Web.csproj` and have one or more additional class library projects such as `MyAwesomeProject.Code.csproj`

    ```csharp
    [project]
    base = "src/MyAwesomeProject/MyAwesomeProject.Web"
    csproj = "MyAwesomeProject.Web.csproj"
    ```

:::note
Its a good idea to update the namespace used in the `Program.cs`, `Startup.cs` and `_ViewImports.cshtml` files so the naming is consistent throughout your project structure. Once updated, you will need to clear out the `bin` and `obj` folders locally to avoid build errors. When you are done, commit the changes and push them to Cloud.
:::

## Advanced

Manage **Advanced** settings for your project from the **Settings** menu:

- [Enable static outbound IP addresses](../External-Services) for projects on a **Standard**, **Professional**, or **Enterprise** plan.
- Enable IIS logging for each of your environments. The log files can be accessed through kudu in `C:\home\LogFiles\http`. There is a rolling size limit on the log files of 100 MB. Once the limit is reached, the oldest log files will be overwritten by new ones.

    :::note
    When enabling IIS logging, the site will have to restart. For more information about IIS logging look at the [Official Microsoft Documentation](https://docs.microsoft.com/en-us/iis/configuration/system.webserver/httplogging).
    :::

## [Payment](../Manage-Subscriptions/new-shop.md)

From here, you can see the payment history for your project, change the credit card, as well as download the latest invoices for your project.

:::note
This only applies to new customers on Umbraco Cloud after the 28th of April, for old projects, the invoices and payment history is still available from the [Umbraco Shop](https://shop.umbraco.com/profile/sign-in).
:::

## [Usage](../Usage/)

On your Umbraco Cloud project, it is possible to see the usage of Custom Domains, Media Storage, Content Nodes, and Bandwidth for your project. You can also check if it is using above or below the allowed amount for the plan that your project is on.

### Delete Project

You can delete your Umbraco Cloud project from the **Settings** menu. Deleting your Umbraco Cloud project is permanent - all data, media, databases, configuration, setup, and domain bindings are removed in the process.

:::note
Deleting your Umbraco Cloud project will also cancel any subscriptions you have set up for the project.
:::
