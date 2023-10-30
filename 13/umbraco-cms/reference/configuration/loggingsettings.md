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
      "Directory": "~/CustomLogFileLocation"
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
