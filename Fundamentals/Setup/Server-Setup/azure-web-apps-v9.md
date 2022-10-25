---
versionFrom: 9.0.0
versionTo: 9.3.0
---

# Running Umbraco on Azure Web Apps

_This section describes best practices with running Umbraco on Azure Web Apps_

## What are Azure Web Apps

They have been called a few names in the past, many people still know Azure Web Apps as Azure Web Sites.

> App Service is a fully Managed Platform for professional developers that brings a rich set of capabilities to web, mobile and integration scenarios. Quickly create and deploy mission critical web Apps that scale with your business by using Azure App Service.

[You can read more about them here](https://azure.microsoft.com/en-us/documentation/articles/app-service-web-overview/)

Umbraco will run on Azure Web Apps but there are some configuration options and specific Azure Web Apps environment limitations you need to be aware of.

## Recommended configuration

You need to add these configuration values. E.g in a json configuration source like `appSettings.json`:

```json
{
    "Umbraco": {
        "CMS": {
            "Global": {
                "MainDomLock" : "SqlMainDomLock"
            },
            "Hosting": {
                "LocalTempStorageLocation": "EnvironmentTemp"
            },
            "Examine": {
                "LuceneDirectoryFactory": "SyncedTempFileSystemDirectoryFactory"
            }
        }
    }
}
```

__The minimum recommended Azure SQL Tier is "S2"__, however noticeable performance improvements are seen in higher Tiers

__If you are load balancing or require the scaling ("scale out") ability of Azure Web Apps then you need to consult the
[Load Balancing documentation](Load-Balancing/index.md)__ since there is more that needs to be configured to support scaling/auto-scaling.

## Storage

It is important to know that Azure Web Apps uses a remote file share to host the files to run your website (i.e. the files running your website do not exist on the machine running your website). In many cases this isn't an issue but it can become one if you have a large amount of IO operations running over remote file share.

## Issues with read-only filesystems

Although Umbraco can be configured to use environmental storage it still requires its working-directory to be writable. If Umbraco is deployed to a read-only file system it will [fail to boot](https://github.com/umbraco/Umbraco-CMS/issues/12043).

For example, Azure's [Run from Package feature](https://docs.microsoft.com/en-us/azure/app-service/deploy-run-package) is not supported by Umbraco. To check if your web app is using this feature you can check the `WEBSITE_RUN_FROM_PACKAGE` environment variable.

## Scaling

If you require the scaling ("scale out") ability of Azure Web Apps then you need to consult
the [Load Balancing documentation](Load-Balancing/index.md) since there is a lot more that needs
to be configured to support scaling/auto-scaling.

## Web worker migrations

It's important to know that Azure Web Apps may move your website between their 'workers' at any given time. This is normally a transparent operation but in some cases you may be affected by it if any of your code or libraries use the following variables:

* `Environment.MachineName` (or equivalent)

When your site is migrated to another worker, these variables will change.
You cannot rely on these variables remaining static for the lifetime of your website.
