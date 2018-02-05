# Running Umbraco on Azure Web Apps

_This section describes best practices with running Umbraco on Azure Web Apps_

## What is Azure Web Apps

This has been called a few names in the past, many people still know Azure Web Apps as Azure Web Sites. 

> App Service is a fully Managed Platform for professional developers that brings a rich set of capabilities to web, mobile and integration scenarios. Quickly create and deploy mission critical web Apps that scale with your business by using Azure App Service.

[You can read more about this here](https://azure.microsoft.com/en-us/documentation/articles/app-service-web-overview/)

Umbraco will run on Azure Web Apps but there are some configuration options and some specific Azure Web Apps environment limitations you need to be aware of.

## Storage

The first important thing to know about Azure Web Apps is that it uses a remote file share. 
This means that the files being used to run your website do not exist locally to the server that is serving your website.
In many cases this isn't an issue but it can become an issue if you have a large amount of IO operations like Lucene indexing
due to IO latency of the remote file share.

## Scaling

If you require the scaling ("scale out") ability of Azure Web Apps then you need to consult 
the [Load Balancing documentation](load-balancing.md) since there is a lot more that needs
to be configured to support scaling/auto-scaling.

## Web worker migrations

It's important to know that Azure Web Apps may move your website between it's 'workers' at any
given time. This is normally a transparent operation but in some cases you may be affected by this 
if any of your code or libraries use the following variables:

* Environment.MachineName (or equivalent)
* HttpRuntime.AppDomainAppId (or equivalent)

When your site is migrated to another worker, these variables will change. 
You cannot rely on these variables remaining static for the lifetime of your website.


## Best practices

These best practices are for a single environment/non-scaled azure website. __If you require the scaling ("scale out") 
ability of Azure Web Apps then you need to consult the 
[Load Balancing documentation](load-balancing.md)__ since there is a lot more that needs
to be configured to support scaling/auto-scaling.

* You should ensure that `fcnMode="Single"` in your web.config's `<httpRuntime>` section (this is the default that is shipped with Umbraco, see [here](http://shazwazza.com/post/all-about-aspnet-file-change-notification-fcn/) for more details)
* You should set your log4net minimum log priority to "WARN" in /Config/log4net.config if you are running a live site (of course if you are debugging this is irrelevant)
* The minimum recommended Azure SQL Tier is "S2", however noticeable performance improvements are seen in higher Tiers 

#### Examine v0.1.80+ ####

Examine v0.1.80 introduced a new `directoryFactory` named `SyncTempEnvDirectoryFactory` which should be added to all indexers in the `~/Config/ExamineSettings.config` file

    directoryFactory="Examine.LuceneEngine.Directories.SyncTempEnvDirectoryFactory,Examine"

The `SyncTempEnvDirectoryFactory` enables Examine to sync indexes between the remote file system and the local environment temporary storage directory, the indexes will be accessed from the temporary storage directory. This setting is required due to the nature of Lucene files and IO latency on Azure Web Apps.

#### Pre Examine v0.1.80 ####

* If you have a {machinename} token in your `~/Config/ExamineIndex.config` file remove this part of the path. Example, if you have path that looks like: `~/App_Data/TEMP/ExamineIndexes/{machinename}/External/` it should be `~/App_Data/TEMP/ExamineIndexes/External/` 
* Due to the nature of Lucene files and IO latency, you should update all of your Indexers and Searchers in the `~/Config/ExamineSettings.config` file to have these two properties (see [here](http://issues.umbraco.org/issue/U4-7614) for more details): `useTempStorage="Sync"`

### Umbraco XML cache file and other TEMP files

For a single Azure Web App instance you need to ensure that the Umbraco XML config file is stored on the local server (since Azure uses a shared file system). To do this you need to add a new app setting to web.config:

For **Umbraco v7.7.3+**

For Umbraco installations that are hosted by Azure Web Apps it is recommend that Umbraco is upgraded to the latest version if the current version is pre v7.7.3. This is so that the umbracoLocalTempStorage setting can be utilised to avoid locking issues with TEMP files during automated server migrations or slot swapping. See [U4-10503](http://issues.umbraco.org/issue/U4-10503) for more information on this.

	<add key="umbracoLocalTempStorage" value="EnvironmentTemp" />

This will set Umbraco to store `umbraco.config` and the other Umbraco TEMP files in the environment temporary folder. More info on this setting is available [here](../../../Reference/Config/webconfig/index.md#umbracolocaltempstorage-umbraco-v773)

For **Umbraco v7.6+**

	<add key="umbracoContentXMLStorage" value="EnvironmentTemp" />

This will set Umbraco to store `umbraco.config` in the environment temporary folder

For **Umbraco Pre v7.6**

	<add key="umbracoContentXMLUseLocalTemp" value="true" /> 

This will set Umbraco to store `umbraco.config` in the ASP.NET temporary folder
