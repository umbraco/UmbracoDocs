---
description: "Information on the serilog settings section"
---

# Serilog settings

Umbraco uses Serilog as its logging library, this means that the configuration of logging is offloaded to Serilog instead of the CMS. This means that logging specific configuration is not in the `Umbraco.Cms` section, but instead the Serilog section.

We will go through some of the more common logging configurations here, but for more information see the [Serilog settings GitHub project](https://github.com/serilog/serilog-settings-configuration).

## Default configuration

When you create a new Umbraco project the following Serilog section will be included by default:

```json
"Serilog": {
  "MinimumLevel": {
    "Default": "Information",
    "Override": {
      "Microsoft": "Warning",
      "Microsoft.Hosting.Lifetime": "Information",
      "System": "Warning"
    }
  }
}
```

## Specifying minimum log level

As you can see above, the CMS comes with a default Serilog config that defines the minimum log level with the `"MinimumLevel"` key.

You can specify the overall minimum log level with the `"Default"` key. This will apply to all namespaces, however it's also possible to override this log level for specific names spaces with the `"Override"` key. In the example above, any logging coming from the `Microsoft` and `System` namespaces will only log warnings and up, however the `Microsoft.Hosting.Lifetime` namespace will log information and up.

The possible values, from most verbose to least, is:

* Verbose
* Debug
* Information
* Warning
* Error
* Fatal

For information on what each of these levels means see [the serilog wiki](https://github.com/serilog/serilog/wiki/Configuration-Basics#minimum-level).


## Changing the log level for specific namespaces

This can be done by updating the appsettings.json configuration file to specify namespaces in which you want to change the log level for.

```json
  "Serilog": {
    "MinimumLevel": {
      "Default": "Information",
      "Override": {
        "Microsoft": "Warning",
        "Microsoft.Hosting.Lifetime": "Information",
        "System": "Warning",
        "Examine.Lucene.Providers.LuceneIndex": "Debug",
        "Examine.BaseIndexProvider": "Debug",
        "MyNamespace": "Verbose"
      }
    }
  }
```

## Logging to a different output

Serilog has the ability to log to a number of different mechanisms, from console to files, even to Slack or email. This is all configured using what Serilog calls sinks.

An example of this can be seen in the default `appsettings.Development.json`, where Serilog is configured to log to the console using the Async wrapper sink:

```json
  "Serilog": {
    "MinimumLevel": {
      "Default": "Information"
    },
    "WriteTo": [
      {
        "Name": "Async",
        "Args": {
          "configure": [
            {
              "Name": "Console"
            }
          ]
        }
      }
    ]
  }
```

Here you can see that we use the `"WriteTo"` key to specify a list of sinks the logger should write to. In this case we use the `"Async"` sink configured to write to the console, this means that we'll log to the console asynchronously.

Now there's too many sinks to cover here, for a full list of all available sinks see [Provided sinks](https://github.com/serilog/serilog/wiki/Provided-Sinks#list-of-available-sinks). Each of these entries will have their own documentation on how to set up the logging with the particular sink.

## Changing the Umbraco 'sink'
By default, Umbraco uses a special Serilog 'sink' that is optimized for performance. To change parameters for only this sink, but not the default. For E.g higher log lever for this compared to other sinks you can do it in the following way:

```json
  "Serilog": {
    "MinimumLevel": {
      "Default": "Information"
    },
    "WriteTo": [
      {
        "Name": "UmbracoFile",
        "Args": {
          "RestrictedToMinimumLevel": "Warning",
          "FileSizeLimitBytes": 1073741824,
          "RollingInterval" : "Day",
          "FlushToDiskInterval": null,
          "RollOnFileSizeLimit": false,
          "RetainedFileCountLimit": 31
        }
      }
    ]
  }
```

## Adding a custom log property to all log items

You may wish to add a log property to all log messages. A good example could be a log property for the `environment` to determine if the log message came from `development` or `production`.

This is useful when you could be writing logs from all environments or multiple customer projects into a single logging source, such as Elasticsearch. This would allow you to search and filter for a specific project and its environment to see the log messages.  You can also reference your hosting server's environment variables in the property values.

In the `appsettings.json` configuration file you can add the following lines

```json
  "Serilog": {
    "MinimumLevel": {
      "Default": "Information",
      "Override": {
        "Microsoft": "Warning",
        "Microsoft.Hosting.Lifetime": "Information",
        "System": "Warning"
      }
    },
    "Properties": {
      "Customer": "Super Customer",
      "Environment": "Production"
    }
  }
```
