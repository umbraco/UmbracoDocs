# Distributed jobs settings

The distributed jobs settings allow you to configure how Umbraco handles distributed background jobs in a load-balanced environment.

## Configuration
```json
"Umbraco": {
  "CMS": {
    "DistributedJobs": {
      "Period": "00:00:05",
      "Delay": "00:01:00"
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
