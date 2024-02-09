---


meta.Title: "Umbraco Debug Settings"
description: "Information on debug settings section"
---

# Debug settings

This section contains configurations regarding debugging, and should therefore only be used in development.

The debug section has two settings you can configure, `"LogIncompletedScopes"` and `"DumpOnTimeoutThreadAbort"`, both of these are false by default:

```json
"Umbraco": {
  "CMS": {
    "Debug": {
      "DumpOnTimeoutThreadAbort": false
      "LogIncompletedScopes": false,
    }
  }
}
```

## Log incompleted scopes

If this value is set to true, any scope that gets disposed without first being completed will trigger a log entry containing the stacktrace.

## DumpOnTimeoutThreadAbort

If this value is set to true, a memory dump will be taken if a thread aborts due to a timeout. This dump will be saved to `/umbraco/Data/MiniDump`.
