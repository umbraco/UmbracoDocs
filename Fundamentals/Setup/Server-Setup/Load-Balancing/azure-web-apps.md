---
versionFrom: 9.4.0
versionTo: 10.0.0
---

# Load Balancing Azure Web Apps

Ensure you read the [Load Balancing overview](index.md) and general [Azure Web Apps](../azure-web-apps.md) documentation before you begin - you will need to ensure that your ASP.NET Core & logging configurations are correct.

## Azure Requirements

* You will need to setup 2 x Azure Web Apps - one for the backoffice (Administrative) environment and another for your scalable public-facing environment (Public)
* You will need 1 x SQL server that is shared with these 2 web apps

## Lucene/Examine configuration

The single instance Backoffice Administrative Web App should be set to use [SyncedTempFileSystemDirectoryFactory](file-system-replication.md#examine-directory-factory-options).

The multi-instance Scalable Public Web App should be set to use [TempFileSystemDirectoryFactory](file-system-replication.md#examine-directory-factory-options).

## Umbraco TEMP files

When an instance of Umbraco starts up it generates some 'temporary' files on disk. In a normal IIS environment, these would be created within the folders of the Web Application. In an Azure Web App, we want these to be created in the local storage of the actual server that Azure happens to be used for the Web App. So we set this configuration setting to 'true' and the temporary files will be located in the environment temporary folder. This is required for both the performance of the website as well as to prevent file locks from occurring due to the nature of Azure Web Apps shared files system.

```json
{
    "Umbraco": {
        "CMS": {
            "Hosting": {
                "LocalTempStorageLocation" : "EnvironmentTemp"
            }
        }
    }
}
```

## AppDomain synchronization

Each application runs inside an [AppDomain](https://docs.microsoft.com/en-us/dotnet/framework/app-domains/application-domains) which is like a subprocess within the web app process. When an ASP.Net application restarts, the current AppDomain 'winds down' while another AppDomain is started; meaning there can be more than 1 live AppDomain during a restart. Restarts can occur in many scenarios including when an Azure Web App auto transitions between hosts, you scale the instances or you utilize slot swapping.

Some file system based services in Umbraco such as the Published Cache and Lucene files can only be accessed by a single AppDomain at once. Umbraco manages this synchronization by an object called `IMainDom`. 

By default **Umbraco v9.4 & 9.5** uses a system-wide semaphore locking mechanism but this mechanism only works on Windows systems and doesn't work in Azure Web Apps so we need to swap it out for an alternative file system based locking mechanism by using the following appSetting.
With **Umbraco v10+** `FileSystemMainDomLock` is the default setting.

```json
{
    "Umbraco": {
        "CMS": {
            "Global": {
                "MainDomLock" : "FileSystemMainDomLock"
            }
        }
    }
}
```

Apply this setting to both the __SCHEDULINGPUBLISHER__ Administrative server and the __SUBSCRIBER__ scalable public-facing servers.

## Steps to set-up an environment

1. Create an Azure SQL database
2. Install Umbraco on your backoffice administrative environment and ensure to use your Azure SQL Database
3. Install Umbraco on your scalable public-facing environment and ensure to use your Azure SQL Database
4. Test: Perform some content updates on the administrative environment, ensure they work successfully in that environment, then verify that those changes appear on the scalable public-facing environment
5. Fix the backoffice environment to be the SCHEDULINGPUBLISHER scheduling server and the scalable public-facing environment to be SUBSCRIBERs - see [Setting Explicit Server Roles](flexible-advanced.md#explicit-schedulingpublisher-server)

:::note
Ensure all Azure resources are in the same region to avoid connection lag.
:::

## Scaling

**Do not scale your backoffice administrative environment** this is not supported and can cause issues.

The public-facing subscriber Azure Web Apps can be manually or automatically scaled up or down and is supported by Umbraco's load balancing.

## Deployment considerations

Since you have 2 x web apps, when you deploy you will need to deploy to both places - There are various automation techniques you can use to simplify the process. That is outside the scope of this article.

:::note
This also means that you should not be editing templates or views on a live server as SchedulingPublisher and Subscriber environments do not share the same file system. Changes should be made in a development environment and then pushed to each live environment.
:::
