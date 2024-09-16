# Data collection

This is the first phase of the dataflow. In this stage the data is collected from the user and stored temporarily in memory.

## Serverside collection

The uMarketingSuite works via serverside collecting which means that all initial visitor data is collected on the server and not sent via javascript for example. As soon as a visitor visits your website the uMarketingSuite code checks whether you already have a uMarketingSuite cookie. If not, it creates one and sends it back to you.

At the same time the visitor is doing a request the visitor sends all kinds of data to the server:

- Which browser the visitors is using
- Which url is requested
- If there was any referring page (where did the visitor come from)
- At what time the page is requested
- Which IP Address is used
- Which operation system is used
- Which type of device is used
- Which cookies are sent

This data is all collected and because of efficiency stored for a while in memory of the webserver. The idea is that storing this data in memory is faster than directly writing it to the database. It's more efficient to store multiple databaserecords at once than storing these databaserecords one at the time.

In the next phase the data in memory will [be stored in the database](/the-umarketingsuite-broad-overview/dataflow-pipeline/data-storage/).

The beauty of serverside collection is that it always works and you're not relying on javascript for example. Also there is no way for clients to block this behavior because this is "just how the internet works".

### Which requests are collected

Only page requests are collected in the uMarketingSuite. Requests to images (.png, .jpg, etcetera) and css-files are ignored.

Also all requests to the /Umbraco/-folder are ignored.

### Configuration options

There are several [configuration options](/installing-umarketingsuite/configuration-options-1-x/) to adjust the collecting process.

- You can limit the amount of data records that are stored in memory. If you're a limited in memory you can adjust these settings to fit your needs.
- The IP Address is anonymized by default. There is an option to change this
- You can turn off serverside tracking. This can be useful if not every page requests reaches your websites. This could be the case if you're using CloudFlare for example.

## Clientside collection

The amount of data that you can collect via serverside is limited. Visitors have all kinds of interactions when your website is loaded; they can scroll, they can click on the website, they watch videos and click to other pages (inside and outside of your website).

These kinds of requests need to be collected via the clientside. To support this we have created a javascript that collects already a lot of data, but it's also possible to extend this with your own events.

### uMarketingSuite.analytics.js

If you install the package you will find this javascript file in the folder /Assets/uMarketingSuite/scripts/.

This javascript collects the following data for you:

- The maximum scrolldepth as a percentage of the whole page and in absolute pixels
- The links you have clicked and at what moment you've clicked these
- The time you've been 'engaged' on the page. We track the time that you're actively using the page. We see whether you are scrolling, moving your cursor, and typing. As long as you are doing that we track the time. As soon as you do not anything of the above we stop the timer until you start doing 'stuff' again. So if you've opened a page, but you went away for a cup of coffee for ten minutes this time will still be less than a minute probably. Also if you've opened the page in a tab for example, but you are using another website at the moment, we will not count that time. We stop measuring time as soon as you haven't done anything for 5 seconds.

To enable these events you'll need to load the file on your page /Assets/uMarketingSuite/scripts/uMarketingSuite.analytics.js at the end of your page.

    <script src="/Assets/uMarketingSuite/Scripts/uMarketingSuite.analytics.js"></script>

When a visitor exits the page (an unload-event) by going to another page or closing the tab or browser all these collected clientside events are sent to the server and stored in memory as well.

#### Some automagic script

If you look in the source code of your website (or this website if you want) you will see one line of code that is automatically inserted by the uMarketingSuite. It probably looks like something like this:

    <script>typeof uMarketingSuite!=="undefined"&&uMarketingSuite.analytics&&uMarketingSuite.analytics.init("XXXXXX-YYY-ZZZZ-1111-222222222")</script>

This snippet of code makes sure that if you're loading our uMarketingSuite.analytics.js-file it will automatically link the exact page visit to the submitted clientside events.

### Creating custom events

It is also possible to push your own events to the uMarketingSuite. It works for 80% the same as [Google Analytics Event Measurement](https://developers.google.com/analytics/devguides/collection/analyticsjs/events). Read more about custom events [here](/analytics/clientside-events-and-additional-javascript-files/create-your-own-events/).

#### Google Analytics Bridging library

There is a chance that you've already implemented all kinds of events via Google Analytics with their syntax:

    ga('send', 'event', [eventCategory], [eventAction], [eventLabel], [eventValue], [fieldsObject]);

If that is the case you can simply include a bridging library that we've created. This bridging library makes sure that all custom events that are sent to Google Analytics will also be sent to uMarketingSuite. These events will now be sent to both systems.

The only thing you'll need to do is include the script \Assets\uMarketingSuite\Scripts\uMarketingSuite.analytics.ga-bridge.js somewhere on your page:

    <script src="/Assets/uMarketingSuite/Scripts/uMarketingSuite.analytics.ga-bridge.js"></script>