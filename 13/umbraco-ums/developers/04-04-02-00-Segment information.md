Sometimes you need more fine grained personalization for your website. For this purpose the uMarketingSuite exposes a service called the **IAnalyticsStateProvider**. This service providers access to all analytics-related information for the current request, as well as segment information. Whenever you have a need to execute custom code that is specifically tied to personalization, you can use this service.

To get started you will need an instance of a **IAnalyticsStateProvider**, which can be resolved through Dependency Injection. For example consider the following case, where we  use [route hijacking](https://our.umbraco.com/documentation/reference/routing/custom-controllers) to execute custom code for our content typed called "**Home**":

    using System.Web.Mvc;
    using uMarketingSuite.Business.Analytics.State;
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

Umbraco automatically will resolve our service, without us having to write any code! We can now use the service in our request, by calling the **.GetState()** method to get the current state for the current request, which in turn exposes the **PageView** containing the concrete information we are looking for.

The **PageView** lies at the heart of uMarketingSuite's Analytics feature and exposes a lot of interesting information. For now, we will focus on reading all segments for the current pageview. Depending on your configuration, it is possible for a visitor to fall into multiple segments, as we can see by enumerating over all **PageViewSegments**.

Consider the following example (continued from above) where content of content type "**Home**" was requested. We will now tell Umbraco to execute this custom code whenever the template "**HomeTemplate**" is requested:

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

We can for example check if the current visitor falls into a segment called "**MySegment**". Keep in mind that it is possible for a visitor to fall into any number of segments (zero, one, or all). A segment by itself does not do anything, and can thusly be regarded as purely informational, or as a "**Flag**" or "**Label**" if you will.

The actual personalization that is used by the uMarketingSuite to modify the appearance of a page is called **Applied Personalization**. A page request can have only **one** active Applied Personalization. Based on the current segments (and their sort order), the uMarketingSuite picks the first applicable Applied Personalization. This could be a multi-doctype or multi-page personalization (Marketing section) or single page personalization (content).

To inspect the resolved Applied Personalization, we can use the property **AppliedPersonalization** on the state's  **PageView**:

    if (analyticsState.Pageview.AppliedPersonalization != null && analyticsState.Pageview.AppliedPersonalization.Name == "MyAppliedPersonalization")
    {
        ...
    }

Keep in mind that it is possible that no personalization has been resolved for the current request, so make sure to do a **null check** before reading the AppliedPersonalization property. The property **SegmentId** will tell you which active segment was responsible for triggering the Applied Personalization. It is possible that a Segment is used by several Applied personalizations, but only one personalization will ever be resolved and displayed. This implies several important things:

1) The Applied Personalization can only trigger on currently active segments (as found on **Pageview**.**PageviewSegments**)

2) Not having any active segments automatically means there will never be any Applied Personalizations active. So configuring correct segments is essential.

3) Having a maximum of one active Applied Personalization per request means that you might find an unexpected personalization was activated. **Always make sure to check the segment sorting order**.

When testing this it is always a good idea to inspect the Cockpit information in your front end requests so you can easily see which segments are active.