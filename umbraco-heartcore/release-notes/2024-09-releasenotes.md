# September 2024
The following changes have been released to all Heartcore sites.

## New Redirect Endpoint
For a long time, the only way to get redirect information from Heartcore was a single endpoint on the Delivery API. This endpoint returned paginated redirect information for _all_ content items in the tree. If you needed to find the canonical URL for a given path, then this endpoint was your only option. You would need to find your path in the returned items - especially challenging if it wasn't on the first page of results!

In order to save you the trouble, a brand new endpoint has been added to the Delivery API. It allows you to fetch the canonical URL (and any other redirects) for a given path. For more information, check out the [updated page here](../api-documentation/content-delivery/redirect.md#get-content-by-redirect-url).
