---
icon: square-exclamation
description: Learn what Umbraco Engage tracks before any additional configuration is added.
---

# What is measured by default

If you install Umbraco Engage we will automatically collect a lot of data for you.

Serverside the following data is tracked:

* The URL of the visited page (`/foobar/`)
* The query string of the visited page (`?filtering=on&parameter1=2`)
* The variant of the page that we serve. This could be a personalized version of the page or one of the A/B-test variants.
* The time that the page was visited (`31 august 2021, 16:04:22`)
* Where the visitor came from before this visit (the so-called referrer). This could be an internal webpage (`/my-contentpage/`) or an external URL (`www.umbraco.com/products/engage/`)
* The browser being used (Firefox), the Operating System used (Windows), and the type of device being used (Desktop). These data points are based on the user-agent string that any browser is sending.
* The IP address (`213.62.44.123`) or anonymized IP address (`213.62.44.0`), depending on your configuration.

With the data collected, the Analytics reports in Umbraco Engage can be visualized. It also allows us to calculate other metrics, such as conversion rates, bounce rates, and landing & exit pages.

If you [include the clientside collection script](../../developers/analytics/client-side-events-and-additional-javascript-files/) as well, you can also capture behavioural data of your visitors.
