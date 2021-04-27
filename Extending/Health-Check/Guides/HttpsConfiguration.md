---
versionFrom: 9.0.0
state: complete
updated-links: true
verified-against: alpha-3
---

# Health check: HTTPS Configuration

_Checks if your site is configured to work over HTTPS and if the Umbraco related configuration for that is correct._

## How to fix this health check

This health check actuall checks a couple of things.

First of all, it ensures that your website is running on HTTPS using a valid certificate.

Furthermore, it is used to specify the configuration on the following path: `Umbraco:CMS:Global:UseHttps`.

This configuration can be setup in a configuration source of your choice. This guide shows how to set it up in one of the json file sources.

### Updating the json configuration

The following json needs to be merged into one of you json sources. By default the following json sources are used: `appSettings.json` and `appSettings.<environment>.json`, e.g. `appSettings.Development.json` or `appSettings.Production.json`.

```json
{
    "Umbraco": {
        "CMS": {
            "Global": {
                "UseHttps": <false,true>
            }
        }
    }
}
```

One example that can be used:

```json
{
    "Umbraco": {
        "CMS": {
            "Global": {
                "UseHttps": true
            }
        }
    }
}
```
