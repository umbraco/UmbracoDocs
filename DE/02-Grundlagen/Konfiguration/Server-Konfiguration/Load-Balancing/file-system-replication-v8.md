---
versionFrom: 8.0.0
---

## Standalone File System 
:::note 
(No file replication is configured, deployment handles updating files on the different servers)
:::

If the file system on your servers isn't performing any file replication then no _Umbraco_ configuration file changes are necessary. However Media will need to be configured to use a shared location such as Blob storage or S3.

Depending on the configuration and performance of the environment's local storage you might need to consider [Examine Directory Factory Options](#examine-directory-factory-options) and the [Umbraco temporary storage location](../../../../Reference/Config/webconfig/index.md#umbracocorelocaltempstorage). 

## Synchronised File System 
:::note 
(the servers are performing file replication, updates to a file on one server, updates the corresponding file on any other servers)
:::

If the file system on your servers is performing file replication then the Umbraco temporary folder (`App_Data/TEMP`) must be excluded from replication.

If the file system on your servers is located on shared storage you will need to configure Umbraco to locate the Umbraco temporary folder outside of the shared storage.

### Replication techniques

A common way to replicate files on Windows Server is to use [DFS](https://msdn.microsoft.com/en-us/library/windows/desktop/bb540031(v=vs.85), which is included with Windows Server.

Additional DFS resources:

* [Implementing DFS Replication in Windows Server 2003](http://www.windowsnetworking.com/articles_tutorials/Implementing-DFS-Replication.html)
* [Overview of DFS Replication in Windows Server 2008 R2](https://technet.microsoft.com/en-us/library/cc771058.aspx)
* [Watch an intro to installing and working with DFS](https://www.youtube.com/watch?v=DYfBoUt2RVE)

There are other alternatives for file replication out there, some free and some licensed. You'll need to decide which solution is best for your environment.

### Non-replicated files

When deploying Umbraco in a load balanced scenario using file replication, it is important to ensure that not all files are replicated - otherwise you will experience file locking issues. Here are the folders and files that should not be replicated:

* ~/App_Data/TEMP/*

:::tip
Alternatively store the Umbraco temporary files in the local server's 'temp' folder and set Examine to use a [Directory Factory](#examine-directory-factory-options). Achieve this by changing the value of the `Umbraco.Core.LocalTempStorage` configuration setting to 'EnvironmentTemp' in the web.config. The downside is that if you need to view temporary files you'll have to find it in the temp files. Locating the file this way isn't always clear.
        
```xml
<add key="Umbraco.Core.LocalTempStorage" value="EnvironmentTemp" />
```
:::            
* ~/App_Data/Logs/*
	* This is **optional** and depends on how you want your logs configured (see below) 

If for some reason your file replication solution doesn't allow you to not replicate specific files folders (which it should!!) then you can use an alternative approach by using virtual directories. *This is not the recommended setup but it is a viable alternative:*

* Copy the /App_Data/TEMP directory to each server, outside of any replication areas or to a unique folder for each server.
* Create a virtual directory (not a virtual application) in the /App_Data folder, and name it TEMP. Point the virtual directory to the folder you created in step 2.
* You may delete the /App_Data/TEMP folder from the file system - not IIS as this may delete the virtual directory - if you wish.

### IIS Setup

IIS configuration is pretty straightforward with file replication. IIS is only reading files from its own file system like a normal IIS website.

## Mixture of standalone & synchronised

In some scenarios you have a mixture of standalone and synchronised file systems. An example of this is Azure Web Apps where the file system isn't replicated between backoffice and front end servers but is replicated between all front end servers, in this configuration you should follow the steps for synchronised file systems.

There is a specific documentation for load balancing with [Azure Web Apps](azure-web-apps.md)

## Examine Directory Factory Options
 
- The `TempEnvDirectoryFactory` allows Examine to store indexes directly in the environment temporary storage directory, and should be used instead of `SyncTempEnvDirectoryFactory` mentioned above.
```xml
<add key="Umbraco.Examine.LuceneDirectoryFactory" value="Examine.LuceneEngine.Directories.TempEnvDirectoryFactory, Examine" />
``` 
- The `SyncTempEnvDirectoryFactory` enables Examine to sync indexes between the remote file system and the local environment temporary storage directory, the indexes will be accessed from the temporary storage directory. This setting is needed because Lucene has issues when working from a remote file share so the files need to be read/accessed locally. Any time the index is updated, this setting will ensure that both the locally created indexes and the normal indexes are written to. This will ensure that when the app is restarted or the local environment temp files are cleared out that the index files can be restored from the centrally stored index files.
```xml
<add key="Umbraco.Examine.LuceneDirectoryFactory" value="Examine.LuceneEngine.Directories.SyncTempEnvDirectoryFactory, Examine" />
``` 

:::tip
If you are load balancing with [Azure Web Apps](azure-web-apps.md) make sure to check out the article we have for that specific set-up.
:::

## Advanced techniques

Once you are familiar with how flexible load balancing works, you might be interested in some [advanced techniques](flexible-advanced.md).
