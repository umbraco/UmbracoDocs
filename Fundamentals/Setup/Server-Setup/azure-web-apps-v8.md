---
versionFrom: 8.0.0
---

# Running Umbraco on Azure Web Apps

_This section describes best practices with running Umbraco on Azure Web Apps_

## What are Azure Web Apps

They have been called a few names in the past, many people still know Azure Web Apps as Azure Web Sites.

> App Service is a fully Managed Platform for professional developers that brings a rich set of capabilities to web, mobile and integration scenarios. Quickly create and deploy mission critical web Apps that scale with your business by using Azure App Service.

[You can read more about them here](https://azure.microsoft.com/en-us/documentation/articles/app-service-web-overview/)

Umbraco will run on Azure Web Apps but there are some configuration options and specific Azure Web Apps environment limitations you need to be aware of.

## Recommended configuration

You need to add these `appSettings`:

```xml
<add
    key="Umbraco.Core.MainDom.Lock"
    value="SqlMainDomLock" />
<add
    key="Umbraco.Core.LocalTempStorage"
    value="EnvironmentTemp" />
<add
    key="Umbraco.Examine.LuceneDirectoryFactory"
    value="Examine.LuceneEngine.Directories.SyncTempEnvDirectoryFactory, Examine" />
```

You should also add an appsetting `WEBSITE_DISABLE_OVERLAPPED_RECYCLING` with a value of 1 to your Azure WebApp (not this needs to be added to the App configuration via the Azure portal and not via Web.config. This setting prevents Umbraco from starting on an instance before a shutdown is complete - which is important as Umbraco in Azure needs to acquire an exclusive `MainDom` lock in order to start.

You may also want add a setting `WEBSITE_ADD_SITENAME_BINDINGS_IN_APPHOST_CONFIG` with a value of 1 to your Azure WebApp. Although not required, this may help minimise app restarts during deployments. More details can be found in this post: https://ruslany.net/2019/06/azure-app-service-deployment-slots-tips-and-tricks/

:::note
The `Umbraco.Core.MainDom.Lock` setting is for Umbraco 8.6+. Having this setting for versions between 8.0-8.5 will not have any affect. It is recommended to use 8.6+ when running Umbraco on Azure Web Apps since this setting will prevent file locking issues.
:::

__The minimum recommended Azure SQL Tier is "S2"__, however noticeable performance improvements are seen in higher Tiers. If Umbraco uses all of the available database DTU during startup it may fail to start, or prevent other instances from starting. If Umbraco can't query the database then it can't obtain a `MainDom` lock in order to start.  
In the worst case scenario Umbraco may end up in a application recycling loop trying to acquire this lock. Ensure that your database scaling is sufficient for the number of instances and volume of content that you have.

__If you are load balancing or require the scaling ("scale out") ability of Azure Web Apps then you need to consult the
[Load Balancing documentation](Load-Balancing/index.md)__ since there is more that needs to be configured to support scaling/auto-scaling.

## Storage

It is important to know that Azure Web Apps uses a remote file share to host the files to run your website (i.e. the files running your website do not exist on the machine running your website). In many cases this isn't an issue but it can become one if you have a large amount of IO operations running over remote file share.

## Scaling

If you require the scaling ("scale out") ability of Azure Web Apps then you need to consult
the [Load Balancing documentation](Load-Balancing/index.md) since there is a lot more that needs
to be configured to support scaling/auto-scaling.

## Web worker migrations

It's important to know that Azure Web Apps may move your website between their 'workers' at any given time. This is normally a transparent operation but in some cases you may be affected by it if any of your code or libraries use the following variables:

* `Environment.MachineName` (or equivalent)
* `HttpRuntime.AppDomainAppId` (or equivalent)

When your site is migrated to another worker, these variables will change.
You cannot rely on these variables remaining static for the lifetime of your website.

## Deployment

When deploying to an Azure WebApp using a CI/CD server, it is recommended to stop the webapp prior to the deployment and start it again post deployment. This avoids multiple app restarts as files are deployed to app service. Multiple restarts can potentially cause file locking issues.
