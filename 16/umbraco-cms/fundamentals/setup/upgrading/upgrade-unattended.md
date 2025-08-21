---
description: Learn how to enable unattended upgrades, allowing your project to upgrade without your interference.
---

# Upgrade Unattended

When upgrading your Umbraco project, you can enable the upgrade to run unattended. This means that you will not need to run through the installation wizard when upgrading.

{% hint style="info" %}

Are you running a load-balanced setup with multiple servers and environments?

Check out the section about [Unattended upgrades in a load-balanced setup](#unattended-upgrades-in-a-load-balanced-setup).

{% endhint %}

## Enable the unattended upgrade feature

1. Add the `Umbraco:Cms:Unattended:UpgradeUnattended` configuration key.
2. Set the value of the key to `true`.

{% code title="appsettings.json" %}

```json
{
    "Umbraco": {
        "CMS": {
            "Unattended": {
                "UpgradeUnattended": true
            }
        }
    }
}
```

{% endcode %}

## Run the upgrade

With the correct configuration applied, the project will be upgraded on the next boot.

### Boot order

The Runtime level uses `Run` instead of `Upgrade` to allow the website to continue to boot up directly after the migration is run. This happens instead of initiating the otherwise required restart.

{% hint style="info" %}
The upgrade is run after Composers but before Components, and the `UmbracoApplicationStartingNotification`. This is because the migration requires services that are registered in Composers, and Components require that Umbraco and the database are ready.
{% endhint %}

## Unattended upgrades in a load-balanced setup

Follow the steps outlined below to use unattended upgrades in a load-balanced setup.

1. [Upgrade Umbraco via NuGet](upgrade-details.md#upgrade-to-a-new-major).
2. Deploy to all environments.
3. Set the `Umbraco:CMS:Unattended:UpgradeUnattended` configuration key to `true` for the **Main server** only.
4. Boot the Main server, and the upgrade will run automatically.
5. Wait for the upgrade to complete.
6. Boot the **Read-Only** servers and ensure they do not show the “Upgrade Required” screen.
