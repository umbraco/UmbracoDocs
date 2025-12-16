---
description: >-
  Learn how to use the Umbraco Engage API to track page views, personalize
  content, and manage segmentation for visitors.
---

# Using the Engage API

After setting up the Umbraco Engage API, let us learn how to use it.

With the installation of `Umbraco.Engage.Headless` you can track visitor page views, personalize content, and manage segmentation for visitors through the Umbraco Engage API. Personalized content and A/B tests work with Umbraco's Content Delivery API, delivering the correct content. For more details on how to use and query content from Umbraco, see the [Umbraco Documentation](https://docs.umbraco.com/umbraco-cms/reference/content-delivery-api#enable-the-content-delivery-api).

The steps to track & retrieve personalized content are as follows:

1. A new visitor visits their first page. An HTTP POST request is made to the `analytics/pageview/trackpageview/client` endpoint with the requested URL. This returns an External Visitor ID unique to this visitor.
2. Content is retrieved for that visitor through the Umbraco Content Delivery API. The External Visitor ID is used as the `External-Visitor-Id` header to retrieve content for that specific visitor.
3. The page is rendered using the retrieved content and returned to the visitor.
4. The same visitor visits another page. An HTTP POST request is made to the `analytics/pageview/trackpageview/client` endpoint with the requested URL **and** the _External-Visitor-Id_ header. This pageview will be attributed to the same visitor.

{% hint style="info" %}
_Without providing the_ `External-Visitor-Id` _header, each registered pageview will be considered as a new visitor._
{% endhint %}

5. Repeat these steps for each page visit for a new or existing visitor.

By tracking visitor behavior, Engage determines if the user meets criteria for segmenting, A/B testing, or applying personalization. Subsequent requests to the Umbraco content API then deliver personalized content.

Umbraco Engage needs to be explicitly notified because a single request to Umbraco's Content Delivery API represents one page visit.

## Configuration

Umbraco Engage Headless package settings can be configured through .NET options, including AppSettings JSON file, Environment Variables, or other configuration sources.

An example of configuration in `AppSettings.json` file:

```json
"Engage": {
  "DeliveryApi": {
    "Segmentation": {
      "ContentById": true,
      "ContentByIds": true,
      "ContentByPath": true,
      "ContentByQuery": true
    }
  }
}
```

The settings can be changed at runtime without restarting the website for these changes to take effect. These configurations will toggle whether Umbraco Engage will apply segmentation to the various Content Delivery API endpoints when applicable.

| **Key**        | **Description**                                                                                                                                     | **Default Value** |
| -------------- | --------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------- |
| ContentById    | <p>Enable Umbraco content delivery API endpoint by <strong>ID</strong><br><em>/umbraco/delivery/api/v1/content/item/{id}</em></p>                   | true              |
| ContentByIds   | <p>Enable Umbraco content delivery API endpoint<br>that uses an array of <strong>IDs</strong><br><em>/umbraco/delivery/api/v1/content/item</em></p> | true              |
| ContentByPath  | <p>Enable Umbraco content delivery API endpoint by <strong>Path</strong><br><em>/umbraco/delivery/api/v1/content/item/{path}</em></p>               | true              |
| ContentByQuery | <p>Enable Umbraco content delivery API endpoint by <strong>Query</strong><br><em>/umbraco/delivery/api/v1/content</em></p>                          | true              |

### Analytics

To track a page view, send a POST request to:

`/umbraco/engage/api/v1/analytics/pageview/trackpageview/client`

* Required: `url` property of the page that a user has visited in the site
* Optional: `reffererUrl` can be set to inform Umbraco Engage where the user came from.

`/umbraco/engage/api/v1/analytics/pageview/trackpageview/server`

* Useful when a frontend JAMStack Server such as a NuxtJS server or similar is being used.
* Can notify Umbraco Engage when a page view has taken place and provide extra information.
* Requests extra metadata like `headers`, `browserUserAgent`, `remoteClientAddress`, and `userIdentifier`.

Both API endpoints will return the following response:

```json
{
  "externalVisitorId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
  "pageviewId": "64955e29-4edf-475a-b154-aa8efd1f3724"
}
```

The `externalVisitorId` is unique to this visitor and is to be used in subsequent API calls for this visitor, and this visitor only. The pageviewId is unique to this specific pageview and used in specific API's like tracking events on pageviews.

#### **Client and Server**

Umbraco Engage gathers information about visitors based on their requests, extracting details from your request like HTTPContext.

