---
versionFrom: 8.0.0
---

# Configuration Files

_This section will explain the many configuration options in Umbraco and what they do_

### [web.config](webconfig/)
This file can be found at the following path: /web.config

### [tinyMceConfig.config](tinyMceConfig/index.md)
The 'tinyMceConfig.config' contains configuration options for the [TinyMce](https://www.tinymce.com/) editors in the Umbraco Backoffice.

This file can be found at the following path: /config/tinyMceConfig.config

### [umbracoSettings.config](umbracoSettings/index.md)

Contains many Umbraco options. Generally the default values work well in most installs; however, in some cases some of these options may need adjusting depending on each installation.

This file can be found at the following path: /config/umbracoSettings.config

### [healthChecks.config](healthchecks/index.md)

Contains the configuration for the health checks, allowing you to disable certain checks when not applicable and to manage the notifications.

This file can be found at the following path: /config/HealthChecks.config

## clientdependency.config

The ClientDependency configuration options can be found on the [ClientDependency website](https://github.com/Shandem/ClientDependency/wiki/Configuration).

This file can be found at the following path: /config/ClientDependency.config

## [SeriLog.config](Serilog/index.md)

In v8 Serilog is used for logging, use these files to configure this:

* `/config/serilog.config` is used to modify the main Umbraco logging pipeline
* `/config/serilog.user.config` which is a sublogger and allows you to make
