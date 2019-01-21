# Configuration

Courier 2.5 comes with sensible defaults, but in special cases, you might need to add or modify core settings.

Core settings are configuration options which covers the entire Courier application, no matter if it runs from Umbraco, or a desktop client, all core settings resides inside the `<settings>` xml node in the` /config/courier.config` file. With the below settings, simply copy the sample xml inside the `<settings>` node and Courier will register it.

**For provider configuration:** look under the appropriate provider type in documentation

## Cache Settings
Courier keeps an ongoing cache of items to speed up transfers, this can be turned off:

```xml
<cache>
	<enable>False</enable>
</cache>
```

## Transfer settings

### Timeout
Milliseconds before a web client connection times out.

```xml
<timeout>30000</timeout>
```

### Base64 encoding
Encode all resources and items as base64 to avoid illegal characters

```xml
<disableBase64Encoding>false</disableBase64Encoding >
```

### Strip resources from courier files
Strip the raw byte data from the courier files before transferring

```xml
<stripResourcesFromCourierFiles>false</stripResourcesFromCourierFiles>
```

## Path settings
### Root folder
The root folder containing all Courier's data. This folder needs changed, if Courier runs outside of the standard Umbraco web context. 

```xml	
<paths>  
	<root>~/path/to/courier</root>
</paths>
```

### Revisions folder
Specifies the folder within the root folder, which holds each individual revision folder.

```xml
<paths>  
	<revisions>/folder</revisions>
</paths>
```

### Masterpages folder
The Sql connection to the SQL database Courier should use. Notice this is not necessary as long as the repository pattern is used, as that will then be handled by the Umbraco website data is pulled/pushed from.

```xml
<paths>  
	<masterPages>/folder</masterPages>
</paths>
```

### Database connection

```xml
<databaseConnectionString>
	DATABASE=yahahdasd;USER ID=etc
</databaseConnectionString>
```

### Use short courier file names
In case of too long paths, shorten file names

```xml
<enableShortFileNames>false</enableShortFileNames>
```

## Ignoring providers
If there is an issue with a specific provider, no matter what type of provider. You can turn it off by ignoring it. 

This is done by adding its full namespace and class to the configuration, you can ignore any item provider, data resolver, repository provider or any other functionality that’s loaded through Courier's provider model.

```xml
<ignore>
    <!-- Ignore the lucene indexer -->
    <add>Umbraco.Courier.DataResolvers.Events.UpdateLuceneIndexes</add>
    <!-- ignore all ucomponents data resolvers -->
    <add>Umbraco.Courier.uComponents.*</add>
    <!--<add>my.namespace.*</add>-->
</ignore>
```

## Settings for debugging

### Debugmode
Enables logging to the /app_data/courier/logs folder, by default **false**

```xml
<debugMode>true</debugMode>
```

### Map graphs
If enabled, Courier will generate a blumind compatible mindmap after each extraction to map dependencies, by default **false**

```xml
<mapGraphs>true</mapGraphs>
```