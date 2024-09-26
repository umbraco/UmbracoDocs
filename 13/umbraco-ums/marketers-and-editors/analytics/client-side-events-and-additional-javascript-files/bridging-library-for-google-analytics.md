# Bridging library for Google Analytics

We have included a bridging JavaScript file that will "catch" all Google Analytics event calls and send them to uMS. If you have a website with Google Analytics events defined you do not have to make changes to the code to send them to uMS. The only thing you need to do is include our JavaScript bridge.

## Google Analytics 4 (GA4)

Add a reference to `uMarketingSuite.analytics.ga4-bridge.min.js`:

```html
<script src="~/Assets/uMarketingSuite/Scripts/uMarketingSuite.analytics.ga4-bridge.min.js"></script>
```

### Excluded events

If you enable Enhanced Measurement in GA4 a lot of events will be sent by Google automatically. Everything is an event in GA4 -- even pageviews.

uMarketingSuite already tracks many of the things Google measures when Enhanced Measurement is enabled, so our bridge will exclude the built-in GA4 events. They will still be sent to Analytics so can be viewed there if needed. 

The following built-in GA4 events are excluded by the GA4 bridge:

- `click`
- `file\download`
- `form\start`
- `form\submit`
- `page\view`
- `scroll`
- `video\complete`
- `video\progress`
- `video\start`
- `view\search\results`

{% hint style="warning" %}
This means if any of your custom events use one of the above event names they will also be ignored.
{% endhint %}

This is based on [https://support.google.com/analytics/answer/9234069?hl=en](https://support.google.com/analytics/answer/9234069?hl=en) - all events tagged "(web)".

## Customize which events are sent

If there are specific events you want to exclude from being sent to uMS you can customize the behavior.

Say you want to exclude all events that have cateogry "X" and action "Y". To do that, add the following JavaScript to your website. Make sure `uMarketingSuite.analytics.js` has been loaded when the code executes.

```js
<script>
if(typeof window.ums === "function" && typeof window.ums.onSendEvent === "function")
{
    window.ums.onSendEvent(function(evt) 
    {
        if(evt.fields.category == "X" && evt.fields.action == "Y")
        {
            // Do not send events with category "X" and action "Y" to uMarketingSuite
            evt.cancel();
        }
    });
}
</script>
```

It is also possible to change the category/action/label/value properties of `evt.fields` to modify the values we send to uMS.

{% hint style="info" %}
Note this functionality ships in 1.20.5 and is not available in earlier versions.
{% endhint %}
