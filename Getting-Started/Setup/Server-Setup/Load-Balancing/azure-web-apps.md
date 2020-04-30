---
versionFrom: 8.6.0
---

## Load Balancing Azure Web Apps

Ensure you read the [overview](index.md) before you begin - you will need to ensure that your ASP.NET & logging configurations are correct.

### Azure Requirements

* You will need to setup 2 x Azure Web Apps - one for the backoffice (administrative) environment and another for your front-end environment
* You will need 1 x SQL server that is shared with these 2 web apps

### Lucene/Examine configuration

The single instance backoffice Web App should be set to use [SyncTempEnvDirectoryFactory](file-system-replication.md#examine-directory-factory-options).

The multi instance front end Web App should be set to use [TempEnvDirectoryFactory](file-system-replication.md#examine-directory-factory-options).

### Umbraco TEMP files

When an instance of Umbraco starts up it generates some 'temporary' files on disk... in a normal IIS environment these would be created within the folders of the Web Application. In an Azure Web App we want these to be created in the local storage of the actual server that Azure happens to be using for the Web App. So we set this configuration setting to 'true' and the temporary files will be located in the environment temporary folder. This is required for both the performance of the website as well as to prevent file locks from occurring due to the nature of Azure Web Apps shared files system.

```xml
<add key="Umbraco.Core.LocalTempStorage" value="EnvironmentTemp" />
```

### AppDomain synchronization

Each ASP.Net application runs inside an [AppDomain](https://docs.microsoft.com/en-us/dotnet/framework/app-domains/application-domains) which is like a sub process within the web app process. When an ASP.Net application restarts, the current AppDomain 'winds down' while another AppDomain is started meaning there can be more than 1 live AppDomain during a restart. Restarts can occur in many scenarios including when Azure Web Apps auto transitions between hosts, you scale the instances or you utilise slot swapping.

Several file system based services in Umbraco such as the Published Cache and Lucene files can only be accessed by a single AppDomain at once. Umbraco manages this synchronization by an object called `IMainDom`. By default this uses a system-wide locking mechanism but this default mechanism doesn't work in Azure Web Apps so we need to swap it out for a database locking mechanism by using the following appSetting:

```xml
<add key="Umbraco.Core.MainDom.Lock" value="SqlMainDomLock" />
```

##### v8.6.0 - v8.6.1

TODO: Update this

The `Umbraco.Core.MainDom.Lock` should be applied to your __master__ server only. Your replica servers should be configured with:

##### v8.0 - v8.5.x

TODO: Update this

:::note
The `Umbraco.Core.MainDom.Lock` setting is for Umbraco v8.6+. Having this setting for versions between v8.0-v8.5 will not have any affect. It is recommended to use 8.6+ when running Umbraco on Azure Web Apps since this setting will prevent file locking issues.
:::


### Steps to set-up a environment

1. Create an Azure SQL database
2. Install Umbraco on your backoffice environment and ensure to use your Azure SQL Database
3. Install Umbraco on your front-end environment and ensure to use your Azure SQL Database
4. Test: Perform some content updates on the backoffice environment, ensure they work successfully on that environment, then verify that those changes appear on the front-end environment
5. Fix the backoffice environment to be the master scheduling server and the front-end environment to be replicas - see [Explicit Master Scheduling](flexible-advanced.md#explicit-master-scheduling-server)

:::note
Ensure all Azure resources are located in the same region to avoid connection lag
:::

### Scaling

**Do not scale your backoffice environment** this is not supported and can cause issues.

The Front end replica Azure Web Apps can be manually or automatically scaled up or down and is supported by Umbraco's load balancing.

### Deployment considerations

Since you have 2 x web apps, when you deploy you will need to deploy to both places - There are various automation techniques you can use to simplify the process. That is outside the scope of this article.

**Important note:** This also means that you should not be editing templates or views on a live server as master and front-end environments do not share the same file system. Changes should be made in a development environment and then pushed to live environments.
