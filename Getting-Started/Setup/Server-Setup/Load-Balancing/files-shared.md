# File Storage on SAN/NAS/Clustered File Server/Network Share

_documentation about setting up load balanced environments using shared file systems_

## Overview

Configuring your servers to work using a centrally located file system that is shared for all of your IIS instances can be tricky and can take a while to setup correctly. 

A note when using this method to store your files centrally, you **must** make sure that your file storage system is HA (Highly Available) which means that there's not single point of failure. If you're hosting your files on a File Server share, you need to make the file share clustered (using [MSCS](http://en.wikipedia.org/wiki/Microsoft_Cluster_Server) or similar). Windows Server 2008 supports connecting directly to a SAN via [iSCSI](http://en.wikipedia.org/wiki/ISCSI) if your SAN supports it (there are also many other ways to connect to a SAN to share folders), otherwise you should be able to connect to a NAS via a UNC path but you must ensure that it is a windows/NTFS file system - IIS will not work properly using a linux shared file system.

There's a lot of work required to get this working, but once it's done it's fairly easy to maintain. We've this same setup working for many websites so hopefully these notes help you get started:

### Umbraco XML cache file

One important configuration option that **must** be set when using a centralized storage is to store the umbraco.config file in a folder that is local to the individual server.

For **Umbraco v7.7.3+**

	<add key="umbracoLocalTempStorage" value="EnvironmentTemp" />

This will set Umbraco to store `umbraco.config` in the environment temporary folder

**Or**

	<add key="umbracoLocalTempStorage" value="AspNetTemp" />

This will set Umbraco to store `umbraco.config` in the ASP.NET temporary folder

For **Umbraco v7.6+**

	<add key="umbracoContentXMLStorage" value="EnvironmentTemp" />

This will set Umbraco to store `umbraco.config` in the environment temporary folder

**Or**

	<add key="umbracoContentXMLStorage" value="AspNetTemp" />

This will set Umbraco to store `umbraco.config` in the ASP.NET temporary folder

For **Umbraco Pre v7.6**

	<add key="umbracoContentXMLUseLocalTemp" value="true" /> 

This will set Umbraco to store `umbraco.config` in the ASP.NET temporary folder


## Lucene/Examine configuration

You cannot share indexes between servers, therefore when using a shared file server, Examine settings are a little bit tricky. 

#### Examine v0.1.83+ ####

Examine v0.1.83 introduced a new `directoryFactory` named `TempEnvDirectoryFactory` which should be added to all indexers in the `~/Config/ExamineSettings.config` file

    directoryFactory="Examine.LuceneEngine.Directories.TempEnvDirectoryFactory,Examine"

The `TempEnvDirectoryFactory` allows Examine to store indexes directly in the environment temporary storage directory.

#### Pre Examine v0.1.83 ####

* In ExamineIndex.config, you can tokenize the path for each of your indexes to include the machine name, this will ensure that your indexes are stored in different locations for each machine. An example of a tokenized path is: `~/App_Data/TEMP/ExamineIndexes/{machinename}/Internal/`
* In ExamineSettings.config, you can add this attribute to all of your indexers and searchers: `useTempStorage="Sync"`
* The 'Sync' setting will store your indexes in ASP.Net's temporary file folder which is on the local file system. Lucene has issues when working from a remote file share so the files need to be read/accessed locally. Anytime the index is updated, this setting will ensure that both the locally created indexes and the normal indexes are written to. This will ensure that when the app is restarted or the local temp files are cleared out that the index files can be restored from the centrally stored index files. If you see issues with this syncing process (in your logs), you can change this value to be 'LocalOnly' which will only persist the index files to the local file system in ASP.Net temp files.

## Windows Setup

* Create domain user account that will run your IIS websites. Example: MyDomain\WebsiteUser
* Grant this domain user FULL access to your file share
* On each web server, add this user to the IIS Security group account. Server 2003: IIS_WPG, Server 2008: IIS_IUSRS
* The .NET Code Access Policy must be updated on each server to run with Full Trust for the UsterNC share:
** EXAMPLE: %windir%\Microsoft.NET\Framework64\v2.0.50727\caspol -m -ag 1. -url "file://\\fileserver.mydomain.local\Inetpub\MySite\*" FullTrust -name "WebsiteUser"
* The IIS user above needs to be granted the appropriate IIS permissions:
** EXAMPLE: %windir%\Microsoft.NET\Framework64\v2.0.50727\Aspnet_regiis.exe -ga ActiveDirectoryDomain\ProcessIdentity
* Restart the server

**Much of the above is covered in this Microsoft doc: [ASP.NET 3.5 Hosting](http://wiki.dev/GetFile.aspx?File=Wiggles-Hosting/ASPNET35_HostingDeploymentGuide.doc)**

## IIS Setup

Since the files for the website will be hosted centrally, each IIS website on your servers will need to point to the same UNC share for the files. For example: *\\fileserver.mydomain.local\Inetpub\MySite*

* Point to the shared file server: \\fileserver.mydomain.local\Inetpub\MySite
* "Connect To" this share with the user account created above
* Have their application pools run as the user above
* Have the IIS anonymous user account set to the application pool account (IIS 7)
