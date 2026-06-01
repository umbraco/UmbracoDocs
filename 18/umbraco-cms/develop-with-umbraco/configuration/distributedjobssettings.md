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

Adds a grace period on top of the job's own `Period` before a running job is considered stale.

A job that is marked as running in the database is normally skipped by other servers, which prevents duplicate execution. A job becomes eligible for recovery only when more than `Period + MaximumExecutionTime` has elapsed since `LastAttemptedRun`. The `Period` here is the job's own `Period` property — not the polling `Period` defined above.

For example, a job with a 20-minute `Period` and the default 5-minute `MaximumExecutionTime` is recoverable 25 minutes after the last attempted start.

`MaximumExecutionTime` only applies when a job's `finally` block never runs — for example when the server crashes or is forcibly killed mid-job. When a server shuts down gracefully and the job observes the cancellation token, the host clears the running flag and stamps `LastRun` as part of cleanup. The job is then eligible again on its normal cadence — `Period` after the cancellation moment — and `MaximumExecutionTime` is not used.
