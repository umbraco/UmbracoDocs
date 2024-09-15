**Behaviour:**

When visiting a page in Umbraco directly, no issue occurs. When visiting a page through a referral (either from the umbraco back-office or through an external source), the application crashes due to a StackOverflow Exception.

**Details:**

In the stacktrace of the StackOverflow Exception you notice an infinite loop occured, and there is a reference to both Umbraco and uMarketingSuite .DLL's. One of Umbraco's classes that is in the infinite loop stacktrace, is the "ContentFinderByUrlAlias" class with it's "FindContentByAlias" method. In here there is a reference to the umbracoUrlAlias property.

This error occurs when a doctype has added the "umbracoUrlAlias" reserved property alias, and set said property with the "Allow Segmentation" setting. When visiting the page from a referral it causes an infinite loop where uMarketingSuite tries to determine whether the referral link is an internal page, checks the Umbraco routing to do so, which in turn causes Umbraco to check the umbracoUrlAlias property. Doing so causes uMarketingSuite to check for possible segmentation of that property, tries to determine a possible url, checks the umbraco routing, etc. etc., causing it to end up in an infinite loop.

**Solution:**

Remove the "Allow Segmentation" setting on the "umbracoUrlAlias" property, as this property shouldn't ever be segmented.

**Last updated:**

September 14th, 2021