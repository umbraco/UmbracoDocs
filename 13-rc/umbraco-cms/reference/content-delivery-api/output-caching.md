---
description: Boosting Delivery API performance with output caching.
---

# Output caching

In many cases the Delivery API output is stateless, and it is not absolutely necessary to push content updates immediately. In these cases the API can greatly benefit from using output caching.

Output caching is an opt-in feature in the Delivery API. It can be configured individually for both the Content and Media Delivery APIs. When enabled, API outputs are cached on the server for each unique request, and re-used until the cache expires.

Under the hood, the Delivery API utilizes the built-in [output caching middleware in ASP.NET Core](https://learn.microsoft.com/en-us/aspnet/core/performance/caching/output) to handle the cache.

## Why use output caching?

Output caching is primarily designed to increase performance. While the Delivery API is performant on its own, output caching takes the performance to another level.

Another aspect to consider is the overall server load. Uncached requests require much more processing time than cached requests. Especially for high traffic sites, even a short-lived output cache makes a significant difference in the server load. This might result in a lesser need to scale instances, and thus a greener footprint for the site.

However, output caching does come with a few trade-offs:

- The cache lives in memory by default. This means the site will consume additional memory to handle the cache.
- The cache does not expire automatically when content changes. Therefore, editors will experience increased publishing time when making changes to existing content.

{% hint style="info" %}
Requests made in preview mode are not subject to output caching.
{% endhint %}

## When _not_ to use output caching

Output caching can be a bad fit in some cases:

- If editors require immediate publishing of content updates (see above).
- When using personalization in the API output.
- If a custom property editor requires re-rendering for every request (for example if a property value converter outputs the current time).

## Configuring output caching

Output caching must be explicitly enabled by configuration. To enable it, add the `OutputCache` section to the `DeliveryApi` configuration in `appsettings.json`:

{% code title="appsettings.json" %}
```json
{
    "Umbraco": {
        "CMS": {
            "DeliveryApi": {
                "Enabled": true,
                "OutputCache": {
                    "Enabled": true,
                    "ContentDuration": "00:15:00",
                    "MediaDuration": "01:00:00"
                }
            }
        }
    }
}
```
{% endcode %}

The output cache duration (time-to-live) can be configured for the Content and Media Delivery APIs. In the example above, content output is cached for 15 minutes while media output is cached for an hour.

## Load balancing considerations

The default output caching mechanism is based on the individual server instance memory. When hosting in a load balanced environment, this likely will not work, as the memory cache isn't synchronized across instances.

Instead you'll need to use a distributed caching solution like Redis cache. Starting with .NET 8, Microsoft supports output caching with Redis cache as backing store. Read more [here](https://learn.microsoft.com/en-us/aspnet/core/performance/caching/output#redis-cache).

## Additional considerations

While output caching is a great way to boost performance, it should never be used as a band-aid to solve poor uncached performance. The Delivery API is generally performant without caching.

If you experience performance issues while querying the Delivery API, your first step should be to diagnose and fix the root cause. This could be any number of things, like:

- Un-performant value converters.
- Overly complex queries.
- An inexpedient content architecture.
- ...or something else entirely.

Hiding such problems behind output caching should only ever be considered as a short-term solution. In the long run it will not be a sustainable fix.
