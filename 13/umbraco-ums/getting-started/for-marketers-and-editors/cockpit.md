---
description: >-
  The Cockpit is a tool to let you view data directly on the front end of the
  website.
---

# Cockpit

The cockpit lets you check out all the stored data when browsing the website. It is also a good way to verify your personalization setup.

To enable the uMS Cockpit add the following code above the `</body`> tag.

```csharp
@Html.Partial("uMarketingSuite/Cockpit")
```

Once the code is added, reload the page to see the uMS Cockpit on the left or right side of the screen:

<div align="left">

<figure><img src="../../.gitbook/assets/image (20) (1).png" alt="Cockpit"><figcaption><p>Cockpit</p></figcaption></figure>

</div>

Click **Open** to see all the features of the Cockpit:

<div align="left">

<figure><img src="../../.gitbook/assets/image (2) (2).png" alt="Cockpit features"><figcaption><p>Cockpit features</p></figcaption></figure>

</div>

## Access to the cockpit

When the uMS Cockpit code has been added to the page you can see it when you are logged in to Umbraco. Visitors to your website do not have access to the Cockpit.

If you do not see the Cockpit while Umbraco runs on a different domain please refer to the [load balancing / CM / CD environments](../../../../installing-umarketingsuite/loadbalancing-and-cm-cd-environments/) section.

### Data reporting client-side

If you have set up the [additional analytics script](../../../../analytics/clientside-events-and-additional-javascript-files/additional-measurements-with-our-ums-analytics-scripts/) of the uMS you can find all tracked data in the Cockpit.

The following are tracked:

* The time on page. This is defined between the time the page was loaded and the current time. If you visit the website at 11:23:12 and it is now 11:25:30, your time on the page is 2 minutes and 18 seconds.
* The engaged time on page. This measures the time you were active on the page. When you scroll, move your mouse, type, or select text on the website you are considered "engaged". As soon as you stop one of these actions and have no other interaction in the next five seconds this engaged timer will be stopped. This could happen when you are browsing in another window or tab of your browser or system or when you leave your computer. The time on the page is still counting, but you are not engaged at that moment.
* The script tracks the maximum scroll depth that you have reached. This counts in absolute pixels and as a percentage.
* All [fired events](../../../../analytics/clientside-events-and-additional-javascript-files/create-your-own-events/) are tracked.
* Every outclick to other domains, a pdf-file or excel-file is measured by default.

<div align="left">

<figure><img src="../../.gitbook/assets/image (3) (2).png" alt="Cockpit Analytics."><figcaption><p>Cockpit Analytics.</p></figcaption></figure>

</div>

### Data reporting server-side

In this section you can see all the data that is captured on the server side:

* The browser,
* The type of device,
* The IP address (anonymized or not; depending on your [settings](../../../../installing-umarketingsuite/configuration-options-1-x/))
* The total number of pages visited in this session
* The total number of sessions with this cookie

Also, you have the option to delete your uMS cookie

<div align="left">

<figure><img src="../../.gitbook/assets/image (4) (2).png" alt="Delete Umbraco Engage cookies."><figcaption><p>Delete Umbraco Engage cookies.</p></figcaption></figure>

</div>

### Segments

In the segments section, you can see which segments are configured and which are applied to the current visitor.

<div align="left">

<figure><img src="../../.gitbook/assets/image (5) (2).png" alt="Segments"><figcaption><p>Segments</p></figcaption></figure>

</div>
