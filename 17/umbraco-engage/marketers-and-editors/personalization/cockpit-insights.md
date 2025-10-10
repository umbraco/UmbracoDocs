---
description: >-
  This article explains how to use the Umbraco Engage cockpit to verify
  tracking and understand personalization in your analytics.
---

# Cockpit Insights

Umbraco Engage includes a cockpit feature to help verify the tracking of analytics and understand personalization behavior. The cockpit adds a button to the front end, giving real-time insights:

![Umbraco Engage cockpit feature](../../.gitbook/assets/engage-cockpit.png)

Clicking the Open button provides detailed information:

![Detailed information displayed after clicking the Open button](../../.gitbook/assets/engage-cockpit-2.png)

## Adding the Cockpit to Your Website

To add the cockpit to your website:

1. Render the HTML partial provided by Umbraco Engage.
2. The partial view is located at `/Views/Partials/uMarketings/Cockpit.cshtml`.
3. Insert the following code before the closing `</body>` tag:

    ```cs
    @Html.Partial("uMarketingSuite/Cockpit")
    ```

The cockpit will only be rendered if the user is logged into Umbraco.
