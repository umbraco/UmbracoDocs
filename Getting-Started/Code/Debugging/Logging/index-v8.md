---
keywords: logging serilog messagetemplates logs v8 version8
versionFrom: 8.0.0
---
# Logging

In Umbraco v8.0+ we have changed the underlying logging framework from Log4Net to Serilog.

Out of the box for v8.0+ we will write two log files to disk, a .txt file in the same identical format as previously logged by Log4Net, so that you can continue to use any tools or regular expressions you may have used and secondly we will write a JSON file that contains a more rich logfile, that allows tools to perform searches & correlation on log patterns alot easier.

The default location of these files are written to `App_Data/Logs` and contains the Machine name, along with the date too:
* `/App_Data/Logs/UmbracoTraceLog.DELLBOOK.20181108.txt`
* `/App_Data/Logs/UmbracoTraceLog.DELLBOOK.20181108.json`


## Structured logging
Serilog is a logging framework that allows us to do structured logging or write log messages using the message template format, allowing us to


```
2018-11-12 08:34:50,419 [P27004/D2/T1] INFO   Umbraco.Core.Runtime.CoreRuntime - Booted. (4586ms) [Timing 9e76e5f]
```

Here is an example of the same log message represented as JSON, you can see here we have much more information that would allow us to search & filter logs based on these properties with an appropiate logging system.

```json
{
  "@t": "2018-11-12T08:34:50.4190399Z",
  "@mt": "{EndMessage} ({Duration}ms) [Timing {TimingId}]",
  "EndMessage": "Booted.",
  "Duration": 4586,
  "TimingId": "9e76e5f",
  "SourceContext": "Umbraco.Core.Runtime.CoreRuntime",
  "ProcessId": 27004,
  "ProcessName": "iisexpress",
  "ThreadId": 1,
  "AppDomainId": 2,
  "AppDomainAppId": "LMW3SVC2ROOT",
  "MachineName": "DELLBOOK",
  "Log4NetLevel": "INFO ",
  "HttpRequestNumber": 1,
  "HttpRequestId": "557f45ba-0888-4216-8723-e226d795a2f7"
}
```

To learn more about structured logging and message templates you can read more about it over on the https://messagetemplates.org website

## Writing to the log
...
Bad usages & why
Good usages

## Log Levels
Serilog uses levels as the primary means for assigning importance to log events. The levels in increasing order of importance are:

1. **Verbose** - tracing information and debugging minutiae; generally only switched on in unusual situations
1. **Debug** - internal control flow and diagnostic state dumps to facilitate pinpointing of recognised problems
1. **Information** - events of interest or that have relevance to outside observers; the default enabled minimum logging level
1. **Warning** - indicators of possible issues or service/functionality degradation
1. **Error** - indicating a failure within the application or connected system
1. **Fatal** - critical errors causing complete failure of the application

## Changing the log level

## Writing your own log messages to a custom file

## Writing to a different source
Serilog has a similar concept to Log4Net with its appenders, which are referred to Serilog Sinks.
A Serilog Sink, allows you to persist the structured log message

## Adding a custom log property to all log items
You may wish to add a log property to all log messages. A good example could be a Log property for the `environment` to determine if the log message came from `development` or `production`.
This is useful when you could be writing logs from all environments or multiple customer projects into a single logging source, such as ElasticSearch, this would then easily allow you to search and filter for a specific project and its environment to see the log messages.

In the `/config/serilog.user.config` file you can add the following lines, which the values could be changed or transformed as needed.

```xml
<add key="serilog:enrich:with-property:customer" value="Super Customer" />
<add key="serilog:enrich:with-property:environment" value="Production" />
```



## Advanced
### Full C# control over Serilog configuration

### Changing Serilog to another Logging Framework



<hr/>

* default log info
* where on disk and what is created


* configuring
** Create own txt/json log file - containing only

* note changes to config files will need a recyle of app - verify this


* use local/free SEQ and CLI tool to import log from a remote server



## Further Resources
If you are interested in learning more then the following resources will beneficial:

* [Serilog](https://serilog.net/)
* [Serilog Community Gitter Chatroom](https://gitter.im/serilog/serilog)
* [Nicholas Blumhardt Blog, creator of Serilog](https://nblumhardt.com/)
* [Nicholas Blumhardt Blog, creator of Serilog](https://nblumhardt.com/)
* [Serilog Pluralsight Course](https://www.pluralsight.com/courses/modern-structured-logging-serilog-seq)


