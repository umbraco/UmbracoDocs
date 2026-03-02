---
description: >-
  The Cockpit is a tool to let you view data directly on the front end of the
  website.
---

# Cockpit

Umbraco Engage includes a cockpit feature to help verify the tracking of analytics and understand personalization behavior. The cockpit adds a button to the front end, giving real-time insights.

As of Umbraco Engage 16, the cockpit is automatically added and visible for logged-in Umbraco users.

{% hint style="info" %}
Automatic injection of the Cockpit can be disabled by setting ‘**Engage:Cockpit:EnableInjection**’ configuration to **false** in your appsettings.json file.
{% endhint %}

When visiting the front-end website, the Umbraco Engage Cockpit will appear on the left or right side of the screen. The cockpit will only be rendered if the user is logged into Umbraco.

![Umbraco Engage Cockpit](../../.gitbook/assets/engage-cockpit.png)

Clicking the **Open** button provides detailed information:

![Umbraco Engage Cockpit - Detailed information](../../.gitbook/assets/engage-cockpit-2.png)

If the Cockpit is missing and the Umbraco backoffice runs on a different domain, see the [Load Balancing and CM/CD Environments](loadbalancing-and-cm-cd-environments.md) article.

## Opening the Cockpit in CM/CD Environments

In load-balanced setups where the backoffice runs separately, you can use the **Open Cockpit** button in the Engage dashboard to open the Cockpit. This provides secure authentication without requiring cookie domain configuration.

See [Load Balancing and CM/CD Environments](loadbalancing-and-cm-cd-environments.md#cockpit) for detailed setup instructions.
