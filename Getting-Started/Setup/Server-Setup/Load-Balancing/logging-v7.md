---
versionFrom: 7.0.0
---

# Logging with load balancing

Since Umbraco is using log4net for logging there are various configurations that you can use to ensure logging is done the way that you'd like.
If you are using file based logs you'll want to ensure that your logs are named with file names that include the machine name, otherwise you'll get file locks. *(See below for details on how to do this)*

Other options include changing your log4net setup to log to a centralized database - keep in mind that if your database cannot be accessed then no logging will occur.

## Log4net file logging with machine name

This describes how you can configure log4net to write log files that are named with the machine name.

Update your log4net configuration's appender's file value as below:

```xml
<appender .... >
<!--
    THIS IS THAT VALUE THAT UMBRACO IS SHIPPED WITH THAT DOES NOT
    INCLUDE THE MACHINE NAME IN THE FILE
    <file value="App_Data\Logs\UmbracoTraceLog.txt" />
-->

<!-- THIS IS THE NEW CHANGE TO HAVE A MACHINE NAME IN THE FILE NAME -->
<file type="log4net.Util.PatternString" value="App_Data\Logs\UmbracoTraceLog.%property{log4net:HostName}.txt" />

</appender>
```
