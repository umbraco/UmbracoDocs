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

## Other cookies

Umbraco Engage uses the following cookie in addition to the visitor cookie:

| Cookie                 | Purpose                                                                                                                                                                                                            | Lifetime                |
| ---------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ----------------------- |
| `ue-consent-referrer`  | Carries the visitor's original referrer across the page reload after consent. Written by `umbracoEngage.analytics.consentGranted()` only after the visitor has consented. Removed when the reloaded request is processed. See [tracking a visitor's initial pageview](../../../security-and-privacy/gdpr/how-to-become-gdpr-compliant-using-cookiebot.md#tracking-a-visitors-initial-pageview). | 20 seconds at most |

The `ue-consent-referrer` cookie is first-party and sets `SameSite=Lax` and `Secure` on HTTPS. It is set by a script, so it is not `HttpOnly`.

## Overriding the default behavior

By default, all modules are initiated at the first page request. If you want to override this behavior, read the documentation about the different [module permissions](module-permissions.md).
