---
description: >-
  Learn how the Umbraco Engage cookie works and how the functionality can be
  tested.
---

# The Umbraco Engage Cookie

When visiting a website with Umbraco Engage installed you will get a unique cookie. This cookie allows for relating different page visits or sessions to the same visitor. It will also continuously serve the same variant of an A/B test.

By default the Umbraco Engage cookie has the name `umbracoEngageAnalyticsVisitorId`. You can change the name in the [configuration file](../../settings/configuration.md).

The Umbraco Engage cookie:

* Is a first-party cookie. This means it is set by the website itself and can only be used by the website itself. The cookie will not track you across the whole internet on all kinds of websites (like Facebook and LinkedIn).
* Sets the `HttpOnly` flag.
* Sets the `Secure` flag.
* Is initialized with an expiry date of 365 days (depending on the settings in the configuration file) and has a sliding expiration. That means that if you revisit the website after 30 days, the cookie will reset and expire 365 days after that visit.

## Overriding the default behavior

By default, all modules are initiated at the first page request. If you want to override this behavior, read the documentation about the different [module permissions](module-permissions.md).
