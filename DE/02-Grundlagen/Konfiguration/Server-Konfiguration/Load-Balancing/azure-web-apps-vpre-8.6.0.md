---
versionFrom: 8.0.0
versionTo: 8.5.5
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
When an instance of Umbraco starts up it generates some 'temporary' files on disk... in a normal IIS environment these would be created within the folders of the Web Application. In an Azure Web App we want these to be created in the local storage of the actual server that Azure happens to be using for the Web App. So we set this configuration setting and the temporary files will be located in the environment temporary folder. This is great for 'speed' of access for Umbraco operation however, the downside is it's  difficult on Azure to manually browse to this temporary location if you are troubleshooting for any reason.
			
```xml
<add key="Umbraco.Core.LocalTempStorage" value="EnvironmentTemp" />
```

### Umbraco PublishedCache

When Azure Web Apps auto transition between hosts, you scale the instances or you utilise slot swapping you may experience issues with the Umbraco Published Cache becoming locked unless your web app is configured to disable overlapped recycling. 

[Disable overlapping recycling](https://github.com/projectkudu/kudu/wiki/Configurable-settings#disable-overlapped-recycling) by adding the `WEBSITE_DISABLE_OVERLAPPED_RECYCLING` setting to appSettings with a value of `1`. This setting must be set in the Application Settings part in your Azure portal. Setting it in your web.config file makes no effect.

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
