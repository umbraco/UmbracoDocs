# Enable logging on Umbraco Cloud projects

On all Umbraco Cloud projects, logging is currently disabled. We are working on getting it resolved as soon as possible.

If you need logging on your site beofre we roll out the fix, here's a guide on how to do just that.

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
