# Rate limits
Umbraco Heartcore is subject to soft rate limits for requests to Content Delivery APIs. These limits arebased upon the plan tier of the project, as follows:

| Plan Tier      | Requests per second |
| -------------- | ------------------- |
| Starter        | 25                  |
| Standard       | 50                  |
| Professional   | 75                  |
| Enterprise     | Starting from 75    |


## Excluded Traffic
Requests to the Content Management API are not limited.

Rate limits are individual for each of the GraphQL, REST, and Preview APIs. For example, a Standard Heartcore project may make up to 50 requests per second to GraphQL and 50 more to the REST API without being in violation.

When a request is made to the REST or GraphQL APIs, the result is cached. Subsequent requests to the same endpoint with the same parameters will return the cached result. Cached results expire after a variable time period or after relevant content is published. Requests served from cache do not count towards the rate limit.

## Soft limits
Rate limits to Heartcore APIs are currently _soft_ limits. That is, whenever a given environment receives requests in excess of the limit, it will continue to serve responses normally. Umbraco may reach out to the owner of projects that significantly exceed their allowed rate limit.

{% hint style="info" %}
In future Heartcore may change to _hard_ enforcement of rate limits. In this eventuality, APIs will return an [HTTP 429](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/429) response with a `Retry-After` header when receiving a request in excess of the limit.
{% endhint %}