---
description: >-
  Learn more about how Umbraco Engage distinguishes between bots and real
  visitors.
---

# Bot detection

Engage only tracks '**real**' visitors and discard any visit we determine to be from a bot. The data for bots is not stored in Umbraco Engage and cannot be viewed in the Analytics section.

From an Search Engine Optimization (SEO) perspective, bots, search engine crawlers, spiders, and the like, will always see the default content. This means that they will not participate in personalization or A/B tests.

The tracking of a visitor is done via the following steps:

* [DeviceDetector.NET](https://github.com/totpero/DeviceDetector.NET) will assess if the visitor is a bot or a 'real' visitor\` using the device ID of the browser.
* If it is a 'real' visitor the page will send a POST request to `umbraco/engage/pagedata/ping` record a visit.
* The page will not add a POST request if the visitor is deemed a bot.
