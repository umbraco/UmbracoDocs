# Distributed jobs settings

The distributed jobs settings allow you to configure how Umbraco handles distributed background jobs in a load-balanced environment.

## Configuration
```json
"Umbraco": {
  "CMS": {
    "DistributedJobs": {
      "Period": "00:00:05",
      "Delay": "00:01:00",
      "MaximumExecutionTime": "00:05:00"
    }
  }
}
```

## Settings

### Period

**Default:** `00:00:05` (5 seconds)

Specifies how frequently each server checks for distributed background jobs that need to be run.

A shorter period means jobs are picked up more quickly, but increases the frequency of database queries. A longer period reduces overhead but may introduce delays in job execution.

### Delay

**Default:** `00:01:00` (1 minute)

Specifies how long the server should wait after initial startup before beginning to check for and run distributed background jobs. This startup delay ensures that the application is fully initialized and stable before participating in distributed job processing.

### MaximumExecutionTime

**Default:** `00:05:00` (5 minutes)

Specifies the maximum time a distributed job can run before it is considered stale. Jobs that are currently being executed by another server are not picked up by other servers, preventing duplicate execution. However, if a job exceeds this time threshold, it is considered abandoned and can be picked up by another server for recovery.

This setting is useful for handling scenarios where a server crashes or becomes unresponsive while processing a job. By setting an appropriate maximum execution time, the system can automatically recover and reassign stale jobs to healthy servers.
