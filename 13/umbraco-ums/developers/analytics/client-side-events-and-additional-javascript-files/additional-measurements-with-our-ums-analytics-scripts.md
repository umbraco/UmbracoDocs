# Additional measurements with our uMS Analytics scripts

You can add the uMarketingSuite analytics JavaScript file to your website by adding the following line of code, just before the closing **&lt;/body&gt;**-tag of your website.

    <script src="/Assets/uMarketingSuite/Scripts/uMarketingSuite.analytics.js"></script>

If you include this file the uMarketingSuite will send the following data back to the server just before the unload event of a page is triggered (somebody goes to another page):

- We track the maximum scroll depth of the page in both the number of pixels and the percentage of the page. For example; this person scrolled to 93% of the height of the page and this was a depth of 967 pixels
- The total time on page is measured in milliseconds. The total time on page is defined as the time difference between the page being shown and when you leave the page
- The engaged time on page. This measures the time that you are active on the page and is in our opinion more accurate than the total time on page. This script measures only time when you are scrolling and clicking through the website in the active tab, but not when you're getting coffee or working in another tab. This is uses a 5 second grace period. More information about the concept can be found on this blogpost: [https://www.simoahava.com/analytics/track-content-engagement-via-gtm/](https://www.simoahava.com/analytics/track-content-engagement-via-gtm/)
- All clicks to the following urls are measured
    - A click to an external domain
    - A click to a .pdf, .doc, or .docx document
    - An internal onpage link which is defined by an anchor link (#intro)
    - Clicks on mailto: and tel: links

Of course you can extend and tweak the JavaScript file according to your specifications.

Please be aware that if the name of the file stays the same this file will be overwritten each time you update the uMarketingSuite to a newer version.