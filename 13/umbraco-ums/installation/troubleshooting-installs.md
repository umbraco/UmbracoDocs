# Troubleshooting Installs

At the moment we are not aware of any problems when installing the uMarketingSuite.

If you have one please let us know by [submitting an issue on GitHub](https://github.com/uMarketingSolutions/uMarketingSuite/issues/new/choose) or by getting in touch with us.

[Please check out our known-issue section for possible issues after installing.](../../../support/known-issues-and-work-arounds/)

## The uMS Checklist

If you are having problems or unsure you have uMS setup and configured, then this checklist is for you. Verify you installed the Nuget package **uMarketingSuite** into your Umbraco website

### 1. The Marketing section

After logging in into Umbraco you are able to see the Marketing section along with the other main sections in the Umbraco backoffice.

If you cannot see this, please check if your Umbraco user and or user group has access to the Marketing section.

![]()

### 2. Marketing Content Apps

When editing a page within Umbraco you should be able to see the following Content App on the top right of the page:

![]()

If you cannot see this, please check if your Umbraco user and or user group has access to the Marketing section.

### 3. Cockpit

Is the **uMS Cockpit tool** visible on frontend of your site **after logging into Umbraco**?

No? Ensure you added the [Cockpit Partial view](../../../installing-umarketingsuite/cockpit/) in your main template.

![]()

### 4. Cockpit Client Side Data

Can you see client-side data such as **scroll depth** & **total time** on pages in analytics or  the cockpit?

No? Ensure you have [added the client side tracking script](../../../analytics/clientside-events-and-additional-javascript-files/additional-measurements-with-our-ums-analytics-scripts/) in your main template.
![]()

### 5. Umbraco Forms

Go to a Form and add a new question to a form. Do you see this option?

![]()

Go to Marketing -> Settings -> Create a new goal. Do you see the following option called **Umbraco Forms Submission**?

![]()

If you see both options, this has been configured correctly. If not, ensure that your development team have installed the additional [uMarketingSuite.UmbracoForms nuget package](https://www.nuget.org/packages/uMarketingSuite.UmbracoForms).

### 6. Analytics

Edit a page and go to the Content App marked **Analytics** or alternatively go to **Marketing** -> **Analytics** from the top navigation.

Are you able to see analytical data? If not then you **need to wait 24 hours for todays analytics** to be collected and reported.

### 7. Locations for Analytics

Do you see the following message when browsing Analytics for Locations?

![]()

This means that some configuration is needed by your development team. They need to do a bit of [work to set up and track visitor locations by country and city](../../../analytics/extending-analytics/implement-an-ip-to-location-provider/).

Once set up, you will see analytics for countries like this below:

![]()

### 8. Setup IP Filters

Confirm that your own IP of your company/office building has been set to be excluded from uMS. This is done to ensure it is excluded from tracking and reporting, along with anyone else who is a content editor of the website.

You can check what your IP is by [Googling for What is My IP](https://www.google.com/search?q=what+is+my+IP). Ensure it is in the list of IPs by navigating to **Marketing** -> **Settings** -> **IP Filters**.

![]()

### 9. Reload after Cookie consent

To ensure that uMS can interact with the visitor from the first page on, reloaded the page as soon as the Cookie consent is approved. This enables showing personalized variant on the landing page which you need to have consent for doing. More info on how to this can be found at the bottom of the [tracking a visitors initial pageview](../../../security-privacy/gdpr/how-to-become-gdpr-compliant-using-cookiebot/) article.

### Still missing analytical data?

If you have performed all the steps and do not see Analytics data within uMS there are a handful of additional steps to take. Please work with a developer to check the following steps, as they are more technical.

* Open your website in a browser with the browser developer tools open.
* Refresh the page with the developer tools open.
* Look for a POST request being made to `umbraco/umarketingsuite/pagedata/ping` in the Network Tab of requests.

[![]()](../../../%7BlocalLink:umb:/media/a06f75c283c540bfb583cd59f66f0e18%7D/)

Only '**real**' visitors will be tracked and any information we determine to be from a bot is discarded. The following steps are taken to report a page view:

* DeviceDetector.NET will assess if the visitor is a bot or a '**real**' visitor.
* If it is a '**real**' visitor the page will send a POST request to `umbraco/umarketingsuite/pagedata/ping` and record a visit.
* If they are deemed a bot, they will not make this request and no page view is tracked

If you are still not seeing the POST request happen above, then [please reach out to us via support](../../../support/).
