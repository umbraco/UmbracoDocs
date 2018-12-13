# Enable logging on Umbraco Cloud projects

:::warning
If you do this on several environments you need to use unique names on each. Check out the [config transforms section](#config-transforms-of-log4netconfig)
:::

On all Umbraco Cloud projects, logging is currently disabled. We are working on getting it resolved as soon as possible.

If you need logging on your site before we roll out the fix, here's a guide on how to do just that.

1. Clone down your Cloud project to your local machine
2. Open `Config/log4net.config`

You need to change the name of the log files. This is how the default setting will look:

```xml
<appender name="rollingFile" type="log4net.Appender.RollingFileAppender">
	  <file type="log4net.Util.PatternString" value="App_Data\Logs\UmbracoTraceLog.%property{log4net:HostName}.txt" />
```

In order to change the name of the log files, you need to replace `UmbracoTraceLog` with something unique.

In the example below, I've changed the file name to `SwautoTraceLog`.

```xml
<appender name="rollingFile" type="log4net.Appender.RollingFileAppender">
	  <file type="log4net.Util.PatternString" value="App_Data\Logs\SwautoTraceLog.%property{log4net:HostName}.txt" />
```

Push the change to the Cloud environment, and deploy the change all the way to the Live environment.

:::warning
This is a config change, which means that deploying this to your Cloud environments, will cause the environments to restart.
:::

With this setting in place, your log files will now look something like this: `SwautoTraceLog.PrWeSWEs2V3QD.txt`.


## Config transforms of log4net.config

By default your `~/Config/log4net.config` file will look something like this:

```xml
<?xml version="1.0"?>
<log4net>
  
  <root>
    <priority value="Info" />
    <appender-ref ref="AsynchronousLog4NetAppender" />
  </root>

  <appender name="rollingFile" type="log4net.Appender.RollingFileAppender">
	  <file type="log4net.Util.PatternString" value="App_Data\Logs\UmbracoTraceLog.%property{log4net:HostName}.txt" />
    <lockingModel type="log4net.Appender.FileAppender+MinimalLock" />
    <appendToFile value="true" />
    <rollingStyle value="Date" />
    <maximumFileSize value="5MB" />
    <layout type="log4net.Layout.PatternLayout">
      <conversionPattern value=" %date [P%property{processId}/D%property{appDomainId}/T%thread] %-5level %logger - %message%newline" />
    </layout>
    <encoding value="utf-8" />
  </appender>

  <appender name="AsynchronousLog4NetAppender" type="Log4Net.Async.ParallelForwardingAppender,Log4Net.Async">
    <appender-ref ref="rollingFile" />
  <appender-ref ref="UCDbErrors" /></appender>

  <!--Here you can change the way logging works for certain namespaces  -->

  <logger name="NHibernate">
    <level value="WARN" />
  </logger>
  
  
<appender name="UCDbErrors" type="log4net.Appender.AdoNetAppender"><bufferSize value="25" /><filter type="log4net.Filter.LoggerMatchFilter"><loggerToMatch value="Umbraco.Web.Scheduling.ScheduledPublishing" /><acceptOnMatch value="false" /></filter><filter type="log4net.Filter.LevelRangeFilter"><levelMin value="ERROR" /><levelMax value="FATAL" /></filter><connectionStringName value="umbracoDbDSN" /><connectionType value="System.Data.SqlClient.SqlConnection, System.Data, Version=1.0.3300.0, Culture=neutral, PublicKeyToken=b77a5c561934e089" /><commandText value="INSERT INTO UCErrorLog ([Date],[Thread],[Level],[Logger],[Message],[Exception]) VALUES (@log_date, @thread, @log_level, @logger, @message, @exception)" /><parameter><parameterName value="@log_date" /><dbType value="DateTime" /><layout type="log4net.Layout.RawTimeStampLayout" /></parameter><parameter><parameterName value="@thread" /><dbType value="String" /><size value="255" /><layout type="log4net.Layout.PatternLayout"><conversionPattern value="%thread" /></layout></parameter><parameter><parameterName value="@log_level" /><dbType value="String" /><size value="50" /><layout type="log4net.Layout.PatternLayout"><conversionPattern value="%level" /></layout></parameter><parameter><parameterName value="@logger" /><dbType value="String" /><size value="255" /><layout type="log4net.Layout.PatternLayout"><conversionPattern value="%logger" /></layout></parameter><parameter><parameterName value="@message" /><dbType value="String" /><size value="4000" /><layout type="log4net.Layout.PatternLayout"><conversionPattern value="%message" /></layout></parameter><parameter><parameterName value="@exception" /><dbType value="String" /><size value="-1" /><layout type="log4net.Layout.ExceptionLayout" /></parameter></appender></log4net>
```

Other than that you may have some custom log appenders added below that. Adding a config transform of this file will work the same no matter how many log files you are writing to.

To ensure you have different names for your log files you should follow the [guidelines for config transforms on Cloud](../../Set-Up/Config-Transforms)

One or two config transforms will have to be made, depending on how many environments you have on your project. 

One file called `log4net.development.xdt.config` and if you have a staging environment, one called `log4net.staging.xdt.config`

Inside these files you need to have something like this:

```xml
<?xml version="1.0"?>
<!--For more information on using transformations see the web.config examples at http://go.microsoft.com/fwlink/?LinkId=214134. -->
<log4net xmlns:xdt="http://schemas.microsoft.com/XML-Document-Transform">
  <appender name="rollingFile" type="log4net.Appender.RollingFileAppender" xdt:Locator="Match(name)" xdt:Transform="Replace">
    <file type="log4net.Util.PatternString" value="App_Data\Logs\Dev-UmbracoTraceLog.%property{log4net:HostName}.txt" />
    <lockingModel type="log4net.Appender.FileAppender+MinimalLock" />
    <appendToFile value="true" />
    <rollingStyle value="Date" />
    <maximumFileSize value="5MB" />
    <layout type="log4net.Layout.PatternLayout">
      <conversionPattern value=" %date [P%property{processId}/D%property{appDomainId}/T%thread] %-5level %logger - %message%newline" />
    </layout>
    <encoding value="utf-8" />
  </appender>
</log4net>
```

All this does is to find the *appender* with the *name* `rollingFile` and then it replaces the values inside it. These values are copied from the original file but the path of the log file has been changed from:

`App_Data\Logs\UmbracoTraceLog.%property{log4net:HostName}.txt` to
`App_Data\Logs\Dev-UmbracoTraceLog.%property{log4net:HostName}.txt`

This same kind of config transform can be added for all of the custom appenders as well. The important part is to add an environment specific naming for each file!
