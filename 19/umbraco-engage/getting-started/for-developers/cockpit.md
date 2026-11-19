---
description: >-
  The Cockpit is a tool to let you view data directly on the front end of the
  website.
---

# Cockpit

Umbraco Engage includes a cockpit feature to help verify the tracking of analytics and understand personalization behavior. The cockpit adds a button to the front end, giving real-time insights.

The cockpit is automatically added. The cockpit is visible for logged-in Umbraco users with access to the **Engage** section.

{% hint style="info" %}
Automatic injection of the Cockpit can be disabled by setting ‘**Engage:Cockpit:EnableInjection**’ configuration to **false** in your appsettings.json file.
{% endhint %}

When visiting the front-end website, the Umbraco Engage Cockpit will appear on the left or right side of the screen. The cockpit is only rendered if the user is logged in to Umbraco and has access to the **Engage** section.

![Umbraco Engage Cockpit](../../.gitbook/assets/engage-cockpit.png)

Each part of the cockpit is shown only when the user's group has the **Read** permission for that feature:

* Analytics data requires the **Read** permission for Analytics.
* Personas, customer journeys, segments, and the personalization variant require the **Read** permission for Personalization.
* The A/B test variant requires the **Read** permission for A/B Testing.
* The link to the visitor profile requires the **Read** permission for Profiles.

Access is checked on every request. Learn more in the [Permissions](../../marketers-and-editors/settings/permissions.md#user-group-permissions) article.

Clicking the **Open** button provides detailed information:

![Umbraco Engage Cockpit - Detailed information](../../.gitbook/assets/engage-cockpit-2.png)

If the Cockpit is missing and the Umbraco backoffice runs on a different domain, see the [Load Balancing and CM/CD Environments](loadbalancing-and-cm-cd-environments.md) article.

## Opening the Cockpit in CM/CD Environments

In load-balanced setups where the backoffice runs separately, you can use the **Open Cockpit** button. It is located in the top-right corner of the **Engage** section. This provides secure authentication without requiring cookie domain configuration.

See [Load Balancing and CM/CD Environments](loadbalancing-and-cm-cd-environments.md#cockpit) for detailed setup instructions.
