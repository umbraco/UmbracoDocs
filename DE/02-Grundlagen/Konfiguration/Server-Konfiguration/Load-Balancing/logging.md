---
versionFrom: 8.0.0
versionTo: 9.0.0
---

# Logging with load balancing

Umbraco v8+ uses Serilog for logging. When load balancing Umbraco consideration should be given as to how the log files from each server will be accessed.

There are many Serilog Sinks available and one of these may be appropriate to store logs for all servers in a central repository such as Azure Application Insights or Elmah.io.

See [SeriLog Provided Sinks](https://github.com/serilog/serilog/wiki/Provided-Sinks) for more info
