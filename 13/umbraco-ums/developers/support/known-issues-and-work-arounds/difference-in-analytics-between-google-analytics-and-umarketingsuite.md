# Difference in analytics between Google Analytics and uMS

**Behaviour:**

You will see a difference in statistics between Google Analytics and uMarketingSuite.

**Details:**

Umbraco uMS will collect pageviews unless Goolge Analytics / GTM is blocked or GA / GTM cookies are not accepted. So approx. 10% - 25% more pageviews in Umbraco uMS compared to GA should be considered as normal depending on the audience with the current available information.

**Solution:**

This is the intended behaviour.

In Umbraco uMS 1.13 the bot detection has been improved so if you are running uMarketingSuite version 1.12.x or lower we recommend to upgrade to the latest version or at least 1.13.1

**Last updated:**

November 23rd, 2021