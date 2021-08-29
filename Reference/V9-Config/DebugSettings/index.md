---
versionFrom: 9.0.0
meta.Title: "Umbraco Debug Settings"
meta.Description: "Information on debug settings section"
state: complete
verified-against: beta-3
update-links: true
---

# Debug settings

This section contains configurations regarding debugging, and should therefore only be used in development.

The debug section has two settings you can configure, `"LogIncompletedScopes"` and `"DumpOnTimeoutThreadAbort"`, both of these are false by default:

```json
"Umbraco": {
  "CMS": {
    "Debug": {
      "LogIncompletedScopes": false,
      "DumpOnTimeoutThreadAbort": false
    }
  }
}
```

## Log incopleted scopes

If this value is set to true, any scope that gets disposed without first being completed will trigger a log entry containing the stacktrace.

## DumpOnTimeoutThreadAbort

If this value is set to true a memory dump will be taken if a thread aborts due to a timeout, this dump will be saved to `/umbraco/Data/MiniDump`
