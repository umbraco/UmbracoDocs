---
description: >-
  The Commerce add-on tracks Umbraco Commerce orders per visitor and adds
  shopping-based segment rules for personalization.
---

# Commerce

The Commerce add-on connects Umbraco Engage to [Umbraco Commerce](https://docs.umbraco.com/umbraco-commerce). It tracks visitor orders and lets you personalize content based on shopping behavior.

## What it adds

* Order tracking per visitor. Created and completed Umbraco Commerce orders are linked to the visitor profile.
* A **Commerce** view on the visitor profile in the Engage section, showing the orders placed by that visitor.
* Two segment rules for [personalization](../marketers-and-editors/personalization/creating-a-segment.md):
  * **Commerce - has product(s) in cart**: the visitor has products in their cart right now.
  * **Commerce - existing customer**: the visitor has completed an order, ever or within a chosen number of days.
* [Cockpit](../getting-started/for-marketers-and-editors/cockpit.md) support for the Commerce segment rules.

<!-- SCREENSHOT NEEDED: The Commerce view on a visitor profile in the Engage section, showing an order list -->

{% hint style="warning" %}
Screenshot placeholder: the Commerce view on a visitor profile, showing the visitor's orders.
{% endhint %}

<!-- SCREENSHOT NEEDED: The two Commerce segment rules in the segment rule picker -->

{% hint style="warning" %}
Screenshot placeholder: the Commerce segment rules in the segment rule picker.
{% endhint %}

## Prerequisites

* Umbraco Engage is [installed](../installation/installation.md) and [licensed](../installation/licensing.md).
* Umbraco Commerce is installed with a valid license.

## Install the package

Install the [Umbraco.Engage.Commerce](https://www.nuget.org/packages/Umbraco.Engage.Commerce) package via NuGet or using your preferred approach.

{% tabs %}
{% tab title="Visual Studio Package Manager" %}
```
PM> install-package Umbraco.Engage.Commerce
```
{% endtab %}

{% tab title="Console" %}
```console
dotnet add package Umbraco.Engage.Commerce
```
{% endtab %}
{% endtabs %}

Build or restart your website afterwards.

## Next steps

{% content-ref url="../marketers-and-editors/personalization/creating-a-segment.md" %}
[Creating a Segment](../marketers-and-editors/personalization/creating-a-segment.md)
{% endcontent-ref %}

{% content-ref url="../marketers-and-editors/profiling/profile-detail.md" %}
[Profile detail](../marketers-and-editors/profiling/profile-detail.md)
{% endcontent-ref %}
