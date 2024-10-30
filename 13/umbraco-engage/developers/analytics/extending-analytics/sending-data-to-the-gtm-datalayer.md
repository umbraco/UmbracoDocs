---
description: >-
  Discover how to push A/B testing and personalization variables from
  Umbraco Engage to the Google Tag Manager (GTM) data layer in Razor templates.
---

# Sending data using Google Tag Manager

Umbraco Engage provides a partial view that pushes variables related to A/B testing and personalization to the Google Tag Manager (GTM) data layer.

The following variables are pushed:

* `inabtest: true` - if the visitor participates in an active A/B test on the page; otherwise **false**.

{% hint style="info" %}
This will also be **true** if the visitor is assigned to the "A" variant which is the original page.
{% endhint %}

* `abtestname` - The name of the A/B test the visitor is participating in. If there is no active A/B test, the value will be **null**
* `abtestvariant` - The name of the A/B test variant assigned to the visitor. If there is no active A/B test, the value will be **null**
* `personalized: true` - If personalization is applied to the page for the visitor; otherwise **false**.
* `personalizationname` - The name of the active personalization. If there is no active personalization, the value will be **null**.

To render the partial view in your Razor template, use the following line:

```cs
@Html.Partial("~/Views/Partials/Umbraco.Engage/GTMDataLayerPush.cshtml")
```

This partial will render the following output:

```html
<script>
    window.dataLayer = window.dataLayer || [];
    window.dataLayer.push({
        inabtest: true,
        abtestname: "The name of the AB test",
        personalized: true,
        personalizationname: "The name of the personalized variant",
    });
</script>
```
