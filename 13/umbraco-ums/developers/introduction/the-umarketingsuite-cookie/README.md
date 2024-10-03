---
description: Learn how the uMS cookie works and how the functionality can be tested.
icon: square-exclamation
---

# The uMS Cookie

When visiting a website with Umbraco uMS installed you will get a unique cookie. This cookie allows for relating different page visits or sessions to the same visitor. It will also continuously serve the same variant of an A/B test.

By default the uMS cookie has the name `uMarketingSuiteAnalyticsVisitorId`. You can change the name in the [configuration file](../../../getting-started/for-developers/configuration-options-2-x.md).

The Umbraco uMS cookie:

* Is a first-party cookie. This means it is set by the website itself and can only be used by the website itself. The cookie will not track you across the whole internet on all kinds of websites (like Facebook and LinkedIn).
* Sets the `HttpOnly` flag.
* Sets the `Secure` flag.
* Is initialized with an expiry date of 365 days (depending on the settings in the configuration file) and has a sliding expiration. That means that if you revisit the website after 30 days, the cookie will reset and expire 365 days after that visit.

## Testing A/B variants

To test whether the A/B test is working and distributes the different variants you can use [the A/B test preview functionality](../../ab-testing/previewing-an-ab-test.md). Delete the uMS cookie to become a _new visitor_ to the website and you can test whether it works.

Consult your browser settings to learn how to delete the cookie.

## Overriding the default behavior

By default, all modules are initiated at the first page request. If you want to override this behavior, read the documentation about the different [module permissions](module-permissions.md).
