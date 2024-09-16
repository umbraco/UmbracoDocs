# Google Analytics blocker detection

If a visitor of a website runs an Adblocker or a cookieblocker this visitor is most likely not be tracked in Google Analytics, because this domain is normally on the blocked list (at least by default). The beauty of the uMarketingSuite is that we still can track this visitor.

To make it easier for you to measure which visitors you cannot track with Google Analytics, but you can track with the uMarketingSuite we've created a simple javascript file that you can include before the closing &lt;/body&gt;-tag of your website:

    <script src="/Assets/uMarketingSuite/Scripts/uMarketingSuite.analytics.blockerdetection.js"></script>

If you do this on of the following events is sent. If Google Analytics is blocked in the browser of the visitor:

    ums("send", "event", "Tracking", "Blocked", "Google Analytics");

And else the following event is sent:

    ums("send", "event", "Tracking", "Allowed", "Google Analytics");

To see the statistics of this event you should go to the Analytics section of the uMarketingSuite and to the report 'Events'. There you should look for the category with the name 'Tracking'.

![]()