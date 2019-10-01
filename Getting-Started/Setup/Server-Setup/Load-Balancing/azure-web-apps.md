---
versionFrom: 8.0.0
---

## Non-synchronised file system

If the file system on your servers isn't performing any file replication then no _Umbraco_ configuration file changes are necessary.

Depending on the configuration and performance of the local storage you might need to consider Examine Directory Factory Options and the Umbraco temporary storage location. 

## Synchronised/replicated file system

If the file system on your servers is performing file replication then the Umbraco temporary folder must be excluded from replication.

## Mixed

In some scenarios you have a mixture of replicated and not replicated. An example of this is Azure Web Apps where the file system isn't replicated between back office and front servers but is synchronised between front end servers, in this configuration you should follow the steps for synchronised file systems.

### Replication techniques

A common way to replicate files on Windows Server is to use [DFS](https://msdn.microsoft.com/en-us/library/windows/desktop/bb540031(v=vs.85).aspx), which is included with Windows Server.

Additional DFS resources:

* [Implementing DFS Replication in Windows Server 2003](http://www.windowsnetworking.com/articles_tutorials/Implementing-DFS-Replication.html)
* [Overview of DFS Replication in Windows Server 2008 R2](https://technet.microsoft.com/en-us/library/cc771058.aspx)
* [Watch an intro to installing and working with DFS](https://www.youtube.com/watch?v=DYfBoUt2RVE)

There are other alternatives for file replication out there, some free and some licensed. You'll need to decide which solution is best for your environment.

### Non-replicated files

When deploying Umbraco in a load balanced scenario using file replication, it is important to ensure that not all files are replicated - otherwise you will experience file locking issues. Here are the folders and files that should not be replicated:

* ~/App_Data/TEMP/*
	* Alternatively store the Umbraco temporary files in the local server's 'temp' folder. Achieve this by changing this configuration setting to 'true' in the web.config. The downside is that if you need to view this configuration file you'll have to find it in the temp files. Locating the file this way isn't always clear.
			
    ```xml
    <add key="Umbraco.Core.LocalTempStorage" value="EnvironmentTemp" />
    ```
            
* ~/App_Data/Logs/*
	* This is **optional** and depends on how you want your logs configured (see below) 

If for some reason your file replication solution doesn't allow you to not replicate specific files folders (which it should!!) then you can use an alternative approach by using virtual directories. *This is not the recommended setup but it is a viable alternative:*

* Copy the /App_Data/TEMP directory to each server, outside of any replication areas or to a unique folder for each server.
* Create a virtual directory (not a virtual application) in the /App_Data folder, and name it TEMP. Point the virtual directory to the folder you created in step 2.
* You may delete the /App_Data/TEMP folder from the file system - not IIS as this may delete the virtual directory - if you wish.

### IIS Setup

IIS configuration is pretty straightforward with file replication. IIS is only reading files from its own file system like a normal IIS website.


## Examine Directory Factory Options
 
- The `TempEnvDirectoryFactory` allows Examine to store indexes directly in the environment temporary storage directory, and should be used instead of `SyncTempEnvDirectoryFactory` mentioned above.
```xml
<add key="Umbraco.Examine.LuceneDirectoryFactory" value="Examine.LuceneEngine.Directories.TempEnvDirectoryFactory, Examine" />
``` 
- The `SyncTempEnvDirectoryFactory` enables Examine to sync indexes between the remote file system and the local environment temporary storage directory, the indexes will be accessed from the temporary storage directory. This setting is needed because Lucene has issues when working from a remote file share so the files need to be read/accessed locally. Any time the index is updated, this setting will ensure that both the locally created indexes and the normal indexes are written to. This will ensure that when the app is restarted or the local environment temp files are cleared out that the index files can be restored from the centrally stored index files.
```xml
<add key="Umbraco.Examine.LuceneDirectoryFactory" value="Examine.LuceneEngine.Directories.SyncTempEnvDirectoryFactory, Examine" />
``` 

## Umbraco Configuration files

There isn't any _Umbraco_ configuration file changes necessary. **You must not enable the distributed calls flag in the umbracoSettings.config** file for Flexible Load Balancing to work, that is purely for Traditional load balancing. 

There are some Examine/Logging config file updates needed (see below and the [Overview](index.md))

## Option #1 : Cloud based auto-scale appliances

We have focused primarily on Azure Web Apps when developing flexible load balancing for cloud based appliances. The documentation here is for Azure Web Apps but a similar setup would be achievable on other services supporting ASP.NET.

Ensure you read the [overview](index.md) before you begin - you will need to ensure that your ASP.NET & logging configurations are correct.

### Azure Requirements

* You will need to setup 2 x Azure Web Apps - one for the master (administrative) environment and another for your front-end environment
* You will need 1 x SQL server that is shared with these 2 web apps

### Lucene/Examine configuration

#### Examine v0.1.80+ ####

Examine v0.1.80 introduced a new `directoryFactory` named `SyncTempEnvDirectoryFactory` which should be added to all indexers

```xml
directoryFactory="Examine.LuceneEngine.Directories.SyncTempEnvDirectoryFactory,Examine"
```

The `SyncTempEnvDirectoryFactory` enables Examine to sync indexes between the remote file system and the local environment temporary storage directory, the indexes will be accessed from the temporary storage directory. This setting is needed because Lucene has issues when working from a remote file share so the files need to be read/accessed locally. Any time the index is updated, this setting will ensure that both the locally created indexes and the normal indexes are written to. This will ensure that when the app is restarted or the local environment temp files are cleared out that the index files can be restored from the centrally stored index files.  

#### Pre Examine v0.1.80 ####

* In ExamineSettings.config, you can add these properties to all of your indexers and searchers: `useTempStorage="Sync" tempStorageDirectory="UmbracoExamine.LocalStorage.AzureLocalStorageDirectory, UmbracoExamine"`
* The 'Sync' setting will store your indexes in the local workers file system instead of Azure Web Apps' 
remote file system. Lucene has issues when working from a remote file share so the files need to be read/accessed locally. Anytime the index is updated, this setting will ensure that both the locally created indexes and the normal indexes are written to. This will ensure that when the app is restarted or the local temp files are cleared out that the index files can be restored from the centrally stored index files. If you see issues with this syncing process (in your logs), you can also change this value to be 'LocalOnly' which will only persist the index files to the local file system but this does mean they will be rebuilt when the website is migrated between Azure workers.

### If you plan on using auto-scaling

**Important!** Your Examine path settings need to be updated! Azure Web Apps uses a shared file system which means that if you increase your front-end environment scale setting to more than one worker your Lucene index files will be shared by more than one process. This will not work!

#### Examine v0.1.83+ ####

Examine v0.1.83 introduced a new `directoryFactory` named `TempEnvDirectoryFactory` which should be added to all indexers in the `~/Config/ExamineSettings.config` file

```xml
directoryFactory="Examine.LuceneEngine.Directories.TempEnvDirectoryFactory,Examine"
```

The `TempEnvDirectoryFactory` allows Examine to store indexes directly in the environment temporary storage directory, and should be used instead of `SyncTempEnvDirectoryFactory` mentioned above. 

#### Pre Examine v0.1.83 ####

In ExamineIndex.config, you need to tokenize the path for each of your indexes to include the machine name, this will ensure that your indexes are stored in different locations for each machine. An example of a tokenized path is: `~/App_Data/TEMP/ExamineIndexes/{machinename}/Internal/`. This however has some drawbacks for two reasons:

* Azure web apps migrates your site between workers without warning which means the {machinename} will change and your index will be rebuilt when this occurs
* When you scale out (increase the number of workers), the new worker will also rebuild its own index

We are working towards being able to mitigate these issues by adding the ability to store a master index in blob storage. That way, when new workers come online they can sync the existing index locally (this is not yet in place).

### Umbraco XML cache file and other TEMP files

For a front-end Azure Web App instance, you'll need to ensure that the Umbraco XML config file is stored on the local server (since Azure uses a shared file system). To do this you need to add a new app setting to web.config:

For **Umbraco v7.7.3+**

```xml
<add key="umbracoLocalTempStorage" value="EnvironmentTemp" />
```

This will set Umbraco to store `umbraco.config` and the other Umbraco TEMP files in the environment temporary folder. More info on this setting is available [here](../../../../Reference/Config/webconfig/index.md#umbracolocaltempstorage-umbraco-v773)

For **Umbraco v7.6+**

```xml
<add key="umbracoContentXMLStorage" value="EnvironmentTemp" />
```

This will set Umbraco to store `umbraco.config` in the environment temporary folder

For **Umbraco Pre v7.6**

```xml
<add key="umbracoContentXMLUseLocalTemp" value="true" /> 
```

This will set Umbraco to store `umbraco.config` in the ASP.NET temporary folder

### Steps

1. Create an Azure SQL database
2. Install Umbraco on your master environment and ensure to use your Azure SQL Database
3. Install Umbraco on your front-end environment and ensure to use your Azure SQL Database
4. Test: Perform some content updates on the master/administration environment, ensure they work successfully on that environment, then verify that those changes appear on the front-end environment

### Scaling

**Do not scale your master/administration environment** this is not supported and can cause issues.

Azure Web Apps can be manually or automatically scaled up or down and is supported by Umbraco's flexible load balancing.

### Deployment considerations

Since you have 2 x web apps, when you deploy you will need to deploy to both places - There is probably various automation techniques you can use to make this more basic. That is outside the scope of this article.

**Important note:** This also means that you should not be editing templates or views on a live server as master and front-end environments do not share the same file server. Changes should be made in a staging environment and then pushed to live environments.

## Option #2 : File Storage with File Replication

If you are not using a cloud based setup then *this is the recommended setup*.

Ensure you read the [overview](index.md) before you begin - you will need to ensure that your ASP.NET & logging configurations are correct.

[See here for specific details about using Option #2: File Storage with Replication](files-replicated.md)

### Scaling

Scaling will be a slightly manual process because it would involve you adding servers/sites. With flexible load balancing you don't have to configure anything in Umbraco. You only need to point the site to the Umbraco database and update your load balancer to include the site.

## Option #3 : File Storage on SAN/NAS/Clustered File Server/Network Share

Configuring your servers to work using a centrally located file system that is shared for all of your IIS instances can be tricky and can take a while to setup correctly.

[See here for specific details about using Option #3: File Storage on SAN/NAS/Clustered File Server/Network Share](files-shared.md)

### Scaling

Scaling will be a slightly manual process because it would involve you adding servers/sites. With flexible load balancing you don't have to configure anything in Umbraco. You only need to point the site to the Umbraco database and update your load balancer to include the site.

## Advanced techniques

Once you are familiar with how flexible load balancing works, you might be interested in some [advanced techniques](flexible-advanced.md).
