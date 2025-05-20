# Fixed Application Url

_Check to make sure a fixed application URL is specified. This URL is for example used when sending emails from backoffice._\
_If this is not specified in configuration, Umbraco gets the application URL from last host used to request the application_

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

{% hint style="info" %}
If the site is hosted on Umbraco Cloud, changing the above configuration will have no effect. The site will always use the URL set in the\`umbraco-cloud.json\` file, which can not be changed.
{% endhint %}
