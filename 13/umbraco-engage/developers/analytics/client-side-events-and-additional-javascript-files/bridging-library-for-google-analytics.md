---
description: Learn how to bridge Google Analytics with the data in Umbraco Engage.
---

# Bridging Library for Google Analytics

We have included a bridging JavaScript file to "catch" all Google Analytics event calls and send them to Umbraco Engage. If you have a website with Google Analytics events defined you do not have to change the code to send them to Umbraco Engage. The only thing you need to do is include our JavaScript bridge.

## Google Analytics 4 (GA4)

Add a reference to `umbracoEngage.analytics.ga4-bridge.min.js`:

```html
<script src="~/Assets/Umbraco.Engage/Scripts/umbracoEngage.analytics.ga4-bridge.min.js"></script>
```

{% hint style="info" %}
The following Google Analytics bridging script loading types are currently not supported: "async" or "defer".
{% endhint %}

### Excluded events

The following built-in GA4 events are excluded by the GA4 bridge:

* `click`
* `page\view`
* `scroll`
* `video\complete`
* `video\progress`
* `video\start`

{% hint style="warning" %}
This means if any of your custom events use one of the above event names they will also be ignored.
{% endhint %}

This is based on [official Google Analytics documentation](https://support.google.com/analytics/answer/9234069?hl=en) - all events tagged `(web)`.

## Customize which events are sent

If there are specific events you want to exclude from being sent to Umbraco Engage you can customize the behavior.

Say you want to exclude all events that have category "X" and action "Y". To do that, add the following JavaScript to your website. Make sure `umbracoEngage.analytics.js` has been loaded when the code executes.

```js
<script>
if(typeof window.umbEngage === "function" && typeof window.umbEngage.onSendEvent === "function")
{
    window.umbEngage.onSendEvent(function(evt) 
    {
        if(evt.fields.category == "X" && evt.fields.action == "Y")
        {
            // Do not send events with category "X" and action "Y" to Umbraco Engage
            evt.cancel();
        }
    });
}
</script>
```

It is also possible to change the category/action/label/value properties of `evt.fields` to modify the values we send to Umbraco Engage.

### View GA4 events

The captured GA4 events will appear in Analytics -> Events in the **GA 4 - Bridging** category

### Using GA4 events in Goals

If you want to trigger a goal based on a GA4 event please use the following information:

Category: **GA 4 Bridging**\
Action: **\<your action>**
