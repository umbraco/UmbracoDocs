---
description: This is the first phase of the data flow. In this stage, the data is collected from the user and stored temporarily in memory.
---

# Data collection


## Server side collection

Umbraco uMS works via serverside collecting meaning that all initial visitor data is collected on the server and not sent via JavaScript for example. When a visitor visits your website the Umbraco uMS code checks whether you already have an Umbraco uMS cookie. If not, it creates one and sends it back to you.

At the same time the visitor is making a request the visitor sends all kinds of data to the server:

- Which browser the visitors are using
- Which URL is requested
- If there was any referring page (where did the visitor come from)
- At what time the page is requested
- Which IP Address is used
- Which operation system is used
- Which type of device is used
- Which cookies are sent

This data is all collected and, because of the efficiency stored for a while in the web server memory. The idea is that storing this data in memory is faster than directly writing it to the database. It is more efficient to store multiple database records at once than to store the database records one at a time.

In the next phase, the data in memory will [be stored in the database](/the-umarketingsuite-broad-overview/dataflow-pipeline/data-storage/).

The beauty of server-side collection is that it always works and you're not relying on JavaScript for example. Also, there is no way for clients to block this behavior because this is "how the internet works".

### Collected requests 

Only page requests are collected in Umbraco uMS. Requests to images (.png, .jpg, etcetera) and CSS files are ignored.

Also, all requests to the /Umbraco/-folder are ignored.

### Configuration options

There are different [configuration options](/installing-umarketingsuite/configuration-options-1-x/) to adjust the collecting process.

- You can limit the amount of data records stored in memory. If you are limited in memory you can adjust these settings to fit your needs.
- The IP Address is anonymized by default. There is an option to change this
- You can turn off server-side tracking. This can be useful if not every page request reaches your website. This could be the case if you're using CloudFlare for example.

## Client side collection

The amount of data that you can collect via serverside is limited. Visitors have all kinds of interactions when your website loads. They can scroll, click on the website, watch videos, and click on other pages (inside and outside of your website).

These kinds of requests need to be collected via the client side. To support this we have created a JavaScript that collects a lot of data, and it is also possible to extend this with your events.

### uMarketingSuite.analytics.js

If you install the package you will find this JavaScript file in the folder /Assets/uMarketingSuite/scripts/.

This JavaScript collects the following data for you:

- The maximum scroll depth as a percentage of the whole page and in absolute pixels
- The links you have clicked and at the moment you have clicked these
- The time you have been 'engaged' on the page. We track the time that you are actively using the page. We see whether you are scrolling, moving your cursor, or typing. As long as you are doing that we track the time. As soon as you do not anything of the above we stop the timer until you start doing 'stuff' again. So if you've opened a page, but you went away for a cup of coffee for ten minutes this time will still be less than a minute probably. Also if you've opened the page in a tab for example, but you are using another website at the moment, we will not count that time. We stop measuring time as soon as you haven't done anything for 5 seconds.

To enable these events you will need to load the file /Assets/uMarketingSuite/scripts/uMarketingSuite.analytics.js at the end of your page.

{% code overflow="wrap" lineNumbers="false" %}
```Html
<script src="/Assets/uMarketingSuite/Scripts/uMarketingSuite.analytics.js"></script>
```
{% endcode %}

Client-side events is collected and sent to the server and stored in-memory when Visitors exits the page or close the tab/browser .

### Automatic script

Looking in the source code of your website you will see one line of code that is automatically inserted by Umbraco uMS. It probably looks like something like this:

{% code overflow="wrap" lineNumbers="false" %}
```Html
<script>typeof uMarketingSuite!=="undefined"&&uMarketingSuite.analytics&&uMarketingSuite.analytics.init("XXXXXX-YYY-ZZZZ-1111-222222222")</script>
```
{% endcode %}

This snippet of code ensures loading the uMarketingSuite.analytics.js-file, the exact page visit will be automatically linked to the submitted client-side events.

### Creating custom events

It is also possible to push your own events to the Umbraco uMS. It work 80% the same as [Google Analytics Event Measurement](https://developers.google.com/analytics/devguides/collection/analyticsjs/events). Read more about custom events in the [Create your own events](/analytics/clientside-events-and-additional-javascript-files/create-your-own-events/) article.

### Google Analytics Bridging library

There is a chance that you've already implemented all kinds of events via Google Analytics with their syntax:

- ga('send','event',[eventCategory],[eventAction],[eventLabel],[eventValue],[fieldsObject]);

If that is the case you can include a bridging library we created. This bridging library ensures that all custom events sent to Google Analytics are also sent to Umbraco uMS. These events will now be sent to both systems.

The only thing you will need to do is include the script *\Assets\uMarketingSuite\Scripts\uMarketingSuite.analytics.ga-bridge.js* somewhere on your page:

{% code overflow="wrap" lineNumbers="false" %}
```Html
<script src="/Assets/uMarketingSuite/Scripts/uMarketingSuite.analytics.ga-bridge.js"></script>
```