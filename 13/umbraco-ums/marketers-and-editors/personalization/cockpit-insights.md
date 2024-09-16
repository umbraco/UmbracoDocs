# Cockpit Insights

To verify whether the tracking of uMarketingSuite analytics works correctly and to get a better understanding of the way personalization works in the uMarketingSuite we've added a cockpit to the uMarketingSuite. The cockpit gives you an additional button in the frontend that allows you to see what actually is going on:

![]()

If you click on it, it will open and you see even more information:

![]()

To add the cockpit to your website you need to render the html partial that is shipped by default by the uMarketingSuite. The partial view is located in the folder **/Views/Partials/uMarketings/Cockpit.cshtml**.

The view can be rendered by adding in this code snippets before the closing **&lt;/body&gt;**-tag:

    @Html.Partial("uMarketingSuite/Cockpit")

The cockpit itself will only be rendered if the user is logged into Umbraco.