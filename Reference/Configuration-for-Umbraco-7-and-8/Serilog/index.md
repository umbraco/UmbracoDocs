---
versionFrom: 8.0.0
versionTo: 8.0.0
meta.Title: "Umbraco Serilog config"
meta.Description: "Reference for the Serilog config file in Umbraco"
meta.RedirectLink: "/umbraco-cms/reference/configuration/serilog"
---

# Serilog Config

:::note
This article is only valid if you are using Umbraco 8 or previous versions.

If you are using Umbraco 9 or later, the relevant article for you is found in the [Configuration](../../Configuration/Serilog/) section.
:::

Serilog can be configured and extended by using the two XML configuration files on disk.

* `/config/serilog.config` is used to modify the main Umbraco logging pipeline
* `/config/serilog.user.config` which is a sublogger and allows you to make modifications without affecting the main Umbraco logger

For more information on Serilog in v8, the docs are [here](../../../Getting-Started/Code/Debugging/Logging/index.md).

### Changing the log level

This can be done by adding the following into either `serilog.config` or the sub logger configuration file `serilog.user.config`

```xml
<add key="serilog:minimum-level" value="Verbose" />
```

:::warning
If you change the main Umbraco logger in `serilog.config` to log only **Warning** you would not be able to have the `serilog.user.config` sub logger to be set to **Debug**. Having this setting only Warning messages and higher will flow down into the child sub logger.
:::


### Changing the log level for specific namespaces

This can be done by adding the following into either `serilog.config` or the sub logger configuration file `serilog.user.config`

```xml
<add key="serilog:minimum-level:override:Microsoft" value="Warning" />
<add key="serilog:minimum-level:override:Microsoft.AspNet.Mvc" value="Error" />
<add key="serilog:minimum-level:override:MyNamespace" value="Information" />
```

:::warning
If you change the **serilog:minimum-level** to be **Error** then the following example above would only log Error messages from *Microsoft.AspNet.Mvc* and not any warning, info or debug messages from the *Microsoft* namespace
:::

### Writing your own log messages to a custom file

Add the following to the `/config/serilog.user.config` file, which will create a new JSON log file

```xml
<!-- Write to a user log file -->
<add key="serilog:using:File" value="Serilog.Sinks.File" />
<add key="serilog:write-to:File.path" value="%BASEDIR%\my-logs\my-custom-logfile.txt" />
<add key="serilog:write-to:File.shared" value="true" />
<add key="serilog:write-to:File.restrictedToMinimumLevel" value="Debug" />
<add key="serilog:write-to:File.retainedFileCountLimit" value="32" /> <!-- Number of log files to keep (or remove value to keep all files) -->
<add key="serilog:write-to:File.rollingInterval" value="Day" /> <!-- Create a new log file every Minute/Hour/Day/Month/Year/infinite -->
<add key="serilog:write-to:File.outputTemplate" value="{Timestamp:yyyy-MM-dd HH:mm:ss,fff} [P{ProcessId}/D{AppDomainId}/T{ThreadId}] {Log4NetLevel}  {SourceContext} - {Message:lj}{NewLine}{Exception}" />
```

### Filtering user log file to include only log messages from your namespace

With the above example we are able to write to a separate JSON log file, but adding these additional lines to `serilog.user.config` will allow you to filter and include log messages. For further details on specific expressions you can write, refer to the readme of the [Serilog Filters Expression project](https://github.com/serilog/serilog-filters-expressions)

```xml
<!-- Filters all sink's in the serilog.user.config to use this expression -->
<!-- Common use case is to include SourceType starting with your own namespace -->
<add key="serilog:using:FilterExpressions" value="Serilog.Filters.Expressions" />
<add key="serilog:filter:ByIncludingOnly.expression" value="StartsWith(SourceContext, 'MyNamespace')" />
```

### Writing log events to different storage types

Serilog has a similar concept to Log4Net with its appenders, which are referred to as Serilog Sinks.
A Serilog Sink, allows you to persist the structured log message to a data store of your choice. In v8.0+ we use the *Serilog.Sinks.File* to allow us to write a .txt or .json file to disk. But the Serilog project and the wider Serilog community allows you to store these logs in various locations.

[An extensive list of examples can be found here](https://github.com/serilog/serilog/wiki/Provided-Sinks)

For example you could install the Nuget package `PM> Install-Package Serilog.Sinks.Seq` and update the `serilog.user.config` file with the following XML snippet and if you already have the file example above it will write to that location as well as Seq.

```xml
<add key="serilog:using:Seq" value="Serilog.Sinks.Seq" />
<add key="serilog:write-to:Seq.serverUrl" value="http://localhost:5341" />
<add key="serilog:write-to:Seq.apiKey" value="[optional API key here]" />
```

### Adding a custom log property to all log items

You may wish to add a log property to all log messages. A good example could be a log property for the `environment` to determine if the log message came from `development` or `production`.

This is useful when you could be writing logs from all environments or multiple customer projects into a single logging source, such as Elasticsearch. This would allow you to search and filter for a specific project and its environment to see the log messages.  You can also reference your hosting server's environment variables in the property values.

In the `/config/serilog.user.config` file you can add the following lines, which the values could be changed or transformed as needed.

```xml
<add key="serilog:enrich:with-property:customer" value="Super Customer" />
<add key="serilog:enrich:with-property:environment" value="Production" />
<add key="serilog:enrich:with-property:deploymentId" value="%WEBSITE_DEPLOYMENT_ID%" /> <!-- reference your hosting server's environment variables, eg. if using Azure -->
```
