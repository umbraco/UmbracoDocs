---
description: >-
  Configure custom preview URLs to provide editors with seamless access to external preview environments for the Content Delivery API data.
---

# Additional preview environments support

{% hint style="warning" %}
The original contents of this article, explaining how to change the backoffice UI, does not apply anymore to Umbraco 15 and above and has been removed.
The way to achieve this beyond Umbraco 14 is to create and register an extension to modify the backoffice UI preview button.
{% endhint %}

With Umbraco, you can save and preview draft content before going live. The preview feature allows you to visualize how a page will look like once it is published, directly from within the backoffice. This is also possible for the Content Delivery API data. You can extend the preview functionality in the backoffice by configuring external preview URLs for client libraries consuming the Content Delivery API.

{% hint style="info" %}
To get familiar with the preview functionality in the Content Delivery API, please refer to the [Preview concept](https://docs.umbraco.com/umbraco-cms/reference/content-delivery-api#preview) section.
{% endhint %}

{% hint style="info" %}
The support for configuring additional preview environments in the Content Delivery API was introduced in version 12.3.
{% endhint %}

{% hint style="info" %}
There are plans to simplify this process. In an upcoming major version of Umbraco, a UI will be introduced, allowing you to configure these custom preview URLs directly from the backoffice.
{% endhint %}
