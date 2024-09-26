# Google Analytics Blocker Detection

When a visitor runs an Adblocker or cookieblocker the visitor is likely not tracked in Google Analytics. With uMS, however, you can still track this visitor.

This is made possible by a JavaScript file that you can include before the closing `body`-tag in your HTML:

```js
<script src="/Assets/uMarketingSuite/Scripts/uMarketingSuite.analytics.blockerdetection.js"></script>
```

If you do this one of the following events is sent:

* If Google Analytics is blocked in the browser of the visitor: `ums("send", "event", "Tracking", "Blocked", "Google Analytics");`
* Otherwise the following event is sent: `ums("send", "event", "Tracking", "Allowed", "Google Analytics");`

To see the statistics of this event go to the Analytics section of uMS and open the 'Events' report. Look for the category with the name 'Tracking'.

![]()
