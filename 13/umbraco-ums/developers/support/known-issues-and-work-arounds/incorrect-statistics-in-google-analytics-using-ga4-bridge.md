**Behaviour:**

Incorrect statistics may appear in Google Analytics because GA4 events are sent twice to GA4 by using the GA4 bridge of uMarketingSuite.

**Applies to:**

uMarketingSuite version &gt; 1.20.5 and &lt; 1.24.0 using the Google Analytics 4 (GA4) bridge as described [here](/analytics/clientside-events-and-additional-javascript-files/bridging-library-for-google-analytics/).  
It does not apply to the Universal Analytics (UA) bridge!  

**Details:**

When using the GA4 bridge to send events to Google Analytics there is a mechanism in place in the Google GA4 script that checks the return value of the initial send event method. By using the uMarketingSuite GA4 bridge the return value never arrived in the initial Google GA4 script. Google has implemented a fallback mechanism when the return value does not arrive it will send the event in an alternative way but the initial event is also received by Google. By using the uMarketingSuite GA4 bridging script the event was sent twice to Google Analytics.  
The analytics in the uMarketingSuite Analytics section are correct.

**Solution:**

Upgrade to uMarketingSuite 1.24.x or higher. Read the full product update [here](https://www.umarketingsuite.com/blog/product-update-september-2023/).

**Last updated:**

September 20th, 2023