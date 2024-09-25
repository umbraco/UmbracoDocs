# Bridging library for Google Analytics

We have included a bridging JavaScript file that will "catch" all Google Analytics event calls and send them to the uMarketingSuite as well. The purpose of the file is that if you have a running website with Google Analytics events already defined you do not have to make any changes to the code to send them to uMarketingSuite as well. The only thing you need to do is include our JavaScript bridge.

## Google Analytics 4 (GA4)

Add a reference to uMarketingSuite.analytics.ga4-bridge.min.js:

    <script src="~/Assets/uMarketingSuite/Scripts/uMarketingSuite.analytics.ga4-bridge.min.js"></script>

### Excluded events

If you enable Enhanced Measurement in GA4 a lot of events will be sent by Google automatically. Everything is an event in GA4 -- even pageviews.

uMarketingSuite already tracks many of the things Google measures when Enhanced Measurement is enabled, so our bridge will exclude the built-in GA4 events. They will still be sent to Analytics so can be viewed there if needed. 

The following built-in GA4 events are excluded by the GA4 bridge:

- click
- file\_download
- form\_start
- form\_submit
- page\_view
- scroll
- video\_complete
- video\_progress
- video\_start
- view\_search\_results

Note this does mean if any of your custom events use one of the above event names they will also be ignored.

This is based on [https://support.google.com/analytics/answer/9234069?hl=en](https://support.google.com/analytics/answer/9234069?hl=en) - all events tagged "(web)".

## Customize which events are sent

If there are events you want to exclude from being sent to uMarketingSuite (other than the built-in GA4 events as discussed above) you can customize the behavior with a bit of custom JavaScript.

Say you want to exclude all events that have cateogry "X" and action "Y" then you can add this JavaScript to your website. Just make sure uMarketingSuite.analytics.js has been loaded when this code executes:

    <script>if(typeof window.ums === "function" && typeof window.ums.onSendEvent === "function") {    window.ums.onSendEvent(function(evt) {        if(evt.fields.category == "X" && evt.fields.action == "Y") {            // Do not send events with category "X" and action "Y" to uMarketingSuite            evt.cancel();         }    });}</script>

It is also possible to change the category/action/label/value properties of **evt.fields** to modify the values we send to uMarketingSuite.

Note this functionality ships in 1.20.5 and is not available in earlier versions.