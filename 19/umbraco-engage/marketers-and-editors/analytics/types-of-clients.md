---
description: >-
  Learn more about how Umbraco Engage distinguishes between bots and real
  visitors.
---

# Types Of Clients

Engage tracks only **real** visitors, filtering out bot traffic. The data for bots is not stored in Umbraco Engage and is excluded from the Analytics section.

From a Search Engine Optimization (SEO) perspective, bots and crawlers always see the default content, with no personalization or participation in A/B tests.

The tracking of a visitor is done via the following steps:

* DeviceDetector.NET will assess if the visitor is a bot or a 'real' visitor\` using the device ID of the browser.
* If it is a 'real' visitor the page will send a special ping request to Umbraco Engage to record the visit. If this ping is not received the requests of this visitor will not be tracked.

