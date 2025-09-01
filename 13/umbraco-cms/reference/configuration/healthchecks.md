---
description: "Information on the health check settings section"
---

# Health checks

The health checks section allows you to disable certain health checks, and configure your own custom notification methods, that will automatically run the health checks every so often, and notify you if any health checks fails.

An example of a HealthChecks settings can look something like this:

```json
"Umbraco": {
  "CMS": {
    "HealthChecks": {
      "DisabledChecks": [
        {
          "Id": "D0F7599E-9B2A-4D9E-9883-81C7EDC5616F"
        }
      ],
      "Notification": {
        "Enabled": true,
        "FirstRunTime": "* 4 * * *",
        "Period": "1.00:00:00",
        "NotificationMethods": {
          "email": {
            "Enabled": true,
            "Verbosity": "Detailed",
            "FailureOnly": true,
            "Settings": {
              "RecipientEmail": "alerts@mywebsite.tld"
            }
          }
        }
      }
    }
  }
}
```

This config will disable the macro errors check, and enable notifications to run the checks and notify via email if a check fails. The checks will run the first time five minutes after the site is booted, and then once every day.

The email notification method is built in, if you want to read more about creating you own notification methods, or see a list of the ID of every built in health check, then see [Extending health checks](../../extending/health-check/)

But let's go through the config one by one

## Disabled checks

A list of `DisabledHealthCheckSettings` objects, each of these objects represents a disabled health check. Only the Id key needs to be present and have a value, corresponding to the GUID of the health check to disable.

There is also a `DisabledOn` key representing the date the health check was disabked and a `DisabledBy` key containing the ID of the user that disabled the health check, however these values are currently not used.

## Notification

Settings relating to running the health checks automatically and sending out notifications.

### Enabled

Allows you to disable or enable all notifications methods, if set to false, the health checks will not automatically run.

### First run time

This will configure when you run the health checks for the first time, if the value is not configured the health checks will run immediately after the site boots for the first time. This value is specified as a string in crontab format, so in this example, the health checks will first run at 4 a.m.

### Period

Specifies how often the health checks should run, as a DateTime string, in this example the checks will run every day (every 24 hours).

### Notification methods

A dictionary of all the notification methods that should be used.

The key of the dictionary is the alias of the notification method, and the value is a `HealthChecksNotificationMethodSettings` configuration object, in this case it's the built in `email` notification method.

Each object allows the following to be configured:

#### Enabled

Allows you to enable or disable specific checks.

#### Verbosity

Configures how verbose the reporting should be, the available options are:

* Summary
* Detailed

#### Failure only

If set to true, the notification method will only run if a check has failed.

#### Settings

Allows you to set custom settings for a given implementation of a notification method, which settings are available depends on the specific implementation.
