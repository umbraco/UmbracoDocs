---
description: >-
  This article explains how to use the uMarketingSuite cockpit to verify tracking and understand personalization in your analytics.
---

# Cockpit Insights

uMarketingSuite includes a cockpit feature to help verify the tracking of analytics and understand personalization behavior. The cockpit adds a button to the frontend, giving real-time insights:

![]()

Clicking the button provides detailed information:

![]()

## Adding the Cockpit to Your Website

To add the cockpit to your website:

1. Render the HTML partial provided by uMarketingSuite.
2. The partial view is located at `/Views/Partials/uMarketings/Cockpit.cshtml`.
3. Insert the following code before the closing `</body>` tag: 

    ```cs
    @Html.Partial("uMarketingSuite/Cockpit")
    ```

The cockpit will only be rendered if the user is logged into Umbraco.
