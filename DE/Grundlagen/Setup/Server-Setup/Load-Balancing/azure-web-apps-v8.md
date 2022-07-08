---
versionFrom: 8.6.0
---

## Load Balancing Azure Web Apps

Ensure you read the [overview](index.md) before you begin - you will need to ensure that your ASP.NET & logging configurations are correct.

### Azure Requirements

* You will need to setup 2 x Azure Web Apps - one for the backoffice (Administrative) environment and another for your scalable public facing environment (Public)
* You will need 1 x SQL server that is shared with these 2 web apps

### Lucene/Examine configuration

The single instance Backoffice Administrative Web App should be set to use [SyncTempEnvDirectoryFactory](file-system-replication.md#examine-directory-factory-options).

The multi instance Scalable Public Web App should be set to use [TempEnvDirectoryFactory](file-system-replication.md#examine-directory-factory-options).

### Umbraco TEMP files

When an instance of Umbraco starts up it generates some 'temporary' files on disk... in a normal IIS environment these would be created within the folders of the Web Application. In an Azure Web App we want these to be created in the local storage of the actual server that Azure happens to be using for the Web App. So we set this configuration setting to 'true' and the temporary files will be located in the environment temporary folder. This is required for both the performance of the website as well as to prevent file locks from occurring due to the nature of Azure Web Apps shared files system.

```xml
<add key="Umbraco.Core.LocalTempStorage" value="EnvironmentTemp" />
```

### AppDomain synchronization

Each ASP.Net application runs inside an [AppDomain](https://docs.microsoft.com/en-us/dotnet/framework/app-domains/application-domains) which is like a subprocess within the web app process. When an ASP.Net application restarts, the current AppDomain 'winds down' while another AppDomain is started; meaning there can be more than 1 live AppDomain during a restart. Restarts can occur in many scenarios including when an Azure Web App auto transitions between hosts, you scale the instances or you utilise slot swapping.

##### v8.6.4+

Several file system based services in Umbraco such as the Published Cache and Lucene files can only be accessed by a single AppDomain at once. Umbraco manages this synchronization by an object called `IMainDom`. By default this uses a system-wide locking mechanism but this default mechanism doesn't work in Azure Web Apps so we need to swap it out for an alternative database locking mechanism by using the following appSetting _(in either web.config or the Azure Portal)_:

```xml
<add key="Umbraco.Core.MainDom.Lock" value="SqlMainDomLock" />
```
Apply this setting to both the __MASTER__ Administrative server and the __REPLICA__ scalable public-facing servers.
##### v8.6.0 - v8.6.3

The `Umbraco.Core.MainDom.Lock` should be applied to your __MASTER__ Administrative server only.

Your __REPLICA__ scalable public facing servers should be configured with:

[Disable overlapping recycling](https://github.com/projectkudu/kudu/wiki/Configurable-settings#disable-overlapped-recycling) by adding the `WEBSITE_DISABLE_OVERLAPPED_RECYCLING` setting to application settings with a value of `1`. This setting must be set in the Application Settings part of the Azure portal _(setting it in your `web.config` file is not supported.)_

In some cases, if locking issues are continuing to occur on the REPLICA Web App even with `WEBSITE_DISABLE_OVERLAPPED_RECYCLING`
successfully configured in the Azure Portal - then a further approach would be to set the Published Cache to completely ignore the local database at start up, do this **only** for the REPLICA WebApp.

A composer is required to configure this option

```csharp
composition.Register(factory => new PublishedSnapshotServiceOptions
{
    IgnoreLocalDb = true
});
```

Or if you want to control this via the Azure Portal along with the other options you could add an Application Setting.

e.g.

```csharp
var appSettingIgnoreLocalDb = ConfigurationManager.AppSettings["PublishedSnapshotServiceOptions.IgnoreLocalDb"];

if (appSettingIgnoreLocalDb == "true")
{
    composition.Register(factory => new PublishedSnapshotServiceOptions
    {
        IgnoreLocalDb = true
    });
}
```
The downside of this approach is it will take slightly longer to build the published cache when a new server is intialilized, therefore consider ensuring new servers are fully 'warmed up' before swapping a slot, or enabling [Application Intialization](https://docs.microsoft.com/en-us/iis/configuration/system.webserver/applicationinitialization/) to allow Azure to warm up the server before any scaling or auto transitions occur.

```xml
<applicationInitialization doAppInitAfterRestart="true">
 <add initializationPage="/"/>
</applicationInitialization>
```

##### v8.0 - v8.5.x

The SQLDomainLock option was added in V8.6, for previous versions of Umbraco V8 you should configure both your __MASTER__ and __REPLICA__ servers 'as if they were all replica servers' based upon the [v8.6.0 - v8.6.1](#v860---v861) configuration above.

### Steps to set-up an environment

1. Create an Azure SQL database
2. Install Umbraco on your backoffice administrative environment and ensure to use your Azure SQL Database
3. Install Umbraco on your scalable public facing environment and ensure to use your Azure SQL Database
4. Test: Perform some content updates on the administrative environment, ensure they work successfully on that environment, then verify that those changes appear on the scalable public facing environment
5. Fix the backoffice environment to be the MASTER scheduling server and the scalable public facing environment to be REPLICAs - see [Explicit Master Scheduling](flexible-advanced.md#explicit-master-scheduling-server)

:::note
Ensure all Azure resources are located in the same region to avoid connection lag
:::

### Scaling

**Do not scale your backoffice administrative environment** this is not supported and can cause issues.

The public facing replica Azure Web Apps can be manually or automatically scaled up or down and is supported by Umbraco's load balancing.

### Deployment considerations

Since you have 2 x web apps, when you deploy you will need to deploy to both places - There are various automation techniques you can use to simplify the process. That is outside the scope of this article.

**Important note:** This also means that you should not be editing templates or views on a live server as master and replica environments do not share the same file system. Changes should be made in a development environment and then pushed to each live environment.
