# Rate limits
Umbraco Heartcore is subject to soft rate limits for requests to the delivery APIs. These limits are based upon the plan tier of the project, as follows:

| Plan Tier      | Requests per second |
| -------------- | ------------------- |
| Starter        | 25                  |
| Standard       | 50                  |
| Professional   | 75                  |
| Enterprise     | Starting from 75    |


## Excluded Traffic
Requests to the Content Management API are not limited.

Rate limits are individual for each of the GraphQL, Content Delivery, and Preview APIs. For example, a Standard Heartcore project may make up to 50 requests per second each of GraphQL and Content Delivery without being in violation.

When a request is made to the Content Delivery or GraphQL APIs, the result is cached. Subsequent requests to the same endpoint with the same parameters will return the cached result. Cached results expire after a variable period or after publishing relevant content. Requests served from the cache do not count toward the rate limit.

## Soft limits
Rate limits to Heartcore APIs are currently _soft_ limits. That is, whenever a given environment receives requests above the limit, it will continue to serve responses normally. Umbraco may contact the owner of projects that exceed their allowed rate limit.

{% hint style="info" %}
In the future, Heartcore may change to _hard_ enforcement of rate limits. In this eventuality, APIs will return an [HTTP 429](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/429) response with a `Retry-After` header when receiving a request above the limit.
{% endhint %}