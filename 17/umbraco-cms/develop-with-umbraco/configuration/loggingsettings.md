---
description: "Information on the logging settings section."
---

# Logging settings

The majority of logging related configuration has been moved to the Serilog configuration see [Serilog settings](serilog.md) for more information.

The following configuration is available in the Logging settings:

```json
"Umbraco": {
  "CMS": {
    "Logging": {
      "MaxLogAge": "2.00:00:00",
      "Directory": "~/CustomLogFileLocation",
      "FileNameFormat": "UmbracoTraceLog.{0}..json",
      "FileNameFormatArguments": "MachineName",
      "SessionIdLogging": "SessionId"
    }
  }
}
```

## MaxLogAge

This setting allows you to configure the maximum log age for the internal audit log scrubbing. The default maximum age for the internal audit log is 24 hours. Change the duration with the `MaxLogAge` key in the Logging settings.

To increase the maximum age of the entries in the audit log to 48 hours (2 days), set the value to `2.00:00:00`.

## Directory

By default, all log files are saved to the `umbraco/Logs` directory. You can define a custom directory for your log files by using the `Directory` key in the Logging settings.

Set the value to `~/LogFiles` to add all log files to a `LogFiles` directory in the root of the file structure.

## FileNameFormat

The default file name format for the Umbraco log file is `UmbracoTraceLog.{0}..json`. The single argument is replaced at runtime with the server's machine name.

If you want to change the file name or include additional arguments, you can amend the format with the `FileNameFormat` setting.

## FileNameFormatArguments

By default the single argument for the log file format name is the server's machine name.

Other or additional arguments can be provided via the `FileNameFormatArguments` setting using a comma-delimited string:

- `MachineName` - the server's name.
- `EnvironmentName` - the ASP.NET environment name such as "Development" or "Production.

So for example, to provide both supported arguments you would configure `MachineName,EnvironmentName`.

The number of arguments provided should match the placeholders in the configured `FileNameFormat`.

## SessionIdLogging

This setting determines how log events are enriched with a session identifier. The identifier correlates the log entries produced while handling requests from the same session.

The available options are:

- `SessionId` (default) - Enriches log events with the actual ASP.NET Core session id. This matches the historical behavior. Reading the session id forces the session to be loaded from its store, which is a blocking round-trip per request when the session is backed by an `IDistributedCache` (for example, on a load-balanced setup or when using a standalone L2 cache).
- `CookieHash` - Enriches log events with a one-way hash of the session cookie value. This provides the same per-session correlation as `SessionId` without loading the session from its store, so it never incurs a distributed-cache round-trip.
- `None` - Does not enrich log events with a session identifier.

If your session is backed by an `IDistributedCache`, consider setting this to `CookieHash` or `None`. This avoids the blocking session-store load that resolving the actual session id incurs on each request.
