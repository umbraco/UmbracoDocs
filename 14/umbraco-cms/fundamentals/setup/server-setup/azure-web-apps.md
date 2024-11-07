# Running Umbraco On Azure Web Apps

This section describes best practices with running Umbraco on Azure Web Apps

## What are Azure Web Apps

They have been called a few names in the past, many people still know Azure Web Apps as Azure Web Sites.

> App Service is a fully Managed Platform for professional developers that brings a rich set of capabilities to web, mobile and integration scenarios. Quickly create and deploy mission critical web Apps that scale with your business by using Azure App Service.

[You can read more about them here](https://azure.microsoft.com/en-us/documentation/articles/app-service-web-overview/)

Umbraco will run on Azure Web Apps but there are some configuration options and specific Azure Web Apps environment limitations to be aware of.

## Recommended configuration

You need to add these configuration values. E.g in a json configuration source like `appSettings.json`:

```json
{
    "Umbraco": {
        "CMS": {
            "Global": {
                "MainDomLock" : "FileSystemMainDomLock"
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
You can also copy the following JSON directly into your Azure Web App configuration via the Advanced Edit feature.
![image](https://github.com/umbraco/UmbracoDocs/assets/11179749/ae53a26b-c45a-4b71-932a-0682f3d264a8)

```json
{
  "name": "UMBRACO__CMS__Global__MainDomLock",
  "value": "FileSystemMainDomLock",
  "slotSetting": false
},
{
  "name": "UMBRACO__CMS__Hosting__LocalTempStorageLocation",
  "value": "EnvironmentTemp",
  "slotSetting": false
},
{
  "name": "UMBRACO__CMS__Examine__LuceneDirectoryFactory",
  "value": "SyncedTempFileSystemDirectoryFactory",
  "slotSetting": false
}
```

Also remember to add environment variable `ASPNETCORE_ENVIRONMENT` witch value `Development`, `Staging` og `Production`.

The minimum recommended Azure SQL Tier is "S2", however noticeable performance improvements are seen in higher Tiers

If you are load balancing or require the scaling ("scale out") ability of Azure Web Apps then you need to consult the [Load Balancing documentation](load-balancing/). This is due to the fact that a lot more needs to be configured to support scaling/auto-scaling.

## Storage

It is important to know that Azure Web Apps uses a remote file share to host the files to run your website. This is due to the files running your website do not exist on the machine running your website. In many cases this isn't an issue. It can become one if you have a large amount of IO operations running over remote file-share.

## Issues with read-only filesystems

Although Umbraco can be configured to use environmental storage it still requires its working-directory to be writable. If Umbraco is deployed to a read-only file system it will [fail to boot](https://github.com/umbraco/Umbraco-CMS/issues/12043).

For example, Azure's [Run from Package feature](https://docs.microsoft.com/en-us/azure/app-service/deploy-run-package) is not supported by Umbraco. To check if your web app is using this feature you can check the `WEBSITE_RUN_FROM_PACKAGE` environment variable.

## Scaling

If you require the scaling ("scale out") ability of Azure Web Apps you need to consult the [Load Balancing documentation](load-balancing/). This is due to the fact that a lot more needs to be configured to support scaling/auto-scaling.

## Web worker migrations

It's important to know that Azure Web Apps may move your website between their 'workers' at any given time. This is normally a transparent operation. In some cases you may be affected by it if any of your code or libraries use the following variables:

* `Environment.MachineName` (or equivalent)

When your site is migrated to another worker, these variables will change. You cannot rely on these variables remaining static for the lifetime of your website.

### How to find the Linux App Service Logs

The quickest way to get to your logs is using the following URL template and replacing `{app}` with your Web App name:

`https://{app}.scm.azurewebsites.net/api/logstream`

You can also find this in the KUDU console by clicking **Advanced Tools** > **Log Stream** on the Web App in the Azure Portal.

## Web App secret management

Consult the [Azure Key Vault documentation](../../../extending/key-vault.md) if you would like to directly reference Azure Key Vault Secrets to your Azure Web App.
