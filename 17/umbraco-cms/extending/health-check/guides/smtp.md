# Health check: SMTP

_Checks that valid settings for sending emails are in place._

## How to fix this health check

This health check can be fixed by providing configuration on the following path: `Umbraco:CMS:Global:Smtp`

This configuration can be setup in a configuration source of your choice. This guide shows how to set it up in one of the JSON file sources.

### Updating the JSON configuration

The following JSON needs to be merged into one of your JSON sources. By default the following JSON sources are used: `appSettings.json` and `appSettings.<environment>.json`, e.g. `appSettings.Development.json` or `appSettings.Production.json`.

```json
{
    "Umbraco": {
        "CMS": {
            "Global": {
                "Smtp": {
                    "From": "<your email>",
                    "Host": "<host>",
                    "Port": <port>,
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

An example that can be used on localhost, is if you have a local Simple Mail Transfer Protocol (SMTP) server running during development. This could be a tool like [Smtp4dev](https://github.com/rnwood/smtp4dev).

```json
{
    "Umbraco": {
        "CMS": {
            "Global": {
                "Smtp": {
                    "From": "my@email.com",
                    "Host": "localhost",
                    "Port": 25
                }
            }
        }
    }
}
```
