If you visit a website that has the uMarketingSuite installed you will get a unique cookie. This cookie allows us to relate different page visits or sessions to one and the same visitor. It also gives the ability to serve always the same variant of an A/B test.

By default the uMarketingSuite cookie has the name **uMarketingSuiteAnalyticsVisitorId**. You can however give it another name via the [configuration file](/installing-umarketingsuite/configuration-options-1-x/).

The cookie is:

- A first-party cookie. This means it is set by the website itself and can only be used by the website itself. The cookie won't track you across the whole internet on all kind of websites (like Facebook, LinkedIn, etcetera) and is therefor much privacy friendlier.
- The cookie has set the flag HttpOnly
- The cookie has the Secure flag set
- The cookies is initialized with a expiry date of **365 days** (or something else depending on the settings in the configuration file) and has a sliding expiration. That means that if you revisit the website after 30 days, the cookie will expire after 365 days again.

## Testing A/B variants

If you want to test whether the A/B test is working and really distributes the different variants you can always use [the A/B test preview functionality](/a-b-testing/previewing-an-a-b-test/) within Umbraco. But if you want to test whether it really works you can always delete the uMarketingSuite cookie. Because if you delete the cookie you will be treated as a new visitor of the website and you will be put in a random variant.

How you delete a cookie is different per browser so [Google is probably your best friend](http://letmegooglethat.com/?q=how+can+i+delete+a+cookie+in+my+browser).

## Overriding the default behaviour

By default all modules (Analytics, A/B Testing and Personalization) are initiated at the first page request. If you want to override this behaviour, for privacy purposes for example, that can be easily done. Read the documentation about the different [module permissions](/the-umarketingsuite-broad-overview/the-umarketingsuite-cookie/module-permissions/).