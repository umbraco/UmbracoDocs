# The uMS Cookie

If you visit a website that has uMS installed you will get a unique cookie. This cookie allows us to relate different page visits or sessions to one and the same visitor. It also gives the ability to serve always the same variant of an A/B test.

By default the uMS cookie has the name **uMarketingSuiteAnalyticsVisitorId**. You can change name via the [configuration file](/installing-umarketingsuite/configuration-options-1-x/).

The cookie:

- Is a first-party cookie. This means it is set by the website itself and can only be used by the website itself. The cookie will not track you across the whole internet on all kind of websites (like Facebook, LinkedIn, etcetera).
- Has the `HttpOnly` flag set.
- Has the `Secure` flag set
- Is initialized with an expiry date of **365 days** (depending on the settings in the configuration file) and has a sliding expiration. That means that if you revisit the website after 30 days, the cookie will reset and expire 365 days after that visit.

## Testing A/B variants

To test whether the A/B test is working and distributes the different variants you can use [the A/B test preview functionality](/a-b-testing/previewing-an-a-b-test/). To test whether it works delete the uMS cookie to become a _new visitor_ of the website and be put in a random variant.

Consult your browser settings to learn how to delete the cookie.

## Overriding the default behaviour

By default all modules are initiated at the first page request. If you want to override this behaviour, read the documentation about the different [module permissions](/the-umarketingsuite-broad-overview/the-umarketingsuite-cookie/module-permissions/).
