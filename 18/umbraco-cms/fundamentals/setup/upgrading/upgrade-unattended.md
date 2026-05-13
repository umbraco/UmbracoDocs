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

{% hint style=”info” %}
The behavior described below applies to Umbraco 17.3 and later. In earlier versions, migrations ran synchronously before the web server started accepting requests.
{% endhint %}

When the application starts, migrations run in a background service after the web server begins listening. During the migration the RuntimeLevel is `Upgrading`. The web server is reachable during this time, serving health probe responses and maintenance pages.

Once all migrations complete, the RuntimeLevel transitions to `Run` and the site operates normally.

### HTTP behavior during upgrade

While the RuntimeLevel is `Upgrading`, Umbraco responds differently depending on the request surface:

| Surface | Behavior |
|---|---|
| Frontend | HTTP 503 with `Upgrading.cshtml` view |
| Surface controllers | HTTP 503 with `Upgrading.cshtml` view |
| Backoffice | Upgrade-in-progress screen |
| Management API | HTTP 503 JSON ProblemDetails |
| Delivery API | HTTP 503 JSON ProblemDetails |

The [liveness probe](../server-setup/health-probes.md) returns HTTP 200 during the upgrade, confirming the process is alive. The [readiness probe](../server-setup/health-probes.md) returns HTTP 503, indicating the site is not yet ready to serve normal traffic.

You can customize the maintenance page shown to frontend visitors by setting the `Umbraco:CMS:Global:UpgradingViewPath` configuration key. See [Global Settings](../../../reference/configuration/globalsettings.md#upgrading-view-path) for details.

## Unattended upgrades in a load-balanced setup

Follow the steps outlined below to use unattended upgrades in a load-balanced setup.

1. [Upgrade Umbraco via NuGet](upgrade-details.md#upgrade-to-a-new-major).
2. Deploy to all environments.
3. Set the `Umbraco:CMS:Unattended:UpgradeUnattended` configuration key to `true` for the **Main server** only.
4. Boot the Main server, and the upgrade will run automatically.
5. Wait for the upgrade to complete.
6. Boot the **Read-Only** servers and ensure they do not show the “Upgrade Required” screen.

You can use the [readiness probe](../server-setup/health-probes.md) to let your load balancer detect when each server has completed its upgrade and is ready to receive traffic.
