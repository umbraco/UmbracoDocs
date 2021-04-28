---
versionFrom: 9.0.0
state: complete
updated-links: true
verified-against: alpha-3
---

# Health check: SMTP

_Checks that valid settings for sending emails are in place._

## How to fix this health check

This health check can be fixed by providing configuration on the following path: `Umbraco:CMS:Global:Smtp`

This configuration can be setup in a configuration source of your choice, but this guide only shows how to setup in one of the json file sources.

### Updating the json configuration

The following json needs to be merged into one of you json sources. By default the following json sources are used: `appSettings.json` and `appSettings.<environment>.json`, e.g. `appSettings.Development.json` or `appSettings.Production.json`.

```json
{
    "Umbraco": {
        "CMS": {
            "Global": {
                "Smtp": {
                    "From": "<your email>",
                    "Host": "<host>",
                    "Port": "<port>",
                    "PickupDirectoryLocation": "<optional directory>",
                    "Username": "<optional username>",
                    "Password": "<optional password>",
                    "DeliveryMethod": "<Network(default)|SpecifiedPickupDirectory|PickupDirectoryFromIis>",
                    "SecureSocketOptions": "<None|Auto(default)|SslOnConnect|StartTls|StartTlsWhenAvailable>"
                }
            }
        }
    }
}
```

One example that can be used on localhost, if you have a (fake) SMTP server running doing development. E.g. [Smtp4dev](https://github.com/rnwood/smtp4dev)

```json
{
    "Umbraco": {
        "CMS": {
            "Global": {
                "Smtp": {
                    "From": "my@email.com",
                    "Host": "localhost",
                    "Port": "25"
                }
            }
        }
    }
}
```
