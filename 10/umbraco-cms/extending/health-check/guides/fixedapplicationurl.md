---
versionFrom: 9.0.0
versionTo: 10.0.0
---

# Health check: Fixed Application Url

_Check to make sure a fixed application url is specified. This url is for example used when sending emails from backoffice.
If this is not specified in configuration, Umbraco gets the application url from last host used to request the application_


## How to fix this health check

This health check can be fixed by providing configuration on the following path: `Umbraco:CMS:WebRouting:UmbracoApplicationUrl`.

This configuration can be setup in a configuration source of your choice. This guide shows how to set it up in one of the JSON file sources.

### Updating the JSON configuration

The following JSON needs to be merged into one of your JSON sources. By default the following JSON sources are used: `appSettings.json` and `appSettings.<environment>.json`, e.g. `appSettings.Development.json` or `appSettings.Production.json`.

```json
{
    "Umbraco": {
        "CMS": {
            "WebRouting": {
                "UmbracoApplicationUrl": "string"
            }
        }
    }
}
```

One example that can be used in production

```json
{
    "Umbraco": {
        "CMS": {
            "WebRouting": {
                "UmbracoApplicationUrl": "https://www.my-custom-domain.com/"
            }
        }
    }
}
```