* **Client-side**: This version applies when you make an API call directly to Umbraco from your browser. In this case, all the request metadata, such as IP address, cookies, request headers, and so on, comes directly from your browser.
* **Server-side**: If there is a server between the browser and Umbraco, like a NuxtJS server, the requests tracked are from the server rather than the browser. In this scenario, Umbraco Engage does not receive metadata from the end-client's requests. Instead, you can use the server version to add this additional metadata (headers, IP addresses, and so on) to your pageview tracking between the NuxtJS server and Umbraco.

### Page Events

To track events, send a POST request to:

`/umbraco/engage/api/v1/analytics/pageevent/trackpageevent`

* After tracking a pageview using the Analytics TrackPageview API as mentioned above, you will receive both an externalVisitorId and `pageviewId`.
* Requires a supplied pageview-Id header and a request body containing a `category`, `action` _(optional)_, `label` _(optional)_, and `timestamp` _(optional)_.

Optionally, provide an External-Visitor-Id header in order to automatically update the in-memory visitor. This helps to automatically reflect segments involving events for said visitors. Without this parameter, the pageview must be flushed to the database (according to the configuration) before any segment-related information is updated. For example: personalization variants based on events.

### Segmentation - Assets

`/umbraco/engage/api/v1/segmentation/assets/item/{path}`

`/umbraco/engage/api/v1/segmentation/assets/item/{id}`

These requests let you verify if a content page has a **JavaScript** or **CSS** variant available for page injection for this specific visitor. This endpoint requires the External-Visitor-Id header to function. This returns the following response:

```json
{
  "javascript": [
    "alert('hello world')"
  ],
  "css": [
    "body { background-color:red; }"
  ]
}
```

![Add custom code for variant](<../../.gitbook/assets/engage-headless-segment-css (1).png>)

### Segmentation - Content

`/umbraco/engage/api/v1/segmentation/content/segments`

`/umbraco/engage/api/v1/segmentation/content/segments/{path}`

`/umbraco/engage/api/v1/segmentation/content/segments/{id}`

These requests return details about segments (personalization and A/B testing) configured for a page. This helps determine if content can be changed by Umbraco Engage or cached more aggressively. The information returned by the APIs is visitor agnostic and reflects all the segments as configured in Umbraco. This returns the following response:

```json
{
  "segmentedContent": [
    {
      "contentTypeAlias": "home",
      "contentId": 1097,
      "contentGuid": "ca4249ed-2b23-4337-b522-63cabe5587d1",
      "contentUrls": [
        "/",
        "https://umbraco.com/",
        "https://umbraco.com/en/"
      ],
      "segments": [
        {
          "umbracoSegmentAlias": "engage_personalization_1",
          "segmentId": 1,
          "segmentName": "All Developers",
          "segmentType": "Personalization",
          "segmentApplicationType": "SinglePage"
        },
        {
          "umbracoSegmentAlias": "engage_personalization_2",
          "segmentId": 2,
          "segmentName": "All Marketeers",
          "segmentType": "Personalization",
          "segmentApplicationType": "SinglePage"
        }
      ]
    },
    ...
  ]
}
```

### Segmentation - Visitor

`/umbraco/engage/api/v1/segmentation/content/activesegments/{path}`

`/umbraco/engage/api/v1/segmentation/content/activesegments/{id}`

These requests return the segment (personalization and A/B testing) that the current visitor ID of that specific page belongs to. This endpoint requires the External-Visitor-Id header to function.

This returns the following response:

```json
{
  "contentTypeAlias": "home",
      "contentId": 1097,
      "contentGuid": "ca4249ed-2b23-4337-b522-63cabe5587d1",
      "contentUrls": [
        "/",
        "https://umbraco.com/",
        "https://umbraco.com/en/"
      ],
      "segments": [
        {
          "umbracoSegmentAlias": "engage_personalization_1",
          "segmentId": 1,
          "segmentName": "All Developers",
          "segmentType": "Personalization",
          "segmentApplicationType": "SinglePage"
        }
      ]
  ]
}
```

### Cookies & External Visitor IDs

Umbraco Engage in a non-headless setup uses cookies to track returning visitors. This, however, has proven difficult to work with in a headless setup for most clients. Therefore, it is not a recommended way of working with the Engage API.

Each API endpoint that allows for tracking analytics, segmentation, and retrieving content has support for adding the External Visitor ID header. This is a unique ID for an individual visitor and is to be used instead of the cookie. When tracking pageviews, a new External Visitor ID will be generated and is to be used for subsequent API calls corresponding to that visitor.

{% hint style="info" %}
A visitor will be considered an **existing visitor** when either of the following applies to the request:

* An `umbracoEngageAnalyticsVisitorId` cookie is present.
* An `External-Visitor-Id` Header is provided.

If neither applies, the requests will be considered coming from a new visitor.
{% endhint %}
