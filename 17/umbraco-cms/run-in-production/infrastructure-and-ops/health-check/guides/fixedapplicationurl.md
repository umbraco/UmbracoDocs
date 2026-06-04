# Fixed Application Url

_Checks that an application URL is available. This URL is used by features that need an absolute URL, such as password-reset and user-invitation emails sent from the backoffice._

The check has three possible outcomes:

| Condition | Result |
| --- | --- |
| `UmbracoApplicationUrl` is set | **Success** |
| `UmbracoApplicationUrl` is not set, but `ApplicationUrlDetection` is `FirstRequest` or `EveryRequest` | **Warning** — the application URL is detected from incoming requests. Setting it explicitly is recommended. |
| `UmbracoApplicationUrl` is not set **and** `ApplicationUrlDetection` is `None` | **Error** — no URL is configured and none will ever be detected. |

When the check returns an **Error**, no application URL is available and nothing will detect one. Features that require an absolute URL - such as password-reset and user-invitation emails - will not work until the configuration is corrected.

## How to fix this health check

There are two ways to resolve this health check. Setting the application URL explicitly is the recommended approach for production environments.

### Option 1: Set the application URL explicitly (recommended)

Provide configuration on the following path: `Umbraco:CMS:WebRouting:UmbracoApplicationUrl`.

This configuration can be setup in a configuration source of your choice. This guide shows how to set it up in one of the JSON file sources.

#### Updating the JSON configuration

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

### Option 2: Enable application URL detection

Alternatively, set `Umbraco:CMS:WebRouting:ApplicationUrlDetection` to `FirstRequest` or `EveryRequest`, so that the application URL is detected automatically from incoming requests. This resolves the **Error** to a **Warning**.

```json
{
    "Umbraco": {
        "CMS": {
            "WebRouting": {
                "ApplicationUrlDetection": "FirstRequest"
            }
        }
    }
}
```

For details on the available detection modes and their security implications, see [Application URL detection](../../../../develop-with-umbraco/configuration/webroutingsettings.md#application-url-detection) in the WebRouting settings documentation.
