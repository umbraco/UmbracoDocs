# Troubleshooting Installs

At the moment we are not aware of any problems when installing the uMarketingSuite.\
If you have one please let us know by [submitting an issue on GitHub](https://github.com/uMarketingSolutions/uMarketingSuite/issues/new/choose) or by getting in touch with us

[Please check out our known-issue section for possible issues after installing.](../../../support/known-issues-and-work-arounds/)

### The 'is uMarketingSuite working 100%' checklist ✅

If you are having problems or unsure you have uMarketingSuite all setup and configured, then take a look through this checklist below. Verify you installed the Nuget package **uMarketingSuite** into your Umbraco website

### 1 - The Marketing section

After logging in into Umbraco you should be able to see the Marketing section within Umbraco.\
If you can't see this then please check if your Umbraco user and or user group has been given access to the marketing section.

![]()

### 2 - Marketing Content Tabs

When editing a page within Umbraco you should be able to see the following Content Tabs on the top right of the page;

![]()

If you can not see them then please check if your Umbraco user and or user group has been given access to the marketing section.

### 3 - Cockpit

Is **uMarketingSuite Cockpit tool** visible on frontend of your site **after logging into Umbraco**?\
No? Ensure you added the [Cockpit Partial view](../../../installing-umarketingsuite/cockpit/) in your main template\
![]()

### 4 - Cockpit Client Side Data

Can you see client-side data such as **scroll depth** & **total time** on page in analytics or cockpit?\
No? Ensure you have [added the client side tracking script](../../../analytics/clientside-events-and-additional-javascript-files/additional-measurements-with-our-ums-analytics-scripts/) in your main template\
![]()

### 5 - Umbraco Forms

Go to a Form and add a new question to a form, do you see this option?\
![]()

Goto Marketing -> Settings -> Create a new goal. Do you see the following option called **Umbraco Forms Submission**?\
![]()

If you see both options then this has been configured correctly, if not then ensure your development team have installed the additional [uMarketingSuite.UmbracoForms nuget package](https://www.nuget.org/packages/uMarketingSuite.UmbracoForms)

### 6 - Analytics

Edit a page and go to the Content tab marked **Analytics** or alternatively go to **Marketing** -> **Analytics** from the top navigation.

Are you able to see analytical data, if not then you **need to wait 24 hours for todays analytics** to be collected and reported.

### 7 - Locations for Analytics

Do you see the following message when browsing Analytics for Locations?\
![]()

If so then some configuration is needed by your development team to do a bit of [work to set up and track visitor locations by country and city](../../../analytics/extending-analytics/implement-an-ip-to-location-provider/)

Once setup you will see analytics for countries like this below\
![]()

### 8 - Setup IP Filters

Confirm your own IP of your company/office building has been set to be excluded from uMarketingSuite, to ensure it is excluded from tracking and reporting, along with anyone else who is a content editor of the website.

You can check what your IP is by [Googling for What is My IP](https://www.google.com/search?q=what+is+my+IP) and ensuring it is in the list of IPS by navigating to **Marketing** -> **Settings** -> **IP Filters**

![]()

### 9 - Reload after Cookie consent

To make sure that uMarketingSuite is able to interact with the visitor from the first page on, the page should be reloaded as soon as the Cookie consent is approved. This enables showing personalized variant on the landing page (you need to have consent for doing this). More info on how to this can be found at the bottom of this page; [tracking a visitors initial pageview](../../../security-privacy/gdpr/how-to-become-gdpr-compliant-using-cookiebot/).

### Still missing analytical data?

If you have performed all the above steps and you are still unable to see Analytics within uMarketingSuite, then please work with a developer to check the following steps, as they are more technical.

* Open your website in a browser with the browser developer tools open.
* Refresh the page with the developer tools open
* In the network tab of requests look for a POST request being made to **umbraco/umarketingsuite/pagedata/ping**

[![]()](../../../%7BlocalLink:umb:/media/a06f75c283c540bfb583cd59f66f0e18%7D/)

As of version 1.21 and newer uMarketingSuite will only track '**real**' visitors and discard any information we determine to be from a bot. The following steps are taken to report a page view:

* DeviceDetector.NET will assess if the visitor is a bot or a '**real**' visitor
* If it's a '**real**' visitor then the page will send a POST request to **umbraco/umarketingsuite/pagedata/ping** and record a visit
* If they are deemed a bot, they won't make this request & no page view is tracked

So if you are still not seeing the POST request happen above, then [please reach out to us via support](../../../support/) and we can assist you further.

### ✅Ticked off all the steps above?

Then your good to go and your uMarketingSuite installation has been setup correc
