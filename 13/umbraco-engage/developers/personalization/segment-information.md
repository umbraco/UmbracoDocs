---
description: >-
  Sometimes you need more fine-grained personalization for your website. For
  this purpose the Umbraco Engage exposes a service called the
  IAnalyticsStateProvider.
icon: square-exclamation
---

# Retrieve segment information from code

This service provides access to all analytics-related information for the current request, and the segment information. When you need to execute custom code specifically tied to the personalization, you can use this service.

To get started you need an instance of an`IAnalyticsStateProvider`, which can be resolved through Dependency Injection. For example consider the following case, where we use [route hijacking](https://docs.umbraco.com/umbraco-cms/v/13.latest-lts/reference/routing/custom-controllers) to execute custom code for our content type called "`Home`":

```csharp
using System.Web.Mvc;
using Umbraco.Engage.Business.Analytics.State;
using Umbraco.Web.Mvc;

public class HomeController : SurfaceController, IRenderController
{
    private readonly IAnalyticsStateProvider _analyticsStateProvider;
    public HomeController(IAnalyticsStateProvider analyticsStateProvider)
    {
        _analyticsStateProvider = analyticsStateProvider;
    }
    ...
}
```

Umbraco will automatically resolve the service, without having to write any code. We can now use the service in our request, by calling the `.GetState()` method to get the current state for the current request. Which in turn exposes the **PageView** containing the concrete information we are looking for.

The `PageView` lies at the heart of Umbraco Engage Analytics feature and exposes a lot of interesting information. For now, we will focus on reading all segments for the current pageview. Depending on your configuration, a visitor can fall into multiple segments, as we can see by enumerating overall `PageViewSegments`.

Consider the following example (continued from above) where the content of content type "`Home`" was requested. We will now tell Umbraco to execute this custom code whenever the template `HomeTemplate` is requested:

{% code overflow="wrap" %}
```csharp
public ActionResult HomeTemplate()
{
    var analyticsState = _analyticsStateProvider.GetState();
    foreach (var pageviewSegment in analyticsState.Pageview.PageviewSegments)
    {
        if (pageviewSegment.Segment.Name == "MySegment")
        {
            // Execute custom code
        }
    }
    ...
}
```
{% endcode %}

We can for example check if the current visitor falls into a segment called "**MySegment**". Keep in mind that a visitor can fall into any number of segments (zero, one, or all). A segment alone don't anything and can be regarded as purely informational, or as a "**Flag**" or "**Label**".

The personalization used by the Umbraco Engage to modify the appearance of a page is called **Applied Personalization**.

A page request can have only **one** active Applied Personalization. Based on the current segments (and their sort order), Umbraco Engage picks the first applicable Applied Personalization. This could be a multi-doctype or multi-page personalization (Engage section) or single-page personalization (content).

To inspect the resolved Applied Personalization, we can use the property `AppliedPersonalization` on the state's **PageView**:

{% code overflow="wrap" %}
```csharp
if (analyticsState.Pageview.AppliedPersonalization != null && analyticsState.Pageview.AppliedPersonalization.Name == "MyAppliedPersonalization")
{
    ...
}
```
{% endcode %}

Be aware that no personalization may have been resolved for the current request. Make sure to do a **null check** before reading the `AppliedPersonalization` property. The property `SegmentId` will tell you which active segment was responsible for triggering the Applied Personalization.

A Segment may be used by different Applied personalizations, but only one personalization will ever be resolved and displayed.

This implies some different important things:

1. The Applied Personalization can only trigger on currently active segments (as found on `Pageview.PageviewSegments`)
2. Not having any active segments automatically means there will never be any Applied Personalizations active. So configuring correct segments is essential.
3. Having a maximum of one active Applied Personalization per request means that you might find an unexpected personalization was activated. **Always make sure to check the segment sorting order**.

When testing it is a good idea to inspect the Cockpit information in your front end requests so you can see which segments are active.
