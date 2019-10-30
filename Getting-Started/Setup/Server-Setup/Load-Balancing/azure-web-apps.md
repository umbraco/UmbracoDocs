---
versionFrom: 8.0.0
---

## Load Balancing Azure Web Apps

Ensure you read the [overview](index.md) before you begin - you will need to ensure that your ASP.NET & logging configurations are correct.

### Azure Requirements

* You will need to setup 2 x Azure Web Apps - one for the master (administrative) environment and another for your front-end environment
* You will need 1 x SQL server that is shared with these 2 web apps

### Lucene/Examine configuration

The single instance backoffice Web App should be set to use [SyncTempEnvDirectoryFactory](file-system-replication.md#examine-directory-factory-options).

The multi instance front end Web App should be set to use [TempEnvDirectoryFactory](file-system-replication.md#examine-directory-factory-options).

### Umbraco TEMP files

Store the Umbraco temporary files in the local server's 'temp' folder. Achieve this by changing this configuration setting to 'true' in the web.config. The downside is that if you need to view this configuration file you'll have to find it in the temp files. Locating the file this way isn't always clear.
			
```xml
<add key="Umbraco.Core.LocalTempStorage" value="EnvironmentTemp" />
```

### Umbraco PublishedCache

When Azure Web Apps auto transition between hosts, you scale the instances or you utilise slot swapping you may experience issues with the Umbraco Published Cache becoming locked unless it is configured to ignore the local database. 

A composer is required to configure this option

```csharp
composition.Register(factory => new PublishedSnapshotServiceOptions
{
    IgnoreLocalDb = true
});
```

### Steps to set-up a environment

1. Create an Azure SQL database
2. Install Umbraco on your master environment and ensure to use your Azure SQL Database
3. Install Umbraco on your front-end environment and ensure to use your Azure SQL Database
4. Test: Perform some content updates on the master/administration environment, ensure they work successfully on that environment, then verify that those changes appear on the front-end environment

### Scaling

**Do not scale your master/administration environment** this is not supported and can cause issues.

Azure Web Apps can be manually or automatically scaled up or down and is supported by Umbraco's load balancing.

### Deployment considerations

Since you have 2 x web apps, when you deploy you will need to deploy to both places - There is probably various automation techniques you can use to make this more basic. That is outside the scope of this article.

**Important note:** This also means that you should not be editing templates or views on a live server as master and front-end environments do not share the same file server. Changes should be made in a staging environment and then pushed to live environments.