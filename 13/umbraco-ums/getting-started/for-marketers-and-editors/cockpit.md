# Cockpit

To enable the uMarketingSuite cockpit add the following partial just above the body end.

    @Html.Partial("uMarketingSuite/Cockpit")</body>

If you reload the page it will show you the uMarketingSuite Cockpit on the left or right side of the screen:

![]()

Click open to see all the features of the Cockpit:

![]()

The cockpit gives you the option to check out all the data that is stored on the fly when browsing through the website. It's also a really easy way to verify your personalization setup.

## Access to the cockpit

When the uMarketingSuite cockpit partial has been added to the page you will see it when you are logged in to Umbraco (!). Visitors of your website won't see the cockpit. If you don't see the cockpit and Umbraco is running on a different domain please refer to the [loadbalancing / CM / CD environments](/installing-umarketingsuite/loadbalancing-and-cm-cd-environments/) section.

### Data reporting client side

If you've setup the [additional Analytics-script](/analytics/clientside-events-and-additional-javascript-files/additional-measurements-with-our-ums-analytics-scripts/) of the uMarketingSuite you'll find all tracked data in the cockpit. 

We will track:

- The time on page. This is defined betweened the time the page was loaded and the current time. So if you visit the website at 11:23:12 and it's now 11:25:30 you're time on page is 2 minutes and 18 seconds.
- The engaged time on page. This is a far more important metric because it measures the time you were active on the page. When you scroll, move your mouse, type or select text on the website you're considered "engaged". As soon as you stop one of these actions and have no other interaction in the next five seconds this engaged timer will be stopped. This could happen when you're browsing in another window or tab of your browser or system, when you went to grab a cup of coffee, or when you're talking to a colleague. The time on page is still counting, but you're not engaged at that moment.
- The script tracks the maximum scrolldepth that you have reached. Both in absolute pixels and as a percentage
- We keep track off all [fired events](/analytics/clientside-events-and-additional-javascript-files/create-your-own-events/) within the uMarketingSuite
- And finally we measure every outclick to another domain, a pdf-file or excel-file by default

![]()

### Data reporting server side

In this section you'll see all the data that is capture server side:

- The browser,
- the type of device,
- the IP address (anonymized or not; depending on your [settings](/installing-umarketingsuite/configuration-options-1-x/))
- The total number of pages you've visited in this session
- The total number of sessions you've had with this cookie

Also you have the option to easily delete your uMarketingSuite cookie

![]()

### Segments

In the segments section you can easily see which segments are configured and which are applied to the current visitor. 

![]()